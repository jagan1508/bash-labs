#!/bin/bash

USR="devops"

for hosts in `cat remhosts` ; do
	echo "###########################################"
	echo "Setting up in ${hosts}"
	echo "###########################################"
	echo "Connecting to ${hosts} machine"
	echo "Pushing script to ${hosts} machine"
	scp web_setup.sh $USR@$hosts:/tmp/
	ssh $USR@$hosts sudo /tmp/web_setup.sh
	ssh $USR@$hosts rm -rf /tmp/web_setup.sh
	echo "###########################################"
	echo "Set up completed on ${hosts} machine"
	echo "###########################################"
done
