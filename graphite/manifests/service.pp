class graphite::service {
  include graphite::params

  $dir_root = $graphite::params::dir_root
  service { 'carbon-cache.py' :
    alias      => 'carbon',
    ensure     => 'running',
    path       => "$dir_root/bin",
    hasstatus  => true,
    hasrestart => false,
  }
}
