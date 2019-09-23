f_Check()
{
  if [ $? = 0 ];then
    echo -e "${VERT}[ SUCCESS ]${NORMAL}\\n"
  else
    if [[ "${1}" = "exit_script" ]];then
      echo -e "${ROUGE}[ FAILED ] - ARRET DU SCRIPT${NORMAL}\\n"
      exit 2
    else
      echo -e "${ROUGE}[ FAILED ]${NORMAL}\\n"
    fi
  fi
}
