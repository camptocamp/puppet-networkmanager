# Define networkmanager::openvpn
define networkmanager::openvpn (
  $remote,                  # use "vpn1.example.com:port:proto, vpn2.example.com:port:proto" syntax
  $ca,                      # /path/to/ca.crt
  $systemloginuser = undef, # username that owns the vpn connection profile
  $vpnloginuser    = undef, # login to the vpn with this username
  $remote_random   = false,
  $connection_type = 'tls', # can be 'tls', 'password-tls' or 'password'
  $hmac            = undef, # this is the openvpn auth parameter
  $cipher          = undef,
  $dev_type        = undef,
  $cert            = undef, # /path/to/cert.crt
  $key             = undef, # /path/to/cert.key
  $cert_pass_flags = undef,
  $password_flags  = undef, # 0 = saved, 2 = always-ask, 4 = not-required
  $comp_lzo        = false,
  $ta              = undef, # /path/to/tlsauth.key
  $ta_dir          = undef, # tlsauth key direction - must be 0 or 1
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

  file { "/etc/NetworkManager/system-connections/${name}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('networkmanager/openvpn.erb'),
    notify  => Exec['reload nm configuration'],
  }
}
