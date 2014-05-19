class networkmanager::install {
  package { 'network-manager':
    ensure => $::networkmanager::version,
  }
  if $::networkmanager::gui {
    package { 'network-manager-gnome':
      ensure => $::networkmanager::version,
    }
  }
}
