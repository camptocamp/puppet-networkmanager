# == Definition: networkmanager::wifi
#
# Adds an openvpn VPN to NetworkManager
#
# Parameters:
# - *name*: the name of the Wifi connection
# - *ensure* present/absent, defaults to present
# - *gconf_number*: set the connection number in gconf.
#   This is only used for NM <= $networkmanager::params::gconf_maxversion
#
# Requires:
# - Class["networkmanager::openvpn::base"]
# - gnome module with gnome::gconf
#
# Example usage:
#
# TODO
#
define networkmanager::wifi (
  $user,
  $ssid,
  $eap,
  $phase2_auth,
  $gconf_number,
  $password_raw_flags,
  $uuid               = regsubst(
    md5($name), '^(.{8})(.{4})(.{4})(.{4})(.{12})$', '\1-\2-\3-\4-\5'),
  $ensure             = present,
  $ssid_gconf         = '[]',
  $mode               = 'infrastructure',
  $mac_address        = '',
  $autoconnect        = true,
  $ipv4_method        = 'auto',
  $ipv6_method        = 'auto',
  $security           = 'none',
  $nma_ca_cert_ignore = false,
  $key_mgmt           = 'wpa-eap',
  $auth_alg           = 'open',
) {

  include networkmanager::params
  $gconf_path=$networkmanager::params::gconf_path
  $gconf_maxversion=$networkmanager::params::gconf_maxversion

  Gnome::Gconf {
    user => $user,
  }

  # NetworkManager stopped using GConf, in what version exactly ?
  if (versioncmp($::networkmanager_version, $gconf_maxversion) < 0) {
    gnome::gconf {
      "WIFI 802-11 mode for ${name}":
        keyname => "${gconf_path}/${gconf_number}/802-11-wireless/mode",
        type    => 'string',
        value   => $mode;

      "WIFI 802-11 name for ${name}":
        keyname => "${gconf_path}/${gconf_number}/802-11-wireless/name",
        type    => 'string',
        value   => '802-11-wireless';

      "WIFI 802-11 security for ${name}":
        keyname => "${gconf_path}/${gconf_number}/802-11-wireless/security",
        type    => 'string',
        value   => $security;

      "WIFI 802-11 . for ${name}":
        keyname   => "${gconf_path}/${gconf_number}/802-11-wireless/ssid",
        type      => 'list',
        list_type => 'int',
        value     => $ssid_gconf;

      "WIFI 802-11 key-mgmt for ${name}":
        keyname => "${gconf_path}/${gconf_number}/802-11-wireless-security/key-mgmt",
        type    => 'string',
        value   => $key_mgmt;

      "WIFI 802-11 name1 for ${name}":
        keyname => "${gconf_path}/${gconf_number}/802-11-wireless-security/name",
        type    => 'string',
        value   => '802-11-wireless-security';

      "WIFI eap for ${name}":
        keyname   => "${gconf_path}/${gconf_number}/802-1x/eap",
        type      => 'list',
        list_type => 'string',
        value     => "[${eap}]";

      "WIFI identity for ${name}":
        keyname => "${gconf_path}/${gconf_number}/802-1x/identity",
        type    => 'string',
        value   => $user;

      "WIFI name2 for ${name}":
        keyname => "${gconf_path}/${gconf_number}/802-1x/name",
        type    => 'string',
        value   => '802-1x';

      "WIFI nma-ca-cert-ignore for ${name}":
        keyname => "${gconf_path}/${gconf_number}/802-1x/nma-ca-cert-ignore",
        type    => 'bool',
        value   => $nma_ca_cert_ignore;

      "WIFI phase2-auth for ${name}":
        keyname => "${gconf_path}/${gconf_number}/802-1x/phase2-auth",
        type    => 'string',
        value   => $phase2_auth;

      "WIFI autoconnect for ${name}":
        keyname => "${gconf_path}/${gconf_number}/connection/autoconnect",
        type    => 'bool',
        value   => $autoconnect;

      "WIFI id for ${name}":
        keyname => "${gconf_path}/${gconf_number}/connection/id",
        type    => 'string',
        value   => $name;

      "WIFI name3 for ${name}":
        keyname => "${gconf_path}/${gconf_number}/connection/name",
        type    => 'string',
        value   => 'connection';

      "WIFI type2 for ${name}":
        keyname => "${gconf_path}/${gconf_number}/connection/type",
        type    => 'string',
        value   => '802-11-wireless';
    }
  } else {
    file { "/etc/NetworkManager/system-connections/${name}":
      ensure    => $ensure,
      owner     => 'root',
      group     => 'root',
      mode      => '0600',
      content   => template('networkmanager/wifi.erb'),
      replace   => false,  # Passwords are stored in this file!
    }
  }
}
