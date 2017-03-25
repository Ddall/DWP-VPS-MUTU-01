# DWP-VPS-MUTU-01

````bash
mkdir /etc/puppet/environments/webhosts

cd /etc/puppet/environments/webhosts

git init
git remote add origin git@github.com:Ddall/DWP-VPS-MUTU-01.git

git fetch

git reset --hard origin/master

bash /etc/puppet/environments/webhosts/scripts/puppet-webhosts-apply.sh
````
