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
  $id            = $name,
  $autoconnect   = false,
  $ipv4_method   = 'auto',
  $never_default = true,
  $routes        = '',
) {

  Class['networkmanager::install'] -> Networkmanager::Openvpn[$title]

  ensure_resource(
    'package', 'network-manager-openvpn', { ensure => present, }
  )

  file { "/etc/NetworkManager/system-connections/${name}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('networkmanager/openvpn.erb'),
  }
}
