
# some  parts of the current shell script should to be chnaged in the future. search "STBCIF" term in the following script.

: '
how to run  this shell script:
sh install_codes.sh
or
shell_script="install_codes.sh"
chmod +x $shell_script 
./$shell_script
'

#!/bin/bash

## INPUT variables
# We are in the parent directory where this shell script exists.  


#  define thegithub path of  codes  which are used for the simulation. 
# 1  Define the git repository paths as variables
picongpu_git_path='https://github.com/ComputationalRadiationPhysics/picongpu.git'
picmi_git_path='https://github.com/picmi-standard/picmi'

# 3.2 Define the path to the template folder of the picongpu code
picongpu_custom_template_path="picongpu/share/picongpu/pypicongpu/template"

# 3.2.1 Define variables for the source and destination directories:
#As we already modified customTemplates somewhere else we should copy it from the initial source ** STBCIF**  
SOURCE_customTemplates="/home/afshar87/afshari/simulation/picInputs/testPICMI-v2/customTemplates/" 
DEST_customTemplates="/home/afshar87/afshari/simulation/simulation_auto/testPICMI-v2/customTemplates/"

# 3.3.1 Define the pull request (PR) relevant to this simulation (if needed); in this case adding ionization for picongpu simulation using PICMI rules
PR_ID="5007"           # https://github.com/ComputationalRadiationPhysics/picongpu/pull/5007
# 3.3.2 Define a temporary branch name
relevant_branch_name="PICMI_Add_ionization_model"  # Name for the new branch


### Function to check if a command was successful
check_command() {
    if [ $? -ne 0 ]; then
        echo "Error occurred while $1."
        exit 1
    fi
}


######## Function to check if Git is installed or available as a module
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

########  Clone the **PIConGPU** repository (if not already cloned)
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


########  Create customTemplates folder if it doesn't exist and copy template 
echo "Create custom_templates folder if it doesn't exist and copy template"
mkdir -p "${simulation_directory}/customTemplates"
# Copy the 'etc' and 'includes' directories from the template directly to customTemplates
cp -r "${picongpu_custom_template_path}/etc"      "${simulation_directory}/customTemplates/"
cp -r "${picongpu_custom_template_path}/include"  "${simulation_directory}/customTemplates/"

echo "Starting rsync CUSTOM_TEMPLATE between ${SOURCE_customTemplates} and ${DEST_customTemplates}..." 
rsync -a --delete "${SOURCE_customTemplates}" "${DEST_customTemplates}"

echo "Setup completed successfully!"
