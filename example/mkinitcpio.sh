#!/bin/bash

curDir=$(dirname $(realpath -- $0))
workDir=$(dirname ${curDir})

echo $workDir

hooks=$(realpath --relative-base $(ls "${workDir}/config/initramfs/hooks"))
#hooks=$(ls "${workDir}/config/initramfs/hooks")

echo ${hooks[@]}

export HOOKDIR=${workDir}/config/initramfs/hooks

[[ -f "${curDir}/initramfs.img" ]] && rm -f "${curDir}/initramfs.img"

#-A "${hooks[@]}" \
#-D "${workDir}/config/initramfs/hooks" \
mkinitcpio \
    -r ${workDir}/work/rootfs/ \
    -c ${workDir}/config/initramfs/config/graceful-linux.conf \
    -k 6.6.1-arch1-1 \
    -z xz \
    -g ${curDir}/initramfs.img

exit 0
rm -rf ${curDir}/tmp
[[ ! -d "${curDir}/tmp" ]] && mkdir "${curDir}/tmp"
cp ${curDir}/initramfs.img ${curDir}/tmp/initramfs.img.xz
cd ${curDir}/tmp
xz -d ${curDir}/tmp/initramfs.img.xz
cpio -i < ${curDir}/tmp/initramfs.img
cp ${hooks} hooks/
rm -f ${curDir}/tmp/initramfs.img
cpio $(find *) -o ${curDir}/tmp/initramfs.img
xz -z ${curDir}/tmp/initramfs.img 
mv ${curDir}/tmp/initramfs.img.xz ${curDir}/initramfs.img
cd ${curDir}
rm -rf "${curDir}/tmp"

