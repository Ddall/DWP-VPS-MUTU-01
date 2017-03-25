class vhost-pizz-savoyarde{

  $projectname = "pizz-savoyarde"
  $fqdn = "http://pizz-savoyarde.web-ifs73.fr"
  $port = '80'

  ## CUSTOMIZE
  $httpHome = "/home/web"
  $webrootdir = "${httpHome}/${projectname}/web"
  $mysql_username = "${projectname}"
  $mysql_database = "${projectname}_db"

  ## DO NOT EDIT PAST THIS ---------------------------------------------------------

  require httpd

  ## webrootdir

  file { $httpHome :
    ensure => directory,
    owner => "www-data",
    group => "www-data",
  }

  file { "${httpHome}/${projectname}" :
    ensure => directory,
    owner => "www-data",
    group => "www-data",
  }

  file { $webrootdir :
    ensure => directory,
    owner => "www-data",
    group => "www-data",
  }

  ## vhost
  apache::vhost { $fqdn:
    # servername => $fqdn,
    port       => $port,
    docroot    => $webrootdir,
    access_log_file => "${projectname}_access.log",
    error_log_file  => "${projectname}_error.log",
  }


  ## mysql
  mysql_database { $mysql_database:
    ensure  => "present",
    charset => "utf8",
    collate => "utf8_general_ci",
  }

  mysql_user { "${mysql_username}@127.0.0.1":
    ensure                   => "present",
    max_connections_per_hour => "0",
    max_queries_per_hour     => "0",
    max_updates_per_hour     => "0",
    max_user_connections     => "0",
  }

  mysql_grant { "${mysql_username}@127.0.0.1/${mysql_database}.*":
    ensure     => present,
    privileges => ["ALL PRIVILEGES"],
    table      => "${mysql_database}.*",
    user       => "${mysql_username}@127.0.0.1",
  }

  ## double up for hostname
  mysql_user { "${mysql_username}@localhost":
    ensure                   => "present",
    max_connections_per_hour => "0",
    max_queries_per_hour     => "0",
    max_updates_per_hour     => "0",
    max_user_connections     => "0",
  }

  mysql_grant { "${mysql_username}@localhost/${mysql_database}.*":
    ensure     => present,
    privileges => ["ALL PRIVILEGES"],
    table      => "${mysql_database}.*",
    user       => "${mysql_username}@localhost",
  }


}
