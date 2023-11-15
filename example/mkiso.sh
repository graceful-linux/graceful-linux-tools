#!/bin/bash
opts+=(
        '-isohybrid-mbr' "../work/iso/boot/syslinux/isohdpfx.bin"
        # When GPT is used, create an additional partition in the MBR (besides 0xEE) for sectors 0–1 (MBR
        # bootstrap code area) and mark it as bootable
        # May allow booting on some systems
        # https://wiki.archlinux.org/title/Partitioning#Tricking_old_BIOS_into_booting_from_GPT
        '--mbr-force-bootable'
        # Move the first partition away from the start of the ISO to match the expectations of partition editors
        # May allow booting on some systems
        # https://dev.lovelyhq.com/libburnia/libisoburn/src/branch/master/doc/partition_offset.wiki
        '-partition_offset' '16'
        '-eltorito-boot' 'boot/syslinux/isolinux.bin'
        # El Torito boot catalog file
        '-eltorito-catalog' 'boot/syslinux/boot.cat'
        # Required options to boot with ISOLINUX
        '-no-emul-boot' '-boot-load-size' '4' '-boot-info-table'
    )

sudo xorriso \
    -as mkisofs \
    -iso-level 3 \
    -full-iso9660-filenames \
    -joliet -joliet-long -rational-rock \
    -volid graceful-linux \
    -appid ga \
    -publisher gf \
    -uuid 121231-12313 \
    -preparer "prepares" \
    "${opts[@]}" \
    -output aa.iso \
    ../work/iso/
