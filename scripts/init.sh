#!/bin/sh
echo "---------------------------------"
echo "Running startup script."
task_list='prep_scripts '
tasks=$(echo "$task_list" | wc -w)
completed=0


function prep_scripts (){

    echo "Granting execute perms for all scripts in folder."

    for script in ./scripts/*; do chmod +x $script; done;
    
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

