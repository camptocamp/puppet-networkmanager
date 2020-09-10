class networkmanager::config {
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
