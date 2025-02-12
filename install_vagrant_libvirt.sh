#!/bin/bash

# Step 1: Remove Existing Vagrant Libvirt Installation
echo "Removing existing vagrant-libvirt installation..."
sudo apt-get purge -y vagrant-libvirt
sudo apt-mark hold vagrant-libvirt

# Step 2: Install Required Dependencies
echo "Installing necessary dependencies..."
sudo apt-get update
sudo apt-get install -y qemu libvirt-daemon-system libvirt-dev ebtables libguestfs-tools

# Step 3: Install Vagrant and Libvirt Plugin
echo "Installing Vagrant and ruby-fog-libvirt..."
sudo apt-get install -y vagrant ruby-fog-libvirt

# Step 4: Install the vagrant-libvirt Plugin
echo "Installing vagrant-libvirt plugin..."
vagrant plugin install vagrant-libvirt

# If there are issues with the plugin, run with custom environment variables
echo "If you face errors during plugin installation, try using custom environment variables:"
echo "CONFIGURE_ARGS='with-ldflags=-L/opt/vagrant/embedded/lib with-libvirt-include=/usr/include/libvirt with-libvirt-lib=/usr/lib' GEM_HOME=~/.vagrant.d/gems GEM_PATH=\$GEM_HOME:/opt/vagrant/embedded/gems PATH=/opt/vagrant/embedded/bin:\$PATH vagrant plugin install vagrant-libvirt"

# Step 5: Clean Up Unnecessary Packages
echo "Cleaning up unnecessary packages..."
sudo apt autoremove -y

# Step 6: Set the Default Provider to Libvirt
echo "Setting default Vagrant provider to libvirt..."
echo "export VAGRANT_DEFAULT_PROVIDER=libvirt" >> ~/.bashrc
source ~/.bashrc

# Step 7: Check Vagrant Installation
echo "Verifying Vagrant installation..."
vagrant --version

# Step 8: Check Libvirt Installation
echo "Checking libvirt service status..."
sudo systemctl status libvirtd

# Start and enable libvirtd if not already running
echo "Starting and enabling libvirtd if necessary..."
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

echo "Installation process completed!"
