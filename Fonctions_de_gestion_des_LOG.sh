log()
{
echo -e $1 >> $LOG_FILE
}
	
msg_and_log() 
{ 
	echo -e $1 | tee -a $LOG_FILE
}
  
loggage()
{
  TYPE="${1}"
  MESSAGE="${2}"
  echo "$(date "+%d/%m/%Y %H:%M:%S") - $TYPE - $MESSAGE"
}
# Ex: loggage "INFO" "Le fichier FILE_INPUT : ${FILE_INPUT} comporte ${NB_LIGNES_INPUT} lignes."
# Ex: loggage "WARNING" "N'oubliez pas de les traiter!!!"
