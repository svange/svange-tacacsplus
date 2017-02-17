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
  $_package_name = $tacacsplus::params::package_name
  validate_string($_package_name)
  package {'tacplus':
    provider    =>  'rpm',
    source      =>  $_package_name,
    ensure      =>  installed,
  }
}