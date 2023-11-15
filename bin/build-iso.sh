#!/bin/bash

set -e -u

DIR_BASE=$(dirname $(dirname $(realpath -- $0)))
DIR_BIN=${DIR_BASE}/bin
DIR_LIB=${DIR_BASE}/lib
DIR_CONF=${DIR_BASE}/config

. ${DIR_CONF}/env                           # 导入变量
. ${DIR_LIB}/utils                          # 功能独立的工具类函数
. ${DIR_LIB}/boot                           # 引导相关函数
. ${DIR_LIB}/common-functions               # 制作ISO主要函数

check_is_root                               #
check_is_validate_options                   # 检查配置是否合法 OK!
show_config                                 # OK!

# start build
run_once make_pacman_conf                   # 生成 pacman.conf OK! 1
run_once export_gpg_public_key              #
run_once make_custom_rootfs                 #
run_once make_packages                      # OK! 2
run_once make_version                       # OK! 3
#run_once make_customize_rootfs              #
run_once make_pkg_list                      # OK! 4
make_boot_modes                             #
run_once make_cleanup                       # OK!
run_once make_prepare
make_iso
