class graphite::package {
  package { 
     'django' :
       ensure   => '1.3',
       provider => pip;

    [ 'django-tagging',
      'python-memcached',
      'twisted' ] : 
        provider => pip,
        require  => Package['django'];

    [ 'whisper', 'carbon', 'graphite-web' ] :
      ensure   => '0.9.9',
      provider => pip,
      require  => [ Package['twisted'],
                    Package['django-tagging'],
                    Package['python-memcached'] ];
  }

}
