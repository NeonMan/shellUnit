#Check if the PID is active
#
# Params:
#    $1 <-- a process PID
assertPidRunning () {
	if ps -F --no-headers --pid "$1"
	then
		pass
	else
		fail
	fi
}

#Check if the PID is dead
#
# Params:
#    $1 <-- a process PID
assertPidNotRunning () {
	if ps -F --no-headers --pid "$1"
	then
		fail
	else
		pass
	fi
}

#Check if a command is currently running
#
# Params:
#    $1 <-- A command-line command ;)
assertCommandRunning () {
	SHU_FOUND_CMD=`ps -f --no-headers -C "$1" | awk '{$1=$2=$3=$4=$5=$6=$7=""; print $0}' | cut -d\  -f8-`
	if [ "$SHU_FOUND_CMD" = "$1" ]
	then
		pass
	else
		fail
	fi
}

#Check if a command is currently NOT running
#
# Params:
#    $1 <-- A command-line command ;)
assertCommandNotRunning () {
	SHU_FOUND_CMD=`ps -f --no-headers -C "$1" | awk '{$1=$2=$3=$4=$5=$6=$7=""; print $0}' | cut -d\  -f8-`
	if [ "$SHU_FOUND_CMD" = "$1" ]
	then
		fail
	else
		pass
	fi
}

