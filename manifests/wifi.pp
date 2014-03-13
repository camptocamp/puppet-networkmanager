# See README.md for details.
define networkmanager::wifi (
  $user,
  $ssid,
  $eap,
  $phase2_auth,
  $password_raw_flags,
  $uuid               = regsubst(
    md5($name), '^(.{8})(.{4})(.{4})(.{4})(.{12})$', '\1-\2-\3-\4-\5'),
  $ensure             = present,
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

  Class['networkmanager::install'] -> Networkmanager::Wifi[$title]

  file { "/etc/NetworkManager/system-connections/${name}":
    ensure    => $ensure,
    owner     => 'root',
    group     => 'root',
    mode      => '0600',
    content   => template('networkmanager/wifi.erb'),
    replace   => false,  # Passwords are stored in this file!
  }
}
