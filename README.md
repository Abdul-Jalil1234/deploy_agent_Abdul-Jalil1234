# 🛠  Setup Instructions
1. First ensure the script is executable by giving it the executable permission using the chmod u+x  setup_project.sh(name of my script) if it is not executable on your side
2. Run bash setup_project.sh to execute the script

To trigger the archive , once the script has started executing , hit the control key + c to terminate it . The current workspace will then be bundle into an archive .
NB An archive will only be created when you have bypassed the section that acts for a name of the directory.
Alternative approach for running the script is ./ setup_project.sh

# 📝 Description of project and codes
## Attendance Tracker Workspace Setup
This script automates the creation and configuration of a workspace for the Attendance Tracker project. It handles directory structuring, file organization, and user-driven configuration, with built-in safety mechanisms.
1. Safety & Error Handling
The script is built to be "fail-safe" using two primary bash features:
- set -e: Ensures the script stops immediately if any command fails.
- trap: Catches the SIGINT signal (triggered by Ctrl+C).
##  The Cleanup Function
When an interruption occurs, the stop_and_bundle_archive() function:
Identifies the active $parent_dir.
Creates an archive of the current work.
Removes the original directory to leave the workspace clean.

2. Directory Scaffolding
The script builds a standardized project structure based on your input:
Component	Path	                   Description
Root	  attendance_tracker_[user_input]/	Contains the attendance_checker.py file.
Helpers	  /Helpers/	                Contains config.json and assets.csv.
Reports 	/reports/	      Contains the reports.log file.

3. Dynamic Configuration
The script allows for real-time updates to the config.json file using the sed stream editor.
Threshold Management
If the user chooses to update thresholds, the script replaces the following values:
Warning Threshold: (Default: 75)
Failure Threshold: (Default: 50)
## Example of the internal update logic
sed -i "s/\(\"warning\":\)[[:space:]]*[0-9]*/\1 ${warning_value:-75}/"  "$parent_dir/Helpers/config.json"

4. Environment Validation
Before completing, the script runs a two-step health check:
 ## Python Health Check
i). It verifies if python3 is installed in the current environment .
ii). It performs a final check to confirm that:
- The main script exists in the root.
- The /Helpers directory is present.
- The /reports directory is present
