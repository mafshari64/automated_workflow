#!/bin/bash

## INPUT variables
# We are in the parent directory where this shell script exists.  

# 1. Define which profile is relevant for running the simulation:
#  in this case  'fwkt_v100_picongpu.profile' profile of the picongpu code: https://github.com/ComputationalRadiationPhysics/picongpu/tree/dev/etc/picongpu/hemera-hzdr. 
# for lwfa simulation: (https://github.com/ComputationalRadiationPhysics/picongpu/tree/dev/share/picongpu/examples/LaserWakefield)

PROFILE_NAME="fwkt_v100_picongpu.profile" 

# 2. Define correct values for the relevant profile chosen above (PROFILE_NAME)
NEW_MY_MAIL="m.afshari@hzdr.de"
NEW_MY_MAILNOTIFY="ALL"  # "NONE" or  "ALL"
PICSRC="/home/afshar87/afshari/simulation/simulation_auto/picongpu"
TBG_PARTITION="casus"  # "fwkt_v100"
SIMULATION_OUTPUT_PATH="/bigdata/hplsim/external/afshar87"

########   Create profile folder and copy hemera-hzdr
mkdir -p profile
# Copy the specific profile file and rename it using the PROFILE_NAME variable
cp picongpu/etc/picongpu/hemera-hzdr/${PROFILE_NAME}.example profile/${PROFILE_NAME}

######## update PROFILE_NAME file with correct parametrs using sed
echo "update PROFILE_NAME file with correct parametrs using sed" 

sed -i "s/export MY_MAILNOTIFY=\"NONE\"/export MY_MAILNOTIFY=\"${NEW_MY_MAILNOTIFY}\"/" profile/${PROFILE_NAME}
sed -i "s/export MY_MAIL=\"someone@example.com\"/export MY_MAIL=\"${NEW_MY_MAIL}\"/" profile/${PROFILE_NAME}
sed -i "s|export PICSRC=.*|export PICSRC=${PICSRC}|" profile/${PROFILE_NAME} # Replace PICSRC path with the path to the cloned repository
sed -i "s/export TBG_partition=\"fwkt_v100\"/export TBG_partition=\"${TBG_PARTITION}\"/" profile/${PROFILE_NAME} # Replace TBG_partition value
echo "export SCRATCH=${SIMULATION_OUTPUT_PATH}" >> profile/${PROFILE_NAME} # Append the SCRATCH environment variable to the end of the profile file

echo "Setup completed successfully!"
