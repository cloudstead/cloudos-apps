How to create an app
====================

Let's walk through a concrete example: packaging the DokuWiki app for CloudOs.

### Create a directory called dokuwiki

    mkdir dokuwiki

### Create the manifest

In the `dokuwiki` folder, create a file name cloudos-manifest.json

#### Basic settings

##### Version

Set the version to whatever you please. This is the initial version so it doesn't matter so much.

##### Name

Name of the app. We'll call it dokuwiki

##### Style

Style of the app. This can be php, rails, java_webapp, nodejs, or system. We'll choose php.

##### Interactive

This is a true/false setting that indicates if this app is something end users will interact with, or a "backend" service. Backend services do not get an app icon in the CloudOs taskbar. We want an icon for this app, so we set interactive to true.

##### Publisher

This block is for informational purposes only. It is good form to include (or link to) the license and copyright for the app you are bundling. Our block looks like this:

    "publisher": {
      "maintainer": "Jonathan Cobb",
      "maintainer_email": "jonathan@cloudstead.io",
      "license": "https://www.dokuwiki.org/faq:license",
      "code_copyright": "DokuWiki - 2004-2014 (c) Andreas Gohr <andi@splitbrain.org> and the DokuWiki Community",
      "packaging_copyright": "Copyright 2015 Cloudstead, Inc."
    },

##### Getting the code

To install and the app we will need the code for it. CloudOs supports downloading code in a tarball and/or pulling code from a git repository. In this case we will use a tarball available from the DokuWiki site. In the example below, we've copied this tarball to the cloudstead.io site so we don't have to worry if the DokuWiki tarball URL changes or is no longer available at some point in the future. The shasum field is the SHA-256 checksum of the file.

    "tarball": {
      "url": "http://cloudstead.io/downloads/dokuwiki-2014-09-29d-Hrun.tar.gz",
      "shasum": "6fc6794e13c8e3fe07f5e02bd09cc3a167486a676e9822fa17aab0a45b094794"
    },

##### App requirements

Next we look at what the app expects the system to look like. For DokuWiki, this information is at https://www.dokuwiki.org/requirements

Reading the link above, we see that DokuWiki wants PHP and some associated modules. By setting the "style" to "php" above, we've taken care of the PHP requirement.

For resizing images, they recommend the PHP GD extension or ImageMagick. We can ensure the GD extension is installed by adding the following block to the manifest:

    "packages": [ "php5-gd" ],

DokuWiki also requires a web server, noting that most users use Apache. That's great, because CloudOs is built heavily around Apache. We add the following block to the manifest:

    "web": { "type": "apache", "mode": "service" },

The `"mode": "service"` means that the root URL for this app will be https://hostname/dokuwiki/
If the mode had been set to `vhost`, then the root URL would be https://dokuwiki-hostname/

##### Permissions

DokuWiki expects the web filesystem to have certain permissions described at https://www.dokuwiki.org/install:permissions

We'll add the following block to our manifest:

    "perms": {
      "@doc_root/data":        { "perms": "770", "recursive": true },
      "@doc_root/bin":         { "perms": "770", "recursive": true },
      "@doc_root/conf":        { "perms": "770", "recursive": true },
      "@doc_root/inc":         { "perms": "770", "recursive": true },
      "@doc_root/data/tmp":    { "perms": "770", "recursive": true },
      "@doc_root/lib/plugins": { "perms": "770", "recursive": true },
      "@doc_root/lib/tpl":     { "perms": "770", "recursive": true }
    },

In the above, @doc_root will be replaced with the filesystem path to the DokuWiki document root directory. The 770 refers to UNIX-style permissions constants, explained in greater detail here: http://www.maketecheasier.com/file-permissions-what-does-chmod-777-means/

DokuWiki also recommends setting some Apache-level configuration to restrict access to sensitive files. In the `templates` directory, create a file called apache_vhost.conf.erb, and put the text below in it:

    <LocationMatch "/<%=@app[:name]%>/(data|conf|bin|inc)/">
      Order allow,deny
      Deny from all
      Satisfy All
    </LocationMatch>


##### Automating the Normal Installation

DokuWiki, like many web apps, has an install.php script that detects if it is being run from a brand-new, uninitialized state, and if so, runs an installer. For CloudOs users, we want to take care of as many steps as possible to make things as easy as can be. 

So let's run the installer once manually, see what it's doing, and then update our manifest to take care of those things too. For one thing, I notice that even though we've set permissions on local.php.bak and plugins.php.bak, these files do not exist. Thus these permission-setting operations will fail unless those files exist first. I'm betting that happens during the DokuWiki first-time installation. Let's give it a whirl.

First make a backup of the conf directory, so we can compare to see what gets changed by the installer.

    cd /var/www/dokuwiki    # or wherever you have put the document root
    cp -R conf conf.bak

Unroll the tarball to some Apache server that has PHP configured and hit the install.php URL: http://test-hostname/dokuwiki/install.php

The installation page asks you to setup a few different things. Pick whichever values you like and submit the form. Your wiki is now set up, but we'll want to parameterize it so that the CloudOs installer can set all of those installer settings automatically. Let's see which conf files got changed.

    cd /var/www/dokuwiki    # or wherever you have put the document root
    cd conf        ; find . -type f | xargs md5sum > /tmp/after.md5
    cd ../conf.bak ; find . -type f | xargs md5sum > /tmp/before.md5
    diff -u /tmp/before.md5 /tmp/after.md5

The diff shows us that some files have been changed by the installer: users.auth.php, acl.auth.php, local.php, plugins.local.php

Declare these templates in your cloudos-manifest.json file like so:

    "templates": {
      "@doc_root/conf/users.auth.php": "_",
      "@doc_root/conf/acl.auth.php": "_",
      "@doc_root/conf/local.php": "_",
      "@doc_root/conf/plugins.local.php": "_"
    },

The templates block tells the CloudOs installer which templates to write and where to write them. The "_" on the right side means "look for a file in the 'templates' directory with the same basename as the target file". Why would you ever create a template with one filename and write it with another? One example is a "dot-file", that is, a file that starts with '.' If this were the case, you might declare your template like this:

    "templates": {
      "@doc_root/path/to/.somefile": "dot-somefile"
    }

Now that we have declared our templates, we need to define them in the templates directory. Each file in the templates directory will have a ".erb" extension added to it.

###### users.auth.php

This file contains the user database. Mine looks like this:

    admin:$1$VxtUCNBj$Y6e3M0tt8fMbT2BJdIS2V1:admin-realname:jonathan+admin@example.com:admin,user

Later on, we'll show how to hook up authentication so that logins will be checked against the CloudOs user database. In addition to this, it's often useful to have one "superadmin" user that can login even without CloudOs. The user created during the installation process can be this user.

Instead of letting the installer setup this user, we can write to the file directly when CloudOs is installing the app. Let's create a template file. In your development environment, create a directory called "templates", and edit a file called "users.auth.php.erb" (note the .erb extension, which is required). Put this in the template file:

    # users.auth.php
    # <?php exit()?>
    # Don't modify the lines above
    #
    # Userfile
    #
    # Format:
    #
    # login:passwordhash:Real Name:email:groups,comma,seperated
    <%
    admin = @app[:databag][:init]['admin']
    hashed_password = Chef::Recipe::Base.bcrypt(admin['password'], 12)
    %>

    <%=admin['login']%>:<%=hashed_password%>:<%=admin['name']%>:<%=admin['email']%>:admin,user

What's going on here? First, we grab the "admin" section of our configuration. This doesn't exist yet -- we'll create it next. Then, with some poking around the DokuWiki source code, we find out (in inc/PassHash.class.php) that many forms of hashing are supported. We choose to use bcrypt with 12 rounds for good security.

In the next section we will declare and define the "admin" configuration that we use here.



###### acl.auth.php

This file controls who can read and write to the wiki. The default setting should be totally private, so, using the instructions in the original acl.auth.php.dist file, we'll create a file called acl.auth.php.erb in the templates directory. Its contents will be:

    # acl.auth.php
    # <?php exit()?>
    # Don't modify the lines above
    #
    # Access Control Lists
    #
    # Auto-generated by install script
    # Date: Thu, 14 May 2015 19:39:09 +0000
    *               @ALL          0
    *               @user         8

This will allow registered users to both read and write wiki pages, and anonymous users will have no permissions. The admin user can always open things up more later on. (Though if we wanted to get fancy we could make this configurable by CloudOs at install-time too... another lesson for another day)

###### local.php

Looking at this file post-manual-install, it appears to capture some of the settings specified at install-time. Let's parameterize it. Create a file called local.php.erb in your templates directory, and write this to it:

    <?php
    /**
     * Dokuwiki's Main Configuration File - Local Settings
     * Auto-generated by install script
     * Date: Thu, 14 May 2015 19:39:09 +0000
     */
    <% wiki = @app[:databag][:init]['wiki'] %>
    
    $conf['title'] = '<%=wiki['title']%>';
    $conf['lang'] = '<%=wiki['lang']%>';
    $conf['license'] = '<%=wiki['license']%>';
    $conf['useacl'] = 1;
    $conf['superuser'] = '@admin';
    
    <% if wiki['disable_registration'] %>
    $conf['disableactions'] = 'register';
    <% end %>

As you can see, we're using another config block that will have to be defined later: wiki. More on that once we're done setting up the template files.

###### plugins.local.php

Looking at this file, it's evident that DokuWiki supports LDAP authentication. So we'll turn that on, and figure out how to get it hooked up later. Create a file named plugins.local.php.erb in your templates directory. Its contents will be:

    <?php
    /*
     * Local plugin enable/disable settings
     *
     * Auto-generated by install script
     * Date: Thu, 14 May 2015 19:51:21 +0000
     */
    $plugins['authad']    = 0;
    $plugins['authldap']  = 1;
    $plugins['authmysql'] = 0;
    $plugins['authpgsql'] = 0;


##### Declaring configuration options

In the templates above, we have used some values that come a databag called 'init'. We will declare the databag in our manifest, then define the databag and its associated metadata.

In your manifest file, add the following block to define the configuration:

    "config": [ {
      "name": "init",
      "items": [ "admin.login", "admin.password", "admin.name", "admin.email",
                 "wiki.title", "wiki.lang", "wiki.license", "wiki.disable_registration" ]
    } ],

In the same directory as your manifest file, create a directory called "config". Within the config directory, create a file named `init.json`, this will provide default values for the configuration options declared in your manifest:

    {
      "id": "init",
      "admin": {
        "login": "admin",
        "name": "admin",
        "email": "postmaster@@hostname"
      },
      "wiki": {
        "title": "@hostname wiki",
        "lang": "@lang",
        "license": "0",
        "disable_registration": true
      }
    }

To make the configuration more user-friendly to edit in the CloudOs admin console, we can also define metadata for it. Create a file called config-metadata.json (also in the config directory), its contents will be:

    {
      "id": "config-metadata",
      "categories": {
        "init": {
          "fields": {
            "admin.login": { "required": true, "type": "login" },
            "admin.name": { "required": true },
            "admin.password": { "required": true, "type": "password", "login": "admin.login" },
            "admin.email": { "required": true, "type": "email" },
            "wiki.title": { "required": true, "type": "field" },
            "wiki.lang": { "required": true, "type": "locale",
              "choices": ["ne", "ka", "en", "zh", "cs", "kk", "da", "fo", "is", "et", "pl", "it", "af", "el", "ca-valencia", "id-ni", "lb", "ko", "de-informal", "eo", "de", "ro", "hu-formal", "id", "nl", "es", "mk", "ms", "ru", "az", "lv", "ca", "he", "ku", "hr", "uk", "bg", "pt", "ta", "ia", "zh-tw", "fr", "km", "la", "gl", "th", "eu", "sq", "lt", "pt-br", "ar", "no", "hu", "sv", "mr", "sr", "hi", "sl", "vi", "tr", "mg", "fi", "sk", "fa", "ja", "bn"] },
            "wiki.license": { "required": true, "type": "pick_one",
              "choices": ["cc-zero", "publicdomain", "cc-by", "cc-by-sa", "gnufdl", "cc-by-nc", "cc-by-nc-sa", "0"] },
            "wiki.disable_registration": { "required": true, "type": "yesno" }
          }
        }
      }
    }

In the above you can see each databag is represented as a category under the main "categories" object. Within each category, we have declared the fields. We've made them all required, and chosen an appropriate type for each field. To read all about every option available in describing a field, head here (link TBD) 

* For the `wiki.lang` field with type `locale`, where did that list of choices come from? With a little poking around the source, you find that DokuWiki maintains its locale-specific files in inc/lang, one directory per locale. So we can easily list all of them with `find inc/lang -maxdepth 1 -type d -exec basename {} \;` and put that list here. The type 'locale'

To get the choices for `wiki.license` a little more poking around the source leads us to `conf/license.php`, which contains all the valid values. 

The above metadata will allow CloudOs to present an appropriate UI (and perform validation) to cloudstead administrators when installing the app. But the field names and options will still be pretty raw, so we can add translation files that allow localization of the field labels and choices.

Create a file called `translations.json` in the config directory. This will be the "default" translations and must exist. To create translations of the field names for other locales, create more files anamed translations_locale.json. For example, translations_es.json would contain translations in Spanish.

Here's what our default (English) translation file looks like:

{
  "id": "translations",
  "categories": {
    "init": {
      "admin.login": { "label": "Admin Login", "info": "Login for the admin user" },
      "admin.name": { "label": "Admin Name", "info": "Name of the admin user" },
      "admin.password": { "label": "Admin Password", "info": "Password for the admin user" },
      "admin.email": { "label": "Admin Email", "info": "Email for the admin user" },
      "wiki.title": { "label": "Title", "info": "Main title for the entire wiki" },
      "wiki.lang": { "label": "Language", "info": "Language" },
      "wiki.license": { "label": "License", "info": "License for content created on this wiki" },
      "wiki.disable_registration": { "label": "Disable Registration?", "info": "If set, anonymous users will not be able to register accounts on the wiki" },

      "wiki.license.choice.cc-zero": { "label": "Creative Commons Zero License", "info": "As close to Public Domain as you can get with a license" },
      "wiki.license.choice.publicdomain": { "label": "Public Domain", "info": "Anyone can do anything with it" },
      "wiki.license.choice.cc-by": { "label": "Creative Commons BY License", "info": "Attribution required. https://creativecommons.org/licenses/by/4.0" },
      "wiki.license.choice.cc-by-sa": { "label": "Creative Commons BY SA License", "info": "Attribution + ShareAlike. https://creativecommons.org/licenses/by-sa/4.0" },
      "wiki.license.choice.gnufdl": { "label": "GNU FDL", "info": "GNU Free Documentation License. https://gnu.org/licenses/fdl.html" },
      "wiki.license.choice.cc-by-nc": { "label": "Creative Commons BY NC License", "info": "Attribution + Noncommercial. https://creativecommons.org/licenses/by-nc/4.0" },
      "wiki.license.choice.cc-by-nc-sa": { "label": "Creative Commons BY NC SA License", "info": "Attribution + Noncommercial + ShareAlike. https://creativecommons.org/licenses/by-nc-sa/4.0" },
      "wiki.license.choice.0": { "label": "No License", "info": "Do not specify any license" }
   }
  }
}

In the translations file, we have a main "categories" block, with each category corresponding to the contents of one data bag.

##### Hooking up CloudOs Authentication

Fortunately, DokuWiki supports LDAP authentication. Documentation is here: https://www.dokuwiki.org/plugin:authldap

Just like with the installation, let's walk through a manual set up of LDAP, see what it does, then update our manifest to make sure that stuff gets done.

Following the instructions in the link above, we enable the LDAP plugin.

In the Configuration Settings screen, enter the following for the LDAP configuration:

server: ldap://127.0.0.1:389
usertree: ou=People,cn=cloudos,dc=cloudstead,dc=io
grouptree: ou=Groups,cn=cloudos,dc=cloudstead,dc=io
userfilter: (objectclass=inetorgperson)
groupfiler: (objectclass=groupOfUniqueNames)
version: 3
starttls: unchecked
referrals: unchecked
binddn: cn=admin,dc=cloudstead,dc=io
bindpw: Use the value of LDAP_PASS found in ~cloudos/.cloudos.env

##### Adding a taskbar icon

In the same directory as your manifest file, create a directory named `files`. 
Within that directory, create a file called taskbarIcon.png, this will be the icon shown in the CloudOs task bar.
The ideal taskbar icon is a 400x400 PNG image, containing an icon-style graphic on a transparent background to represent the app.

