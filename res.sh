#!/bin/bash
echo $1 $2
TARGET_PRODUCT=$1
PRODUCT_OUT=$2

if [ -e "device/rockchip/$TARGET_PRODUCT/8188eu.ko" ] ; then
cp device/rockchip/$TARGET_PRODUCT/8188eu.ko $PRODUCT_OUT/recovery/root/res/
fi

if [ -e "device/rockchip/$TARGET_PRODUCT/8192cu.ko" ] ; then
cp device/rockchip/$TARGET_PRODUCT/8192cu.ko $PRODUCT_OUT/recovery/root/res/
fi

if [ -e "device/rockchip/$TARGET_PRODUCT/rda5890.ko" ] ; then
cp device/rockchip/$TARGET_PRODUCT/rda5890.ko $PRODUCT_OUT/recovery/root/res/
fi

if [ -e "device/rockchip/$TARGET_PRODUCT/rt5370sta.ko" ] ; then
cp device/rockchip/$TARGET_PRODUCT/rt5370sta.ko $PRODUCT_OUT/recovery/root/res/
fi

if [ -e "device/rockchip/$TARGET_PRODUCT/rkwifi.ko" ] ; then
cp device/rockchip/$TARGET_PRODUCT/rkwifi.ko $PRODUCT_OUT/recovery/root/res/
fi

if [ -e "device/rockchip/$TARGET_PRODUCT/wlan.ko" ] ; then
cp device/rockchip/$TARGET_PRODUCT/wlan.ko $PRODUCT_OUT/recovery/root/res/
fi

if [ -e "external/wlan_loader/firmware/nvram_RK903_26M.cal" ] ; then
cp external/wlan_loader/firmware/nvram_RK903_26M.cal $PRODUCT_OUT/recovery/root/res/
fi

if [ -e "external/wlan_loader/firmware/fw_RK903b2.bin" ] ; then
cp external/wlan_loader/firmware/fw_RK903b2.bin $PRODUCT_OUT/recovery/root/res/
fi

if [ -e "external/wlan_loader/firmware/fw_RK901a0.bin" ] ; then
cp external/wlan_loader/firmware/fw_RK901a0.bin $PRODUCT_OUT/recovery/root/res/
fi

if [ -e "external/wlan_loader/firmware/fw_RK901a2.bin" ] ; then
cp external/wlan_loader/firmware/fw_RK901a2.bin $PRODUCT_OUT/recovery/root/res/
fi

if [ -e "external/wlan_loader/firmware/nvram_RK901.txt" ] ; then
cp external/wlan_loader/firmware/nvram_RK901.txt $PRODUCT_OUT/recovery/root/res/
fi

if [ -e "external/wlan_loader/firmware/WIFI_RAM_CODE" ] ; then
cp external/wlan_loader/firmware/WIFI_RAM_CODE $PRODUCT_OUT/recovery/root/res/
fi

if [ -e "device/rockchip/$TARGET_PRODUCT/proprietary/libipp/rk29-ipp.ko" ] ; then
cp device/rockchip/$TARGET_PRODUCT/proprietary/libipp/rk29-ipp.ko $PRODUCT_OUT/recovery/root/
fi

if [ -e "device/rockchip/$TARGET_PRODUCT/bluetooth/pcba/rk903/system/bin" ] ; then
cp device/rockchip/$TARGET_PRODUCT/bluetooth/pcba/rk903/system/bin/ $PRODUCT_OUT/recovery/root/system/ -a
fi

if [ -e "device/rockchip/$TARGET_PRODUCT/bluetooth/pcba/rk903/system/etc" ] ; then
cp device/rockchip/$TARGET_PRODUCT/bluetooth/pcba/rk903/system/etc/ $PRODUCT_OUT/recovery/root/system/ -a 
fi