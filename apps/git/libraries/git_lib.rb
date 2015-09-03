class Chef::Recipe::Git

  KNOWN_HOSTS = ".ssh/known_hosts"

  def self.add_github_hostkey (chef, run_as)
    github_hostkey = chef.node[:git][:github_hostkey]
    known_hosts = "~#{run_as}/#{KNOWN_HOSTS}"
    chef.bash "set github known host key for #{run_as}" do
      user 'root'
      code <<-EOF
sudo -u #{run_as} -H bash -c "echo '#{github_hostkey}' >> #{known_hosts}"
sudo -u #{run_as} -H chmod 644 #{known_hosts}
      EOF
      not_if { File.exist?(known_hosts) && `cat #{known_hosts}`.lines.grep(github_hostkey).size > 0 }
    end
  end

  def self.synchronize (chef, repo, branch, run_as, cwd, dir = nil)
    dir ||= base_name(repo)
    branch ||= 'master'
    is_tag = branch.start_with?('tags/') ? 1 : 0
    chef.bash "synchronize repository #{repo} (branch #{branch}) into dir #{dir}" do
      user 'root'
      code <<-EOF
# for a first-time install, the user dir might be missing. Create it.
if [ ! -d #{cwd} ] ; then
  mkdir -p #{cwd} && chown #{run_as} #{cwd}
fi
cd #{cwd}

is_tag=#{is_tag}
if [ -d "#{dir}/.git" ] ; then
  # it exists. grab the latest code from the (possibly new) branch.
  current_branch="$(cd #{dir} && git rev-parse --abbrev-ref HEAD)"
  if [ ${is_tag} ] ; then
    cd #{dir} && sudo -u #{run_as} -H bash -c "git fetch --all && git reset --hard origin/master && git checkout #{branch}"
  else
    if [ "${current_branch}" != "#{branch}" ] ; then
      cd #{dir} && sudo -u #{run_as} -H bash -c "git fetch --all && git reset --hard origin/#{branch} && git checkout #{branch} && git pull origin #{branch}"
    else
      cd #{dir} && sudo -u #{run_as} -H bash -c "git fetch --all && git reset --hard origin/#{branch} && git pull origin/#{branch}"
    fi
  fi

elif [ -e "#{dir}" ] ; then
  # it exists but is not a git repo? wtf. we bail.
  echo >&2 "git_lib.synchronize ($0): #{dir} exists but is not a git repo (no .git dir)"
  exit 1

else
  # it doesn't exist. create its parent dir and do a fresh clone.
  sudo -u #{run_as} -H bash -c "mkdir -p $(dirname #{dir}) && git clone #{repo} #{dir} && cd #{dir} && git checkout #{branch}"
fi
      EOF
    end
  end

  def self.base_name(repo)
    /\/([-\w]+)\.git/.match(repo)[1]
  end

end
