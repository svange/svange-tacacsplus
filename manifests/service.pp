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
# Copyright 2016 Samuel Vange, unless otherwise noted.
#
class tacacsplus::service {
  service {'tac_plus':
    ensure  =>  running,
    enable  =>  true,
    hasrestart  =>  false,
    hasstatus   =>  false,
  }
}