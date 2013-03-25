#== Definition: networkmanager::openconnect
#
#Adds an openconnect VPN to NetworkManager
#
#Parameters:
#- *name*: the name of the VPN connection
#- *id*: the id of the VPN connection, defaults to name
#- *ensure* present/absent, defaults to present
#- *uuid*: the UUID of the connection
#- *user*: the user who can use the connection
#- *autoconnect*: whether to autoconnect the VPN
#- *authtype*: authentication type
#- *gateway*: the remote host
#- *xmlconfig*: the xmlconfig for the VPN
#- *gconf_number*: set the connection number in gconf.
#  This is only used for NM < $networkmanager::params::gconf_maxversion
#- *ipv6_method*: IPv6 method (defaults to 'auto')
#- *ipv4_method*: IPv4 method (defaults to 'auto')
#- *never_default*: do not use VPN connection as default route (defaults to 'true')
#
#Requires:
#- Class['networkmanager::openconnect::base']
#- gnome module with gnome::gconf
#
#Example usage:
#
#TODO

define networkmanager::openconnect (
  $uuid,
  $user,
  $gateway,
  $authtype,
  $xmlconfig,
  $gconf_number,
  $ensure='present',
  $id='',
  $autoconnect='false',
  $ipv4_method='auto',
  $ipv6_method='auto',
  $never_default='true'
) {

  $setid = $id ? {
    ''      => $name,
    default => $id,
  }

  include networkmanager::openconnect::base
  include networkmanager::params
  $gconf_path=$networkmanager::params::gconf_path
  $gconf_maxversion=$networkmanager::params::gconf_maxversion

  Gnome::Gconf {
    user => $user,
  }

  # NetworkManager stopped using GConf, in what version exactly ?
  if (versioncmp($::networkmanager_version, $gconf_maxversion) <= 0) {
    gnome::gconf {
      "VPN id for ${name}":
        keyname => "${gconf_path}/${gconf_number}/connection/id",
        type    => 'string',
        value   => $setid;

      "VPN name for ${name}":
        keyname => "${gconf_path}/${gconf_number}/connection/name",
        type    => 'string',
        value   => 'connection';

      "VPN type for ${name}":
        keyname => "${gconf_path}/${gconf_number}/connection/type",
        type    => 'string',
        value   => 'vpn';

      "VPN remote for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/gateway",
        type    => 'string',
        value   => $gateway;

      "VPN service-type for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/service-type",
        type    => 'string',
        value   => 'org.freedesktop.NetworkManager.openconnect';

      "VPN username for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/username",
        type    => 'string',
        value   => $user;

      "VPN xmlconfig for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/xmlconfig",
        type    => 'string',
        value   => $xmlconfig;

      "VPN lasthost for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/lasthost",
        type    => 'string',
        value   => $gateway;

      "VPN authtype for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/authtype",
        type    => 'string',
        value   => $authtype;

      "VPN addresses for ${name}":
        keyname => "${gconf_path}/${gconf_number}/ipv4/addresses",
        type    => 'list', list_type => 'int',
        value   => '[]';

      "VPN dns for ${name}":
        keyname => "${gconf_path}/${gconf_number}/ipv4/dns",
        type    => 'list', list_type => 'int',
        value   => '[]';

      "VPN method for ${name}":
        keyname => "${gconf_path}/${gconf_number}/ipv4/method",
        type    => 'string',
        value   => $ipv4_method;

      "VPN name2 for ${name}":
        keyname => "${gconf_path}/${gconf_number}/ipv4/name",
        type    => 'string',
        value   => 'ipv4';

      "VPN routes for ${name}":
        keyname => "${gconf_path}/${gconf_number}/ipv4/routes",
        type    => 'list', list_type => 'int',
        value   => '[]';
    }
  } else {
    file { "/etc/NetworkManager/system-connections/${name}":
      ensure  => $ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      content => template('networkmanager/openconnect.erb'),
    }
  }
}
