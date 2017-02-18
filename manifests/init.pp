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
  class {tacacsplus::install:}
  class {tacacsplus::config:}
  class {tacacsplus::service:}

  Class[tacacsplus::install] -> Class[tacacsplus::config] -> Class[tacacsplus::service]
}
