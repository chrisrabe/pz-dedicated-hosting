#!/bin/sh

# Go to the game server application folder where the game application `hlds_run` is
cd /home/user/Half-Life

# Set up a pipe named `/tmp/srv-input`
rm /tmp/srv-input
mkfifo /tmp/srv-input

# To avoid your server to receive a EOF. At least one process must have
# the fifo opened in writing so your server does not receive a EOF.
cat > /tmp/srv-input &

# The PID of this command is saved in the /tmp/srv-input-cat-pid file
# for latter kill.
# 
# To send a EOF to your server, you need to kill the `cat > /tmp/srv-input` process
# which PID has been saved in the `/tmp/srv-input-cat-pid file`.
echo $! > /tmp/srv-input-cat-pid

# Start the server reading from the pipe named `/tmp/srv-input`
# And also output all its console to the file `/home/user/Half-Life/my_logs.txt`
#
# Replace the `./hlds_run -console -game czero +port 27015` by your application command
./hlds_run -console -game czero +port 27015 > my_logs.txt 2>&1 < /tmp/srv-input &

# Successful execution 
exit 0