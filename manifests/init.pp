# Class networkmanager
class networkmanager (
  $manage_packages           = $networkmanager::params::manage_packages,
  $package_ensure            = $networkmanager::params::package_ensure,
  $manage_service            = $networkmanager::params::manage_service,
  $service_enable            = $networkmanager::params::service_enable,
  $service_ensure            = $networkmanager::params::service_ensure,
  $gui                       = $networkmanager::params::gui,
  $openconnect_connections   = {},
  $openvpn_connections       = {},
  $wifi_connections          = {},
) inherits networkmanager::params {

  include ::stdlib

  if $gui != undef {
    validate_re($gui, ['^gnome$', '^kde$'])
  }

  include ::networkmanager::install
  include ::networkmanager::config
  include ::networkmanager::service

  Class['networkmanager::install'] ->
  Class['networkmanager::config'] ~>
  Class['networkmanager::service']

}
