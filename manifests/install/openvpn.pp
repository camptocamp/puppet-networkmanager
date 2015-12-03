# Class networkmanager::install::openvpn
class networkmanager::install::openvpn {
  include ::networkmanager

  if $::networkmanager::manage_packages {
    package { $::networkmanager::params::package_openvpn:
      ensure => $::networkmanager::package_ensure,
    }
    case $::networkmanager::gui {
      'gnome': {
        package { $::networkmanager::params::package_openvpn_gnome:
          ensure => $::networkmanager::package_ensure,
        }
      }
      'kde': {
        package { $::networkmanager::params::package_openvpn_kde:
          ensure => $::networkmanager::package_ensure,
        }
      }
      default: {}
    }
  }
}
