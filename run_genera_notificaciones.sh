#!/bin/sh
DIR=`/usr/bin/dirname $0`
cd $DIR
$JAVA_HOME/bin/java -cp lib/*:build -Dconfig_file=etc/car.conf GeneraNotificaciones
