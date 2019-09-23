log()
{
echo -e $1 >> $LOG_FILE
}

#log ""
#log "#---------------------------------------------------------------------------------------#" 
#log "#------------------- INSTALLATION OF NAGIOS AGENT %{version} (`date +'%d%m%y'`) -----------------------#" 
#log "#---------------------------------------------------------------------------------------#" 
#log "\n#----------------------------------------------------#" 
#log "  Installation %{name}-%{version}, `date +'%d/%m/%y'`\n" 
#log " " 

# log "move  %{InstallParamFileTmp} to %{InstallParamFile}"
# log " Creation of logical volume $InstallLV :   [ ECHEC ]"
# log " Creation of logical volume $InstallLV  :   [ OK ]"

msg_and_log() 
{ 
	echo -e $1 | tee -a $LOG_FILE
}
# msg_and_log " Installing process (see $LOG_FILE for details)......"
# msg_and_log " Installing process (see $LOG_FILE for details)......"

loggage()
{
  TYPE="${1}"
  MESSAGE="${2}"
  echo "$(date "+%d/%m/%Y %H:%M:%S") - $TYPE - $MESSAGE"
}
# Ex: loggage "INFO" "Le fichier FILE_INPUT : ${FILE_INPUT} comporte ${NB_LIGNES_INPUT} lignes."
# Ex: loggage "WARNING" "N'oubliez pas de les traiter!!!"
