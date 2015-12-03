# Class networkmanager::install::wifi
class networkmanager::install::wifi {
  include ::networkmanager

  if $::networkmanager::manage_packages {
    package { $::networkmanager::params::package_wifi:
      ensure => $::networkmanager::package_ensure,
    }
  }
}
