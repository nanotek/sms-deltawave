#!/bin/bash
#
# registering globals
monitor_dir="/var/spool/gammu/inbox"
user_list_file="sms-deltawave.list"
broadcast_key="SECRET"
user_list=`cat $user_list_file`
message_file="/var/spool/gammu/temp_file"

# gammu smsd should be runing lets chek that first

# lets see if any new messages in inbox
echo "reading messages"
FILES=`grep -l $broadcast_key $monitor_dir/IN*`

for FILE in $FILES
	do 
	sed s/$broadcast_key//g $FILE > $message_file
	for deltawave in $user_list
		do
		echo "sending to $deltawave"
		cat $message_file | gammu-smsd-inject TEXT $deltawave
		done
	done

echo "exiting"
	


