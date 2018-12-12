#/bin/bash

# Start up script for ansible

echo ===========================
echo "|    Mac Setup Started   |"
echo ===========================
# Base line packages
sudo easy_install pip
sudo easy_install ansible

#sudo -H pip install git

# creating temp directory for instal

installDir="/tmp/setupmac"

mkdir $installDir


echo "Cloning git repo."

git clone -b development https://github.com/smoloney/macsetup.git $installDir


if [! $installDir ]; then
    echo "Failed to find mac setup files."
    echo "Git clone failed."
    exit 1
else
    cd $installDir
    ansible-playbook -i ./hosts playbook.yml --verbose
fi


echo "Cleaning up from install."
#rm -rf $installDir

echo "All done!  Enjoy your new mac."

exit 0