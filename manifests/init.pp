class networkmanager {
  service { "network-manager":
    ensure  => running,
    require => Package["network-manager"],
  }

  package { "network-manager":
    ensure => installed,
  }
}
