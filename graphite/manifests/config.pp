class graphite::config {
  include concat::setup
  include graphite::params

  $dir_config  = $graphite::params::dir_config
  $dir_webapp  = $graphite::params::dir_webapp
  $dir_storage = $graphite::params::dir_storage
  $time_zone   = $graphite::params::time_zone

  file { 
    "$dir_config/carbon.conf" :
      content => template('graphite/carbon.conf.erb');

    "${dir_webapp}/graphite/local_settings.py" :
      content => template('graphite/local_settings.py.erb');

    "${dir_config}/graphite.wsgi" :
      content => template('graphite/graphite.wsgi.erb');
  }

  exec { 'syncdb' :
    command => '/usr/bin/python manage.py syncdb --noinput' , 
    cwd     => "${dir_webapp}/graphite",
    creates => "$dir_storage/graphite.db",
  }

  concat { "${dir_config}/storage-schemas.conf":
    group   => '0',
    mode    => '0644',
    owner   => '0',
    notify  => Service['carbon'];
  }


}

