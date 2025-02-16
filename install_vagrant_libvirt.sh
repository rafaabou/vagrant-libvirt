#!/bin/bash

# How to Use the Script
# 1. Create the script file: Save the script as install_vagrant_libvirt.sh.
#    You can use nano or any text editor to create the file:
#    nano install_vagrant_libvirt.sh
#
# 2. Make the script executable: After saving the script, make it executable by running:
#    chmod +x install_vagrant_libvirt.sh
#
# 3. Run the script: Now, execute the script with:
#    ./install_vagrant_libvirt.sh


# vagrant-libvirt Installation and Configuration on Debian (Kaisen Linux)

echo "Starting the vagrant-libvirt installation..."

# 1. Remove Existing Vagrant Libvirt Installation
# To avoid conflicts, remove any previously installed vagrant-libvirt packages
echo "Removing any previously installed vagrant-libvirt packages..."
sudo apt-get purge -y vagrant-libvirt
sudo apt-mark hold vagrant-libvirt

# 2. Install Required Dependencies
# Install the necessary packages for virtualization support
echo "Installing required dependencies..."
sudo apt-get update
sudo apt-get install -y qemu libvirt-daemon-system libvirt-dev ebtables libguestfs-tools

# 3. Install Vagrant and Libvirt Plugin
# Install Vagrant and the Ruby fog-libvirt dependency
echo "Installing Vagrant and the Ruby fog-libvirt plugin..."
sudo apt-get install -y vagrant ruby-fog-libvirt

# 4. Install the vagrant-libvirt Plugin
# Install the vagrant-libvirt plugin for Vagrant
echo "Installing the vagrant-libvirt plugin for Vagrant..."
vagrant plugin install vagrant-libvirt

# If you encounter errors, set custom environment variables for better compatibility
echo "If installation fails, attempting to set custom environment variables for compatibility..."
CONFIGURE_ARGS='with-ldflags=-L/opt/vagrant/embedded/lib with-libvirt-include=/usr/include/libvirt with-libvirt-lib=/usr/lib' \
    GEM_HOME=~/.vagrant.d/gems \
    GEM_PATH=$GEM_HOME:/opt/vagrant/embedded/gems \
    PATH=/opt/vagrant/embedded/bin:$PATH \
    vagrant plugin install vagrant-libvirt

# 5. Clean Up Unnecessary Packages
# Remove unnecessary packages after installation
echo "Cleaning up unnecessary packages..."
sudo apt autoremove -y

# 6. Set the Default Provider to Libvirt
# Set libvirt as the default provider for Vagrant in your shell configuration
echo "Setting libvirt as the default provider for Vagrant..."
echo 'export VAGRANT_DEFAULT_PROVIDER=libvirt' >> ~/.bashrc
source ~/.bashrc

# 7. Verify Vagrant Installation
# Check that Vagrant was installed successfully
echo "Verifying Vagrant installation..."
vagrant --version

# 8. Check Libvirt Installation
# Verify if libvirt is installed and running
echo "Checking if libvirt is running..."
sudo systemctl status libvirtd

# If it's not running, start and enable the libvirt service
if ! systemctl is-active --quiet libvirtd; then
    echo "Starting and enabling libvirtd service..."
    sudo systemctl start libvirtd
    sudo systemctl enable libvirtd
else
    echo "libvirtd is already running."
fi

# 9. Add User to Libvirt Group
# Add the current user to the libvirt group
echo "Adding user to the libvirt group..."
sudo usermod -aG libvirt $USER
newgrp libvirt  # Apply group changes without logout

echo "vagrant-libvirt installation and configuration completed successfully!"
