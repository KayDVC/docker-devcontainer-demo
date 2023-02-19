#!/bin/sh
task_list='grant_ownership prep_scripts '
tasks=$(echo "$task_list" | wc -w)
completed=0

echo "---------------------------------"
echo "Logged in as: $(whoami)"
echo "Running startup script; Remaining Tasks: ${tasks}"

function grant_ownership() {
    echo "Changing directory ownership from root to NRuser"
    
    sudo chown -R NRuser /home/NRuser

    completed=$((completed+1))
    display_progress
}

function prep_scripts (){

    echo "Granting execute perms for all scripts in folder."

    for script in ./scripts/*; do echo "Modifying $script " && chmod +x $script; done;
    
    completed=$((completed+1))
    display_progress
}

function display_progress() {
    echo "Tasks completed => ${completed} / ${tasks}"
}

# Run all tasks
for t in $task_list; do $t; done

echo "---------------------------------"
echo "Startup script completed."
