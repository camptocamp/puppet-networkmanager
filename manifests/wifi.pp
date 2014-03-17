# See README.md for details.
define networkmanager::wifi (
  $user,
  $ssid,
  $eap,
  $phase2_auth,
  $password_raw_flags,
  $uuid               = regsubst(
    md5($name), '^(.{8})(.{4})(.{4})(.{4})(.{12})$', '\1-\2-\3-\4-\5'),
  $ensure             = present,
  $mode               = 'infrastructure',
  $mac_address        = '',
  $autoconnect        = true,
  $ipv4_method        = 'auto',
  $ipv6_method        = 'auto',
  $security           = 'none',
  $nma_ca_cert_ignore = false,
  $key_mgmt           = 'wpa-eap',
  $auth_alg           = 'open',
) {

  Class['networkmanager::install'] -> Networkmanager::Wifi[$title]

  file { "/etc/NetworkManager/system-connections/${name}":
    ensure    => $ensure,
    owner     => 'root',
    group     => 'root',
    mode      => '0600',
  }

  if $ensure == 'present' {
    Ini_setting {
      ensure  => present,
      path    => "/etc/NetworkManager/system-connections/${name}",
    }

    # section: connection
    ini_setting { "${name}/connection/id":
      section => 'connection',
      setting => 'id',
      value   => $name,
    }

    ini_setting { "${name}/connection/uuid":
      section => 'connection',
      setting => 'uuid',
      value   => $uuid,
    }

    ini_setting { "${name}/connection/type":
      section => 'connection',
      setting => 'type',
      value   => '802-11-wireless',
    }

    ini_setting { "${name}/connection/permissions":
      section => 'connection',
      setting => 'permissions',
      value   => "user:${user}:;",
    }

    # section: 802-11-wireless
    ini_setting { "${name}/802-11-wireless/ssid":
      section => '802-11-wireless',
      setting => 'ssid',
      value   => $ssid,
    }

    ini_setting { "${name}/802-11-wireless/mode":
      section => '802-11-wireless',
      setting => 'mode',
      value   => $mode,
    }

    ini_setting { "${name}/802-11-wireless/security":
      section => '802-11-wireless',
      setting => 'security',
      value   => $security,
    }

    # section: 802-11-wireless-security
    ini_setting { "${name}/802-11-wireless-security/key-mgmt":
      section => '802-11-wireless-security',
      setting => 'key-mgmt',
      value   => $key_mgmt,
    }

    ini_setting { "${name}/802-11-wireless-security/auth-alg":
      section => '802-11-wireless-security',
      setting => 'auth-alg',
      value   => $auth_alg,
    }

    # section: ipv4
    ini_setting { "${name}/ipv4/method":
      section => 'ipv4',
      setting => 'method',
      value   => $ipv4_method,
    }

    # section: ipv6
    ini_setting { "${name}/ipv6/method":
      section => 'ipv6',
      setting => 'method',
      value   => $ipv6_method,
    }

    # section: 802-1x
    ini_setting { "${name}/802-1x/eap":
      section => '802-1x',
      setting => 'eap',
      value   => "${eap};",
    }

    ini_setting { "${name}/802-1x/identity":
      section => '802-1x',
      setting => 'identity',
      value   => $user,
    }

    ini_setting { "${name}/802-1x/phase2-auth":
      section => '802-1x',
      setting => 'phase2-auth',
      value   => $phase2_auth,
    }

    ini_setting { "${name}/802-1x/password-raw-flags":
      section => '802-1x',
      setting => 'password-raw-flags',
      value   => $password_raw_flags,
    }

    ini_setting { "${name}/802-1x/nma-ca-cert-ignore":
      section => '802-1x',
      setting => 'nma-ca-cert-ignore',
      value   => $nma_ca_cert_ignore,
    }

  }

}
