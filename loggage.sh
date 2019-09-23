loggage()
{
  TYPE="${1}"
  MESSAGE="${2}"
  echo "$(date "+%d/%m/%Y %H:%M:%S") - $TYPE - $MESSAGE"
}
