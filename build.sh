#!/bin/bash

#判断node.js mvn是否存在
command -v npm  2>&1 || { echo >&2 "I require node.js v14.16.0+ but it's not installed.  Aborting."; sleep 5; exit 1; }
command -v mvn  2>&1 || { echo >&2 "I require maven 3.5 + but it's not installed.  Aborting."; sleep 5; exit 1; }

cd `dirname $0`
BuildDir=`pwd` #工程根目录

echo "build web"
cd $BuildDir/report-ui
npm install --force --registry=https://registry.npm.taobao.org 2>&1
npm run build:prod  2>&1

echo "publish web to springboot src/main/resources/static"

mkdir -p $BuildDir/report-core/src/main/resources/static
mv $BuildDir/report-ui/dist/* $BuildDir/report-core/src/main/resources/static/


echo "build springboot"
cd $BuildDir/report-core
mvn clean  2>&1
mvn package -Dmaven.test.skip=true  2>&1

echo "zip finish in build dir"
if [ ! -d "$BuildDir/build" ]; then
    mkdir $BuildDir/build
fi
mv $BuildDir/report-core/target/aj-report-*.zip $BuildDir/build/
rm -rf $BuildDir/report-core/src/main/resources/static/*

