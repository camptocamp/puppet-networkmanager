# == Definition: networkmanager::openconnect
#
# Adds an openconnect VPN to NetworkManager
#
# Parameters:
# - *name*: the name of the VPN connection
# - *id*: the id of the VPN connection, defaults to name
# - *ensure* present/absent, defaults to present
# - *uuid*: the UUID of the connection
# - *user*: the user who can use the connection
# - *autoconnect*: whether to autoconnect the VPN
# - *authtype*: authentication type
# - *gateway*: the remote host
# - *xmlconfig*: the xmlconfig for the VPN
# - *gconf_number*: set the connection number in gconf.
#   This is only used for NM < $networkmanager::params::gconf_maxversion
# - *ipv6_method*: IPv6 method (defaults to 'auto')
# - *ipv4_method*: IPv4 method (defaults to 'auto')
# - *never_default*: do not use VPN connection as default route.
#   (defaults to 'true')
#
# Requires:
# - Class['networkmanager::openconnect::base']
# - gnome module with gnome::gconf
#
# Example usage:
#
# TODO
#
define networkmanager::openconnect (
  $user,
  $gateway,
  $authtype,
  $xmlconfig,
  $gconf_number,
  $uuid          = regsubst(
    md5($name), '^(.{8})(.{4})(.{4})(.{4})(.{12})$', '\1-\2-\3-\4-\5'),
  $ensure        = 'present',
  $id            = $name,
  $autoconnect   = false,
  $ipv4_method   = 'auto',
  $ipv6_method   = 'auto',
  $never_default = true,
) {

  Class['networkmanager::install'] -> Networkmanager::Openconnect[$title]

  ensure_resource(
    'package', 'network-manager-openconnect', { ensure => present, }
  )

  file { "/etc/NetworkManager/system-connections/${name}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('networkmanager/openconnect.erb'),
  }
}
