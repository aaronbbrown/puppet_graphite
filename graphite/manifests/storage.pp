define graphite::storage ( $pattern, 
                           $retentions, 
                           $order = 10 ) {
  include graphite::params
  $dir_config = $graphite::params::dir_config

  concat::fragment {$name:
    target  => "${dir_config}/storage-schemas.conf",
    order   => $order,
    content => template('graphite/storage-schemas.conf.erb'),
    notify  => Service['carbon']
  }
}
