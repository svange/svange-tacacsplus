# == Class: tacacsplus::params
#
# This class handles the parameters for tacacsplus
#
# === Variables
#
# [*package_name*]
#   The name of the RPM to install.
#
# [*tacacs_key*]
#   Sets the tacacs+ key.
#
# [*tacacs_login_user*]
#   Sets the name of the tacacs+ login user.
#
# [*tacacs_login_user_password*]
#   Sets the password for the tacacs_login_user.
#
# [*tacacs_admin_group*]
#   Sets the name of the admin group.
#
# [*tacacs_enable_password*]
#   Sets the enable password to $tacacs_enable_password
#
# [*tacacs_logfile*]
#   The tacacs+ log file.
#
# [*simp*]
#   If using SIMP, set this to true. This will enable iptables and make any
#   other necessary configuration changes using modules available in SIMP.
#
# === Authors
#
# Samuel Vange <samuelvange@gmail.com>
#
# === Copyright
#
# Copyright 2016 Samuel Vange, unless otherwise noted.
#
class tacacsplus::params {
  $package_name = 'tacacsplus'
  $tacacs_key = 'tackey'
  $tacacs_login_user = 'admin'
  $tacacs_login_user_password = 'password'
  $tacacs_admin_group = 'admingroup'
  $tacacs_enable_password = 'enable'
  $tacacs_logfile = '/var/log/tacacs/tac_plus.log'
  $tacacs_encoding = "cleartext"
  $simp = false
}