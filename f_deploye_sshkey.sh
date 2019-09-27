f_deploye_sshkey()
{
	for server in `cat ${1}`;
	do
		sshpass -p ${2} ssh-copy-id -i ~/.ssh/id_rsa.pub $server
	done
}
f_deploye_sshkey $1 $2
