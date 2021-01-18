class networkmanager(
  Enum['absent','present'] $version = present,
  Boolean $enable = true,
  Boolean $start = true,
  Optional[Enum['^gnome', '^kde']] $gui = undef,

  Hash $openconnect_connections = {},
  Hash $openvpn_connections     = {},
  Hash $wifi_connections        = {},
) {
  class { '::networkmanager::install': }
  -> class { '::networkmanager::service': }
  -> Class['networkmanager']

  class { '::networkmanager::config': }
  -> Class['networkmanager']
}
