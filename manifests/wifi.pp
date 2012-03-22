/*
== Definition: network-manager::wifi

Adds an openvpn VPN to NetworkManager

Parameters:
- *name*: the name of the Wifi connection
- *ensure* present/absent, defaults to present

Requires:
- Class["network-manager::openvpn::base"]
- gnome module with gnome::gconf

Example usage:

TODO

*/
define network-manager::wifi (
  $ensure=present,
  $uuid,
  $user,
  $ssid,
  $mode=infrastructure,
  $seen_bssids='',
  $mac_address='',
  $autoconnect=true,
  $ipv4_method=auto,
  $ipv6_method=auto,
  $security=none,
  $eap,
  $phase2_auth,
  $nma_ca_cert_ignore='',
  $key_mgmt=wpa-eap,
  $auth_alg=open,
  $password_raw_flags
) {

  include network-manager::params

  # NetworkManager stopped using GConf, in what version exactly ?
  if (versioncmp($networkmanager_version, "0.9.2") < 0) {
    gnome::gconf {
      "WIFI 802-11 mode for ${name}":
        keyname => "${gc_path}${gc_wifi}/802-11-wireless/mode",
        type => 'string', value => $mode, user => $user;
  
      "WIFI 802-11 name for ${name}":
        keyname => "${gc_path}${gc_wifi}/802-11-wireless/name",
        type  => 'string', value => '802-11-wireless', user => $user;
  
      "WIFI 802-11 security for ${name}":
        keyname => "${gc_path}${gc_wifi}/802-11-wireless/security",
        type => 'string', value => $security, user => $user;
  
      "WIFI 802-11 seen-bssids for ${name}":
        keyname => "${gc_path}${gc_wifi}/802-11-wireless/seen-bssids",
        type => 'list', list_type => 'string', value => $seen_bssids, user => $user;
  
      "WIFI 802-11 . for ${name}":
        keyname => "${gc_path}${gc_wifi}/802-11-wireless/ssid",type => 'list',
        list_type => 'int', value => $ssid, user => $user;
  
      "WIFI 802-11 key-mgmt for ${name}":
        keyname => "${gc_path}${gc_wifi}/802-11-wireless-security/key-mgmt",
        type => 'string', value => $key_mgmt, user => $user;
  
      "WIFI 802-11 name1 for ${name}":
        keyname => "${gc_path}${gc_wifi}/802-11-wireless-security/name",
        type => 'string', value => '802-11-wireless-security', user => $user;
  
      "WIFI eap for ${name}":
        keyname => "${gc_path}${gc_wifi}/802-1x/eap",
        type => 'list', list_type => 'string', value   => $eap, user => $user;
  
      "WIFI identity for ${name}":
        keyname => "${gc_path}${gc_wifi}/802-1x/identity",
        type => 'string', value => $user, user => $user;
  
      "WIFI name2 for ${name}":
        keyname => "${gc_path}${gc_wifi}/802-1x/name",
        type => 'string', value => '802-1x', user => $user;
  
      "WIFI nma-ca-cert-ignore for ${name}":
        keyname => "${gc_path}${gc_wifi}/802-1x/nma-ca-cert-ignore",
        type => 'bool', value => $nma_ca_cert_ignore, user => $user;
  
      "WIFI phase2-auth for ${name}":
        keyname => "${gc_path}${gc_wifi}/802-1x/phase2-auth",
        type => 'string', value => $phase2_auth, user => $user;
  
      "WIFI autoconnect for ${name}":
        keyname => "${gc_path}${gc_wifi}/connection/autoconnect",
        type => 'bool',value => $autoconnect, user => $user;
  
      "WIFI id for ${name}":
        keyname => "${gc_path}${gc_wifi}/connection/id",
        type => 'string', value => $name, user => $user;
  
      "WIFI name3 for ${name}":
        keyname => "${gc_path}${gc_wifi}/connection/name",
        type => 'string', value => 'connection', user => $user;
  
      "WIFI type2 for ${name}":
        keyname => "${gc_path}${gc_wifi}/connection/type",
        type => 'string', value => '802-11-wireless', user => $user;
    }
  } else {
    file { "/etc/NetworkManager/system-connections/${name}":
      ensure    => $ensure,
      owner     => root,
      group     => root,
      mode      => 600,
      content   => template("network-manager/wifi.erb"),
      replace   => false,  # Passwords are stored in this file!
    }
  }
}
