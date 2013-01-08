#!/bin/bash

echo "BASH-script to convert all eagle libaries to kicad."
echo "Written by Jan Phillip Willmann (jantek.willmann@gmail.com)"

temp_path=$(dirname $PWD)
cd /usr/share/eagle/lbr

echo "Generating files..."
for i in $(ls *.lbr); do
echo $i
  sudo eagle -C $(echo "\"run $temp_path/eagle2kicad.ulp 1 1 1 1; quit\"") $i
done

while true; do
  read -p "Do you wish to install the libaries? [y/n]" yn
  case $yn in
    [Yy]* )
      echo "Installing..."
      sudo mv *.lib /usr/share/kicad/library/
      sudo mv *.dcm /usr/share/kicad/library/
      sudo mv *.m* /usr/share/kicad/modules/
      break;;
    [Nn]* )
      echo "Deleting generated files..."
      sudo rm *.lib
      sudo rm *.dcm
      sudo rm *.m*
      break;;
    * ) echo "Please answer yes or no.";;
  esac
done

echo "Finished!"
cd $temp_path
exit 0
