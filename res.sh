#!/bin/bash
echo res.sh $1 $2 $3 $4
TARGET_PRODUCT=$1
PRODUCT_OUT=$2
TARGET_BOARD_PLATFORM=$3
TARGET_ARCH=$4
PCBA_PATH=external/rk-pcba-test

############################################### wifi bt firmware ##################################################

mkdir -p $PRODUCT_OUT/recovery/root/system/
mkdir -p $PRODUCT_OUT/recovery/root/system/bin/
mkdir -p $PRODUCT_OUT/recovery/root/system/lib/
mkdir -p $PRODUCT_OUT/recovery/root/system/lib/modules/
mkdir -p $PRODUCT_OUT/recovery/root/system/lib/hw/
mkdir -p $PRODUCT_OUT/recovery/root/system/etc/
mkdir -p $PRODUCT_OUT/recovery/root/system/etc/firmware/
mkdir -p $PRODUCT_OUT/recovery/root/etc/firmware/
mkdir -p $PRODUCT_OUT/recovery/root/etc/bluetooth/
mkdir -p $PRODUCT_OUT/recovery/root/vendor/firmware
mkdir -p $PRODUCT_OUT/recovery/root/lib/firmware
mkdir -p $PRODUCT_OUT/recovery/root/system/etc/bluetooth
mkdir -p $PRODUCT_OUT/recovery/root/vendor/lib/modules/wifi
mkdir -p $PRODUCT_OUT/recovery/root/vendor/etc/firmware
mkdir -p $PRODUCT_OUT/recovery/root/data/misc/wifi/

if [ -e "$PRODUCT_OUT/vendor/etc/firmware/" ] ; then
cp -rf $PRODUCT_OUT/vendor/etc/firmware/ $PRODUCT_OUT/recovery/root/vendor/etc/ -a
fi
if [ -e "$PRODUCT_OUT/vendor/lib/modules/" ] ; then
cp -rf $PRODUCT_OUT/vendor/lib/modules/wifi/ $PRODUCT_OUT/recovery/root/vendor/lib/modules/ -a
fi

############################################### bin/lib ##################################################

cp -rf $PCBA_PATH/sbin/* $PRODUCT_OUT/recovery/root/system/bin/
cp -rf $PCBA_PATH/sbin/* $PRODUCT_OUT/recovery/root/sbin/


if [ -e "$PRODUCT_OUT/system/bin/toolbox" ] ; then
cp $PRODUCT_OUT/system/bin/toolbox $PRODUCT_OUT/recovery/root/system/bin/
fi
if [ -e "$PRODUCT_OUT/system/bin/linker" ] ; then
cp $PRODUCT_OUT/system/bin/linker $PRODUCT_OUT/recovery/root/system/bin/
fi
if [ -e "$PRODUCT_OUT/recovery/root/sbin/sh" ] ; then
cp $PRODUCT_OUT/recovery/root/sbin/sh $PRODUCT_OUT/recovery/root/system/bin/
fi

if [ $TARGET_ARCH = "arm64" ] ; then
    if [ -e "$PRODUCT_OUT/obj_arm/lib/libselinux.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/libselinux.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj_arm/lib/libusbhost.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/libusbhost.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj_arm/lib/libc.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/libc.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj_arm/lib/libz.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/libz.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj_arm/lib/libcutils.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/libcutils.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj_arm/lib/libutils.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/libutils.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj_arm/lib/liblog.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/liblog.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj_arm/lib/libm.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/libm.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj_arm/lib/libstdc++.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/libstdc++.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj_arm/lib/libc++.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/libc++.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj_arm/lib/libdl.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/libdl.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj_arm/lib/libbacktrace.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/libbacktrace.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj_arm/lib/libbase.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/libbase.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj_arm/lib/libunwind.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/libunwind.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj_arm/lib/liblzma.so" ] ; then
    cp $PRODUCT_OUT/obj_arm/lib/liblzma.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
else
    if [ -e "$PRODUCT_OUT/obj/lib/libselinux.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/libselinux.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj/lib/libusbhost.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/libusbhost.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj/lib/libc.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/libc.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj/lib/libz.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/libz.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj/lib/libcutils.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/libcutils.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj/lib/libutils.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/libutils.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj/lib/liblog.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/liblog.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj/lib/libm.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/libm.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj/lib/libstdc++.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/libstdc++.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj/lib/libc++.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/libc++.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj/lib/libdl.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/libdl.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj/lib/libbacktrace.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/libbacktrace.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj/lib/libbase.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/libbase.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj/lib/libunwind.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/libunwind.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
    if [ -e "$PRODUCT_OUT/obj/lib/liblzma.so" ] ; then
    cp $PRODUCT_OUT/obj/lib/liblzma.so $PRODUCT_OUT/recovery/root/system/lib/
    fi
fi

#for camera test
if [ -e "$PRODUCT_OUT/vendor/lib/libion.so" ] ; then
cp $PRODUCT_OUT/vendor/lib/libion.so $PRODUCT_OUT/recovery/root/system/lib/
fi

if [ -e "$PRODUCT_OUT/system/lib/libvndksupport.so" ] ; then
cp $PRODUCT_OUT/system/lib/libvndksupport.so $PRODUCT_OUT/recovery/root/system/lib/
fi

#for wifi test
if [ -e "$PRODUCT_OUT/vendor/lib/librkwifi-ctrl.so" ] ; then
cp $PRODUCT_OUT/vendor/lib/librkwifi-ctrl.so $PRODUCT_OUT/recovery/root/system/lib/
fi
