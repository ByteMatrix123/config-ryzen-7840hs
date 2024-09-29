#!/usr/bin/bash

files=(
/etc/systemd/zram-generator.conf.d/zram0-swap.conf
/etc/systemd/zram-generator.conf.d/zram1-portage-tmpdir.conf
/etc/localtime
/etc/kernel/cmdline
/etc/profile.d/local.sh
/etc/tmpfiles.d/sysfs-local.conf
/etc/portage/binrepos.conf/gentoobinhost.conf
/etc/portage/env/nolto.conf
/etc/portage/make.conf
/etc/portage/make.profile
/etc/portage/package.accept_keywords/zz-autounmask
/etc/portage/package.env/noltobuild
/etc/portage/package.license/kernel
/etc/portage/package.license/android-studio
/etc/portage/package.use/00cpu-flags
/etc/portage/package.use/gnome
/etc/portage/package.use/installkernel
/etc/portage/package.use/qemu
/etc/portage/package.use/zz-autounmask
/etc/portage/repos.conf/gentoo.conf
/etc/portage/repos.conf/gentoo-zh.conf
/var/cache/ccache/ccache.conf
/var/lib/portage/world
/usr/src/linux
/usr/src/linux-6.6.38-gentoo/.config
/usr/src/linux-6.6.38-gentoo/defconfig
/usr/src/linux-6.6.47-gentoo/.config
/usr/src/linux-6.6.47-gentoo/defconfig
/usr/src/linux-6.6.52-gentoo/.config
/usr/src/linux-6.6.52-gentoo/defconfig
)

for file in "${files[@]}"; do
  [[ ! -e $file ]] && echo "Warning: $file not found" && continue
  dst_file="${PWD}/root/${file}"
  dst_dir=$(dirname $dst_file)
  mkdir -p $dst_dir
  [[ -L $dst_file ]] && unlink $dst_file
  cp -fv --no-dereference --preserve=links $file $dst_file
  if [[ "$file" = /var/lib/portage/world ]]; then
    sed -i '/^cross-.*$/d' $dst_file
  fi
done
