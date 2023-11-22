# graceful-linux-tools

## 功能

- [x] 制作可启动镜像
- [x] 测试镜像可用否

## 使用方法

```shell
# 制作可引导镜像
./build -b

# 测试可引导镜像
./build -i ./work/graceful-linux-0.0.1.iso
```

## 依赖

|依赖命令|依赖原因|
|--------|--------|
|`pacstrap`|用于生成根文件系统|
|`chroot`|用于切换到根文件系统执行相关操作|
|`mksquashfs`|用于将根文件系统制作成squashfs|
|`sha512sum`|用于生成镜像的指纹，在ramfs中检测镜像是否被修改|
|`xorriso`|用于生成可引导镜像|
|`qemu`, `qemu-system-x86_64`|用于测试镜像是否可用|
