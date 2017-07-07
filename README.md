# android-apk-viewer-script

decompress .apk file and view source code in GUI named jd-gui

# Prerequirement

* You should have the `JDK` develop environment on you platform
* You should run the script in `bash`

# Usage

```
Usage:

      ./viewSource.sh [apk-path]

Description:

      apk-path is the apk file which you want to view it's source code

      all decompiled files will be hold under the directory: ./apk-src
```


And there is an example to demonstrate the while process:

```
git clone --depth=1 https://github.com/wangzhizhou/android-apk-viewer-script.git
cd android-apk-viewer-script
./viewSource.sh drift_life2.apk
```

![demo](./bin/demo.gif)

