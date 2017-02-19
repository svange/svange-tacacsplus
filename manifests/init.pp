# == Class: tacacsplus
#
# This class handles installing and configuring TACACS+ on the target machine.
#
# === Variables
#
# [*package_name*]
#   Default: `tacacsplus`. The name of the package used to install TACACS+.
#
# [*key*]
#   Default: `tackey`. Specifies the symmetric key used for communication with
#   lients.
#
# [*login_user*]
#   Default: `admin`. Specifies the username that clients can authenticate
#   against.
#
# [*login_user_password*]
#   Default: `password`. Specifies the password of the login_user.
#
# [*admin_group*]
#   Sets the name of the admin group.
#
# [*enable_password*]
#   Sets the enable password to $tacacs_enable_password
#
# [*logfile*]
#   The tacacs+ log file.
#
# [*simp*]
#   Default: `false`. If set, uses the defined types made available by SIMP to
#   set IP tables rules. For information on SIMP please see
#   <https://simp-project.com/> for more information.
#
#
# === Authors
#
# Samuel Vange <samuelvange@gmail.com>
#
# === Example
#
# To use this module, you can set variables and import the class from Hiera
# as such:
# # .../hieradata/hosts/tacacs-server.yaml
# tacacsplus::key : 'password'
# tacacsplus::login_user : 'user'
# tacacsplus::login_user_password : 'longpassword'
# tacacsplus::enable_password : 'enable'
# tacacsplus::encoding : 'md5'
# classes:
#   - 'tacacsplus
#
#
# Or, you can instantiate the tacacsplus class from puppet as such:
# # .../manifests/puppetcode.pp
# class { 'tacacsplus':
#     package_name          => 'mytacacsplus',
#     key                   => 'tackey',
#     login_user            => 'myuser',
#     login_user_password   => 'myuserpassword',
#     admin_group           => 'myadmingroup',
#     enable_password       => 'myenablepassword',
#     logfile               => '/my/log/file',
#     encoding              => 'sha',
#     simp                  => true,
# }
#
#
# To get started with the default values, simply:
# import tacacsplus
# === Copyright
#
# Copyright 2016 Samuel Vange, unless otherwise noted.
#
class tacacsplus {
  $package_name = hiera('tacacsplus::package_name', 'tacacsplus' )
  $key = hiera('tacacsplus::key', 'tackey')
  $login_user = hiera('tacacsplus_login_user', 'admin')
  $login_user_password = hiera('tacacsplus::user_password', 'password')
  $admin_group = hiera('tacacsplus::admin_group', 'admingroup')
  $enable_password = hiera('tacacsplus::enable_password', 'enable')
  $logfile = hiera('tacacsplus::logfile', '/var/log/tacacs/tac_plus.log')
  $encoding = hiera('tacacsplus::encoding', 'cleartext')
  $simp = hiera('tacacsplus::simp', false)

  validate_string($package_name)
  validate_string($key)
  validate_string($login_user)
  validate_string($login_user_password)
  validate_string($admin_group)
  validate_string($enable_password)
  validate_string($logfile)
  validate_string($encoding)
  validate_bool($simp)

  class {tacacsplus::install:}
  class {tacacsplus::config:}
  class {tacacsplus::service:}

  Class[tacacsplus::install] -> Class[tacacsplus::config] -> Class[tacacsplus::service]
}
