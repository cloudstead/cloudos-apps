SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

COPY cwd_directory (id, directory_name, lower_directory_name, created_date, updated_date, active, description, impl_class, lower_impl_class, directory_type, directory_position) FROM stdin;
9999   CloudOs LDAP server     cloudos ldap server     2015-03-01 22:03:46.408-08      2015-03-01 22:03:46.408-08      1       \N      com.atlassian.crowd.directory.OpenLDAP  com.atlassian.crowd.directory.openldap  CONNECTOR       1
\.


COPY cwd_directory_attribute (directory_id, attribute_name, attribute_value) FROM stdin;
9999   directory.cache.synchronise.interval    3600
9999   ldap.read.timeout       120000
9999   ldap.user.displayname   displayName
9999   ldap.usermembership.use false
9999   ldap.search.timelimit   60000
9999   ldap.user.objectclass   inetorgperson
9999   ldap.group.objectclass  groupOfUniqueNames
9999   ldap.pagedresults       false
9999   ldap.user.firstname     givenName
9999   ldap.group.description  description
9999   crowd.sync.incremental.enabled  true
9999   ldap.pool.timeout       0
9999   ldap.group.usernames    uniqueMember
9999   ldap.user.group memberOf
9999   ldap.user.filter        (objectclass=inetorgperson)
9999   ldap.secure     false
9999   ldap.password   xxx
9999   ldap.relaxed.dn.standardisation true
9999   ldap.user.username.rdn  cn
9999   ldap.user.encryption    sha
9999   ldap.pool.maxsize       \N
9999   ldap.group.filter       (objectclass=groupOfUniqueNames)
9999   ldap.nestedgroups.disabled      true
9999   ldap.user.username      uid
9999   ldap.group.dn   ou=Groups
9999   ldap.user.email mail
9999   autoAddGroups
9999   ldap.pool.prefsize      \N
9999   ldap.basedn     cn=cloudos,dc=cloudstead,dc=io
9999   ldap.propogate.changes  false
9999   localUserStatusEnabled  false
9999   ldap.roles.disabled     true
9999   ldap.connection.timeout 9999
9999   ldap.url        ldap://127.0.0.1:389
9999   ldap.external.id        entryUUID
9999   ldap.usermembership.use.for.groups      false
9999   ldap.pool.initsize      \N
9999   ldap.referral   false
9999   ldap.userdn     cn=admin,dc=cloudstead,dc=io
9999   ldap.user.lastname      sn
9999   ldap.pagedresults.size  1000
9999   ldap.group.name cn
9999   ldap.local.groups       false
9999   ldap.user.dn    ou=People
9999   ldap.user.password      userPassword
\.

COPY cwd_directory_operation (directory_id, operation_type) FROM stdin;
9999   UPDATE_USER_ATTRIBUTE
9999   UPDATE_GROUP_ATTRIBUTE
\.

