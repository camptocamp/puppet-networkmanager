/*
== Class: network-manager::openvpn::base

Base class to install the openvpn support for NetworkManager
*/

class network-manager::openvpn::base {
  include network-manager

  package { "network-manager-openvpn":
    ensure => 'present';
  }
}

/*
== Definition: network-manager::openvpn

Adds an openvpn VPN to NetworkManager

Parameters:
- *name*: the name of the VPN connection
- *ensure* present/absent, defaults to present
- *uuid*: the UUID of the connection
- *user*: the user who can use the connection
- *autoconnect*: whether to autoconnect the VPN
- *ta_dir*: whether to use a ta directory
- *connection_type*: the connection type
- *password_flags*
- *remote*: the remote host
- *comp_lzo*: whether to use LZO compression
- *ca*: path to the CA certificate
- *ta*: path to the TA key
- *gconf_number*: set the connection number in gconf.
  This is only used for NM < 0.9.2

Requires:
- Class["network-manager::openvpn::base"]
- gnome module with gnome::gconf

Example usage:

TODO

*/
define network-manager::openvpn (
  $ensure=present,
  $uuid,
  $user,
  $autoconnect=false,
  $ta_dir,
  $connection_type,
  $password_flags,
  $remote,
  $comp_lzo,
  $ca,
  $ta,
  $ipv4_method=auto,
  $gconf_number
) {

  include network-manager::openvpn::base
  include network-manager::params

  # NetworkManager stopped using GConf, in what version exactly ?
  if (versioncmp($networkmanager_version, "0.9.2") < 0) {
    gnome::gconf {
      "VPN id for ${name}":
        keyname => "${gconf_path}${gconf_number}/connection/id",
        type => 'string', value => $name, user => $user;
    
      "VPN name for ${name}":
        keyname => "${gconf_path}${gconf_number}/connection/name",
        type => 'string',value => 'connection', user => $user;
  
      "VPN type for ${name}":
        keyname => "${gconf_path}${gconf_number}/connection/type",
        type => 'string',value => 'vpn', user => $user;
  
      "VPN ca for ${name}":
        keyname => "${gconf_path}${gconf_number}/vpn/ca",
        type => 'string', value => $ca, user => $user;
      
      "VPN comp-lzo for ${name}":
        keyname => "${gconf_path}${gconf_number}/vpn/comp-lzo",
        type => 'string',value => $comp_lzo, user => $user;
        
      "VPN connection-type for ${name}":
        keyname => "${gconf_path}${gconf_number}/vpn/connection-type",
        type => 'string', value => $connection_type, user => $user;
      
      "VPN remote for ${name}":
        keyname => "${gconf_path}${gconf_number}/vpn/remote",
        type => 'string', value => $remote, user => $user;
      
      "VPN service-type for ${name}":
        keyname => "${gconf_path}${gconf_number}/vpn/service-type",
        type => 'string', value => 'org.freedesktop.NetworkManager.openvpn', user => $user;
    
      "VPN ta for ${name}":
        keyname => "${gconf_path}${gconf_number}/vpn/ta",
        type => 'string', value => $ta, user => $user;
    
      "VPN ta-dir for ${name}":
        keyname => "${gconf_path}${gconf_number}/vpn/ta-dir",
        type => 'string', value => $ta_dir, user => $user;
  
      "VPN username for ${name}":
        keyname => "${gconf_path}${gconf_number}/vpn/username",
        type => 'string', value => $user, user => $user;
  
      "VPN addresses for ${name}":
        keyname   => "${gconf_path}${gconf_number}/ipv4/addresses",
        type => 'list', list_type => 'int', value => '[]', user => $user;
    
      "VPN dns for ${name}":
        keyname => "${gconf_path}${gconf_number}/ipv4/dns",
        type => 'list', list_type => 'int', value => '[]', user => $user;
    
      "VPN method for ${name}":
        keyname => "${gconf_path}${gconf_number}/ipv4/method",
        type => 'string', value => $ipv4_method, user => $user;
  
      "VPN name2 for ${name}":
        keyname => "${gconf_path}${gconf_number}/ipv4/name",
        type => 'string', value => 'ipv4', user => $user;
    
      "VPN routes for ${name}":
        keyname => "${gconf_path}${gconf_number}/ipv4/routes",
        type => 'list', list_type => 'int', value => '[]', user => $user;
    }
  } else {
    file { "/etc/NetworkManager/system-connections/${name}":
      ensure  => $ensure,
      owner   => root,
      group   => root,
      mode    => 600,
      content => template("network-manager/openvpn.erb"),
    }
  }
}
