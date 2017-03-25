#!/bin/bash

cd /etc/puppet/
git pull origin master

puppet apply /etc/puppet/environments/webhosts/manifests/site.pp --environment=webhosts --modulepath=/etc/puppet/modules:/etc/puppet/environments/webhosts/modules:/etc/puppet/environments/main/modules
