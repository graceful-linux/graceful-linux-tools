#!/bin/bash

workDir=$(dirname $(realpath -- $0))

set -eu

function print_help()
{
    local usagetext
    IFS='' read -r -d '' usagetext <<EOF || true
使用:
    ./build.sh [参数]

参数:
    -b              开始构建 graceful-linux 镜像
    -i [image]      引导镜像
    -h              帮助

例子:
    构建镜像：
        ./build.sh -b

    测试构建镜像:
        ./build.sh -i work/graceful-linux-0.0.1.iso
EOF
    printf '%s' "${usagetext}"
}

declare -x build image

build=0
image=""

if (( ${#@} > 0 )); then
    while getopts 'bhi:' flag; do
        case "$flag" in
            b)
                build=1
                ;;
            h)
                print_help
                exit 0
                ;;
            i)
                image="$OPTARG"
                ;;
            *)
                print_help
                exit 1
                ;;
        esac
    done
else
    print_help
    exit 1
fi

#echo $workDir
#echo $image

if [ $build -eq 1 ]; then
    ${workDir}/bin/build-iso.sh
    exit 0
fi

if [ "x$image" != "x" ]; then
    ${workDir}/bin/launch-x86 -i ${image} || exit 0
    exit 0
fi

print_help

exit 0


