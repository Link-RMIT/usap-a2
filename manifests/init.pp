# Class: usap_a2
# ===========================
#
# Full description of class usap_a2 here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'usap_a2':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class usap_a2 {
  notify { 'usap_a2 activated':
  }
  
  group { 'sysadmin':
    ensure => present,
    system => true
  }
  
  group { 'car':
    ensure => present,
  }
  
  user { 'becca':
    ensure   => present,
    home     => '/home/becca',
    groups   => ['sysadmin', 'car'],
    password => 'password',
    uid      => 10018932,
    shell    => '/bin/bash',
  }

  package { ['openssl', 'httpd', 'mariadb','mariadb-server', 'sudo']:
    ensure => installed
  }
  
  #4.d The strace binary must be in the path of everyone’s shell.
  package { 'strace':
    ensure          => installed,
    install_options => ['-ivh','--prefix=/bin'],
  }
  
  service { ['httpd', 'mariadb']:
    enable=>true,
  }
  
  #5. You need to create a host record.
  host { '131.170.1.1':
    ip=>'131.170.1.1',
  }
  
  #6. Whenever the agent runs on a client, output the message
  #  (on the client) “Agent run startin gat <time>”
  exec { 'output_message':
    command=>'/bin/echo Agent run starting at $(/usr/bin/date)',
  }

  
  #8. Using an ERB template with variables
  $student_number = 'sXXX8932'
  file { '/var/www/index.html':
    content => template('usap_a2/index.html.erb')
  }

  #file { '/etc/test' :
  #  owner   => 'root',
  #  group   => 'root',
  #  mode    => '0644',
  #  require => Package['httpd'],
  #  source  => 'puppet:///modules/usap_a2/service.conf',
  #  notify  => Service['httpd'], #ensure each service subscribes to the file
  #}
}
