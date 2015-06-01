package cloudos.app.jira;

import cloudos.appstore.model.ConfigurableAppRuntime;
import lombok.Cleanup;
import lombok.extern.slf4j.Slf4j;
import org.cobbzilla.util.http.HttpMethods;

import java.sql.*;
import java.util.Map;

import static cloudos.appstore.model.app.filter.AppFilterHandler.FSCOPE_CONFIG;
import static cloudos.appstore.model.app.filter.AppFilterHandler.FSCOPE_METHOD;
import static org.cobbzilla.util.mustache.MustacheUtil.render;

@Slf4j
public class JiraPlugin extends ConfigurableAppRuntime {

    public static final String LDAP_DRIVER_CLASS = "com.atlassian.crowd.directory.OpenLDAP";
    public static final String COS_LDAP_NAME = "CloudOs LDAP server";
    private static final String[][] LDAP_DIR_ATTRS = new String[][]{
            {"directory.cache.synchronise.interval", "3600" },
            {"ldap.read.timeout", "120000" },
            {"ldap.user.displayname", "{{system.ldap.user_displayname}}" },
            {"ldap.usermembership.use", "false" },
            {"ldap.search.timelimit", "60000" },
            {"ldap.user.objectclass", "{{system.ldap.user_class}}" },
            {"ldap.group.objectclass", "{{system.ldap.group_class}}" },
            {"ldap.pagedresults", "false" },
            {"ldap.user.firstname", "{{system.ldap.user_firstname}}" },
            {"ldap.group.description", "{{system.ldap.group_description}}" },
            {"crowd.sync.incremental.enabled", "true" },
            {"ldap.pool.timeout", "0" },
            {"ldap.group.usernames", "{{system.ldap.group_usernames}}" },
            {"ldap.user.group", "{{system.ldap.user_groupnames}}" },
            {"ldap.user.filter", "{{system.ldap.user_filter}}" },
            {"ldap.secure", "{{system.ldap.secure}}" },
            {"ldap.password", "{{system.ldap.password}}" },
            {"ldap.relaxed.dn.standardisation", "true" },
            {"ldap.user.username.rdn", "{{system.ldap.user_username_rdn}}" },
            {"ldap.user.encryption", "{{system.ldap.user_encryption}}" },
            {"ldap.pool.maxsize", null },
            {"ldap.group.filter", "{{system.ldap.group_filter}}" },
            {"ldap.nestedgroups.disabled", "true" },
            {"ldap.user.username", "{{system.ldap.user_username}}" },
            {"ldap.group.dn", "{{system.ldap.group_simple_dn}}" },
            {"ldap.user.email", "{{system.ldap.user_email}}" },
            {"autoAddGroups", "" },
            {"ldap.pool.prefsize", null },
            {"ldap.basedn", "{{system.ldap.base_dn}}" },
            {"ldap.propogate.changes", "false" },
            {"localUserStatusEnabled", "false" },
            {"ldap.roles.disabled", "true" },
            {"ldap.connection.timeout", "10000" },
            {"ldap.url", "{{system.ldap.server}}" },
            {"ldap.external.id", "{{system.ldap.external_id}}" },
            {"ldap.usermembership.use.for.groups", "false" },
            {"ldap.pool.initsize", null },
            {"ldap.referral", "false" },
            {"ldap.userdn", "{{system.ldap.admin_dn}}" },
            {"ldap.user.lastname", "{{system.ldap.user_lastname}}" },
            {"ldap.pagedresults.size", "1000" },
            {"ldap.group.name", "{{system.ldap.group_name}}" },
            {"ldap.local.groups", "false" },
            {"ldap.user.dn", "{{system.ldap.user_simple_dn}}" },
            {"ldap.user.password", "{{system.ldap.user_password}}" }
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
            final Map<String, Map<String, String>> databags = (Map<String, Map<String, String>>) scope.get(FSCOPE_CONFIG);
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
        final Map<String, Map<String, String>> databags = (Map<String, Map<String, String>>) scope.get(FSCOPE_CONFIG);
        final Map<String, String> initBag = databags.get("init");
        try {
            @Cleanup final Connection conn = getConnection(details.getName(), initBag);
            @Cleanup final PreparedStatement s = conn.prepareStatement(
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
            if (!tryUpdate(s)) return;

            @Cleanup final PreparedStatement check_attr = conn.prepareStatement("select count(*) from cwd_directory_attribute where directory_id=? and attribute_name=?");
            @Cleanup final PreparedStatement insert_attr = conn.prepareStatement("insert into cwd_directory_attribute (directory_id, attribute_name, attribute_value) values (?, ?, ?)");
            @Cleanup final PreparedStatement update_attr = conn.prepareStatement("update cwd_directory_attribute set attribute_value=? where directory_id=? and attribute_name=?");
            for (String[] dir_attr : LDAP_DIR_ATTRS) {
                index=1;
                check_attr.setInt(index++, 9999);
                check_attr.setString(index++, dir_attr[0]);
                @Cleanup final ResultSet check_rs = check_attr.executeQuery();
                if (check_rs.next() && check_rs.getInt(1) > 0) {
                    log.info("attribute already exists, updating it: "+dir_attr[0]);
                    index=1;
                    final String value = render(dir_attr[1], scope);
                    if (value == null) {
                        update_attr.setNull(index++, Types.VARCHAR);
                    } else {
                        update_attr.setString(index++, value);
                    }
                    update_attr.setInt(index++, 9999);
                    update_attr.setString(index++, dir_attr[0]);
                    if (!tryUpdate(update_attr)) update_attr.clearWarnings();
                } else {
                    index = 1;
                    insert_attr.setInt(index++, 9999);
                    insert_attr.setString(index++, dir_attr[0]);
                    final String value = render(dir_attr[1], scope);
                    if (value == null) {
                        insert_attr.setNull(index++, Types.VARCHAR);
                    } else {
                        insert_attr.setString(index++, value);
                    }
                    if (!tryUpdate(insert_attr)) insert_attr.clearWarnings();
                }
            }

            @Cleanup PreparedStatement insert_op = conn.prepareStatement("insert into cwd_directory_operation (directory_id, operation_type) values (?, ?)");
            for (String dir_op : LDAP_DIR_OPS) {
                insert_op.setInt(1, 9999);
                insert_op.setString(2, dir_op);
                if (!tryUpdate(insert_op)) insert_op.clearWarnings();
            }

        } catch (Exception e) {
            log.error("setupLdap: Error inserting into cwd_directory: "+e, e);
        }

    }

    private boolean tryUpdate(PreparedStatement s) throws SQLException {
        if (s.executeUpdate() != 1) {
            log.error("setupLdap: Error inserting (executeUpdate did not return 1): "+s.toString());
            return false;
        }
        return true;
    }

}
