#!/bin/bash

## INPUT variables
# We are in the parent directory where the current shell script exists.  

##  The following parameters should  ***ALREADY***  have been defined.
# 1-  ***ALREADY***   created in the parent directory for each simulation:
simulation_directory="testPICMI-v2"  # Modify this for each simulation

# 2-***ALREADY*** available in simulation_directory (task 1) 
picmi_input_file_name="picmi_inputfile_ionization-v2.py"  # the name of the input_file of the simulation (in this case a python script using PICMI standard rules)
pypicongpuJSON_directory_name="lwfa_ionization_v2"        # lwfa_ionization_v2 is already defined in the picmi python script, i.e. task no.2: picmi_input_file_name="picmi_inputfile_ionization-v2.py" 

# 3- Define relevant profile for running the simulation, in this case using the picongpu code
PROFILE_NAME="fwkt_v100_picongpu.profile" # https://github.com/ComputationalRadiationPhysics/picongpu/tree/dev/etc/picongpu/hemera-hzdr

# 4- Define the **PATH** of the output folder where simulation data are dumped (in general in supercomputer)
simulation_output_folder_path="/bigdata/hplsim/external/afshar87"

# 5- Define the **NAME** of the output folder where simulation data are dumped (in general in supercomputer)
simulation_output_folder_name="lwfa-ionization-auto"  # Replace with your specific output folder name

### Function to check if a command was successful
check_command() {
    if [ $? -ne 0 ]; then
        echo "Error occurred while $1."
        exit 1
    fi
}

### Check if the pypicongpuJSON_directory_name directory exists and delete it if it does
pypicongpuJSON_directory_path="${simulation_directory}/${pypicongpuJSON_directory_name}"  

if [ -d "${pypicongpuJSON_directory_path}" ]; then
    echo "Removing existing output directory: ${pypicongpuJSON_directory_path}"
    rm -rf "${pypicongpuJSON_directory_path}"
    check_command "removing existing output directory"
else
    echo "Directory ${pypicongpuJSON_directory_name} does not exist. Proceeding..."
fi

######## Source the profile file to load environment variables
echo " Source the profile file to load environment variables"
# source "./profile/${PROFILE_NAME}"

# echo $PATH

# exit 0 #  0 in indicates a successful exit

######## Run the Python script to build the PIConGPU simulation
echo " run picmi_input_file_name" 
python "${simulation_directory}/${picmi_input_file_name}" 
check_command "running Python script to build the PIConGPU simulation ${picmi_input_file_name}"


######## get a compute node
echo "getDevice"
getDevice  # getDevice 4 Allocates 4 GPUs default number of GPUs is 1.

######## build simulation (for picongpu: pic-build command)
echo "pic-build simulation"
cd ${pypicongpuJSON_directory_path}

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

# cd ${simulation_directory}/${pypicongpuJSON_directory_name} 
# tbg -f -s -t "./etc/picongpu/N.cfg ${simulation_output_folder_path}/${simulation_output_folder_name}"
tbg -f -s -t "./etc/picongpu/N.cfg ${SCRATCH}/${simulation_output_folder_name}"

# tbg -f -s -t  -c etc/picongpu/N.cfg  $SCRATCH/lwfa-ionization

# tbg -f -s -t  "./picongpu/etc/picongpu/hemera-hzdr/fwkt_v100.tpl" -c etc/picongpu/N.cfg "SCRATCH/${simulation_output_folder}"


check_command "running tbg command"

echo "Setup completed successfully!"
