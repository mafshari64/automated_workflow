
# some  parts of the current shell script should to be chnaged in the future. search "STBCIF" term in the following script.

#!/bin/bash

## INPUT variables
# We are in the parent directory where this shell script exists.  

# 1- Define the folder name ***ALREADY*** created in the parent directory for the simulation:
simulation_directory="./testPICMI-v2"  # Modify this for each simulation

#  1. Define the relative path to the template folder of the picongpu code which is initially cloned and is located in the same directory with this shell script.
picongpu_custom_template_path="picongpu/share/picongpu/pypicongpu/template"

# 2. Define variables for the source and destination custom_template directories:
#As we already modified customTemplates somewhere else we should copy it from the initial source ** STBCIF**  
SOURCE_customTemplates="/home/afshar87/afshari/simulation/picInputs/testPICMI-v2/customTemplates/" 
DEST_customTemplates="/home/afshar87/afshari/simulation/simulation_auto/testPICMI-v2/customTemplates/"

########  Create customTemplates folder if it doesn't exist and copy template 
echo "Create custom_templates folder if it doesn't exist and copy template"
mkdir -p "${simulation_directory}/customTemplates"
# Copy the 'etc' and 'includes' directories from the template directly to customTemplates
cp -r "${picongpu_custom_template_path}/etc"      "${simulation_directory}/customTemplates/"
cp -r "${picongpu_custom_template_path}/include"  "${simulation_directory}/customTemplates/"

echo "Starting rsync CUSTOM_TEMPLATE between ${SOURCE_customTemplates} and ${DEST_customTemplates}..." 
rsync -a --delete "${SOURCE_customTemplates}" "${DEST_customTemplates}"

echo "Setup completed successfully!"
