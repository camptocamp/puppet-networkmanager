# Class networkmanager::params
class networkmanager::params {
  $ensure = 'present'
  $manage_packages = true
  $manage_service = true
  $service_enable = true
  $service_ensure = 'running'
  $gui = undef
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
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }
}
