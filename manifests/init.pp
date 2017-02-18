# == Class: tacacsplus
#
# This class handles installing TACACS+ on the target machine.
#
# === Authors
#
# Samuel Vange <samuelvange@gmail.com>
#
# === Example
#
# # .../hieradata/hosts/tacacs-server.yaml
# tacacsplus::key : 'password'
# tacacsplus::login_user : 'user'
# tacacsplus::login_user_password : 'longpassword'
# tacacsplus::enable_password : 'enable'
# tacacsplus::encoding : 'md5'
# classes:
#   - 'tacacsplus
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
