#Configureation
class usap_a2::config {

  file {'/etc/puppetlabs/puppet/puppet.conf':
    ensure => exist,
    owner  => 'pe-puppet',
    group  => 'pe-puppet',
    mode   => '0600',
    source => 'puppet:///modules/usap_a2/puppet.conf',
  }

  # 4.a disable root logins
  file {'/etc/ssh/sshd_config':
    ensure => exist,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/usap_a2/sshd_confg',
  }
  

  # 4.b Apache’s document root needs to be /var/www.
  file { '/etc/httpd/conf/httpd.conf' :
    ensure  => exist,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['httpd'],
    source  => 'puppet:///modules/usap_a2/service.conf',
    notify  => Service['httpd'], #ensure each service subscribes to the file
  }
  
  # 4.c sudoers must allow becca to sudo to a root shell
  file { '/etc/sudoers':
    ensure  => exist,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    require => Package['sudo'],
    source  => 'puppet:///modules/usap_a2/sudoers',
  }

  # 4.d The strace binary must be in the path of everyone’s shell
  #file { "/etc/profile.d/strace.sh":
  #  content => 'alias strace="/usr/bin/strace"',
  #}
  
  #5.a Ensure a host record for usap.rmit.edu.au is pointed to 131.170.1.1  
  #file { '/etc/hosts' :
  #  ensure => exist,
  #  owner  => 'root',
  #  group  => 'root',
  #  mode   => '0644',
  #  source => 'puppet:///modules/usap_a2/hosts',
  #}

  #6. Whenever the agent runs on a client, output the message 
  #   (on the client) "Agent run starting at <time>"

}