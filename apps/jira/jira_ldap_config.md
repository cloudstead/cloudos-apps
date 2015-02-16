# Configuring JIRA to use your Cloudstead's LDAP directory #

## Getting started ##

1. Install the JIRA app on your cloudstead if you haven't already
2. Go through the basic JIRA configuration. **NB:** the administrative user you create *must not* share a name with one of your existing cloudstead users. If it does, you won't be able to manage that user in JIRA once the ldap directory is connected.
3. After you can access the JIRA dashboard, open 'Administration'->'User Management' and select 'User Directories' from the list on the left
4. Click the 'add directory' button
5. In the server settings, enter the information provided below
6. Once your settings are in, click 'Save and Test'. At the bottom of the screen, enter a user name & password from your ldap directory, then click 'test settings'. JIRA should be able to complete each of the tests. If so, you're off to the races!

## LDAP Directory settings ##

`domain`: your cloudstead's domain name, minus the TLD. E.g., if your cloudstead is my-cloudstead.example.com, your `domain` is example.

`tld`: your cloudstead's TLD, com in the example above.

`password`: the LDAP password for your cloudstead. You can find this by ???

### Server settings: ###

- Name: CloudOS LDAP (or whatever you want)
- Directory Type: OpenLDAP
- Hostname: localhost
- Port: 389
- Username: cn=admin,dc=`domain`,dc=`tld`
- Password: `password`

### LDAP Schema: ###

- Base DN: cn=cloudos,dc=`domain`,dc=`tld`
- Additional User DN: ou=People
- Additional Group DN: ou=Groups

### LDAP Permissions: ###

- Choose Read/Write

### User Schema Settings: ###

- User Object Class: inetOrgPerson
- User Object Filter: (objectClass=inetOrgPerson)
- User Name Attribute: uid
- User Name RDN Attribute: cn
- User First Name Attribute: givenName
- User Last Name Attribute: sn
- User Display Name Attribute: displayName
- User Email attribute: mail
- User Password Attribute: userPassword
- User Password Encryption: SHA

### Group Schema Settings: ###

- Group Object Class: groupOfUniqueNames
- Group Object Filter: (objectClass=groupOfUniqueNames)
- Group Name Attribute: cn
- Group Description Attribute: description

### Membership Schema Settings: ###

- Group Members Attribute: uniqueMember
- User Membership Attribute: memberOf
- Use the User Membership Attribute: leave this unchecked
