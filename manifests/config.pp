class networkmanager::config {
  if $::networkmanager::dns {
    $dns_ensure = 'present'
  } else {
    $dns_ensure = 'absent'
  }
  ini_setting { 'NetworkManager dns':
    ensure  => $dns_ensure,
    path    => '/etc/NetworkManager/NetworkManager.conf',
    section => 'main',
    setting => 'dns',
    value   => $::networkmanager::dns,
  }

  validate_hash($::networkmanager::openconnect_connections)
  validate_hash($::networkmanager::openvpn_connections)
  validate_hash($::networkmanager::wifi_connections)

  create_resources(
    'networkmanager::openconnect',
    $::networkmanager::openconnect_connections
  )

  create_resources(
    'networkmanager::openvpn',
    $::networkmanager::openvpn_connections
  )

  create_resources(
    'networkmanager::wifi',
    $::networkmanager::wifi_connections
  )
}
