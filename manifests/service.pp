# Class networkmanager::service
class networkmanager::service {
  if $::networkmanager::manage_service {
    $service_enable = pick($::networkmanager::enable, $::networkmanager::service_enable)
    $service_ensure = $::networkmanager::start ? {
      true    => 'running',
      false   => 'stopped',
      default => $::networkmanager::service_ensure,
    }
    service { $::networkmanager::service:
      ensure => $service_ensure,
      enable => $service_enable,
    }
  }
  exec {'reload nm configuration':
    name        => '/usr/bin/nmcli connection reload',
    refreshonly => true,
  }
}
