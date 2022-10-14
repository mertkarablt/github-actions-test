#!/bin/bash -l

clear

# Constants
c_branch=${1}
c_environment=${2}
c_release_type=${3}
c_release_notes=${4}
c_version_number=${5}
c_build_number=${6}
c_apple_id=${7}
c_password=${8}

c_workspace="kapida.xcworkspace"
c_scheme=""
c_configuration="${c_environment}-${c_release_type}"
c_export_options="kapida/SupportingFiles/Files/Config/ExportOptions/ExportOptions_${c_environment}.plist"
c_archive_path="Archive/kapida.xcarchive"
c_ipa_path="Archive/ipa"
c_appcenter_project=""
c_appcenter_group="Testers"
c_token="ab823d750070b1ca1ae6424f6680cb77866b3b6a"
c_derived_data_path="/Users/jenkins/Library/Developer/Xcode/DerivedData"

clear
echo 🚀🚀🚀🚀🚀 kapida 🚀🚀🚀🚀🚀
echo
echo

# Clear
find $c_derived_data_path -type d -name 'kapida*' -prune -exec rm -rf {} +
rm -rf kapida-ios-build
if [[ $c_release_type == "AppStore" ]]; then
    rm -rf Archive
fi

# Environment
echo 🚀🚀🚀🚀🚀 ENVIRONMENT: $c_configuration 🚀🚀🚀🚀🚀
if [[ $c_environment == "Dev" ]]; then
    c_scheme="kapida-Dev"
    c_appcenter_project="a101-kapida/A101-Kapida-iOS-Beta"
elif [[ $c_environment == "Beta" ]]; then
    c_scheme="kapida-Beta"
    c_appcenter_project="a101-kapida/A101-Kapida-iOS-Beta-1"
else
    c_scheme="kapida-Store"
    c_appcenter_project="a101-kapida/A101-Kapida-iOS-Store"
    if [[ $c_release_type == "AppStore" ]]; then
        c_export_options="kapida/SupportingFiles/Files/Config/ExportOptions/ExportOptions_${c_release_type}.plist"
    fi
fi

appcenter apps set-current $c_appcenter_project


# Build Number
if [[ $c_release_type != "AppStore" ]]; then
    bn_file="VersionNumber.txt"
    if [[ -f $bn_file ]]; then
        read -r c_build_number<VersionNumber.txt
        c_build_number=$(($c_build_number + 1))
        echo $c_build_number>VersionNumber.txt
    else
        echo "1" > VersionNumber.txt
        read -r c_build_number<VersionNumber.txt
    fi
fi


# Path
mkdir kapida-ios-build
cp -a kapida-ios/ kapida-ios-build/
cd kapida-ios-build


# Release Notes
commit_id="$(git log -1 --format=%h 2>&1)"
c_release_notes="${c_release_notes} - $c_configuration - v$c_version_number ($c_build_number) - [${commit_id}]"
echo $c_release_notes


echo
echo
echo 🚀🚀🚀🚀🚀 POD INSTALL 🚀🚀🚀🚀🚀
echo
echo

arch -x86_64 pod install --repo-update

# Replace version build number
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $c_version_number" kapida/SupportingFiles/Files/Info.plist
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $c_build_number" kapida/SupportingFiles/Files/Info.plist
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $c_version_number" NotificationService/Info.plist
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $c_build_number" NotificationService/Info.plist

# Replace GoogleService-Info.plist
if [[ $c_environment == "Dev" ]]; then
    cp -v kapida/SupportingFiles/Files/Config/Firebase/GoogleService-Info_Dev.plist kapida/SupportingFiles/Files/GoogleService-Info.plist
elif [[ $c_environment == "Beta" ]]; then
    cp -v kapida/SupportingFiles/Files/Config/Firebase/GoogleService-Info_Beta.plist kapida/SupportingFiles/Files/GoogleService-Info.plist
else
    cp -v kapida/SupportingFiles/Files/Config/Firebase/GoogleService-Info_Store.plist kapida/SupportingFiles/Files/GoogleService-Info.plist
fi

echo "Firebase Config file:"
    cat kapida/SupportingFiles/Files/GoogleService-Info.plist

echo
echo
echo 🚀🚀🚀🚀🚀 BUILDING 🚀🚀🚀🚀🚀
xcodebuild -quiet -showBuildTimingSummary \
-workspace $c_workspace \
-scheme $c_scheme \
-configuration $c_configuration \
-archivePath $c_archive_path \
-destination 'generic/platform=iOS' \
clean archive
echo
echo

echo
echo
echo 🚀🚀🚀🚀🚀 EXPORTING ARCHIVE 🚀🚀🚀🚀🚀
echo
echo
xcodebuild -exportArchive \
-archivePath $c_archive_path \
-exportPath $c_ipa_path \
-exportOptionsPlist $c_export_options

ipa_full_path="$(find . -type f -iname "*.ipa" -exec ls "{}" +;)"
ipa_name=$(basename "$ipa_full_path")
ipa_file="${c_ipa_path}/${ipa_name}"
if [[ -f $ipa_file ]]; then

    # - creating release notes
    echo $c_release_notes > "${c_ipa_path}/ReleaseNotes.txt"

    if [[ $c_release_type == "AppStore" ]]; then
        echo 🚀🚀🚀🚀🚀 IPA GENERATED FOR APPSTORE DISTRIBUTION 🚀🚀🚀🚀🚀
        xcrun altool --validate-app --type ios --file "$ipa_file" --username $c_apple_id --password $c_password
        xcrun altool --upload-app --type ios --file "$ipa_file" --username $c_apple_id --password $c_password
    else
        echo
        echo
        echo 🚀🚀🚀🚀🚀 UPLOADING IPA 🚀🚀🚀🚀🚀
        echo
        echo
        appcenter distribute release --quiet --disable-telemetry  \
        --app $c_appcenter_project  \
        --build-version $c_version_number  \
        --build-number $c_build_number  \
        --file "${ipa_file}"  \
        --release-notes-file "${c_ipa_path}/ReleaseNotes.txt"  \
        --group $c_appcenter_group \
        --token $c_token

        echo
        echo
        echo 🚀🚀🚀🚀🚀 UPLOADING SYMBOLS 🚀🚀🚀🚀🚀
        echo
        echo
        cd $c_archive_path && zip -r dSYMs.zip dSYMs && cd ../..

        appcenter crashes upload-symbols  \
        -s "${c_archive_path}/dSYMs.zip"  \
        --app $c_appcenter_project  \
        --token $c_token
    fi
    
    Pods/FirebaseCrashlytics/upload-symbols -gsp kapida/SupportingFiles/Files/GoogleService-Info.plist -p ios Archive/kapida.xcarchive/dSYMs

    echo
    echo
    echo ✅✅✅✅ 🚀 SUCCESS 🚀 ✅✅✅✅
    echo
    echo
else
    echo
    echo
    echo 🔴🔴🔴🔴 🚀 FAIL 🚀 🔴🔴🔴🔴
    echo
    echo
    exit 1
fi
