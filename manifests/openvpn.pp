/*
== Class: networkmanager::openvpn::base

Base class to install the openvpn support for NetworkManager
*/

class networkmanager::openvpn::base {
  include networkmanager

  package { "network-manager-openvpn":
    ensure => 'present';
  }
}

/*
== Definition: networkmanager::openvpn

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
  This is only used for NM < $networkmanager::params::gconf_maxversion

Requires:
- Class["networkmanager::openvpn::base"]
- gnome module with gnome::gconf

Example usage:

TODO

*/
define networkmanager::openvpn (
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

  include networkmanager::openvpn::base
  include networkmanager::params
  $gconf_path=$networkmanager::params::gconf_path
  $gconf_maxversion=$networkmanager::params::gconf_maxversion

  # NetworkManager stopped using GConf, in what version exactly ?
  if (versioncmp($networkmanager_version, $gconf_maxversion) <= 0) {
    gnome::gconf {
      "VPN id for ${name}":
        keyname => "${gconf_path}/${gconf_number}/connection/id",
        type => 'string', value => $name, user => $user;
    
      "VPN name for ${name}":
        keyname => "${gconf_path}/${gconf_number}/connection/name",
        type => 'string',value => 'connection', user => $user;
  
      "VPN type for ${name}":
        keyname => "${gconf_path}/${gconf_number}/connection/type",
        type => 'string',value => 'vpn', user => $user;
  
      "VPN ca for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/ca",
        type => 'string', value => $ca, user => $user;
      
      "VPN comp-lzo for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/comp-lzo",
        type => 'string',value => $comp_lzo, user => $user;
        
      "VPN connection-type for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/connection-type",
        type => 'string', value => $connection_type, user => $user;
      
      "VPN remote for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/remote",
        type => 'string', value => $remote, user => $user;
      
      "VPN service-type for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/service-type",
        type => 'string', value => 'org.freedesktop.NetworkManager.openvpn', user => $user;
    
      "VPN ta for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/ta",
        type => 'string', value => $ta, user => $user;
    
      "VPN ta-dir for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/ta-dir",
        type => 'string', value => $ta_dir, user => $user;
  
      "VPN username for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/username",
        type => 'string', value => $user, user => $user;
  
      "VPN addresses for ${name}":
        keyname   => "${gconf_path}/${gconf_number}/ipv4/addresses",
        type => 'list', list_type => 'int', value => '[]', user => $user;
    
      "VPN dns for ${name}":
        keyname => "${gconf_path}/${gconf_number}/ipv4/dns",
        type => 'list', list_type => 'int', value => '[]', user => $user;
    
      "VPN method for ${name}":
        keyname => "${gconf_path}/${gconf_number}/ipv4/method",
        type => 'string', value => $ipv4_method, user => $user;
  
      "VPN name2 for ${name}":
        keyname => "${gconf_path}/${gconf_number}/ipv4/name",
        type => 'string', value => 'ipv4', user => $user;
    
      "VPN routes for ${name}":
        keyname => "${gconf_path}/${gconf_number}/ipv4/routes",
        type => 'list', list_type => 'int', value => '[]', user => $user;
    }
  } else {
    file { "/etc/NetworkManager/system-connections/${name}":
      ensure  => $ensure,
      owner   => root,
      group   => root,
      mode    => 600,
      content => template("networkmanager/openvpn.erb"),
    }
  }
}
