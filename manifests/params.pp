# Class networkmanager::params
class networkmanager::params {
  $version = undef
  $enable = undef
  $start = undef
  $gui = undef
  $package_ensure = 'present'
  $manage_packages = true
  $package_gui = undef
  $package_gui_openvpn = undef
  $package_gui_openconnect = undef
  $manage_service = true
  $service_enable = true
  $service_ensure = 'running'
  case $::osfamily {
    'Debian': {
      $package = 'network-manager'
      $package_openvpn = 'network-manager-openvpn'
      $package_openconnect = 'network-manager-openconnect'
      $package_wifi = undef
      $package_gnome = 'network-manager-gnome'
      $package_kde = 'plasma-nm'
      $package_openvpn_gnome = 'network-manager-openvpn-gnome'
      $package_openvpn_kde = undef
      $package_openconnect_gnome = 'network-manager-openconnect-gnome'
      $package_openconnect_kde = undef
      $service = 'network-manager'
    }
    'RedHat': {
      $package = 'NetworkManager'
      $package_openvpn = 'NetworkManager-openvpn'
      $package_openconnect = 'NetworkManager-openconnect'
      $package_wifi = 'NetworkManager-wifi'
      $package_gnome = 'NetworkManager-openvpn-gnome'
      $package_kde = 'kde-plasma-networkmanagement'
      $package_openvpn_gnome = 'NetworkManager-openvpn-gnome'
      $package_openvpn_kde = 'kde-plasma-networkmanagement-openvpn'
      $package_openconnect_gnome = undef
      $package_openconnect_kde = 'kde-plasma-networkmanagement-openconnect'
      $service = 'NetworkManager'
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }
}
