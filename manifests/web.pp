# Consul
package {'consul':
  ensure    => installed,
  source    => 'http://hill-storage-repo.s3.amazonaws.com/x86_64/consul-0.2.0-1.fc20.x86_64.rpm',
  provider  => rpm
}
service {'consul':
  ensure  => running,
  enable  => true,
  require => Package['consul'],
}
file {'/etc/sysconfig/consul':
  ensure  => file,
  content => "CMD_OPTS='agent -join 172.20.20.10 -bind $::ipaddress -config-dir /etc/consul.d -data-dir /var/lib/consul'",
  require => Package['consul'],
  notify  => Service['consul']
}

file {'/etc/consul.d/web.json':
  ensure  => file,
  source  => '/vagrant/web.json',
  require => Package['consul'],
  notify  => Service['consul']
}

# Nginx
package {'nginx':
  ensure    => installed,
}
service {'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
file {'/usr/share/nginx/html/index.html':
  ensure  => file,
  content => "<h1>$::hostname</h1>"
}



