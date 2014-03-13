class networkmanager::install {
  package { 'network-manager':
    ensure => $::networkmanager::version,
  }
}
