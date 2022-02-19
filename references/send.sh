half_life_folder="/home/jack/Steam/steamapps/common/Half-Life"

half_life_pid_tail_file_name=hlds_logs_tail_pid.txt
half_life_pid_tail="$(cat $half_life_folder/$half_life_pid_tail_file_name)"

if ps -p $half_life_pid_tail > /dev/null
then
    echo "$half_life_pid_tail is running"
else   
    echo "Starting the tailing..."
    tail -2f $half_life_folder/my_logs.txt &
    echo $! > $half_life_folder/$half_life_pid_tail_file_name
fi

echo "$@" > /tmp/srv-input
sleep 1

exit 0