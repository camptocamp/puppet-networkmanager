#Define networkmanager::openconnect
define networkmanager::openconnect (
  $user,
  $gateway,
  $authtype,
  $xmlconfig,
  $uuid          = regsubst(md5($name), '^(.{8})(.{4})(.{4})(.{4})(.{12})$', '\1-\2-\3-\4-\5'),
  $ensure        = 'present',
  $id            = $name,
  $autoconnect   = false,
  $ipv4_method   = 'auto',
  $ipv6_method   = 'auto',
  $never_default = true,
) {

  include ::networkmanager::install::openconnect

  Class['networkmanager::install::openconnect'] ->
  Networkmanager::Openconnect[$title] ~>
  Class['networkmanager::service']


  file { "/etc/NetworkManager/system-connections/${name}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('networkmanager/openconnect.erb'),
  }
}
