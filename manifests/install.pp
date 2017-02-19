# == Class: tacacsplus::install
#
# This class handles installing TACACS+ on the target machine.
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
class tacacsplus::install {
  package { "tacacsplus":
    provider    =>  'yum',
    ensure      =>  installed,
    name        =>  $tacacsplus::package_name
  }
}