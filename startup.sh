#/bin/bash

# Start up script for ansible

echo ===========================
echo "|    Mac Setup Started   |"
echo ===========================

IDE = read -p "Enter the preferred IDE (Eclipse or Intellij): "
echo $IDE
# Base line packages
if ! [[ -e ~/.ssh/id_rsa ]]; then
echo "creating ssh key"
ssh-keygen -t rsa -b 4096 -C "s_moloney@aol.com" -N ''
ssh-add -K ~/.ssh/id_rsa

echo "Add public key to github"
pbcopy < ~/.ssh/id_rsa.pub
read -p "Press enter to continue."
else
    echo "Key already created"
fi









xcode-select --install
sudo easy_install pip

sudo pip install cryptography
sudo easy_install ansible
sudo pip install ansible-vault
 ansible-vault encrypt ~/.ssh/id_rsa

# creating temp directory for instal

installDir="/tmp/setupmac"

sshkeyDir = "/Users/"$(whoami)"/Desktop"
mkdir $installDir
mkdir $sshkeyDir


echo "Cloning git repo."

git clone -b development https://github.com/smoloney/macsetup.git $installDir


if [! $installDir ]; then
    echo "Failed to find mac setup files."
    echo "Git clone failed."
    exit 1
else
    cd $installDir
    ansible-playbook -i ./hosts playbook.yml --verbose --ide "$IDE"
fi




echo "Cleaning up from install."
rm -rf $installDir ~/.ssh/id_rsa ~/.ssh/id_rsa.pub


echo "All done!  Enjoy your new mac."

exit 0