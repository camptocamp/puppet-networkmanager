class networkmanager::config {
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
