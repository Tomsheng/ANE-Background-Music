#!/bin/bash

# MAIN PARAMS
adt_directory="/Applications/Adobe Flash Builder 4.6/sdks/4.6.0/bin"
root_directory="/Users/titi/Projects/AirBackgroundMusic"
dest_ANE=Binaries/AirBackgroundMusic.ane

# AS PARAMS
library_directory=${root_directory}/AS
extension_XML=${library_directory}/src/extension.xml
library_SWC=${library_directory}/bin/AirBackgroundMusic.swc


# IOS PARAMS
ios_build_directory=${root_directory}/Binaries/iOS
ios_platform_OPTIONS=${root_directory}/NativeIOS/platform.xml
ios_build_name="libAirBackgroundMusic.a"
ios_native_directory=${root_directory}/NativeIOS/build/Debug-iphoneos/

# ANDROID PARAMS
android_build_directory=${root_directory}/Binaries/Android
android_build_name="libAirFlurry.jar"
android_native_directory=${root_directory}/NativeAndroid/

# DEFAULT PARAMS
default_library_directory=${root_directory}/Default

default_directory=${root_directory}/Binaries/Default
default_library_SWC=${library_SWC}

# CERTIFICATES (not used for now)
#signing_options="-storetype pkcs12 -keystore /Users/titi/Desktop/WaMMobile/Certificates.p12"


# IOS BUILD

# get the latest build and copy it to ios_build_directory
echo "copying" ${ios_native_directory}${ios_build_name} "into" ${ios_build_directory}"/"
cp ${ios_native_directory}${ios_build_name} ${ios_build_directory}/

# Android BUILD


# LIBRARY.SWF BUILD

# unzip default_library_SWC
echo "unzipping" ${default_library_SWC}
unzip -q ${default_library_SWC} library.swf

# move library.swf into default platform directory
echo "moving library.swf into " ${default_directory}"/"
mv library.swf ${default_directory}/library.swf

# unzip library_SWC
echo "unzipping" ${library_SWC}
unzip -q ${library_SWC} library.swf
# move library.swf into Android and IOS platform directory
echo "copying library.swf into " ${android_build_directory}"/"
cp library.swf ${android_build_directory}/
echo "moving library.swf into " ${ios_build_directory}"/"
mv library.swf ${ios_build_directory}/


# Android and IOS build
echo "${adt_directory}"/adt -package -target ane "${dest_ANE}" "${extension_XML}" -swc "${library_SWC}" -platform Android-ARM -C "${default_directory}" library.swf  -platform iPhone-ARM -platformoptions "${ios_platform_OPTIONS}" -C "${ios_build_directory}" . -platform default -C "${default_directory}" library.swf
"${adt_directory}"/adt -package -target ane "${dest_ANE}" "${extension_XML}" -swc "${library_SWC}" -platform Android-ARM -C "${default_directory}" library.swf  -platform iPhone-ARM -platformoptions "${ios_platform_OPTIONS}" -C "${ios_build_directory}" . -platform default -C "${default_directory}" library.swf

# IOS-only build
#echo "${adt_directory}"/adt -package -target ane "${dest_ANE}" "${extension_XML}" -swc "${library_SWC}" -platform iPhone-ARM -platformoptions "${ios_platform_OPTIONS}" -C "${ios_build_directory}" . -platform default -C "${default_directory}" library.swf
#"${adt_directory}"/adt -package -target ane "${dest_ANE}" "${extension_XML}" -swc "${library_SWC}" -platform iPhone-ARM -platformoptions "${ios_platform_OPTIONS}" -C "${ios_build_directory}" . -platform default -C "${default_directory}" library.swf
