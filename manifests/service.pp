# Class networkmanager::service
class networkmanager::service {
  include ::networkmanager

  if $::networkmanager::manage_service {
    service { $::networkmanager::params::service:
      ensure => $::networkmanager::service_ensure,
      enable => $::networkmanager::service_enable,
    }
  }
}
