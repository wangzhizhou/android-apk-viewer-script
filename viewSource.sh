#!/bin/sh

APK_SRC_DIR="./apk-src"
JD_GUI=`find . -name "jd-gui*.jar"`
APK_TOOL=`find . -name "apktool"`
DEX2JAR=`find . -name "d2j-dex2jar.sh"`
JAVA_VERSION=`java -version`

check()
{
    if [ "JAVA_VERSION" = "" ]; then
        echo "Your should install the JDK first"
        exit -1
    fi

    if [ "$1" = "" ]; then
        usage
        exit 0
    fi

    if [ ! -f "$1" ]; then
        echo "file not exit!"
        exit -1
    fi

    if [ ! -d "$APK_SRC_DIR" ]; then
        mkdir -p "$APK_SRC_DIR"
    fi 

    if [ "$APK_TOOL" = "" ]; then
        echo "apk_tool command can not found!"
        exit -1
    fi

    if [ "$JD_GUI" = "" ]; then
        echo "jd_gui tool set can not found!"
        exit -1
    fi

    if [ "$DEX2JAR" = "" ]; then
        echo "d2j-dex2jar.sh not found!"
        exit -1
    fi
}

decodeApk()
{
    check $*
    if [ -d "$APK_SRC_DIR" ]; then
        rm -rf "$APK_SRC_DIR"
        $APK_TOOL d -f $1 $APK_SRC_DIR
    fi
}

viewSource()
{
    check $*
    unzip $1 -d $APK_SRC_DIR

    DEX_FILE_PATH=`find . -name classes.dex`
    if [ "$DEX_FILE_PATH" = "" ]; then
        echo "unzip apk file failed!"
        exit -1
    fi

    current_dir=$APK_SRC_DIR
    JAR_FILE_NAME="decompiled.jar"
    $DEX2JAR $DEX_FILE_PATH -o $current_dir/$JAR_FILE_NAME

    SRC_JAR_FILE_PATH=`find . -name $JAR_FILE_NAME`
    if [ "$SRC_JAR_FILE_PATH" = "" ]; then
        echo "cannot decode the dex file to jar file"
        exit -1
    fi
    echo "The decomplied source jar file be holded in: $current_dir/$JAR_FILE_NAME"   

    echo "opening the $JD_GUI tool to view source jar file: $current_dir/$JAR_FILE_NAME"
    java -jar $JD_GUI $current_dir/$JAR_FILE_NAME 
    
    JD_GUI_CFG=`find . -name "jd-gui.cfg"`
    rm $JD_GUI_CFG
}

usage()
{
    echo ""
    echo ""
    echo "Usage:"
    echo ""
    echo "      $0 [apk-path]"
    echo ""
    echo "Description:"
    echo ""
    echo "      apk-path is the apk file which you want to view it's source code"
    echo ""
    echo "      all decompiled files will be hold under the directory: $APK_SRC_DIR"
    echo ""
    echo ""
}



#decodeApk $*
viewSource $*


