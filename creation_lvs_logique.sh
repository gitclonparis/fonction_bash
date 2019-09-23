#########################################################################
	#               Fonction de creation de volume logique                  #
	#########################################################################
	lv_create() {
		NAME=$1
		SIZE=$2
		MOUNT=$3
		VG=$4
		
		# Installation sur cible US
		export LANG=en_US.UTF-8

		# Test si le VG existe
		if [ `vgdisplay 2> /dev/null | grep -i "VG Name" | awk '{print $3}' | grep -i "^$VG$" | wc -l` -eq 0 ]; then
			msg_and_log " "
			msg_and_log " Volume group $VG do not exist"
			msg_and_log " It is not possible to create a logical volume : $NAME"
			msg_and_log " Installation could not continue"
			msg_and_log " "
			exit 1
		fi

		# Creation du volume logique ou d'un repertoire selon le cas PLATON/NOPLATON
		if [ `lvscan 2> /dev/null | grep -i "$NAME" | wc -l` -eq 0 ]; then
			free=`vgdisplay "$VG" 2> /dev/null | grep -i free | awk '{ print $7 }' | cut -d. -f1`
			unit=`vgdisplay "$VG" 2> /dev/null | grep -i free | awk '{ print $8 }'`
			case $unit in
				TB|TiB)
				   coefficient=1048576
				   ;;
				GB|GiB)
				   coefficient=1024
				   ;;
				MB|MiB)
				   coefficient=1
				   ;;
				 *)
				   coefficient=1
				   ;;
			esac
			free=`expr $free \* $coefficient`

			if [ $free  -lt $SIZE ]; then
				log "Not enought disk space on $VG (the Installation program require "$SIZE"M)."
				exit 1
			fi
			OUT=`lvcreate -n "$NAME" -L "$SIZE"M "$VG" 2>&1`
			if [ $? -ne 0 ]; then
				log "Can't create volume group"
				log $OUT
				return 1
			fi
			mkfs.ext3 /dev/"$VG"/"$NAME"
			echo -e "/dev/$VG/$NAME\t$MOUNT\text3\tdefaults,nodev\t1 2" >> /etc/fstab
			if [ ! -d $MOUNT ]; then
				mkdir -p $MOUNT
				chown -R %{NagiosUser}:%{NagiosUser} $MOUNT
			fi
			# mount /dev/"$VG"/"$NAME" $MOUNT
			mount $MOUNT
			chown -R %{NagiosUser}:%{NagiosUser} $MOUNT
		else	
			log "Cannot create volume logic $NAME because already created." 
			return 0
		fi
		return 0
	}
# lv_create $LV %{LVSize} $MOUNT_DIR $VG >/dev/null 2>&1 
