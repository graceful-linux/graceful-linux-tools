#!/bin/bash

set -e -u

DIR_BASE=$(dirname $(dirname $(realpath -- $0)))
DIR_BIN=${DIR_BASE}/bin
DIR_LIB=${DIR_BASE}/lib
DIR_CONF=${DIR_BASE}/config

. ${DIR_CONF}/env                   # 导入变量
. ${DIR_LIB}/log                    # 导入日志输出函数 
. ${DIR_LIB}/common-functions       # 制作ISO主要函数

check_is_root
show_config
run_once make_pacman_conf           # 生成 pacman.conf
run_once export_gpg_public_key      #
run_once make_custom_rootfs         #
run_once make_packages
run_once make_customize_rootfs      #
run_once make_pkg_list              #
make_boot_modes                     #
run_once make_cleanup
run_once make_prepare
make_iso
