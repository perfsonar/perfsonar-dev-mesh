#!/bin/bash

#move to script direcory
cd /opt/perfsonar_ps/perfsonar-dev-mesh/conf

#if here, then time to update
git pull

#get list of files
for f in *.conf
do
    MESH=`echo "$f" | sed 's/\(.\)\.conf/\1/'`
    echo "Building ${MESH}.json"
    /usr/lib/perfsonar/bin/build_json --input $f --output /tmp/${MESH}.json
    if [ $? != 0 ]; then
       echo "Error generating JSON file ${MESH}.json"
    else
       cp -f /tmp/${MESH}.json /var/www/mesh_config/${MESH}.json
       rm -f /tmp/${MESH}.json
       echo "New JSON file available ${MESH}.json"
     fi
     echo ""
done