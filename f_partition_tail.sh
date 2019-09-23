#########################################################################
	#      Fonction de verification de place disque d'un filesystem         #
	#########################################################################
	partition_tail() {
		FILESYSTEM=$1
		SIZE=$2

		if [ ! -d $FILESYSTEM ]; then mkdir -p $FILESYSTEM;	fi
		if [ `df -Pm $FILESYSTEM | tail -1 | awk '{ print $4 }'` -lt $SIZE  ]; then
			log "Not enought disk space on $FILESYSTEM (the Installation program require "$SIZE"M)."
			exit 1;
		fi
	}
