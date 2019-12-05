#!/bin/bash
client_file="/root/client-linux.py"
read -p "Please enter same username with server:" username_c
[[ -z $username_c ]] && echo "same username is needed" && exit 1
read -p "Please enter same password with server (default is zorz.cc):" password_c
password_c=${password_c:-zorz.cc} 
read -p "Please enter server address (domain or ip) :" server_address
[[ -z $server_address ]] && echo "server address is needed" && exit 1
wget --no-check-certificate https://raw.githubusercontent.com/cppla/ServerStatus/master/clients/client-linux.py -O /root/client-linux.py
[[ -z $(which python) ]] && apt-get update && apt-get install python -y
sed -i 's/'"127.0.0.1"/"${server_address}"'/' ${client_file}
sed -i 's/USER = "s01"/USER = "'"${username_c}"'"/' ${client_file}
sed -i 's/USER_DEFAULT_PASSWORD/'${password_c}'/' ${client_file}
echo '[Unit]
Description=serverstatus
After=network.target
     
[Service]
ExecStart=/usr/bin/python /root/client-linux.py
Restart=always
    
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/cstatus.service
systemctl start cstatus && systemctl enable cstatus
echo done
