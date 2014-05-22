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
  content => "CMD_OPTS='agent -bootstrap -server -bind $::ipaddress -config-dir /etc/consul.d -data-dir /var/lib/consul'",
  require => Package['consul'],
  notify  => Service['consul']
}

# Dsmasq
package {'dnsmasq':
  ensure => installed,
}
service {'dnsmasq':
  ensure => running,
  enable => true,
}
file {'/etc/dnsmasq.d/10-consul':
  ensure  => file,
  content => 'server=/consul/127.0.0.1#8600',
  notify  => Service['dnsmasq']
}
file {'/etc/resolv.conf':
  ensure  => file,
  content => "nameserver 127.0.0.1\nnameserver 8.8.8.8\n"
}

# Synapse
package {'synapse':
  ensure    => installed,
  provider  => gem,
  require   => [Package['ruby-devel'], Package['patch'], Package['gcc'], Package['haproxy']]
}
package {'ruby-devel':
  ensure => installed,
}
package {'patch':
  ensure => installed,
}
package {'gcc':
  ensure => installed,
}
package {'haproxy':
  ensure => installed,
}
service {'haproxy':
  ensure  => running,
  enable  => true,
  require => Package['haproxy'],
}
file {'/etc/systemd/system/synapse.service':
  ensure  => file,
  source  => '/vagrant/synapse.service',
  notify  => Service['synapse']
}
file {'/etc/synapse.conf.json':
  ensure  => file,
  source  => '/vagrant/synapse.conf.json',
  notify  => Service['synapse']
}
service {'synapse':
  ensure  => running,
  enable  => true,
  require => [File['/etc/systemd/system/synapse.service'], File['/etc/synapse.conf.json'], Package['synapse']]
}









