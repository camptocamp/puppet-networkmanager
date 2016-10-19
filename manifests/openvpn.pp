# Define networkmanager::openvpn
define networkmanager::openvpn (
  $remote,
  $ca,
  $user            = undef,
  $username        = undef,
  $permitted_user  = undef,
  $remote_random   = false,
  $connection_type = 'tls',
  $hmac            = undef,
  $cipher          = undef,
  $dev_type        = undef,
  $cert            = undef,
  $key             = undef,
  $cert_pass_flags = undef,
  $password_flags  = undef,
  $comp_lzo        = false,
  $ta              = undef,
  $ta_dir          = undef,
  $uuid            = regsubst(md5($name), '^(.{8})(.{4})(.{4})(.{4})(.{12})$', '\1-\2-\3-\4-\5'),
  $ensure          = 'present',
  $id              = $name,
  $autoconnect     = false,
  $ipv4_method     = 'auto',
  $never_default   = undef,
  $routes          = undef,
  $dns             = undef,
  $dns_search      = undef,
) {

  include ::networkmanager::install::openvpn

  Class['networkmanager::install::openvpn'] ->
  Networkmanager::Openvpn[$title] ~>
  Class['networkmanager::service']

  if $user {
    warning('Define ::networkmanager: parameter $user has been deprecated and replaced with $username and $permitted_user.')
  }
  $_permitted_user = pick($user, $permitted_user)
  $_username = pick($user, $_username)

  file { "/etc/NetworkManager/system-connections/${name}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('networkmanager/openvpn.erb'),
    notify  => Exec['reload nm configuration'],
  }
}
