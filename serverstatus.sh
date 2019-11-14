#!/bin/bash
server_conf="/root/ServerStatus/server/config.json"
 
set_config(){
read -p "Please enter username:" username_s
[[ -z $username_s ]] && echo "username is needed" && exit 1
grep username ${server_conf} | sed s/[[:space:]]//g | cut -d ":" -f 2 | tr -d '["][,]' | while read line ; do 
[[ "$line" = "$username_s" ]]  && echo "Username has been used" && exit 89
done
[[ $? -eq 89 ]] && exit 1
read -p "Please enter password (default is zorz.cc):" password_s
password_s=${password_s:-zorz.cc} 
read -p "Please enter location (default is us):" location_s
location_s=${location_s:-us} 
read -p "Please enter type (default is kvm):" type_s
type_s=${type_s:-kvm} 
read -p "Please enter name:" name_s
[[ -z $name_s ]] && echo "name is needed" && exit 1
}
 
Add_ServerStatus_server(){
	sed -i '3i\  },' ${server_conf}
	sed -i '3i\   "disabled": false' ${server_conf}
	sed -i '3i\   "location": "'"${location_s}"'",' ${server_conf}
	sed -i '3i\   "host": "'"None"'",' ${server_conf}
	sed -i '3i\   "type": "'"${type_s}"'",' ${server_conf}
	sed -i '3i\   "name": "'"${name_s}"'",' ${server_conf}
	sed -i '3i\   "password": "'"${password_s}"'",' ${server_conf}
	sed -i '3i\   "username": "'"${username_s}"'",' ${server_conf}
	sed -i '3i\  {' ${server_conf}
	echo  "done"
}
set_config
Add_ServerStatus_server
