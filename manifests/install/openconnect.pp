# Class networkmanager::install::openconnect
class networkmanager::install::openconnect {
  include ::networkmanager

  if $::networkmanager::manage_packages {
    package { $::networkmanager::params::package_openconnect:
      ensure => $::networkmanager::package_ensure,
    }
    case $::networkmanager::gui {
      'gnome': {
        package { $::networkmanager::params::package_openconnect_gnome:
          ensure => $::networkmanager::package_ensure,
        }
      }
      'kde': {
        package { $::networkmanager::params::package_openconnect_kde:
          ensure => $::networkmanager::package_ensure,
        }
      }
      default: {}
    }
  }
}
