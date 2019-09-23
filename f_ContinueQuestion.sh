f_ContinueQuestion()
{
  read ANSWER
  if [ "${ANSWER}" != "y" ];then
    if [ "${ANSWER}" != "Y" ];then
      echo -e "\\n\\t${ROUGE}FIN DU SCRIPT${NORMAL}\\n"
      exit 2
    fi
  fi
  echo
}
