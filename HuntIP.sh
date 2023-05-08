#!/bin/bash

#Table Color
ColorGreen="\e[0;32m\033[1m"
EndColor="\033[0m\e[0m"
ColorRed="\e[0;31m\033[1m"
ColorBlue="\e[0;34m\033[1m"
ColorYellow="\e[0;33m\033[1m"
ColorPurpure="\e[0;35m\033[1m"
ColorTurquesa="\e[0;36m\033[1m"
ColorGray="\e[0;37m\033[1m"

# Ctrl+C 
function ctrl_c (){
  echo -e "\n\n$ColorRed[!]$EndColor $ColorGray Saliendo...$EndColor\n"
  exit 1
}
trap ctrl_c INT

# Variables globales
main_url="https://geo.ipify.org/api/v2/country,city,vpn?apiKey=at_FsEGNBg5lFKnMahp6YcSxeY4nVVIu&ipAddress="
ip_address=$2

# WelCome
function WelCome(){
  echo -e "[!] Bienvenido"
}

# helpPanel
function helpPanel(){

  echo -e " $ColorPurpure
 _   _             _  ___________            
| | | |           | ||_   _| ___ \           
| |_| |_   _ _ __ | |_ | | | |_/ / __  _   _ 
|  _  | | | | '_ \| __|| | |  __/ '_ \| | | |
| | | | |_| | | | | |__| |_| |_ | |_) | |_| |
\_| |_/\__,_|_| |_|\__\___/\_(_)| .__/ \__, |
                                | |     __/ |
                                |_|    |___/ 

$EndColor"

  echo -e "\n$ColorPurpure[*]$EndColor$ColorGray ./HuntIP.sh -h $EndColor$ColorRed[!]$EndColor$ColorGray Ver panel de ayuda$EndColor\n"
  echo -e "$ColorPurpure[*]$EndColor$ColorGray ./HuntIP.sh -i 8.8.8.8$EndColor$ColorRed [!]$EndColor$ColorGray IPv4$EndColor\n"
  echo -e "$ColorPurpure[*]$EndColo$ColorGray ./HuntIP.sh -i 2001:4860:4860::8888 $EndColor$ColorRed[!]$EndColor$ColorGray IPv6$EndColor \n"
}

# getIpaddr
function getIpaddr(){

    getInfo="$(curl -s -X GET $main_url$ip_address | grep -oP '".*?":".*?"' | tr -d '"{}' | sed 's/:/ -> /1' | sed 's/\\\//:/g' | sed 's/,/ - /g' | sed 'G' | awk '{print "\033[0;34m" $1 "\033[0m" "\033[1m" substr($0,length($1)+1)}')" 

    echo -e "$ColorPurpure[+]$EndColor $ColorGray La informacion de su direccion ip es la siguiente:\n\n$EndColor$getInfo"
    
} 

# Indicadores
declare -i parameter_counter=0

while getopts "hi:" arg; do 
  case $arg in
    i) getopts="$OPTARG"; let parameter_counter+=1;;
    h) ;;
  esac
done

if [ $parameter_counter -eq 1 ]; then
  getIpaddr $ip_address
else
 helpPanel
fi
