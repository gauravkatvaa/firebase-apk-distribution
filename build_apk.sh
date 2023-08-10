#!/bin/bash

# IMPORTANT NOTES:

# This script is written to run locally on the machine in the specific branch with the specific code
# Your current branch code build will be pushed into firebase and user will be notified
# To run this script you must have access to firebase console of the app
# To generate development build just run `bash build_apk.sh` or `./build_apk.sh`
# To generate staging build just run `bash build_apk.sh staging` or `./build_apk.sh staging`


# Checking flavor for development / staging / production
if [ -z $1 ]
then
      FLAVOR="development"
      APP_ID="TODO: Add your firebase development app id"

elif [ $1 = "staging" ] 
then
      FLAVOR=$1
      APP_ID="TODO: Add your firebase staging app id"
elif [$1 == "production"]
then
      FLAVOR=$1
      APP_ID="TODO: Add your firebase production app id"
else
      echo "$1 flavor not supported"
      FLAVOR="development"
      echo "Considering flavor default as $FLAVOR"
fi

# Add groups for testing in firebase
# Invite people to that group
# name eg. "qa-test"
GROUPS="TODO: Add your group name here"

# Checking firebase cli toold are installed or not
curl -sL https://firebase.tools | bash

# You will also need to login to firebase CLI via Google Chrome
# To login via differnt account just user firebase logout 
# and re run this script

firebase login

# Building apk on the current branch

echo "Current checkout branch is..."

git branch

bash prcheck.sh

echo "Building $FLAVOR APK file"

if flutter build apk --flavor $FLAVOR --target lib/main_$FLAVOR.dart; then

    echo "Build Success"

    echo "Distributing the $FLAVOR APK File to firebase"

    firebase appdistribution:distribute build/app/outputs/flutter-apk/app-$FLAVOR-release.apk --app $APP_ID --groups $GROUPS

else
    echo "Build Failed"

fi