set -x
#############
# 
# This is the install script which will install the material of the 
# Weekendschool / scratchClient presentation and workshop on 
# a Raspberry Pi as it was given at the Pi And More conference 
# in Krefeld at 14 January 2017.
#
# It will:
# - download and install the Arduino IDE 1.8.0, which is needed for
#   loading the scratchClient sketch in the Arduino Nano or Uno.
# - put scratchClient at the right place. Currently it is included in this
#   distribution because there is currently no possibilityto refer to the specific
#   release that was tested with.
# - download and install the packages that scratchClient needs.
# - put the material of the PiAndMore workshop in a subfolder on the 
#   desktop and give the scripts execute permission.
#
# Author: Hans de Jong
#
##############


echo "##############"
echo "# Download and install Arduino 1.8.0"
echo "##############"
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


echo "##############"
echo "# Put scratchClient at the right place and install required packages"
echo "##############"
cd ~				# go to the home directory
# wget http://heppg.de/ikg/administration/pi/scratchClient/download/scratchClient.tar.gz
				# download scratchClient
tar xzf ~/Weekendschool-PiAndMore-PiAndMore*/PiAndMore/scratchClient/scratchClient.tar.gz	# unpack scratchClient
chmod +r -R scratchClient/	# set read permission on the entire tree
sudo apt-get update		# update Raspian
sudo apt-get install python-pip python-dev
				# get install packages that scratchClient needs ...
sudo pip install cherrypy routes mako ws4py spidev
				# ... and the same for the rest of the needed packages.
rm ~/Weekendschool-PiAndMore-PiAndMore*/PiAndMore/scratchClient		# Cleanup: remove the downloaded archive and the directory 


echo "##############"
echo "# Install the workshop material of the PiAndMore conference"
echo "# Github results in a less than optimal placement of files and names of directories, so"
echo "# that is also corrected here."
echo "##############"
cd ~/Weekendschool-PiAndMore-PiAndMore*
				# go into the directory where the material was unpacked into.
				# use a wildcard so that later releases do not require update
				# of this script.
mv README.md PiAndMore		# move the readme file into the subdirectory
mv PiAndMore ~/Desktop		# move the subdirectory to the Desktop
# rm ../PiAndMore-*.tar.gz	# remove the archive file that was downloaded
cp install.sh ~/Desktop/PiAndMore
				# copy the install script (this script that is executed)
				# it will have left the executable property by this copy, but 
				# that is fine. It is only to be used for reference since the 
				# references to the paths would be wrong anyway.
cd ~/Desktop/PiAndMore/ForHelpers
				# Go to the directory with scripts
chmod 744 DownloadLes.bash
chmod 744 StartScratchClient.bash
chmod 744 UploadResultaten.bash
chmod 744 USBpoorten.sh
				
echo "# FINAL CLEANUP"
				# remove the folder into which the material was unpacked.
				# note that this also deletes this install script, but since
				# that is the almost last line, it should not be a problem.
rm -r ~/Weekendschool-PiAndMore-PiAndMore*

echo "Hit any key to close"
read a
