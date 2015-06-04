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
      not_if { File.exists?(known_hosts) && `cat #{known_hosts}`.lines.grep(github_hostkey).size > 0 }
    end
  end

  def self.synchronize (chef, repo, branch, run_as, cwd, dir = nil)
    dir ||= base_name(repo)
    chef.bash "synchronize repository #{repo} (branch #{branch}) into dir #{dir}" do
      user 'root'
      cwd cwd
      code <<-EOF
if [ -d "#{dir}/.git" ] ; then
  # it exists. grab the latest code from the (possibly new) branch.
  current_branch="$(cd #{dir} && git rev-parse --abbrev-ref HEAD)"
  if [ "${current_branch}" != "#{branch}" ] ; then
    cd #{dir} && sudo -u #{run_as} -H bash -c "git fetch && git checkout #{branch} && git pull origin #{branch}"
  else
    cd #{dir} && sudo -u #{run_as} -H bash -c "git fetch && git pull origin #{branch}"
  fi

elif [ -e "#{dir}" ] ; then
  # it exists but is not a git repo? wtf. we bail.
  echo >&2 "git_lib.synchronize ($0): #{dir} exists but is not a git repo (no .git dir)"
  exit 1

else
  # it doesn't exist. fresh clone.
  sudo -u #{run_as} -H git clone #{repo} --branch #{branch} #{dir}
fi
      EOF
      not_if { File.exists? "#{cwd}/#{dir}"  }
    end
  end

  def self.base_name(repo)
    /\/([-\w]+)\.git/.match(repo)[1]
  end

end
