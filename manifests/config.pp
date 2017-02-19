# == Class: tacacsplus::config
#
# This class handles configuring TACACS+ on the target machine.
#
# === Variables
#
# See init.pp
#
# === Authors
#
# Samuel Vange <samuelvange@gmail.com>
#
# === Copyright
#
# 'file', 'cleartext', 'nopassword', or 'des' before passwords
#
# Copyright 2016 Samuel Vange, unless otherwise noted.
#
class tacacsplus::config {
  # These variables are used in the config file template.
  $package_name = $tacacsplus::package_name
  $tacacs_key = $tacacsplus::key
  $tacacs_login_user = $tacacsplus::login_user
  $tacacs_login_user_password = $tacacsplus::login_user_password
  $tacacs_admin_group = $tacacsplus::admin_group
  $tacacs_enable_password = $tacacsplus::enable_password
  $tacacs_logfile = $tacacsplus::logfile
  $tacacs_encoding = $tacacsplus::encoding

  if ($tacacsplus::simp){
    iptables::add_tcp_stateful_listen { 'tacacsplus_iptables':
      client_nets         =>  hiera('client_nets',['ALL']),
      dports              =>  ['49'],
    }
  }

  file {'/etc/tacacs/tac_plus.conf':
    ensure                =>  file,
    owner                 =>  'root',
    group                 =>  'root',
    mode                  =>  '0600',
    content               =>  template('tacacsplus/tac_plus.conf.erb'),
    notify                =>  Service['tac_plus'],
    provider              =>  posix,
  }

  file {'/etc/tacacs':
    ensure                =>  directory,
    owner                 =>  'root',
    group                 =>  'root',
    mode                  =>  '0755',
  }

  file { '/usr/lib/systemd/system/tac_plus.service':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/tacacsplus/usr/lib/systemd/system/tac_plus.service',
    notify => Service['tac_plus']
  }

  File['/etc/tacacs'] -> File['/etc/tacacs/tac_plus.conf']
  File['/usr/lib/systemd/system/tac_plus.service'] ->  Service['tac_plus']

}