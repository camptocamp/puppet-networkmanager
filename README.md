NetworkManager
==============

[![Build Status](https://travis-ci.org/camptocamp/puppet-networkmanager.png?branch=master)](https://travis-ci.org/camptocamp/puppet-networkmanager)

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
Should the service be enabled during boot time ? Defaults to `true`.

####`openconnect_connections`
A hash of OpenConnect connections to declare.

####`openvpn_connections`
A hash of OpenVPN connections to declare.

####`wifi_connections`
A hash of Wifi connections to declare.

####`start`
Should the service be started by Puppet. Defaults to `true`.

####`version`
The package version to install. Defaults to `present`.

####`gui`
Wether to install the packages for the gnome GUI. Defaults to `false`.

###resource: networkmanager::openconnect

####`authtype`
Authentication type.

####`autoconnect`
Whether to autoconnect the VPN.

####`ensure`
Should the connection be `present` or `absent`. Defaults to `present`.

####`gateway`
The remote host.

####`id`
The id of the VPN connection, defaults to `name`.

####`ipv4_method`
IPv4 method. Defaults to `auto`.

####`ipv6_method`
IPv6 method. Defaults to `auto`.

####`never_default`
Do not use VPN connection as default route. Defaults to `true`.

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
Should the connection be `present` or `absent`. Defaults to `present`.

####`id`
The id of the VPN connection. Defaults to `name`.

####`ipv4_method`
IPv4 method. Defaults to `auto`.

####`never_default`
Do not use VPN connection as default route. Defaults to `true`.

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
Should the connection be `present` or `absent`. Defaults to `present`.

####`ipv4_method`
IPv4 method. Defaults to `auto`.

####`ipv6_method`
IPv6 method. Defaults to `auto`.

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

