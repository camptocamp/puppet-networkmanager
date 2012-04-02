/*
== Class: networkmanager::openvpn::base

Base class to install the openvpn support for NetworkManager
*/

class networkmanager::openvpn::base {
  include networkmanager

  package { 'network-manager-openvpn':
    ensure => 'present';
  }
}

