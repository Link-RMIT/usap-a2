class usap_a2::config {

  file { ["/etc/hosts", "/etc/httpd/conf/httpd.conf" ]:
    owner => 'root',
    group => 'root',
    mode => '644',
  }

  # 4.a disable root logins

  # 4.b Apache’s document root needs to be /var/www.
  file { "/etc/httpd/conf/httpd.conf" :
    notify => Service['httpd'],
    require => Package['httpd'],
    source => 'puppet:///modules/usap_a2/service.conf',
  }
  
  # 4.c sudoers must allow becca to sudo to a root shell
  file { "/etc/sudoers":
    owner => 'root',
    group => 'root',
    mode => '440',
    require => Package['sudo'],
  }

  # 4.d The strace binary must be in the path of everyone’s shell
  file { "/etc/profile.d/strace.sh":
    ensure => 'exist',
    content => 'alias strace="/usr/bin/strace"',
  }
  
  file { "/etc/hosts" :
    
  }

}