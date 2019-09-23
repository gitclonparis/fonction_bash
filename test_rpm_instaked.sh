SYSMON=`rpm -qa SysMon |wc -l`
if [ $SYSMON -eq 0 ]; then
	msg_and_log "WARN: SysMon pakage is not installed."
	rpm -ihv package.rpm
else
	msg_and_log "WARN: SysMon pakage is installed."
fi
