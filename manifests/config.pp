# == Class: tacacsplus::config
#
# This class handles configuring TACACS+ on the target machine.
#
# === Authors
#
# Samuel Vange <samuelvange@gmail.com>
#
# === Copyright
#
# Copyright 2016 Samuel Vange, unless otherwise noted.
#
class tacacsplus::config {
  include tacacsplus::params
  $package_name = $::tacacsplus::params::package_name
  $tacacs_key = $::tacacsplus::params::tacacs_key
  $tacacs_login_user = $::tacacsplus::params::tacacs_login_user
  $tacacs_login_user_password = $::tacacsplus::params::tacacs_login_user_password
  $tacacs_admin_group = $::tacacsplus::params::tacacs_admin_group
  $tacacs_enable_password = $::tacacsplus::params::tacacs_enable_password
  $tacacs_logfile = $::tacacsplus::config::tacacs_logfile
  $simp = $::tacacsplus::params::simp

  validate_string($package_name)
  validate_string($tacacs_key)
  validate_string($tacacs_login_user)
  validate_string($tacacs_login_user_password)
  validate_string($tacacs_admin_group)
  validate_string($tacacs_enable_password)
  validate_string($tacacs_logfile)
  validate_bool($simp)

  if ($simp){
    $_client_nets = hiera('client_nets',['ALL'])
    iptables::add_tcp_stateful_listen { 'tacacsplus_iptables':
      client_nets         =>  $_client_nets,
      dports              =>  ['49'],
    }
  }

  file {'/etc/tacacs/tac_plus.conf':
    ensure                =>  file,
    owner                 =>  'root',
    group                 =>  'root',
    mode                  =>  '0600',
    content               => template('tacacsplus/tac_plus.conf.erb'),
    notify                => Service['tac_plus'],
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