class networkmanager::install {
  package { 'network-manager':
    ensure => $::networkmanager::version,
  }
  case $::networkmanager::gui {
    'gnome': {
      package { 'network-manager-gnome':
        ensure => $::networkmanager::version,
      }
    }
    'kde': {
      package { 'plasma-nm':
        ensure => present,
      }
    }
    default: {}
  }
}
