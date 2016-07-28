NetworkManager
==============

[![Puppet Forge Version](http://img.shields.io/puppetforge/v/camptocamp/networkmanager.svg)](https://forge.puppetlabs.com/camptocamp/networkmanager)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/dt/camptocamp/networkmanager.svg)](https://forge.puppetlabs.com/camptocamp/networkmanager)
[![Build Status](https://img.shields.io/travis/camptocamp/puppet-networkmanager/master.svg)](https://travis-ci.org/camptocamp/puppet-networkmanager)
[![Gemnasium](https://img.shields.io/gemnasium/camptocamp/puppet-networkmanager.svg)](https://gemnasium.com/camptocamp/puppet-networkmanager)
[![By Camptocamp](https://img.shields.io/badge/by-camptocamp-fb7047.svg)](http://www.camptocamp.com)

Overview
--------

Manage NetworkManager connections with Puppet.

Usage
-----

```puppet
include ::networkmanager

$xmlconfig = '...XML describing AnyConnect Profile...'

networkmanager::openconnect { 'My OpenConnect Connection 0':
  user      => 'foo',
  gateway   => '127.0.0.1',
  authtype  => 'password',
  xmlconfig => $xmlconfig,
}

networkmanager::openvpn { 'My OpenVPN Connection 0':
  user            => 'foo',
  ta_dir          => 1,
  connection_type => 'password',
  remote          => '127.0.0.1',
  comp_lzo        => 'yes',
  ca              => '/path/to/my/ca.crt',
  ta              => '/path/to/my/ta.key',
}

networkmanager::wifi { 'My Wifi Connection 0':
  user               => 'foo',
  ssid               => 'mySSID',
  eap                => 'ttls',
  phase2_auth        => 'mschapv2',
  password_raw_flags => 1,
}
```

Reference
---------

Classes:

* [networkmanager](#class-networkmanager)

Resources:

* [networkmanager::openconnect](#resource-networkmanageropenconnect)
* [networkmanager::openvpn](#resource-networkmanageropenvpn)
* [networkmanager::wifi](#resource-networkmanagerwifi)

###Class: networkmanager

####`enable`
Should the service be enabled during boot time ? Default to `true`.

####`openconnect_connections`
A hash of OpenConnect connections to declare.

####`openvpn_connections`
A hash of OpenVPN connections to declare.

####`wifi_connections`
A hash of Wifi connections to declare.

####`start`
Should the service be started by Puppet. Default to `true`.

####`version`
The package version to install. Default to `present`.

####`gui`
The gui packages to install ('gnome', 'kde', or undef). Default to `undef`.

###resource: networkmanager::openconnect

####`authtype`
Authentication type.

####`autoconnect`
Whether to autoconnect the VPN.

####`ensure`
Should the connection be `present` or `absent`. Default to `present`.

####`gateway`
The remote host.

####`id`
The id of the VPN connection, default to `name`.

####`ipv4_method`
IPv4 method. Default to `auto`.

####`ipv6_method`
IPv6 method. Default to `auto`.

####`never_default`
Do not use VPN connection as default route. Default to `true`.

####`user`
The user who can use the connection.

####`uuid`
The UUID of the connection. Default to MD5 of `name`.

####`xmlconfig`
The xmlconfig for the VPN.

###resource: networkmanager::openvpn

####`autoconnect`
Whether to autoconnect the VPN.

####`ca`
Path to the CA certificate.

####`comp_lzo`
Whether to use LZO compression.

####`connection_type`
The connection type.

####`ensure`
Should the connection be `present` or `absent`. Default to `present`.

####`id`
The id of the VPN connection. Default to `name`.

####`ipv4_method`
IPv4 method. Default to `auto`.

####`never_default`
Do not use VPN connection as default route. Default to `true`.

####`password_flags`
The password flags.

####`remote`
The remote host.

####`routes`

####`ta`
Path to the TA key.

####`ta_dir`
Whether to use a ta directory.

####`user`
The user who can use the connection.

####`uuid`
The UUID of the connection. Default to MD5 of `name`.

###resource: networkmanager::wifi

####`auth_alg`

####`autoconnect`

####`eap`

####`ensure`
Should the connection be `present` or `absent`. Default to `present`.

####`ipv4_method`
IPv4 method. Default to `auto`.

####`ipv6_method`
IPv6 method. Default to `auto`.

####`key_mgmt`

####`mac_address`

####`mode`

####`nma_ca_cert_ignore`

####`password_raw_flags`

####`phase2_auth`

####`security`

####`ssid`
The ssid of the connection.

####`user`
The user who can use the connection.

####`uuid`
The UUID of the connection. Default to MD5 of `name`.

