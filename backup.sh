#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
targetDirectory=$1
destinationDirectory=$2

# [TASK 2]
echo "Target Directory: $targetDirectory"
echo "Destination Directory: $destinationDirectory"

# [TASK 3]
currentTS=$(date +%s)


# [TASK 4]
backupFileName="backup-${currentTS}.tar.gz"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=$(pwd)

# [TASK 6]
cd "$destinationDirectory"
destDirAbsPath=$(pwd)

# [TASK 7]
cd "$origAbsPath"
cd "$targetDirectory"

# [TASK 8]
yesterdayTS=$(($currentTS - 24 * 60 * 60))

declare -a toBackup

for file in * # [TASK 9]
do
  # [TASK 10]
  if (($(date -r "$file" +%s) -gt $yesterdayTS))
  then
    # [TASK 11]
    toBackup+=($file)
  fi
done

# [TASK 12]
tar -czvf "$backupFileName" "${toBackup[@]}"

# [TASK 13]
mv "$backupFileName" "$destDirAbsPath"



#   ls -l backup.sh 
#     2  chmod u+x backup.sh 
#     3  ls -l backup.sh 
#     4  wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/Final%20Project/important-documents.zip
#     5  unzip -DDo important-documents.zip
#     6  touch important-documents/*
#     7  ./backup.sh important-documents .
#     8  ls -l
#     9  sudo service cron start
#    10  sudo service cron stop


# To run your backup.sh script, you'll need to follow these steps:

# 1. Make sure the script is executable
# First, ensure the script has execute permissions. If you haven’t already, you can use the following command to make it executable:
# chmod +x backup.sh
# 2. Run the script
# Now, you can run the script by providing the source directory (the target directory to back up files from) and the destination directory (where the backup file will be moved to).

# The basic syntax for running the script is:
# ./backup.sh /path/to/source/directory /path/to/destination/directory
# Example:
# Assuming you want to back up files from /home/user/documents to /home/user/backups, you would run:
# ./backup.sh /home/user/documents /home/user/backups
# 3. Automating with cron (optional)
# If you want the script to run automatically every day (as per your original task), you can set up a cron job.

# To do that:

# Open the crontab configuration by typing:
# crontab -e
# Add a line to run the script daily. For example, to run it at 1 AM every day:
# 0 1 * * * /path/to/backup.sh /path/to/source/directory /path/to/destination/directory
# This will automatically execute the script every day at 1 AM.