# Class networkmanager::install::wifi
class networkmanager::install::wifi {
  if $::networkmanager::manage_packages {
    $package_ensure = pick($::networkmanager::version, $::networkmanager::package_ensure)
    if $::networkmanager::params::package_wifi {
      package { $::networkmanager::params::package_wifi:
        ensure => $package_ensure,
      }
    }
  }
}
