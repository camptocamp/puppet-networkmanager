# Class networkmanager::install::openconnect
class networkmanager::install::openconnect {
  if $::networkmanager::manage_packages {
    $package_ensure = pick($::networkmanager::version, $::networkmanager::package_ensure)
    $package = $::networkmanager::gui ? {
      'gnome' => $::networkmanager::params::package_openconnect_gnome,
      'kde'   => $::networkmanager::params::package_openconnect_kde,
      default => $::networkmanager::package_gui_openconnect,
    }
    if $package {
      package { $package:
        ensure => $package_ensure,
      }
    }
  }
}
