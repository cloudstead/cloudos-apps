<?php

require_once dirname(__FILE__).'/../accesscheck.php';
require_once dirname(__FILE__).'/../../httpful.phar';

class admin_auth {

    function validateLogin($login,$password) {

        if ($login == null || $password == null) return array(0,s("Login failed"));

        $uri = 'http://127.0.0.1:3001/api/accounts';
        $auth_json = '{"name":"' . $login . '", "password": "' . $password . '"}';
        $response = \Httpful\Request::post($uri)->sendsJson()->body($auth_json)->send();
        if ($response->code == 200) {
            $cos_account = $response->body->account;
            $_SESSION['__cloudos_account'] = $cos_account;
            return array($cos_account->uuid, "OK");

        } else {
            return array(0,s("Login failed"));
        }
    }

  function validateAccount($id) {

      if ($_SESSION['__cloudos_account']->uuid != $id) {
        return array(0,s("No such account: " . $id));
    }

    return array(1,"OK");
  }

  function adminName($id) {
    if ($_SESSION['__cloudos_account']->uuid == $id) {
        return $_SESSION['__cloudos_account']->name;
    }
    return s("n/a");
  }

  function adminEmail($id) {
    if ($_SESSION['__cloudos_account']->uuid == $id) {
        return $_SESSION['__cloudos_account']->name . '@' . gethostname();
    }
    return s("n/a");
  }

  function adminIdForEmail($email) { #Obtain admin Id from a given email address.
    throw new Exception("Reset your password in CloudOs, not here");
  }

  function isSuperUser($id) {
    if ($_SESSION['__cloudos_account']->uuid == $id) {
        return $_SESSION['__cloudos_account']->admin ? 1 : 0;
    }
    return 0;
  }

  function listAdmins() {
    $result = array();
    if (isset($_SESSION['__cloudos_account'])) {
      $result[$_SESSION['__cloudos_account']->uuid] = $_SESSION['__cloudos_account']->name;
    }
    return $result;
  }

}
?>
