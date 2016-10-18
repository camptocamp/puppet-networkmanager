# Class networkmanager::install
class networkmanager::install {
  if $::networkmanager::manage_packages {
    $package_ensure = pick($::networkmanager::version, $::networkmanager::package_ensure)
    $package_gui = $::networkmanager::gui ? {
      'gnome' => $::networkmanager::params::package_gnome,
      'kde'   => $::networkmanager::params::package_kde,
      default => $::networkmanager::package_gui,
    }
    package {[$::networkmanager::package,$package_gui]:
      ensure => $package_ensure,
    }
  }
}
