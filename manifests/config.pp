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
  $package_name = $::tacacsplus::params::package_name
  $tacacs_key = $::tacacsplus::params::tacacs_key
  $tacacs_login_user = $::tacacsplus::params::tacacs_login_user
  $tacacs_login_user_password = $::tacacsplus::params::tacacs_login_user_password
  $tacacs_admin_group = $::tacacsplus::params::tacacs_admin_group
  $tacacs_enable_password = $::tacacsplus::params::tacacs_enable_password
  $tacacs_logfile = $::tacacsplus::config::tacacs_logfile
  $simp = $::tacacsplus::params::simp

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
    notify                => Service['tacplus']
  }

  file { '/etc/init.d/tac_plus':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0754',
    source => 'puppet:///modules/tacacsplus/etc_init.d_tac_plus',
    notify => Service['tacplus']
  }


  # change permissions of tac_plus.conf to 600
}