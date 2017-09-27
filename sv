#!/bin/bash
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;

 red='\e[1;31m'
               green='\e[0;32m'
               NC='\e[0m'

               echo "Connecting to autoscriptnobita.tk..."
			   sleep 1

			   echo "Connecting to your ip : $myip ...."
               sleep 2
               
			   echo "Checking Permision..."
               sleep 1.5
               
			   echo -e "${green}Permission Accepted...${NC}"
               sleep 1

function create_user() {
	useradd -M $uname
	echo "$uname:$pass" | chpasswd
	usermod -e $expdate $uname

	myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
	myip2="s/xxxxxxxxx/$myip/g";	
	wget -qO /tmp/client.ovpn "https://autoscriptnobita.tk/MASTER7752/1194-client.ovpn"
	sed -i 's/remote xxxxxxxxx 1194/remote xxxxxxxxx 443/g' /tmp/client.ovpn
	sed -i $myip2 /tmp/client.ovpn
	echo ""
	echo "========================="
	echo "Host IP : $myip"
	echo "Port    : 443/22/80"
	echo "Squid   : 8080/3128"
	echo "========================="
	echo "Script by autoscriptnobita.tk , gunakan akaun dengan bijak"
	echo "========================="
}

function renew_user() {
	echo "New expiration date for $uname: $expdate...";
	usermod -e $expdate $uname
}

function delete_user(){
	userdel $uname
}

function expired_users(){
	cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
	totalaccounts=`cat /tmp/expirelist.txt | wc -l`
	for((i=1; i<=$totalaccounts; i++ )); do
		tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
		username=`echo $tuserval | cut -f1 -d:`
		userexp=`echo $tuserval | cut -f2 -d:`
		userexpireinseconds=$(( $userexp * 86400 ))
		todaystime=`date +%s`
		if [ $userexpireinseconds -lt $todaystime ] ; then
			echo $username
		fi
	done
	rm /tmp/expirelist.txt
}

function not_expired_users(){
    cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
    totalaccounts=`cat /tmp/expirelist.txt | wc -l`
    for((i=1; i<=$totalaccounts; i++ )); do
        tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
        username=`echo $tuserval | cut -f1 -d:`
        userexp=`echo $tuserval | cut -f2 -d:`
        userexpireinseconds=$(( $userexp * 86400 ))
        todaystime=`date +%s`
        if [ $userexpireinseconds -gt $todaystime ] ; then
            echo $username
        fi
    done
	rm /tmp/expirelist.txt
}

function used_data(){
	myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`
	myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`
	ifconfig $myint | grep "RX bytes" | sed -e 's/ *RX [a-z:0-9]*/Received: /g' | sed -e 's/TX [a-z:0-9]*/\nTransfered: /g'
}

	clear
	echo "--------------- Selamat datang Admin Di IP: $myip ---------------"
	cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
	cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
	freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
	tram=$( free -m | awk 'NR==2 {print $2}' )
	swap=$( free -m | awk 'NR==4 {print $2}' )
	up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')

		clear
echo -e "\e[031;1m#******************************************************************"
echo -e "\e[031;1m# Program: Autoscript By @OrangKuatSabahanTerkini"
echo -e "\e[031;1m# Website: mastavps.tk"            
echo -e "\e[031;1m# Developer: KeningauGroup"
echo -e "\e[031;1m# Nickname: @OrangKuatSabahanTerkini"                                  
echo -e "\e[031;1m# TeLegram @OrangKuatSabahanTerkini"
echo -e "\e[031;1m# ChanneL @Premium Servis"
echo -e "\e[031;1m# Date builder: 23.8.2017"
echo -e "\e[031;;1m# Last ChecKer: 26.8.2017"                                        
echo -e "\e[031;1m# ******************************************************************"
	echo " Now You Can Start Using Script By @OrangKuatSabahanTerkini!"
    echo "----------------------------------------------------"
	echo -e "\e[034;1m 1\e[0m)" "\e[032;1madd user/OpenVPN\e[0m" "\e[033;1mCreate New User\e[0m"
	echo -e "\e[034;1m 2\e[0m)" "\e[032;1mGenerate Account SSH/OpenVPN\e[0m" "\e[033;1mGenerate akun SSH/OpenVPN\e[0m"
	echo -e "\e[034;1m 3\e[0m)" "\e[032;1mGenerate Account Trial\e[0m" "\e[033;1mTrial\e[0m"
	echo -e "\e[034;1m 4\e[0m)" "\e[032;1mChange Password SSH/VPN\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m 5\e[0m)" "\e[032;1mRenew User Expired SSH/OpenVPN\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m 6\e[0m)" "\e[032;1mDeleTe Account SSH/OpenVPN\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m 7\e[0m)" "\e[032;1mCheck Login Dropbear & OpenSSH\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m 8\e[0m)" "\e[032;1mAuto Limit Multi Login\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m 9\e[0m)" "\e[032;1mdetail user SSH & OpenVPN\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m10\e[0m)" "\e[032;1madd account and Expire Date\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m11\e[0m)" "\e[032;1mDelete Account Expire\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m12\e[0m)" "\e[032;1mDisable Account Expire\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
    echo -e "\e[034;1m13\e[0m)" "\e[032;1mkill Multi Login\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m14\e[0m)" "\e[032;1mblock Account User SSH & OpenVPN\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m15\e[0m)" "\e[032;1mUnblock Account User SSH & OpenVPN\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m16\e[0m)" "\e[032;1mCheck User Kick Autolimit\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m17\e[0m)" "\e[032;1mCheck User Has Banned\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m18\e[0m)" "\e[032;1mAdd USER PPTP\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m19\e[0m)" "\e[032;1mDelete USER PPTP VPN\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m20\e[0m)" "\e[032;1mCheck Detail User PPTP VPN\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m21\e[0m)" "\e[032;1mlogin PPTP VPN\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m22\e[0m)" "\e[032;1mLihat Daftar User PPTP VPN\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m23\e[0m)" "\e[032;1mSet Auto Reboot \e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m24\e[0m)" "\e[032;1mSpeedtest\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m25\e[0m)" "\e[032;1mMemory Usage\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m26\e[0m)" "\e[032;1mChange OpenVPN Port\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m27\e[0m)" "\e[032;1mChange Dropbear Port\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m28\e[0m)" "\e[032;1mChange Squid Port\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m29\\e[0m)" "\e[032;1mRestart OpenVPN\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m30\e[0m)" "\e[032;1mRestart Dropbear\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m31\e[0m)" "\e[032;1mRestart Squid\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m32\e[0m)" "\e[032;1mRestart Webmin\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m33\e[0m)" "\e[032;1mBenchmark\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m34\e[0m)" "\e[032;1mChange Pasword VPS\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m35\e[0m)" "\e[032;1mChange Hostname VPS\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[034;1m36\e[0m)" "\e[032;1mReboot Server\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
   echo -e "\e[034;1m37\e[0m)" "\e[032;1mCheck User DDos\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
    echo -e "\e[034;1m38\e[0m)" "\e[032;1mRestart All Service\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
    echo -e "\e[034;1m39\e[0m)" "\e[032;1mAttack DDOs\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[031;1m BYE\e[0m)" "\e[031;1m exit\e[0m" "\e[033;1mAutoscript By @OrangKuatSabahanTerkini\e[0m"
	echo -e "\e[132;1m=====================================================\e[0m"                                                                                                                    
            echo -e "\e[031;1m╔══╦═╦═╦══╦═╦═╦╦╦╗\e[0m"
            echo -e "\e[031;1m║║║║║║║╠╗╔╣║║║║║║║\e[0m"
            echo -e "\e[031;1m║║║║╦║║║║║║╦║╔╬╬╬╣\e[0m"
            echo -e "\e[031;1m╚╩╩╩╩╩╩╝╚╝╚╩╩╝╚╩╩╝\e[0m"
    echo -e "\e[132;1mAutoScript By @OrangKuatSabahanTerkini\e[0m"
    echo -e "\e[132;1m======================================================\e[0m"	
        1)  
            clear
            buatakun
            ;;
        2)  
            clear
            generate
            ;;
        3)	
            clear
            trial
			;;	
        4)
            clear
            userpass
            ;;
        5)
            clear
            userrenew
			;;
        6)
            userdelete
            ;;		
		7)
		    clear
	        userlogin
			;;
		8)
		    clear
			autolimit
			;;	
		9)
		    clear
            userdetail
            ;;
		10)
		    clear
            user-list
            ;;
        11)
               clear
               deleteuserexpire
	          ;;
	    12)
	          clear
	          #!/bin/bash
              # Created by autoscriptnobita.tk
              
              red='\e[1;31m'
              green='\e[0;32m'
              NC='\e[0m'
              echo "Connecting to autoscriptnobita.tk..."
              sleep 0.2
			  echo "Connecting to your ip : $myip ...."
              sleep 2
              echo "Checking Permision..."
              sleep 0.3
              echo -e "${green}Permission Accepted...${NC}"
              sleep 1
               echo""
	           echo "    AUTO KILL MULTI LOGIN    "    
	           echo "-----------------------------"
               autokilluser
               echo "-----------------------------"
               echo "AUTO KILL MULTI LOGIN SELESAI"
               ;;
        13)
               clear
               userban
	          ;;
	    14)
               clear
               userunban
	          ;;
	    15)
	        clear
            userlock
			;;
		16)
		    clear
            userunlock
			;;
		17)
		    clear
		    loglimit
			;;
		18)
		    clear
            logban
			;;
	    19)
	        clear
            useraddpptp
			;;
		20)
		    clear
            userdeletepptp
			;;
	    21)
	        clear
            detailpptp
            ;;
        22)
            clear
            userloginpptp
			;;
		23)
		    clear
            alluserpptp
			;;
	    24)
	         clear
             autoreboot
            ;;
	    25)
	         clear
	         #!/bin/bash
            red='\e[1;31m'
            green='\e[0;32m'
            blue='\e[1;34m'
            NC='\e[0m'
            echo "Connecting to autoscriptnobita.tk..."
            sleep 0.2
			echo "Connecting to your ip : $myip ...."
            sleep 2
            echo "Checking Permision..."
            sleep 0.3
            echo -e "${green}Permission Accepted...${NC}"
            sleep 1
            echo""
            echo "Speed Test Server"
            ./speedtest.py --share
            echo "Hasil Speed test diatas Script by autoscriptnobita.tk"
            ;;
        26)
            free -m
            ;;
		27)	
		    clear
            echo "Masukan Port OpenVPN yang diinginkan:"
            read -p "Port: " -e -i 1194 PORT
            sed -i "s/port [0-9]*/port $PORT/" /etc/openvpn/1194.conf
            service openvpn restart
            echo "OpenVPN Updated : Port $PORT"
			;;
		28)	
		    clear
            echo "Masukan Port Dropbear yang diinginkan:"
            read -p "Port: " -e -i 443 PORT
            sed -i "s/DROPBEAR_PORT=[0-9]*/DROPBEAR_PORT=$PORT/" /etc/default/dropbear
            service dropbear restart
            echo "Dropbear Updated : Port $PORT"
			;;
        29)	
            clear
            echo "Masukan Port Squid yang diinginkan:"
            read -p "Port: " -e -i 8080 PORT
            sed -i "s/http_port [0-9]*/http_port $PORT/" /etc/squid3/squid.conf
            service squid3 restart
            echo "echo "Squid3 Updated : Port $PORT""
			;;			
        30)	
            clear
            echo "Service Openvpn restart .................tunggu sebentar"
            service openvpn restart
            echo "Restart OpenVPN selesai Script By autoscriptnobita.tk"
			;;	
		31)
            clear
            echo "Servie dropbear restart .................tunggu sebentar"
            service dropbear restart
            echo "Restart Dropbear selesai Script By autoscriptnobita.tk"
            ;;
		32) 
		    clear
		    echo "Service Squid restart .................tunggu sebentar"
			service squid3 restart
			echo "Restart Squid selesai Script By autoscriptnobita.tk"
			;;
		33)
		    clear
		    /etc/init.d/webmin restart
		    echo "Restart Webmin selesai Script By autoscriptnobita.tk"
		    ;;
		34)
		    clear
            wget freevps.us/downloads/bench.sh -O - -o /dev/null|bash
           ;;
        35)
		    echo "Masukan Password VPS, yang mau diganti :"
		    passwd
			;;	
		36)
			echo "Masukan HOSTNAME VPS, yang mau diganti :"
            echo "  contoh : " hostname autoscriptnobita
            ;;
		37)
		    clear
			reboot
            ;;
        38)
            wget -O update http://autoscriptnobita.tk/MASTER7752/update && chmod +x update && ./update
			;;
        x)
            ;;
        *) menu;;
    esac
