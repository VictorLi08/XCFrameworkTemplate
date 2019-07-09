#!/bin/sh
# Type a script or drag a script file from your workspace to insert its path.

# Step 1: Remove existing .xcframework if applicable
rm -rf ${PROJECT_NAME}.xcframework

# Step 2. Build .framework for iOS Device
xcodebuild -scheme ${PROJECT_NAME} -configuration ${CONFIGURATION} -sdk iphoneos OBJROOT="${OBJROOT}/DependentBuilds"

# Step 3. Build .framework for iOS Simulator
xcodebuild -scheme ${PROJECT_NAME} -configuration ${CONFIGURATION} -sdk iphonesimulator OBJROOT="${OBJROOT}/DependentBuilds"

# Step 4. Build .framework for macOS (optional, only if your framework supports macOS)
xcodebuild -scheme "${PROJECT_NAME}-macOS" -configuration ${CONFIGURATION} OBJROOT="${OBJROOT}/DependentBuilds"

# Step 5. Create .xcframework using each of the .frameworks built previously 
xcodebuild -create-xcframework -framework "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework" -framework "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework" -framework "${BUILD_DIR}/${CONFIGURATION}/${PROJECT_NAME}_macOS.framework" -output ${PROJECT_NAME}.xcframework 

