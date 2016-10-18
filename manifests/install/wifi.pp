# Class networkmanager::install::wifi
class networkmanager::install::wifi {
  if $::networkmanager::manage_packages {
    $package_ensure = pick($::networkmanager::version, $::networkmanager::package_ensure)
    package { $::networkmanager::params::package_wifi:
      ensure => $package_ensure,
    }
  }
}
