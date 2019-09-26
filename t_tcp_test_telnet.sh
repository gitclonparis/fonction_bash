f_Check_telnet()
{
	if bash -c "</dev/tcp/${1}/${2}" 2>/dev/null
  then echo "Connected"
  else echo "no connection"
  fi
}
f_Check_telnet $1 $2
