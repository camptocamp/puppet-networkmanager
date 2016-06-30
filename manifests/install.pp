# Class networkmanager::install
class networkmanager::install {
  include ::networkmanager

  if $::networkmanager::manage_packages {
    package { $::networkmanager::package:
      ensure => $::networkmanager::package_ensure,
    }
    case $::networkmanager::gui {
      'gnome': {
        package { $::networkmanager::package_gnome:
          ensure => $::networkmanager::package_ensure,
        }
      }
      'kde': {
        package { $::networkmanager::package_kde:
          ensure => $::networkmanager::package_ensure,
        }
      }
      default: {}
    }
  }
}
