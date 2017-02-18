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
class tacacsplus::service {
  include tacacsplus::params
  service {'tac_plus':
    ensure  =>  running,
    enable  =>  true,
    hasrestart  =>  false,
    hasstatus   =>  false,
  }
}