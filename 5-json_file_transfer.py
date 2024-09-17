# -*- coding: utf-8 -*-


##### Configuration
# to create an api_key visit: https://fwksimulationlogger.fz-rossendorf.de/login
# to login enter the username and password.
# After login click on ** View Account/Generate API Token** at the top menu of the website.
#create an api_key.txt which contains the api_key value.
api_key_file = './api_key.txt'                          # Define the path to the API key file: currently in the same folder with this python script

# Read the API key from the text file
with open(api_key_file, 'r') as file:
    api_key = file.read().strip()                        # Read and remove any extra whitespace or newline characters

# Now you can use api_key in your code
print("API key: {}".format(api_key))

# File and metadata information
upload_type = 'PIConGPU'
username = 'afshar87'                                   # Replace with your actual username
directory_path = './testPICMI-v2/lwfa_ionization_v2'    # (relative) path from the folder containing this python script to the folder containing the metadata JSON file (in this case 'pypicongpu.json')
json_file_name = 'pypicongpu.json'
path_to_data = '{}/{}'.format(directory_path, json_file_name)
description = 'lwfa'
keywords = ['simulation', 'lwfa', 'electron', 'custom_template']

#####

import subprocess
import sys

def install_package(package_name):
    """Install the specified package using pip."""
    try:
        subprocess.check_call([sys.executable, '-m', 'pip', 'install', package_name])
        print("{} installed successfully.".format(package_name))
    except subprocess.CalledProcessError as e:
        print("Failed to install {}: {}".format(package_name, e))

def main():
    """Check and install the requests package."""
    try:
        import requests
        print("requests is already installed.")
    except ImportError:
        print("requests not found. Installing...")
        install_package('requests')

if __name__ == "__main__":
    main()


import os
import requests


BASE_URL = 'fwksimulationlogger.fz-rossendorf.de'
api_url = 'https://{}/api/upload'.format(BASE_URL)

# for debugging: List files in the directory for debugging
# print("Listing files in directory:", directory_path)
# for filename in os.listdir(directory_path):
#     print(filename)

# Verify the file exists
if not os.path.isfile(path_to_data):
    raise IOError("The file at {} does not exist.".format(path_to_data))

# Prepare the data and file for the request
data = {
    'upload_type': upload_type,
    'path_to_data': path_to_data,
    'description': description,
    'keywords': ','.join(keywords),
    'username': username  # Add username here
}

files = {
    'metadataFile': open(path_to_data, 'rb')  # Assuming 'metadataFile' is the correct key
}

# Prepare headers
headers = {
    'Authorization': 'Bearer {}'.format(api_key)  # Use 'Bearer' if that’s the expected scheme
}

# Perform the file upload
try:
    response = requests.post(api_url, headers=headers, data=data, files=files)
    response.raise_for_status()  # Raise an error for bad responses (4xx, 5xx)
    print("File uploaded successfully!")
except requests.exceptions.HTTPError as err:
    print("Failed to upload file. Status code: {}".format(response.status_code))
    print("Response: {}".format(response.text))
except Exception as e:
    print("An error occurred: {}".format(str(e)))
finally:
    files['metadataFile'].close()  # Close the file when done
