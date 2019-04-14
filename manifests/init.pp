class networkmanager(
  $version = present,
  $enable  = true,
  $start   = true,
  $gui     = undef,
  $dns     = undef,

  $openconnect_connections = {},
  $openvpn_connections     = {},
  $wifi_connections        = {},
) {

  if $gui != undef {
    validate_re($gui, ['^gnome', '^kde'])
  }

  class { '::networkmanager::install': }
  -> class { '::networkmanager::service': }
  -> Class['networkmanager']

  class { '::networkmanager::config': }
  -> Class['networkmanager']
}
