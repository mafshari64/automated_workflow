import json
import os

# Define the common base path
base_path = './testPICMI-v2/lwfa_ionization_v2'
# base_path = './'
pypicongpu_path = os.path.join(base_path, 'pypicongpu.json')
pypicongpu_copied_path = os.path.join(base_path, 'pypicongpu_ontology_dictionary_conversion.json')
dictionary_file = './7-0-picongpu_ontology_dictionary.json'

# Load the original JSON
with open(pypicongpu_path, 'r') as f:
    json_data = json.load(f)

# Load the replacement dictionary
with open(dictionary_file, 'r') as f:
    replacements = json.load(f)

# Create a copy of the original JSON data
json_copy = json_data.copy()

# Function to recursively update the copy
def update_json(obj, replacements):
    if isinstance(obj, dict):
        for key, value in obj.items():
            # Check if the key matches a replacement
            if key in replacements:
                obj[key] = replacements[key]
            else:
                update_json(value, replacements)
    elif isinstance(obj, list):
        for item in obj:
            update_json(item, replacements)

# Update the copied JSON using the replacements
update_json(json_copy, replacements)

# Save the updated copy
with open(pypicongpu_copied_path, 'w') as f:
    json.dump(json_copy, f, indent=4)

print("Updated JSON copied to:", pypicongpu_copied_path)

