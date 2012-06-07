/*
== Class: networkmanager::openconnect::base

Base class to install the openconnect support for NetworkManager
*/

class networkmanager::openconnect::base {
  include networkmanager

  package { 'network-manager-openconnect-gnome':
    ensure => 'present';
  }
}

