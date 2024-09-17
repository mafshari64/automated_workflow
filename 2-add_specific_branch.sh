#!/bin/bash

#  Define the pull request (PR) relevant to the simulation (if needed):
#in this case Laser Wake field: (https://github.com/ComputationalRadiationPhysics/picongpu/tree/dev/share/picongpu/examples/LaserWakefield)
# including using ionization of picongpu defined in the PICMI input file
#PR_ID="5007"           # https://github.com/ComputationalRadiationPhysics/picongpu/pull/5007


# Define variables
REPO_DIR="./picongpu"
BRANCH_TO_FETCH="brian"
BRANCH_TO_CHECKOUT="dev"
BRANCH_TO_DELETE="pr5007"
BRANCH_TO_CREATE="pr5007"
BRANCH_TO_CREATE_FROM="brian/topic-addIonizerSupport"

# Change to the repository directory
cd "$REPO_DIR" || { echo "Failed to change directory to $REPO_DIR"; exit 1; }

# Load necessary modules
module load git

# Show the status of the repository
git status

# Fetch the specified branch
git fetch "$BRANCH_TO_FETCH"

# Checkout to the specified branch
git checkout "$BRANCH_TO_CHECKOUT"

# Delete the specified branch
git branch -D "$BRANCH_TO_DELETE"

# Create and checkout the new branch from the specified branch
git checkout -b "$BRANCH_TO_CREATE" "$BRANCH_TO_CREATE_FROM"

# Show the status of the repository again
git status

# Return to the previous directory
cd .. || { echo "Failed to change directory back"; exit 1; }
