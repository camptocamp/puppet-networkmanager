class networkmanager::service {
  $ensure = $::networkmanager::start ? {
    true    => running,
    default => stopped,
  }

  service { 'network-manager':
    ensure => $ensure,
    enable => $::networkmanager::enable,
  }

  exec {'reload nm configuration':
    name        => '/usr/bin/nmcli connection reload',
    refreshonly => true,
  }
}
