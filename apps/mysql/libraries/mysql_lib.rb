class Chef::Recipe::Mysql

  MYSQL_ROOT = 'mysql --defaults-file=$(cd ~root && pwd)/.my.cnf -s -u root'

  def self.set_config (chef, group, key, value)
    mysql_cnf = "/etc/mysql/conf.d/#{group}__#{key}.cnf"
    chef.bash "set #{key}=#{value} via #{mysql_cnf}" do
      user "root"
      code <<-EOH
echo "[#{group}]
#{key}=#{value}" > #{mysql_cnf}
      EOH
    end
  end

  def self.set_password(chef, user, password)
    chef.bash "set password for mysql user #{user} at #{Time.now}" do
      user 'root'
      code <<-EOF
HOME=$(cd ~#{user} && pwd)
echo "UPDATE mysql.user SET Password=PASSWORD(\'#{password}\') WHERE User=\'#{user}\'; FLUSH PRIVILEGES;" | #{MYSQL_ROOT}
if [ -d ${HOME} ] ; then
  CNF="${HOME}/.my.cnf"
  if [ -f ${CNF} ] ; then
    sed -ie 's/^[[:space:]]*password[[:space:]]*=[[:space:]]*.*$/password=#{password}/' ${CNF}
  else
    echo "[client]
password=#{password}
" > ${CNF}
  fi
  if [ -f ${CNF} ] ; then
    chmod 400 ${CNF}
    chown #{user} ${CNF}
  fi
fi
      EOF
    end
  end

  def self.create_user (chef, dbuser, dbpass, allow_create_db = nil)
    chef.bash "create mysql user #{dbuser} at #{Time.now}" do
      user 'root'
      code <<-EOF
EXISTS=$(echo "select count(*) from mysql.user where User='#{dbuser}'" | #{MYSQL_ROOT} | tr -d ' ')
if [ ${EXISTS} -gt 0 ] ; then
  echo "User already exists: #{dbuser}"
else
  echo "CREATE USER #{dbuser} IDENTIFIED BY '#{dbpass}'" | #{MYSQL_ROOT}
fi
      EOF
    end
  end

  def self.drop_user (chef, dbuser)
    chef.bash "dropping mysql user #{dbuser}" do
      user 'root'
      code <<-EOF
echo "DELETE USER '#{dbuser}'" | #{MYSQL_ROOT}
      EOF
      not_if { %x(echo "select count(*) from mysql.user where User='#{dbuser}'" | #{MYSQL_ROOT}).to_i == 0 }
    end
  end

  def self.db_exists (dbname)
    %x(echo "show databases" | #{MYSQL_ROOT}).lines.grep(/#{dbname}/).size > 0
  end

  def self.find_matching_databases (match)
    %x(echo "show databases" | #{MYSQL_ROOT}).lines.grep(/#{match}/).collect { |db| db.chop }
  end

  def self.create_db (chef, dbname, dbuser, force = false)
    force_clause = force ? "|| echo 'Error creating database #{dbname}'" : ''
    chef.bash "create mysql database #{dbname} at #{Time.now}" do
      user 'root'
      code <<-EOF
EXISTS=$(echo "show databases" | #{MYSQL_ROOT} | grep #{dbname} | wc -l | tr -d ' ')
if [ ${EXISTS} -gt 0 ] ; then
  if [ -z "#{force_clause}" ] ; then
    echo "Database already exists: #{dbname}"
  else
    echo "DROP DATABASE #{dbname}" | #{MYSQL_ROOT} #{force_clause}
    echo "CREATE DATABASE #{dbname}" | #{MYSQL_ROOT} #{force_clause}
  fi
else
  echo "CREATE DATABASE #{dbname}" | #{MYSQL_ROOT} #{force_clause}
fi
      EOF
    end
    grant_access chef, dbname, dbuser, force
  end

  def self.grant_access (chef, dbname, dbuser, force = false)
    force_clause = force ? "|| echo 'Error granting #{dbuser} access to #{dbname}'" : ''
    chef.bash "grant #{dbuser} access to mysql database #{dbname} at #{Time.now}" do
      user 'root'
      code <<-EOF
EXISTS=$(echo "show grants" | mysql -u #{dbuser} | grep "GRANT ALL PRIVILEGES ON \\`#{dbname}\\`.* TO '#{dbuser}'@'%'" | wc -l | tr -d ' ')
if [ ${EXISTS} -eq 0 ] ; then
  echo "GRANT ALL ON #{dbname}.* TO '#{dbuser}'" | #{MYSQL_ROOT} #{force_clause}
fi
      EOF
    end
  end

  def self.count_tables(dbname, dbuser, dbpass)
    %x(echo "show tables" | #{MYSQL_ROOT} #{dbname}).lines.grep(/#{dbname}/).size
  end

  def self.has_tables(dbname, dbuser, dbpass)
    count_tables(dbname, dbuser, dbpass) > 0
  end

  def self.table_exists(dbname, dbuser, dbpass, tablename)
    if tablename
      %x(echo "show tables" | mysql -s -u #{dbuser} -p#{dbpass} #{dbname} | grep #{tablename}).lines.grep(/#{tablename}/).size > 0
    else
      %x(echo "show tables" | mysql -s -u #{dbuser} -p#{dbpass} #{dbname} | wc -l).strip.to_i > 0
    end
  end

  def self.initialize_db(chef, file, dbuser, dbpass, dbname, tablename = nil)
    run_script chef, file, dbuser, dbpass, dbname unless table_exists(dbname, dbuser, dbpass, tablename)
  end

  def self.run_script(chef, script, dbuser, dbpass, dbname)
    chef.bash "running #{script} against #{dbname} " do
      user 'root'
      code <<-EOF
cat #{script} | mysql -u #{dbuser} -p#{dbpass} -h 127.0.0.1 #{dbname}
      EOF
    end
  end

  def self.insert(chef, dbuser, dbname, insert)

    hash1 = Digest::SHA256.hexdigest(insert[:sql])
    hash2 = Digest::SHA256.hexdigest(insert[:unless])

    sql = "/tmp/sql_insert_#{hash1}.sql"
    File.open(sql, "w") do |f|
      f.write(insert[:sql])
    end

    check_sql = "/tmp/check_sql_#{hash2}.sql"
    File.open(check_sql, "w") do |f|
      f.write(insert[:unless])
    end

    mysql="#{MYSQL_ROOT} #{dbname}"

    chef.bash "insert into #{dbname} DB schema: #{insert[:sql]}" do
      user 'root'
      code <<-EOF
found=$(cat #{check_sql} | #{mysql} | tr -d [:blank:])
if [[ -z "${found}" || ${found} -eq 0 ]] ; then
  output=$(cat #{sql} | #{mysql} 2>&1)
  errors=$(echo -n "${output}" | grep ERROR | wc -l | tr -d ' ')
  if [ $errors -gt 0 ] ; then
    echo "Error inserting sql: #{%x(cat #{sql}).strip}: ${output}"
    exit 1
  fi
fi
EOF
      not_if { %x(cat #{check_sql} | #{mysql}").strip.to_i > 0 }
    end
  end

  def self.restart(chef)
      chef.bash 'restart mysql' do
      user 'root'
      code <<-EOH
if [[ "$(service mysql status)" =~ "stop" ]] ; then
  service mysql start
else
  service mysql reload
fi
      EOH
    end
  end

  def self.dump(chef, dbname, dbuser='root', dumpfile)
    chef.bash "dumping #{dbname} to #{dumpfile} " do
      user dbuser
      code <<-EOF
mysqldump #{dbname} > #{dumpfile}
      EOF
    end
  end

  def self.drop_db (chef, dbname)
    exists = db_exists dbname
    chef.bash "dropping mysql database #{dbname} at #{Time.now}" do
      user 'root'
      code <<-EOF
yes | mysqladmin -u root drop #{dbname}
EOF
      only_if { exists }
    end
  end

  def self.create_metadata_table(chef, schema_name, schema_version, dbname, dbuser, dbpass)
    lib = self
    chef.bash "initialize #{dbname} DB schema metadata with version #{schema_name}/#{schema_version}" do
      user 'root'
      code <<-EOF
echo "
CREATE TABLE __cloudos_metadata__ (m_category varchar(255), m_name varchar(255), m_value varchar(255), m_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
INSERT INTO __cloudos_metadata__ (m_category, m_name, m_value) VALUES ('schema_version', '#{schema_name}', '#{schema_version}');
" \
  | #{MYSQL_ROOT} #{dbname}
      EOF
      not_if { lib.table_exists(dbname, dbuser, dbpass, '__cloudos_metadata__') }
    end
  end

  def self.update_schema(chef, schema_name, schema_version, schema_file, dbname, dbuser, dbpass)
    chef.bash "update #{dbname} DB schema metadata with version: #{schema_name}/#{schema_version}" do
      user 'root'
      code <<-EOF
temp=$(mktemp /tmp/update_schema.XXXXXX.sql)
echo "START TRANSACTION WITH CONSISTENT SNAPSHOT; SET autocommit=0;" >> ${temp}
cat #{schema_file} >> ${temp}
echo "
INSERT INTO __cloudos_metadata__ (m_category, m_name, m_value) VALUES ('schema_version', '#{schema_name}', '#{schema_version}');
" >> ${temp}
echo "COMMIT;" >> ${temp}

cat ${temp} | #{MYSQL_ROOT} #{dbname}
      EOF
    end
  end

  def self.get_schema_version(chef, dbname, dbuser, dbpass, schema_name)
    %x(echo "SELECT m_value FROM __cloudos_metadata__ WHERE m_category='schema_version' AND m_name='#{schema_name}' ORDER BY m_time DESC LIMIT 1" | #{MYSQL_ROOT} #{dbname}).strip
  end

end