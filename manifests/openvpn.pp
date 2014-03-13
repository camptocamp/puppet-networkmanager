# == Definition: networkmanager::openvpn
#
# Adds an openvpn VPN to NetworkManager
#
# Parameters:
# - *name*: the name of the VPN connection
# - *id*: the id of the VPN connection, defaults to name
# - *ensure* present/absent, defaults to present
# - *uuid*: the UUID of the connection
# - *user*: the user who can use the connection
# - *autoconnect*: whether to autoconnect the VPN
# - *ta_dir*: whether to use a ta directory
# - *connection_type*: the connection type
# - *password_flags*
# - *remote*: the remote host
# - *comp_lzo*: whether to use LZO compression
# - *ca*: path to the CA certificate
# - *ta*: path to the TA key
# - *gconf_number*: set the connection number in gconf.
#   This is only used for NM < $networkmanager::params::gconf_maxversion
# - *ipv4_method*: IPv4 method (defaults to 'auto')
# - *never_default*: do not use VPN connection as default route.
#   (defaults to 'true')
#
# Requires:
# - Class['networkmanager::openvpn::base']
# - gnome module with gnome::gconf
#
# Example usage:
#
# TODO
#
define networkmanager::openvpn (
  $user,
  $ta_dir,
  $connection_type,
  $password_flags,
  $remote,
  $comp_lzo,
  $ca,
  $ta,
  $gconf_number,
  $uuid          = regsubst(
    md5($name), '^(.{8})(.{4})(.{4})(.{4})(.{12})$', '\1-\2-\3-\4-\5'),
  $ensure        = 'present',
  $id            = '',
  $autoconnect   = 'false',
  $ipv4_method   = 'auto',
  $never_default = 'true',
  $routes        = '',
) {

  $setid = $id ? {
    ''      => $name,
    default => $id,
  }

  include networkmanager::openvpn::base
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

      "VPN ca for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/ca",
        type    => 'string',
        value   => $ca;

      "VPN comp-lzo for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/comp-lzo",
        type    => 'string',
        value   => $comp_lzo;

      "VPN connection-type for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/connection-type",
        type    => 'string',
        value   => $connection_type;

      "VPN remote for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/remote",
        type    => 'string',
        value   => $remote;

      "VPN service-type for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/service-type",
        type    => 'string',
        value   => 'org.freedesktop.NetworkManager.openvpn';

      "VPN ta for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/ta",
        type    => 'string',
        value   => $ta;

      "VPN ta-dir for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/ta-dir",
        type    => 'string',
        value   => $ta_dir;

      "VPN username for ${name}":
        keyname => "${gconf_path}/${gconf_number}/vpn/username",
        type    => 'string',
        value   => $user;

      "VPN addresses for ${name}":
        keyname   => "${gconf_path}/${gconf_number}/ipv4/addresses",
        type      => 'list',
        list_type => 'int',
        value     => '[]';

      "VPN dns for ${name}":
        keyname   => "${gconf_path}/${gconf_number}/ipv4/dns",
        type      => 'list',
        list_type => 'int',
        value     => '[]';

      "VPN method for ${name}":
        keyname => "${gconf_path}/${gconf_number}/ipv4/method",
        type    => 'string',
        value   => $ipv4_method;

      "VPN name2 for ${name}":
        keyname => "${gconf_path}/${gconf_number}/ipv4/name",
        type    => 'string',
        value   => 'ipv4';

      "VPN routes for ${name}":
        keyname   => "${gconf_path}/${gconf_number}/ipv4/routes",
        type      => 'list',
        list_type => 'int',
        value     => '[]';
    }
  } else {
    file { "/etc/NetworkManager/system-connections/${name}":
      ensure  => $ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      content => template('networkmanager/openvpn.erb'),
    }
  }
}
