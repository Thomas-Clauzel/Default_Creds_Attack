#!/bin/bash
# title : def_cred_WN3000RP.sh
# author : tclauzel
# description : trying default credentials on WN3000RP NETGEAR ROUTER
#########################
echo $1 is the IP of the router
CurlReturn=$(curl --max-time 5 "http://$1/start.htm" -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://192.168.1.200/' -H 'DNT: 1' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' -H 'Authorization: Basic YWRtaW46cGFzc3dvcmQ='  > /tmp/defaultpass.txt 2>&1)
string="401"
timeout="timed out"
echo "Trying to connect with admin:password"
if grep -qF "$string" /tmp/defaultpass.txt;then
  echo "ERROR 401"
elif grep -qF "$timeout" /tmp/defaultpass.txt;then
  echo "ERROR 408"
else
  echo "ALERT ! Default password is working on this router ! "
  echo "password is admin:password"
fi
rm /tmp/defaultpass.txt > /dev/null 2>&1
