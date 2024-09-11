
# some  parts of the current shell script should to be chnaged in the future. search "STBCIF" term in the following script.

: '

how to run  this shell script:
sh setup_simulation.sh
or
shell_script="setup_simulation.sh"
chmod +x $shell_script 
./$shell_script

'

#!/bin/bash


## INPUT variables
# We are in the parent directory where this setup_simulation.sh script exists.  

##  The following parameters should  ***ALREADY***  have been defined.
# 1-  ***ALREADY***   created in the parent directory for each simulation:
simulation_directory="testPICMI-v2"  # Modify this for each simulation

# 2-***ALREADY*** available in simulation_directory (task 1) 
picmi_input_file_name="picmi_inputfile_ionization-v2.py"  # the name of the input_file of the simulation (in this case a python script using PICMI standard rules)
directory_contain_pypicongpuJSON="lwfa_ionization_v2"  # lwfa_ionization_v2 is already defined in the picmi python script, i.e. task no.2: picmi_input_file_name="picmi_inputfile_ionization-v2.py" 

## Follopwing parameters should be defined.

# 1- Define the path to the template folder of the picongpu code
picongpu_custom_template_path="picongpu/share/picongpu/pypicongpu/template"

# 1-1 modified customTemplates  for the source and destination directories:
#As we already modified customTemplates somewhere else we should copy it from the initial source ** STBCIF**  
SOURCE_customTemplates="/home/afshar87/afshari/simulation/picInputs/testPICMI-v2/customTemplates/" 
DEST_customTemplates="/home/afshar87/afshari/simulation/simulation_auto/testPICMI-v2/customTemplates/"

# 2- Define relevant profile for running the simulation, in this case using the picongpu code
PROFILE_NAME="fwkt_v100_picongpu.profile" # https://github.com/ComputationalRadiationPhysics/picongpu/tree/dev/etc/picongpu/hemera-hzdr

# 2- Define the PATH of the output folder where simulation data are dumped (in general in supercomputer)
simulation_output_folder_path="/bigdata/hplsim/external/afshar87"

# 3- Define the NAME of the output folder where simulation data are dumped (in general in supercomputer)
simulation_output_folder_name="lwfa-ionization-auto"  # Replace with your specific output folder name

### Function to check if a command was successful
check_command() {
    if [ $? -ne 0 ]; then
        echo "Error occurred while $1."
        exit 1
    fi
}


### Check if the directory_contain_pypicongpuJSON directory exists and delete it if it does
output_directory_path="${simulation_directory}/${directory_contain_pypicongpuJSON}"  

if [ -d "${output_directory_path}" ]; then
    echo "Removing existing output directory: ${output_directory_path}"
    rm -rf "${output_directory_path}"
    check_command "removing existing output directory"
else
    echo "Directory ${directory_contain_pypicongpuJSON} does not exist. Proceeding..."
fi

<<COMMENT
########  Create customTemplates folder if it doesn't exist and copy template 
echo "Create custom_templates folder if it doesn't exist and copy template"
mkdir -p "${simulation_directory}/customTemplates"
# Copy the 'etc' and 'includes' directories from the template directly to customTemplates
cp -r "${picongpu_custom_template_path}/etc"      "${simulation_directory}/customTemplates/"
cp -r "${picongpu_custom_template_path}/include"  "${simulation_directory}/customTemplates/"

echo "Starting rsync CUSTOM_TEMPLATE between ${SOURCE_customTemplates} and ${DEST_customTemplates}..." 
rsync -a --delete "${SOURCE_customTemplates}" "${DEST_customTemplates}"
COMMENT

######## Source the profile file to load environment variables
echo " Source the profile file to load environment variables"
source "./profile/${PROFILE_NAME}"

# echo $PATH

# exit 0 #  0 in indicates a successful exit

######## Run the Python script to build the PIConGPU simulation
echo " run picmi_input_file_name" 
python "${simulation_directory}/${picmi_input_file_name}" 
check_command "running Python script to build the PIConGPU simulation ${picmi_input_file_name}"

######## run simulation (for picongpu: pic-build command)
echo "pic-build simulation"
cd ${output_directory_path}

# echo "Current working directory: $(pwd)"
# echo "  "
# echo "list of elements in the current working directory:"
# ls -a

rm -rf .build
pic-build

######## run simulation (for picongpu: tbg command)
# echo "Current working directory: $(pwd)"
# ls ./picongpu/etc/picongpu/hemera-hzdr/fwkt_v100.tpl
echo "run simulation (for picongpu: tbg command) with the specified configuration file and output folder" 

# cd ${simulation_directory}/${directory_contain_pypicongpuJSON} 
# tbg -f -s -t "./etc/picongpu/N.cfg ${simulation_output_folder_path}/${simulation_output_folder_name}"
tbg -f -s -t "./etc/picongpu/N.cfg ${SCRATCH}/${simulation_output_folder_name}"

# tbg -f -s -t  -c etc/picongpu/N.cfg  $SCRATCH/lwfa-ionization

# tbg -f -s -t  "./picongpu/etc/picongpu/hemera-hzdr/fwkt_v100.tpl" -c etc/picongpu/N.cfg "SCRATCH/${simulation_output_folder}"


check_command "running tbg command"

echo "Setup completed successfully!"
