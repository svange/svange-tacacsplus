# == Class: tacacsplus::install
#
# This class handles installing TACACS+ on the target machine.
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
  include tacacsplus::params
  $_package_name = $tacacsplus::params::package_name
  validate_string($_package_name)
  package { "tacacsplus":
    provider    =>  'yum',
    ensure      =>  installed,
    name        =>  $_package_name
  }
}