#!/bin/bash
echo res.sh $1 $2 $3 $4
TARGET_PRODUCT=$1
PRODUCT_OUT=$2
TARGET_BOARD_PLATFORM=$3
TARGET_ARCH=$4
PCBA_PATH=external/pcba_rockchip/pcba_core

if [ $TARGET_ARCH = "arm64" ] ; then
PLATFORM_LIB_PATH=$PRODUCT_OUT/obj_arm/lib
else
PLATFORM_LIB_PATH=$PRODUCT_OUT/obj/lib
fi

############################################### wifi bt firmware ##################################################
mkdir -p $PRODUCT_OUT/recovery/root/vendor/
mkdir -p $PRODUCT_OUT/recovery/root/vendor/bin/
mkdir -p $PRODUCT_OUT/recovery/root/vendor/lib/
mkdir -p $PRODUCT_OUT/recovery/root/vendor/lib/modules/
mkdir -p $PRODUCT_OUT/recovery/root/vendor/lib/hw/
mkdir -p $PRODUCT_OUT/recovery/root/vendor/etc/
mkdir -p $PRODUCT_OUT/recovery/root/vendor/etc/firmware/
mkdir -p $PRODUCT_OUT/recovery/root/etc/firmware/
mkdir -p $PRODUCT_OUT/recovery/root/etc/bluetooth/
mkdir -p $PRODUCT_OUT/recovery/root/vendor/firmware
mkdir -p $PRODUCT_OUT/recovery/root/vendor/etc/bluetooth/
mkdir -p $PRODUCT_OUT/recovery/root/lib/firmware
mkdir -p $PRODUCT_OUT/recovery/root/vendor/lib/modules/wifi
mkdir -p $PRODUCT_OUT/recovery/root/data/misc/wifi/

#create wifi ko
source $PCBA_PATH/build_wifi_ko.sh $TARGET_ARCH $PRODUCT_OUT

if [ -e "vendor/rockchip/common/wifi/firmware" ] ; then
cp -rf vendor/rockchip/common/wifi/firmware/ $PRODUCT_OUT/recovery/root/vendor/etc/ -a
fi

if [ -e "hardware/broadcom/libbt/conf/rockchip/rksdk/bt_vendor.conf" ] ; then
cp hardware/broadcom/libbt/conf/rockchip/rksdk/bt_vendor.conf $PRODUCT_OUT/recovery/root/vendor/etc/bluetooth/
fi

############################################### bin/lib ##################################################

cp -rf $PCBA_PATH/sbin/* $PRODUCT_OUT/recovery/root/vendor/bin/
cp -rf $PCBA_PATH/sbin/* $PRODUCT_OUT/recovery/root/sbin/


if [ -e "$PRODUCT_OUT/system/bin/toolbox" ] ; then
cp $PRODUCT_OUT/system/bin/toolbox $PRODUCT_OUT/recovery/root/vendor/bin/
fi
if [ -e "$PRODUCT_OUT/system/bin/linker" ] ; then
cp $PRODUCT_OUT/system/bin/linker $PRODUCT_OUT/recovery/root/vendor/bin/
fi
if [ -e "$PRODUCT_OUT/recovery/root/sbin/sh" ] ; then
cp $PRODUCT_OUT/recovery/root/sbin/sh $PRODUCT_OUT/recovery/root/vendor/bin/
fi

if [ -e "$PLATFORM_LIB_PATH/libselinux.so" ] ; then
cp $PLATFORM_LIB_PATH/libselinux.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libusbhost.so" ] ; then
cp $PLATFORM_LIB_PATH/libusbhost.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libc.so" ] ; then
cp $PLATFORM_LIB_PATH/libc.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libz.so" ] ; then
cp $PLATFORM_LIB_PATH/libz.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libcutils.so" ] ; then
cp $PLATFORM_LIB_PATH/libcutils.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libutils.so" ] ; then
cp $PLATFORM_LIB_PATH/libutils.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/liblog.so" ] ; then
cp $PLATFORM_LIB_PATH/liblog.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libm.so" ] ; then
cp $PLATFORM_LIB_PATH/libm.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libstdc++.so" ] ; then
cp $$PLATFORM_LIB_PATH/libstdc++.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libc++.so" ] ; then
cp $PLATFORM_LIB_PATH/libc++.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libdl.so" ] ; then
cp $PLATFORM_LIB_PATH/libdl.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libbacktrace.so" ] ; then
cp $PLATFORM_LIB_PATH/libbacktrace.so $PRODUCT_OUT/recovery/root/vendor/lib/
else
cp $PRODUCT_OUT/system/lib/libbacktrace.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libbase.so" ] ; then
cp $PLATFORM_LIB_PATH/libbase.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libunwind.so" ] ; then
cp $PLATFORM_LIB_PATH/libunwind.so $PRODUCT_OUT/recovery/root/vendor/lib/
else
cp $PRODUCT_OUT/system/lib/libunwind.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/liblzma.so" ] ; then
cp $PLATFORM_LIB_PATH/liblzma.so $PRODUCT_OUT/recovery/root/vendor/lib/
else
cp $PRODUCT_OUT/system/lib/liblzma.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libion.so" ] ; then
cp $PLATFORM_LIB_PATH/libion.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi

if [ -e "$PRODUCT_OUT/system/lib/libvndksupport.so" ] ; then
cp $PRODUCT_OUT/system/lib/libvndksupport.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi

#for wifi test
if [ -e "$PLATFORM_LIB_PATH/librkwifi-ctrl.so" ] ; then
cp $PLATFORM_LIB_PATH/librkwifi-ctrl.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi

if [ -e "$PLATFORM_LIB_PATH/libdrm.so" ] ; then
cp $PLATFORM_LIB_PATH/libdrm.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libdrm_rockchip.so" ] ; then
cp $PLATFORM_LIB_PATH/libdrm_rockchip.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libGLESv1_CM.so" ] ; then
cp $PLATFORM_LIB_PATH/libGLESv1_CM.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PLATFORM_LIB_PATH/libgralloc_drm.so" ] ; then
cp $PLATFORM_LIB_PATH/libgralloc_drm.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
if [ -e "$PRODUCT_OUT/symbols/vendor/lib/hw/gralloc.rk30board.so" ] ; then
cp $PRODUCT_OUT/symbols/vendor/lib/hw/gralloc.rk30board.so $PRODUCT_OUT/recovery/root/vendor/lib/hw/
else
cp $PLATFORM_LIB_PATH/hw/gralloc.rk30board.so $PRODUCT_OUT/recovery/root/vendor/lib/hw/
fi
if [ -e "$PRODUCT_OUT/system/lib/libhardware.so" ] ; then
cp $PRODUCT_OUT/system/lib/libhardware.so $PRODUCT_OUT/recovery/root/vendor/lib/
fi
