#############
# 
# This is the install script which will install the material of the 
# Weekendschool / scratchClient presentation and workshop on 
# a Raspberry Pi.
#
# It will:
# - download and install the Arduino IDE 1.8.0, which is needed for
#   loading the scratchClient sketch in the Arduino Nano or Uno.
# - download and put scratchClient at the right place.
# - download the packages that scratchClient needs.
# - put the material of the PiAndMore workshop in a subfolder on the 
#   desktop.
#
# Author: Hans de Jong
#
##############


##############
# Download and install Arduino 1.8.0
##############
cd ~				# go to the home directory
mkdir Arduino-1.8.0		# make a directory for installing the Arduino IDE
cd Arduino-1.8.0		# go in that directory
wget https://downloads.arduino.cc/arduino-1.8.0-linuxarm.tar.xz
				# download the Arduino IDE
tar xvJf arduino-1.8.0-linuxarm.tar.xz
				# unpack the Arduino IDE
cd arduino-1.8.0/		# Go into the directory that was created as result of the unpacking
./install.sh			# install the Arduino IDE
rm ../arduino-1.8.0-linuxarm.tar.xz	# remove the downloaded package
##############


##############
# Download and put scratchClient at the right place and install required packages
##############
cd ~				# go to the home directory
wget http://heppg.de/ikg/administration/pi/scratchClient/download/scratchClient.tar.gz
				# download scratchClient
tar xzf scratchClient.tar.gz	# unpack scratchClient
chmod +r -R scratchClient/	# set read permission on the entire tree
sudo apt-get update		# update Raspian
sudo apt-get install python-pip python-dev
				# get install packages that scratchClient needs ...
sudo pip install cherrypy routes mako ws4py spidev
				# ... and the same for the rest of the needed packages.
rm scratchClient.tar.gz		# Cleanup: remove the downloaded archive


##############
# Download the workshop material of the PiAndMore conference
# Github results in a less than optimal placement of files and names of directories, so 
# that is also corrected here.
##############
cd ~/Weekendschool-PiAndMore-PiAndMore*
				# go into the directory where the material was unpacked into.
				# use a wildcard so that later releases do not require update
				# of this script.
mv README.md PiAndMore		# move the readme file into the subdirectory
mv PiAndMore ~/Desktop		# move the subdirectory to the Desktop
rm ../PiAndMore-*.tar.gz	# remove the archive file that was downloaded
cp install.sh ~/Desktop/PiAndMore
				# copy the install script (this script that is executed)
				# it will have left the executable property by this copy, but 
				# that is fine. It is only to be used for reference since the 
				# references to the paths would be wrong anyway.
				
				# FINAL CLEANUP
				# remove the folder into which the material was unpacked.
				# note that this also deletes this install script, but since
				# that is the last line, it should not be a problem.
rm -r ~/Weekendschool-PiAndMore-PiAndMore*
