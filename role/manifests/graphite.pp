class role::graphite {
  package { ['memcached', 'python-dev', 'python-pip', 'sqlite3',
            'libcairo2', 'libcairo2-dev', 'python-cairo', 'pkg-config',
            'python-software-properties' ] : ensure => installed }

  include git
  include nodejs
  include ::graphite
  include statsd
  include apache
  include apache::mod::python
  include apache::mod::wsgi
  include ::graphite::params

  $dir_config  = $graphite::params::dir_config
  $dir_webapp  = $graphite::params::dir_webapp

  graphite::storage { 'statsd' :
    order      => '10',
    pattern    => '^stats\..*',
    retentions => '10:2160,60:10080,600:262974',
  }
  graphite::storage {'default_1sec':
    order      => '9990',
    pattern    => '\.load\.',
    retentions => '1s:7d,60s:720d',
  }

  graphite::storage {'default_1min_for_720days':
    order      => '9999',
    pattern    => '.*',
    retentions => '60s:720d',
  }

  apache::vhost { 'graphite' :
    port       => '80',
    docroot    => $dir_webapp,
    template   => 'role/graphite-vhost.conf.erb',
    servername => 'graphite',
  }
}
