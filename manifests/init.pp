# == Class: tacacsplus
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
class tacacsplus {
  include tacacsplus::install
  include tacacsplus::config
  include tacacsplus::service
}
