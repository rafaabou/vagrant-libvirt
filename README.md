# vagrant-libvirt
 configure vagrant-libvirt on Debian (kaisen linux)

# 1. Remove Existing Vagrant Libvirt Installation
# To avoid conflicts, remove any previously installed vagrant-libvirt packages
sudo apt-get purge vagrant-libvirt
sudo apt-mark hold vagrant-libvirt

# 2. Install Required Dependencies
# Install the necessary packages for virtualization support
sudo apt-get update
sudo apt-get install -y qemu libvirt-daemon-system libvirt-dev ebtables libguestfs-tools

# 3. Install Vagrant and Libvirt Plugin
# Install Vagrant and the Ruby fog-libvirt dependency
sudo apt-get install -y vagrant ruby-fog-libvirt

# 4. Install the vagrant-libvirt Plugin
# Install the vagrant-libvirt plugin for Vagrant
vagrant plugin install vagrant-libvirt

# If you encounter errors, set custom environment variables for better compatibility
CONFIGURE_ARGS='with-ldflags=-L/opt/vagrant/embedded/lib with-libvirt-include=/usr/include/libvirt with-libvirt-lib=/usr/lib' \
    GEM_HOME=~/.vagrant.d/gems \
    GEM_PATH=$GEM_HOME:/opt/vagrant/embedded/gems \
    PATH=/opt/vagrant/embedded/bin:$PATH \
    vagrant plugin install vagrant-libvirt

# 5. Clean Up Unnecessary Packages
# Remove unnecessary packages after installation
sudo apt autoremove

# 6. Set the Default Provider to Libvirt
# Set libvirt as the default provider for Vagrant in your shell configuration
export VAGRANT_DEFAULT_PROVIDER=libvirt
source ~/.bashrc

# 7. Verify Vagrant Installation
# Check that Vagrant was installed successfully
vagrant --version

# 8. Check Libvirt Installation
# Verify if libvirt is installed and running
sudo systemctl status libvirtd

# If it's not running, start and enable the libvirt service
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
