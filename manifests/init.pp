class networkmanager {
  service { "network-manager":
    ensure  => running,
    require => Package["network-manager"],
  }

  package { "network-manager":
    ensure => installed,
  }

  augeas::lens { "networkmanager":
    lens_source => "puppet:///modules/networkmanager/lenses/networkmanager.aug",
    test_source => "puppet:///modules/networkmanager/lenses/test_networkmanager.aug",
  }
}
