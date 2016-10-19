# Class networkmanager::install::openvpn
class networkmanager::install::openvpn {
  if $::networkmanager::manage_packages {
    $package_ensure = pick($::networkmanager::version, $::networkmanager::package_ensure)
    $package = $::networkmanager::gui ? {
      'gnome' => $::networkmanager::params::package_openvpn_gnome,
      'kde'   => $::networkmanager::params::package_openvpn_kde,
      default => $::networkmanager::package_gui_openvpn,
    }
    if $package {
      package { $package:
        ensure => $package_ensure,
      }
    }
  }
}
