
##### Configuration
# to create an api_key visit: https://fwksimulationlogger.fz-rossendorf.de/login
# to login enter the username and password.
# After login click on ** View Account/Generate API Token** at the top menu of the website. Then, generate an API Token (api_key).
#create an api_key.txt and copy the api_key value.
api_key_file = './api_key.txt'                          # Define the path to the API key file: currently in the same folder with this python script

# File and metadata information
upload_type = 'PIConGPU'
username = 'afshar87'                                   # Replace with your actual username
directory_path = '/bigdata/hplsim/external/afshar87/lwfa-ionization/simOutput/0-pngElectronsYX'    # (relative) path from the folder containing this python script to the folder containing the metadata JSON file (in this case 'pypicongpu.json')
description = 'lwfa-folder'
keywords = ['simulation', 'lwfa', 'electron', 'custom_template']

#####
# -*- coding: utf-8 -*-
import subprocess
import sys

# Read the API key from the text file
with open(api_key_file, 'r') as file:
    api_key = file.read().strip()                        # Read and remove any extra whitespace or newline characters

# Now you can use api_key in your code
# print("API key: {}".format(api_key))

# install required packages
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


# Check if the directory exists
if not os.path.isdir(directory_path):
    raise IOError("The directory at {} does not exist.".format(directory_path))

# List the contents of the directory for debugging purposes
print("Listing files in directory:", directory_path)
for filename in os.listdir(directory_path):
    print(filename)

# Prepare headers
headers = {
    'Authorization': 'Bearer {}'.format(api_key)  # Bearer authentication
}

# define the Size of files in the directory in Bytes or MegaBytes.
def get_file_size_in_mb(file_path):
    try:
        file_size_bytes = os.path.getsize(file_path)
        # print("File size in bytes:", file_size_bytes)  # Print file size in bytes
        file_size_mb = file_size_bytes / (1024. * 1024)  # Convert bytes to megabytes
        return file_size_mb
    except Exception as e:
        print("Error accessing file: {}".format(e))
        
        
# Walk through the directory and find image files
for root, dirs, files in os.walk(directory_path):
    for file_name in files:
        # Check if the file is an image (by extension)
        if file_name.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp', '.tiff')):
            file_path = os.path.join(root, file_name)
            
            file_size_mb = get_file_size_in_mb(file_path)
            print("File size in MB: {:.2f}".format(file_size_mb))

            print("Uploading image: %s" % file_path)
            # Prepare the data and file for the request
            data = {
                'upload_type': upload_type,
                'path_to_data': file_path,
                'description': description,
                'keywords': ','.join(keywords),
                'username': username
            }

            files_to_upload = {
                'imageFile': open(file_path, 'rb')  # Assuming 'imageFile' is the correct key
            }

            try:
                # Perform the file upload
                response = requests.post(api_url, headers=headers, data=data, files=files_to_upload)
                response.raise_for_status()
                print("File '%s' uploaded successfully!" % file_name)
            except requests.exceptions.HTTPError as err:
                print("Failed to upload file '%s'. Status code: %d" % (file_name, response.status_code))
                print("Response: %s" % response.text)
            except Exception as e:
                print("An error occurred with '%s': %s" % (file_name, str(e)))
            finally:
                files_to_upload['imageFile'].close()  # Close the file when done