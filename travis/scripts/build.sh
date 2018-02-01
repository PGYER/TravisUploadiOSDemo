#!/bin/sh
xcrun xcodebuild -project PgySDKDemo.xcodeproj -scheme PgySDKDemo \
  -archivePath PgySDKDemo.xcarchive archive

xcrun xcodebuild -exportArchive -archivePath PgySDKDemo.xcarchive \
  -exportPath ./build -exportOptionsPlist ExportOptions.plist

