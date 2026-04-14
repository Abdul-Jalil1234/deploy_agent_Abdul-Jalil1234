#!/usr/bin/env bash
set -e # This will prompt the script to stop whenever a problem is encountered
stop_and_bundle_archive(){
echo -e "\n The script is been terminated "
if [ -d "$parent_dir" ]; then
echo -e "\n Creating archive"	
tar -cvf "${parent_dir}_archive" "$parent_dir"
rm -rf "$parent_dir"
echo -e "The directory was successfully cleaned up \n Workspace archived as ${parent_dir}_archive"
fi
exit 1
}
# The function stop_and_bundle_archive will be invoked whenever a SIGINT signal is received
trap stop_and_bundle_archive SIGINT
# Prompting the user to enter a name which will be used to form part of the parent directory that will be created later
read -p "Enter a name for the directory to be created :
" user_input
mkdir attendance_tracker_"$user_input"
parent_dir=attendance_tracker_"$user_input"
cp attendance_checker.py $parent_dir/
mkdir -p $parent_dir/Helpers
cp {assets.csv,config.json} $parent_dir/Helpers/
mkdir -p $parent_dir/reports
cp reports.log $parent_dir/reports/
# Prompting user if he/she want to change the default values for the thresholds in the config.json file
read -p "Do you want to update the thresholds ? [Y/N]
" response
if [[ "$response" =~ ^[Yy]$ ]]; then 
read -p "Enter Warning threshold :(Default 75)
" warning_value
read -p "Enter Failure threshold :(Default 50)
" fail_value
# Using the sed command with the -i flag to directly make changes in the config.json file
    sed -i "s/\(\"warning\":\)[[:space:]]*[0-9]*/\1 ${warning_value:-75}/" "$parent_dir/Helpers/config.json"
    sed -i "s/\(\"failure\":\)[[:space:]]*[0-9]*/\1 ${fail_value:-50}/" "$parent_dir/Helpers/config.json"
fi
echo "Running a background health check"
echo "searching for python on your environment"
if python3 --version &>/dev/null; then
echo "Success!! $(python3 --version) is installed"
else 
echo "Missing !! .python is missing .Please install"
fi
# validating correct project directory setup
if [ -f "$parent_dir/attendance_checker.py" ] && [ -d "$parent_dir/Helpers" ] && [ -d "$parent_dir/reports" ]; then
echo -e "SUCCESS !! \n Project directory structure successfully created"
else
echo -e "FAIL !! \n Project directory structure is errotic"
fi


















