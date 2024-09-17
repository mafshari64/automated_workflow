#!/bin/bash

# We are in the parent directory where this shell script exists.  

#  define the github path of the codes which are used for the simulation. 
picongpu_git_path='https://github.com/ComputationalRadiationPhysics/picongpu.git'

picmi_git_path='https://github.com/picmi-standard/picmi'

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

echo "Setup completed successfully!"
