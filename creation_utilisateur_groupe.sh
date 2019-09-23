#########################################################################
	#          Fonction de creation d'un utilisateur et d'un groupe         #
	#########################################################################
	create_user_and_group() {
		Util=$1
		Uid=$2
		Group=$3
		Gid=$4
		Home=$5
		FicInsTrace=$6

		log "Creation of group ${Group} and user ${Util}" 

		# Product group creation if does not exist
		if [ -z "`grep ^${Group}: /etc/group`" ]; then
			if [ -z "`cat /etc/group | cut -d: -f3 | grep \^${Gid}$`" ]; then
				log "                         --> groupadd -g ${Gid} ${Group}" 
				groupadd -g ${Gid} ${Group}
				if [ $? -ne 0 ]; then
					log "Group ${Group} already exists with GID different than ${Gid}." 
					exit 1
				fi
			fi
		else
			RefId=`cat /etc/group | grep \^"${Group}:"| cut -d":" -f3`
			if [ "${RefId}" = "${Gid}" ]; then
				log "Group ${Group} already exists with" 
				log "`grep \^${Group}: /etc/group`" 
			fi
		fi

		# Users Product creation , if not exists
		if [ -z "`grep ^${Util}: /etc/passwd`" ]; then
			if [ -z "`cat /etc/passwd | cut -d: -f3 | grep \^${Uid}$`" ]; then
				useradd -g ${Group} -u ${Uid} ${Util} -d ${Home} -s /bin/bash >> $LOG_FILE 2>&1
				if [ $? -ne 0 ]; then
				log "It's impossible to create user ${Util} with ${Uid} UID "
				exit 1
				fi
			else
			log "It's impossible to create user ${Util}, ${Uid} UID already in use" 
				exit 1
			fi
		else
			RefId=`cat /etc/passwd | grep \^"${Util}:"| cut -d":" -f3`
			if [ "${RefId}" = "${Uid}" ]; then
				log "${Util} user already exists with"
				log "`grep \^${Util}: /etc/passwd`" 
			else
				log "${Util} user already exists with a different UID than ${Uid}." 
				exit 1
			fi
		fi
	}
}
# create_user_and_group %{NagiosUser} %{NagiosUserUID} %{NagiosUser} %{NagiosUserGID} $MOUNT_DIR
