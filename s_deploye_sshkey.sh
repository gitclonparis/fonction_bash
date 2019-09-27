#!/bin/bash
for server in `cat server.txt`;  
do  
    sshpass -p "toto" ssh-copy-id -i ~/.ssh/id_rsa.pub toto@$server  
done
