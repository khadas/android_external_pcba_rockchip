#!/bin/bash
echo res.sh $1 $2 $3 $4
TARGET_PRODUCT=$1
PRODUCT_OUT=$2
TARGET_BOARD_PLATFORM=$3
TARGET_ARCH=$4
PCBA_PATH=external/pcba_rockchip/pcba_core

if [ $TARGET_ARCH = "arm64" ] ; then
PLATFORM_LIB_PATH=$PRODUCT_OUT/obj_arm
else
PLATFORM_LIB_PATH=$PRODUCT_OUT/obj
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

copy_lib() {
    LIB_NAME=$1
    ADDON_PATH=$2
    if [ -e "$PLATFORM_LIB_PATH/SHARED_LIBRARIES/${LIB_NAME}_intermediates/$LIB_NAME.so" ] ; then
        cp "$PLATFORM_LIB_PATH/SHARED_LIBRARIES/${LIB_NAME}_intermediates/$LIB_NAME.so" $PRODUCT_OUT/recovery/root/vendor/lib/$ADDON_PATH
        #echo "$PLATFORM_LIB_PATH/SHARED_LIBRARIES/${LIB_NAME}_intermediates/$LIB_NAME.so is find!"
        #echo "copy_lib to $PRODUCT_OUT/recovery/root/vendor/lib/$ADDON_PATH"
    fi
}

if [ -e "$PRODUCT_OUT/obj/EXECUTABLES/toolbox_intermediates/toolbox" ] ; then
cp $PRODUCT_OUT/obj/EXECUTABLES/toolbox_intermediates/toolbox $PRODUCT_OUT/recovery/root/vendor/bin/
fi
if [ -e "$PLATFORM_LIB_PATH/EXECUTABLES/linker_intermediates/linker" ] ; then
cp $PLATFORM_LIB_PATH/EXECUTABLES/linker_intermediates/linker $PRODUCT_OUT/recovery/root/vendor/bin/
fi
if [ -e "$PRODUCT_OUT/recovery/root/sbin/sh" ] ; then
cp $PRODUCT_OUT/recovery/root/sbin/sh $PRODUCT_OUT/recovery/root/vendor/bin/
fi

copy_lib libselinux
copy_lib libusbhost
copy_lib libc
copy_lib libz
copy_lib libcutils
copy_lib libutils
copy_lib liblog
copy_lib libm
copy_lib libstdc++
copy_lib libc++
copy_lib libdl
copy_lib libbacktrace
copy_lib libbase
copy_lib libunwind
copy_lib liblzma
copy_lib libion
copy_lib libvndksupport
copy_lib librkwifi-ctrl
copy_lib libdrm
copy_lib libdrm_rockchip
copy_lib libGLESv1_CM
copy_lib libgralloc_drm
copy_lib gralloc.rk30board hw/
copy_lib libhardware
