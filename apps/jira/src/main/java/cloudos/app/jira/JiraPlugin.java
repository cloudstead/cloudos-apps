package cloudos.app.jira;

import cloudos.appstore.model.ConfigurableAppRuntime;
import lombok.Cleanup;
import lombok.extern.slf4j.Slf4j;
import org.cobbzilla.util.http.HttpMethods;

import java.sql.*;
import java.util.Map;

import static cloudos.appstore.model.app.filter.AppFilterHandler.FSCOPE_APP_CONFIG;
import static cloudos.appstore.model.app.filter.AppFilterHandler.FSCOPE_METHOD;
import static org.cobbzilla.util.mustache.MustacheUtil.render;

@Slf4j
public class JiraPlugin extends ConfigurableAppRuntime {

    public static final String LDAP_DRIVER_CLASS = "com.atlassian.crowd.directory.OpenLDAP";
    public static final String COS_LDAP_NAME = "CloudOs LDAP server";
    private static final String[][] LDAP_DIR_ATTRS = new String[][]{
            {"directory.cache.synchronise.interval", "3600" },
            {"ldap.read.timeout", "120000" },
            {"ldap.user.displayname", "displayName" },
            {"ldap.usermembership.use", "false" },
            {"ldap.search.timelimit", "60000" },
            {"ldap.user.objectclass", "inetorgperson" },
            {"ldap.group.objectclass", "groupOfUniqueNames" },
            {"ldap.pagedresults", "false" },
            {"ldap.user.firstname", "givenName" },
            {"ldap.group.description", "description" },
            {"crowd.sync.incremental.enabled", "true" },
            {"ldap.pool.timeout", "0" },
            {"ldap.group.usernames", "uniqueMember" },
            {"ldap.user.group", "memberOf" },
            {"ldap.user.filter", "(objectclass=inetorgperson)" },
            {"ldap.secure", "false" },
            {"ldap.password", "{{config.ldap.password}}" },
            {"ldap.relaxed.dn.standardisation", "true" },
            {"ldap.user.username.rdn", "cn" },
            {"ldap.user.encryption", "sha" },
            {"ldap.pool.maxsize", null },
            {"ldap.group.filter", "(objectclass=groupOfUniqueNames)" },
            {"ldap.nestedgroups.disabled", "true" },
            {"ldap.user.username", "uid" },
            {"ldap.group.dn", "ou=Groups" },
            {"ldap.user.email", "mail" },
            {"autoAddGroups", "" },
            {"ldap.pool.prefsize", null },
            {"ldap.basedn", "{{config.ldap.baseDN}}" },
            {"ldap.propogate.changes", "false" },
            {"localUserStatusEnabled", "false" },
            {"ldap.roles.disabled", "true" },
            {"ldap.connection.timeout", "10000" },
            {"ldap.url", "ldap://127.0.0.1:389" },
            {"ldap.external.id", "entryUUID" },
            {"ldap.usermembership.use.for.groups", "false" },
            {"ldap.pool.initsize", null },
            {"ldap.referral", "false" },
            {"ldap.userdn", "cn=admin,{{config.ldap.domain}}" },
            {"ldap.user.lastname", "sn" },
            {"ldap.pagedresults.size", "1000" },
            {"ldap.group.name", "cn" },
            {"ldap.local.groups", "false" },
            {"ldap.user.dn", "ou=People" },
            {"ldap.user.password", "userPassword" }
    };

    private static final String[] LDAP_DIR_OPS = new String[]{ "UPDATE_USER_ATTRIBUTE", "UPDATE_GROUP_ATTRIBUTE" };

    @Override public String applyCustomFilter(String filterName, String document, Map<String, Object> scope) {

        if (!filterName.equals("setupLdap")) return document;
        if (!scope.get(FSCOPE_METHOD).equals(HttpMethods.GET)) return document;
        if (!shouldDoLdapSetup(document, scope)) return document;

        setupLdap(scope);

        return document;
    }

    private boolean shouldDoLdapSetup(String document, Map<String, Object> scope) {

        try {
            final Map<String, Map<String, String>> databags = (Map<String, Map<String, String>>) scope.get(FSCOPE_APP_CONFIG);
            final Map<String, String> initBag = databags.get("init");
            if (initBag != null) {
                @Cleanup Connection conn = getConnection(details.getName(), initBag);
                @Cleanup PreparedStatement stmt = conn.prepareStatement("select count(*) from cwd_directory where directory_name like '%CloudOs%'");
                @Cleanup ResultSet rs = stmt.executeQuery();
                if (!rs.next()) {
                    log.error("shouldDoLdapSetup: jdbc weirdness, rs.next returned false");
                    return false;
                }
                return rs.getInt(1) == 0;
            }
        } catch (Exception e) {
            log.error("shouldDoLdapSetup: Error checking if ldap is setup: " + e, e);
        }
        return false;
    }

    private Connection getConnection(String dbname, Map<String, String> initBag) throws SQLException {
        final String url = "jdbc:postgresql://127.0.0.1:5432/" + dbname;
        return DriverManager.getConnection(url, dbname, initBag.get("admin.password"));
    }

    private void setupLdap(Map<String, Object> scope) {
        final Map<String, Map<String, String>> databags = (Map<String, Map<String, String>>) scope.get(FSCOPE_APP_CONFIG);
        final Map<String, String> initBag = databags.get("init");
        try {
            @Cleanup Connection conn = getConnection(details.getName(), initBag);
            @Cleanup PreparedStatement s = conn.prepareStatement(
                    "insert into cwd_directory (id, directory_name, lower_directory_name, created_date, updated_date, active, " +
                            "impl_class, lower_impl_class, directory_type, directory_position) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            int index=1;
            s.setInt(index++, 9999);
            s.setString(index++, COS_LDAP_NAME);
            s.setString(index++, COS_LDAP_NAME.toLowerCase());
            s.setTimestamp(index++, new Timestamp(System.currentTimeMillis()));
            s.setTimestamp(index++, new Timestamp(System.currentTimeMillis()));
            s.setInt(index++, 1);
            s.setString(index++, LDAP_DRIVER_CLASS);
            s.setString(index++, LDAP_DRIVER_CLASS.toLowerCase());
            s.setString(index++, "CONNECTOR");
            s.setInt(index++, 1);
            if (!tryInsertRow(s)) return;

            @Cleanup PreparedStatement s2 = conn.prepareStatement("insert into cwd_directory_attribute (directory_id, attribute_name, attribute_value) values (?, ?, ?)");
            for (String[] dir_attr : LDAP_DIR_ATTRS) {
                index=1;
                s2.setInt(index++, 9999);
                s2.setString(index++, dir_attr[0]);
                s2.setString(index++, render(dir_attr[1], scope));
                if (!tryInsertRow(s2)) s2.clearWarnings();
            }

            @Cleanup PreparedStatement s3 = conn.prepareStatement("insert into cwd_directory_operation (directory_id, operation_type) values (?, ?)");
            for (String dir_op : LDAP_DIR_OPS) {
                s3.setInt(1, 9999);
                s3.setString(2, dir_op);
                if (!tryInsertRow(s3)) s3.clearWarnings();
            }

        } catch (Exception e) {
            log.error("setupLdap: Error inserting into cwd_directory: "+e, e);
        }

    }

    private boolean tryInsertRow(PreparedStatement s) throws SQLException {
        if (s.executeUpdate() != 1) {
            log.error("setupLdap: Error inserting (executeUpdate did not return 1): "+s.toString());
            return false;
        }
        return true;
    }

}
