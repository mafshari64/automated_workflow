
# some  parts of the current shell script should to be chnaged in the future. search "STBCIF" term in the following script.

# how to run  this shell script:
# 1- sh setup_simulation.sh
# 2.1- chmod +x setup_simulation.sh 
# 2.2- ./setup_simulation.sh


#!/bin/bash
module load git

## INPUT variables
# We are in the parent directory where this setup_simulation.sh script exists.  

##  The following parameters should  ***ALREADY***  have been defined.
# 1-  ***ALREADY***   created in the parent directory for each simulation:
simulation_directory="testPICMI-v2"  # Modify this for each simulation

# 2-***ALREADY*** available in simulation_directory (task 1) 
picmi_input_file_name="picmi_inputfile_ionization-v2.py"  # the name of the input_file of the simulation (in this case a python script using PICMI standard rules)
directory_contains_pypicongpuJSON="lwfa_ionization_v2"  # lwfa_ionization_v2 is already defined in the picmi python script, i.e. task no.2: picmi_input_file_name="picmi_inputfile_ionization-v2.py" 

## Follopwing parameters should be defined.

# 3- Define the output folder where simulation data are dumped (in general in supercomputer)
simulation_output_data_folder="lwfa-ionization-auto"  # Replace with your specific output folder name


: << 'comment'
# 3- define thegithub path of  codes  which are used for the simulation. 
# 3.1  Define the git repository paths as variables
picongpu_git_path='https://github.com/ComputationalRadiationPhysics/picongpu.git'
picmi_git_path='https://github.com/picmi-standard/picmi'

# 3.2 Define the path to the template folder of the picongpu code
picongpu_custom_template_path="picongpu/share/picongpu/pypicongpu/template"

# 3.2.1 Define variables for the source and destination directories:
#As we already modified customTemplates somewhere else we should copy it from the initial source ** STBCIF**  
# SOURCE_customTemplates="/home/afshar87/afshari/simulation/picInputs/testPICMI-v2/customTemplates/" 
# DEST_customTemplates="/home/afshar87/afshari/simulation/simulation_auto/testPICMI-v2/customTemplates/"

# 3.3 Define which profile is relevant for running the simulation, in this case using the picongpu code
PROFILE_NAME="fwkt_v100_picongpu.profile" # https://github.com/ComputationalRadiationPhysics/picongpu/tree/dev/etc/picongpu/hemera-hzdr

# 3.4 Define correct values for the relevant profile chosen above (PROFILE_NAME)
NEW_MY_MAIL="m.afshari@hzdr.de"
NEW_MY_MAILNOTIFY="ALL"  # "NONE" or  "ALL"
PICSRC="./picongpu"
TBG_PARTITION="casus"  # "fwkt_v100"
SIMULATION_OUTPUT_PATH="/bigdata/hplsim/external/afshar87"

# 3.5.1 Define the pull request (PR) relevant to this simulation (if needed); in this case adding ionization for picongpu simulation using PICMI rules
PR_ID="5007"           # https://github.com/ComputationalRadiationPhysics/picongpu/pull/5007
# 3.5.2 Define a temporary branch name
relevant_branch_name="PICMI_Add_ionization_model"  # Name for the new branch
comment

### Check if the output directory exists and delete it if it does
if [ -d "${simulation_directory}/${directory_contain_pypicongpuJSON}" ]; then
    echo "Removing existing output directory:  ${directory_contain_pypicongpuJSON}"
    rm -rf "${directory_contain_pypicongpuJSON}"
    check_command "removing existing output directory"
fi


### Function to check if a command was successful
check_command() {
    if [ $? -ne 0 ]; then
        echo "Error occurred while $1."
        exit 1
    fi
}


: << 'comment'

# Function to check if Git is installed or available as a module
check_git() {
    # Check if git is available
    if ! command -v git &> /dev/null; then
        echo "Git is not installed or not found in PATH."
        
        # Try to load the git module
        if command -v module &> /dev/null; then
            echo "Attempting to load Git module..."
            module load git
            check_command "loading Git module"

            # Check if Git is now available
            if ! command -v git &> /dev/null; then
                echo "Git module could not be loaded. Exiting..."
                exit 1
            else
                echo "Git module loaded successfully."
            fi
        else
            echo "Module system is not available. Exiting..."
            exit 1
        fi
    else
        echo "Git is available."
    fi
}

# Check for Git and load it if needed
check_git

# Clone the **PIConGPU** repository (if not already cloned)
echo "Clone the **PIConGPU** repository (if not already cloned)"
if [ ! -d "picongpu" ]; then
    echo "Cloning PIConGPU repository..."
    git clone ${picongpu_git_path}
else
    echo "PIConGPU repository already cloned. Checking for updates..."

    # Change to the picongpu directory
    cd picongpu

    # Fetch the latest changes from the remote repository
    git fetch origin

    # Detect the default branch of the repository (usually master or main)
    DEFAULT_BRANCH=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')

    if [ -z "$DEFAULT_BRANCH" ]; then
        echo "Unable to determine the default branch. Exiting..."
        exit 1
    fi

    echo "Pulling the latest changes from the ${DEFAULT_BRANCH} branch..."
    git pull origin ${DEFAULT_BRANCH}

    # Fetch the specific pull request and apply its changes
    echo "Fetching and applying pull request #${PR_ID}..."
    git fetch origin pull/${PR_ID}/head:${relevant_branch_name} # fetches the pull request with the ID ${PR_ID} from the GitHub repository. It stores the content of the pull request in a new branch named ${relevant_branch_name}

    # switches  the current branch back to the branch you want to merge changes into (e.g., main or master)
    git checkout ${DEFAULT_BRANCH}
    
    # Merge the changes from ${relevant_branch_name} branch into the ${DEFAULT_BRANCH} branch. 
    git merge ${relevant_branch_name}
    
    # Optionally, delete the temporary branch
    #git branch -d ${relevant_branch_name}

    # Go back to the original directory
    cd ..
fi

######## Clone the **PICMI** repository (if not already cloned)
echo "Clone the **PICMI** repository (if not already cloned)"
if [ ! -d "picmi" ]; then
    echo "Cloning PICMI repository..."
    git clone ${picmi_git_path}
else
    echo "PICMI repository already cloned. Checking for updates..."

    # Change to the picmi directory
    cd picmi

    # Fetch the latest changes from the remote repository
    git fetch origin

    # Detect the default branch of the repository (usually master or main)
    DEFAULT_BRANCH=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')

    if [ -z "$DEFAULT_BRANCH" ]; then
        echo "Unable to determine the default branch. Exiting..."
        exit 1
    fi

    echo "Pulling the latest changes from the ${DEFAULT_BRANCH} branch..."
    git pull origin ${DEFAULT_BRANCH}

    # Go back to the original directory
    cd ..
fi



#  Create customTemplates folder if it doesn't exist and copy template 
echo "Create custom_templates folder if it doesn't exist and copy template"
mkdir -p "${simulation_directory}/customTemplates"
# Copy the 'etc' and 'includes' directories from the template directly to customTemplates
cp -r "${picongpu_custom_template_path}/etc"      "${simulation_directory}/customTemplates/"
cp -r "${picongpu_custom_template_path}/include"  "${simulation_directory}/customTemplates/"

#   Create profile folder and copy hemera-hzdr
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

comment

echo "Starting rsync CUSTOM_TEMPLATE between ${SOURCE_customTemplates} and ${DEST_customTemplates}..." 
rsync -av --delete "${SOURCE_customTemplates}" "${DEST_customTemplates}"

# Source the profile file to load environment variables
echo " Source the profile file to load environment variables" 
source "./profile/${PROFILE_NAME}"

#  Run the Python script to build the PIConGPU simulation
echo " run picmi_input_file_name" 
python "${simulation_directory}/${picmi_input_file_name}" 
check_command "running Python script to build the PIConGPU simulation ${picmi_input_file_name}"


# tbg -f -s -t -c etc/picongpu/N.cfg "${SCRATCH}/${simulation_output_data_folder}"
# echo "Current working directory: $(pwd)"
# ls ./picongpu/etc/picongpu/hemera-hzdr/fwkt_v100.tpl

echo "run simulation (for picongpu: tbg command) with the specified configuration file and output folder" 
(cd ${simulation_directory}/${directory_contains_pypicongpuJSON} && tbg -f -s -t ./etc/picongpu/N.cfg SCRATCH/${simulation_output_data_folder})
check_command "running tbg command"

echo "Setup completed successfully!"
