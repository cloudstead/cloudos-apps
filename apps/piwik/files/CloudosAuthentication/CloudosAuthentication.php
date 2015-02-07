<?php
/**
 * Piwik - free/libre analytics platform
 *
 * @link http://piwik.org
 * @license http://www.gnu.org/licenses/gpl-3.0.html GPL v3 or later
 *
 */
namespace Piwik\Plugins\CloudosAuthentication;

require_once(PIWIK_DOCUMENT_ROOT.'/httpful.phar');

use Exception;
use Piwik\Date;
use Piwik\AuthResult;
use Piwik\Db;
use Piwik\Plugins\UsersManager\Model;
use Piwik\Session;
use Piwik\Plugins\UsersManager\API as UsersManagerAPI;
use Piwik\Registry;
use Piwik\Plugins\Login\Login;
use Piwik\Plugins\Login\SessionInitializer;
use Piwik\Log;

/**
 * Enables login to Piwik using Cloudos credentials
 */
class CloudosAuthentication extends \Piwik\Plugin implements \Piwik\Auth {

    protected $login = null;
    protected $token_auth = null;
    protected $password = null;
    protected $md5Password = null;

    /**
     * @see Piwik_Plugin::getListHooksRegistered
     */
    public function getListHooksRegistered() {
        $hooks = array(
            'Request.initAuthenticationObject' => 'initAuthenticationObject',
        );
        return $hooks;
    }

    public function initAuthenticationObject($activateCookieAuth = null) {
        Registry::set('auth', $this);
        Login::initAuthenticationFromCookie($this, $activateCookieAuth);
    }

    public function getName() { return 'Login'; }

    /**
     * Authenticates user
     *
     * @return AuthResult
     */
    public function authenticate()
    {
        if (!empty($this->md5Password)) { // favor authenticating by password
            $this->token_auth = UsersManagerAPI::getInstance()->getTokenAuth($this->login, $this->getTokenAuthSecret());
        }

        $model = new Model();
        if (is_null($this->login)) {
            $user  = $model->getUserByTokenAuth($this->token_auth);

            if (!empty($user['login'])) {
                $code = $user['superuser_access'] ? AuthResult::SUCCESS_SUPERUSER_AUTH_CODE : AuthResult::SUCCESS;

                return new AuthResult($code, $user['login'], $this->token_auth);
            }
        } else if (!empty($this->login)) {
            $user  = $this->cloudos_auth();
            if ($user == null) {
                $user  = $model->getUser($this->login);
            }

            if ($user != null && !empty($user['token_auth'])
                && ((SessionInitializer::getHashTokenAuth($this->login, $user['token_auth']) === $this->token_auth)
                    || $user['token_auth'] === $this->token_auth)
            ) {
                $this->setTokenAuth($user['token_auth']);
                $code = !empty($user['superuser_access']) ? AuthResult::SUCCESS_SUPERUSER_AUTH_CODE : AuthResult::SUCCESS;

                return new AuthResult($code, $this->login, $user['token_auth']);
            }
        }

        return new AuthResult(AuthResult::FAILURE, $this->login, $this->token_auth);
    }

    function cloudos_auth () {

        if ($this->login == "anonymous" || $this->password == null) return null;

        $model = new Model();
        $uri = 'http://127.0.0.1:3001/api/accounts';
        $auth_json = '{"name":"' . $this->login . '", "password": "' . $this->password . '"}';
        Log::info('cos:: cloudos_auth: starting with auth_json=' . $auth_json);
        $response = \Httpful\Request::post($uri)->sendsJson()->body($auth_json)->send();
        if ($response->code == 200) {
            $cos_account = $response->body->account;
            $user = $model->getUser($cos_account->name);
            if ($user == null) {

                $model->addUser($cos_account->name, '', $cos_account->email, $cos_account->name, md5($this->login . md5($this->password)), Date::now()->getDatetime());
                $user = $model->getUser($cos_account->name);

                if ($user == null) {
                    // whoa, couldn't create user
                    Log::error('authenticate: user just created DOES NOT exist, bailing out');
                    return null;

                } else {
                    $code = AuthResult::SUCCESS;
                    if ($cos_account->admin) {
                        $model->setSuperUserAccess($this->login, true);
                        $code = AuthResult::SUCCESS_SUPERUSER_AUTH_CODE;
                    }
                    Log::info('cos:: cloudos_auth: returning SUCCESS: ' . $code . ' with token_auth=' . $this->token_auth);
                }
            }
            return $model->getUser($cos_account->name);

        } else {
            return null;
        }
    }

    public function getLogin() { return $this->login; }

    public function setLogin($login) { $this->login = $login; }

    public function getTokenAuthSecret() { return $this->md5Password; }

    public function setTokenAuth($token_auth) { $this->token_auth = $token_auth; }

    public function setPassword($password) {
        $this->password = $password;
        $this->md5Password = md5($password);
    }

    public function setPasswordHash($passwordHash) {
        if (strlen($passwordHash) != 32) {
            throw new Exception("Invalid hash: incorrect length " . strlen($passwordHash));
        }

        $this->md5Password = $passwordHash;
    }
}
?>