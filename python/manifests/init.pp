class python {
  package { [ 'python-software-properties',
              'python-dev', 
              'python-pip',
              'python-cairo',
              'pkg-config' ] : ensure => installed }
}
