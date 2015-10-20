#!/bin/bash

function die {
  echo 1>&2 "${1}"
  exit 1
}

if [ "$(whoami)" != "root" ] ; then
  die "Must be root"
fi

JENKINS_USER="${1:?no jenkins-user argument provided}"
JENKINS_HOME="${2:?no jenkins-home argument provided}"

PLUGIN_BASE="http://updates.jenkins-ci.org/latest"
plugin_dir="${JENKINS_HOME}/plugins"
mkdir -p ${plugin_dir} && chown ${JENKINS_USER} ${plugin_dir} || die "*** Error creating plugin dir: ${plugin_dir}"

if [ -z "${PLUGINS}" ] ; then
  die "No PLUGINS found in env"
fi

# stash list of existing plugins
existing_plugins="$(cd ${plugin_dir} && find . -maxdepth 1 -type f -name "*.?pi" | xargs -n 1 basename | awk -F '.' '{print $1}' | sort)"
BUILTIN_PLUGINS="ant
antisamy-markup-formatter
credentials
cvs
external-monitor-job
javadoc
junit
ldap
mailer
matrix-auth
matrix-project
maven-plugin
pam-auth
script-security
ssh-credentials
ssh-slaves
subversion
translation
windows-slaves"

function install_plugin {
  plugin="${1}"
  remove_existing="${2}"

  for builtin in ${BUILTIN_PLUGINS} ; do
    if [ "${plugin}" = "${builtin}" ] ; then
      echo "--- Skipping builtin plugin: ${plugin}"
      return
    fi
  done

  plugin_url="${PLUGIN_BASE}/${plugin}.hpi"
  temp_plugin=$(mktemp /tmp/jenkins_plugins.XXXXXXX) || die "*** Error creating temp file for plugin"

  echo "Downloading plugin: ${plugin_url}"
  curl -sL ${plugin_url} > ${temp_plugin} || die "*** Error downloading plugin ${plugin_url} -> ${temp_plugin}"
  if [ $(du -k ${temp_plugin} | awk '{print $1}') -le 1 ] ; then
    die "*** Plugin was too small: ${temp_plugin}"
  fi

  existing_file="${plugin_dir}/${plugin}.jpi"
  if [ ! -f ${existing_file} ] ; then
    existing_file="${plugin_dir}/${plugin}.hpi"
    if [ ! -f ${existing_file} ] ; then
      echo "~~~ No existing file could be found for plugin ${plugin}"
      existing_file="${plugin_dir}/${plugin}.jpi"
    fi
  fi

  if cmp ${temp_plugin} ${existing_file} 2> /dev/null ; then
    echo "--- Plugin ${plugin} is already at the latest version, not upgrading"
    rm ${temp_plugin}
  else
    chown ${JENKINS_USER} ${temp_plugin} || die "*** Error setting ownership of ${temp_plugin}"
    if [[ ! -z "${remove_existing}" && "${remove_existing}" == "purge_existing" ]] ; then
      echo "removing older plugin: ${plugin_dir}/${plugin} ${plugin_dir}/${plugin}.*"
      rm -rf ${plugin_dir}/${plugin} ${plugin_dir}/${plugin}.*
    fi
    mv ${temp_plugin} ${existing_file} || die "*** Error moving plugin ${temp_plugin} -> ${existing_file}"
    echo "+++ Installed ${plugin} to ${existing_file}"
  fi
}

service jenkins stop

# install new plugins
for plugin in ${PLUGINS} ; do
  install_plugin ${plugin}
done

# upgrade existing plugins
for plugin in ${existing_plugins} ; do
  install_plugin ${plugin} purge_existing
done

service jenkins restart
