#!/bin/bash
NS=$( cat /etc/xray/dns )
PUB=$( cat /etc/slowdns/server.pub )
domain=$(cat /etc/xray/domain)
#color
grenbo="\e[92;1m"
NC='\e[0m'
#izin 
data_ip="https://raw.githubusercontent.com/freetunnel/izin/main/ip"
checking_sc() {
  useexp=$(wget -qO- $data_ip | grep $ipsaya | awk '{print $3}')
  if [[ $date_list < $useexp ]]; then
    echo -ne
  else
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    echo -e "\033[42m          404 NOT FOUND AUTOSCRIPT          \033[0m"
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    echo -e ""
    echo -e "            ${RED}PERMISSION DENIED !${NC}"
    echo -e "   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}"
    echo -e "     \033[0;33mBuy access permissions for scripts${NC}"
    echo -e "             \033[0;33mContact Admin :${NC}"
    echo -e "      \033[0;36mTelegram${NC} t.me/freetunnelproject"
    echo -e "      ${GREEN}WhatsApp${NC} wa.me/6281927625651"
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    exit
  fi
}
checking_sc
#install
apt update && apt upgrade
apt install python3 python3-pip git
cd /usr/bin
wget https://raw.githubusercontent.com/freetunnel/ftp/main/limit/bot.zip
unzip bot.zip
mv bot/* /usr/bin
chmod +x /usr/bin/*
clear
wget https://raw.githubusercontent.com/freetunnel/ftp/main/limit/kyt.zip
unzip kyt.zip
pip3 install -r kyt/requirements.txt

#isi data
echo ""
echo -e "\033[1;36m════════════════════════════════════\033[0m"
echo -e " \e[1;97;101m          ADD BOT PANEL          \e[0m"
echo -e "\033[1;36m════════════════════════════════════\033[0m"
echo -e "${grenbo}Tutorial Create Bot and ID Telegram${NC}"
echo -e "${grenbo}[*] Create Bot and Token Bot : @BotFather${NC}"
echo -e "${grenbo}[*] Info Id Telegram : @MissRose_bot , perintah /info${NC}"
echo -e "\033[1;36m════════════════════════════════════\033[0m"
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /usr/bin/kyt/var.txt
echo -e ADMIN='"'$admin'"' >> /usr/bin/kyt/var.txt
echo -e DOMAIN='"'$domain'"' >> /usr/bin/kyt/var.txt
echo -e PUB='"'$PUB'"' >> /usr/bin/kyt/var.txt
echo -e HOST='"'$NS'"' >> /usr/bin/kyt/var.txt
clear

cat > /etc/systemd/system/kyt.service << END
[Unit]
Description=Simple kyt - @kyt
After=network.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 -m kyt
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl start kyt 
systemctl enable kyt
systemctl restart kyt
cd /root
echo "Done"
echo "Your Data Bot"
echo -e "==============================="
echo "Token Bot      : $bottoken"
echo "Admin          : $admin"
echo "Domain         : $domain"
echo "Pub            : $PUB"
echo "Host           : $NS"
echo -e "==============================="
echo "Setting done"
clear

echo " Installations complete, type /menu on your bot"
rm -rf kyt.sh
rm -rf bot.zip