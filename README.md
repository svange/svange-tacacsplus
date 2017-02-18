# tacacsplus

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with tacacsplus](#setup)
    * [What tacacsplus affects](#what-tacacsplus-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with tacacsplus](#beginning-with-tacacsplus)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module installs and configures TACACS+.

## Module Description

TACACS+ (Terminal Access Controller Access-Control System, usually 
pronounced like tack-axe) is a CISCO developed authentication, authorization and
accounting (AAA) system for tracking user activities on an IP-based network and 
controlling their access to network resources. 

TACACS+ gives administrators the ability to centrally manage users, groups, and
passwords for network appliance.

## Setup

### What tacacsplus affects

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.

### Setup Requirements

Your system must have a tacacsplus package available to it. As this package is 
not available as an RPM, files/tacacsplus-1.0-1.el7.x86_64 is provided.

### Beginning with tacacsplus

#### In Hiera:
````
tacacsplus::key :                   'tackey'
tacacsplus::login_user :            'user'
tacacsplus::login_user_password :   'mypassword'
tacacsplus::enable_password :       'myenablepassword'
tacacsplus::encoding :              'des'

classes:
  - 'tacacsplus'
````

## Usage

##### `encoding`

Default: `cleartext`. Specifies the encoding used for placing passwords into the 
configuration file. Options are 'file', 'cleartext', 'nopassword', or 'des'.

##### `key`

Default: `tackey`. Specifies the symetric key used for communication with 
clients.

##### `login_user`

Default: `admin`. Specifies the username that clients can authenticate against.

##### `login_user_password`

Default: `password`. Specifies the password of the login_user.

##### `simp`

Default: `false`. If set, uses the defined types made available by SIMP to set
IP tables rules. For information on SIMP please see <https://simp-project.com/> 
for more information.

##### `package_name`

Default: `tacacsplus`. The name of the package used to install TACACS+.

##### `admin_group`

Default: `admingroup`. The name of the administrative group.

##### `enable_password`

Default: `enablepassword`. Sets the enable password.

##### `logfile`

Default: `/var/log/tacacs/tac_plus.log`. Specifies the file which TACACS+ will 
log to.

## Reference

Once the package is installed, please see the following:
 * ````man tac_plus````
 * ````man tac_pwd````
 * ````man tac_plus.conf````

## Limitations

This module is currently only compatible with RedHat 7.x.

Built in support for SIMP is included by setting ````tacacsplus::simp = true````
in Hiera.

## Development
This module was written primarily for internal use - features we haven't needed 
to use probably haven't been written. Please send pull requests with new 
features and bug fixes. You are also welcome to file issues but I make no
guarantees of development effort if the features aren't useful to my employer.

### Items on the TODO list
* The user and group blocks in the configuration file should be built using user
and group defined types, allowing for an arbitrary number of users and groups.
* It should be possible to put a user into an arbitrary number of groups.
* This configuration file assumes a single admin group. This needs to be made to
be more flexible.
* Currently the module only supports variables being set from Hiera. This is 
because the author clearly doesn't understand the params pattern.
* The systemd configuration should be updated to include restart and status 
directives.
* The systemd configuration should be rolled into the RPM.

