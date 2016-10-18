# Class networkmanager
class networkmanager (
  $version                 = $networkmanager::params::version,
  $enable                  = $networkmanager::params::enable,
  $start                   = $networkmanager::params::start,
  $gui                     = $networkmanager::params::gui,
  $manage_packages         = $networkmanager::params::manage_packages,
  $package                 = $networkmanager::params::package,
  $package_gui             = $networkmanager::params::package_gui,
  $package_gui_openvpn     = $networkmanager::params::package_gui_openvpn,
  $package_gui_openconnect = $networkmanager::params::package_gui_openconnect,
  $package_ensure          = $networkmanager::params::package_ensure,
  $manage_service          = $networkmanager::params::manage_service,
  $service                 = $networkmanager::params::service,
  $service_enable          = $networkmanager::params::service_enable,
  $service_ensure          = $networkmanager::params::service_ensure,
  $openconnect_connections = {},
  $openvpn_connections     = {},
  $wifi_connections        = {},
) inherits networkmanager::params {

  include ::stdlib

  if $gui != undef {
    validate_re($gui, ['^gnome$', '^kde$'])
  }
  if $version {
    warning('Class ::networkmanager: parameter $version has been deprecated and replaced with $package_ensure.')
  }
  if $enable {
    warning('Class ::networkmanager: parameter $enable has been deprecated and replaced with $service_enable.')
  }
  if $start {
    warning('Class ::networkmanager: parameter $start has been deprecated and replaced with $service_ensure.')
  }

  class {'::networkmanager::install': } ->
  class {'::networkmanager::config': } ~>
  class {'::networkmanager::service': }

}
