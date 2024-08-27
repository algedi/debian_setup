#! /bin/bash

ssPrg=("git" "curl" "tmux" "htop" "gcc" "node" "npm" "nvim" "ranger")
ssPrgOn=()
ssPrgOff=()

declare -A jPrgVerPos
declare -A jPrgVerOpz
declare -A jPrgVer
declare -A jPrgSetup
declare -A jPrgApt

jPrgVerPos[git]='NR==1 {print $3}'
jPrgVerPos[curl]='NR==1 {print $2}'
jPrgVerPos[tmux]='NR==1 {print $2}'
jPrgVerPos[node]='NR==1 {print $1}'
jPrgVerPos[npm]='NR==1 {print $1}'
jPrgVerPos[gcc]='NR==1 {print $4}'
jPrgVerPos[nvim]='NR==1 {print $2}'
jPrgVerPos[htop]='NR==1 {print $2}'
jPrgVerPos[ranger]='NR==1 {print $4}'

jPrgVerOpz[git]='--version'
jPrgVerOpz[curl]='--version'
jPrgVerOpz[tmux]='-V'
jPrgVerOpz[node]='--version'
jPrgVerOpz[npm]='-v'
jPrgVerOpz[gcc]='--version'
jPrgVerOpz[nvim]='-v'
jPrgVerOpz[htop]='-V'
jPrgVerOpz[ranger]='--version'

jPrgApt[git]='git'
jPrgApt[curl]='curl'
jPrgApt[tmux]='tmux'
jPrgApt[gcc]='gcc'
jPrgApt[node]='nodejs'
jPrgApt[npm]='npm'
jPrgApt[htop]='htop'
jPrgApt[ranger]='ranger'

VerificaInstallati() # ///<
{
  ssPrgOn=()
  ssPrgOff=()
  for sPrg in "${ssPrg[@]}"; do
    if command -v $sPrg &>/dev/null; then
      ssPrgOn+=($sPrg)
    else
      ssPrgOff+=($sPrg)
    fi
  done
  # echo -e "VericaInstallati: \n ${ssPrgOn[@]} \n ${ssPrgOff[@]} "
  # sleep 3
} ///>
VerificaSetup() # ///<
{
  for sPrg in "${ssPrgOn[@]}"; do
    case $sPrg in
    git)
      sVer=$(git config --get-all alias.co)
      if [[ "$sVer" == "commit -a -m" ]]; then
        jPrgSetup[git]="kui.setup"
      fi
      ;;
    nvim)
      if [ -d "$HOME/.config/nvim" ]; then
        jPrgSetup[nvim]="kui.setup (lazyvim)"
      fi
      ;;
    esac
  done
  # echo -e "VericaInstallati: \n ${ssPrgOn[@]} \n ${ssPrgOff[@]} "
  # sleep 3
} ///>
CaricaVersioniInstallati() # ///<
{
  for sPrg in "${ssPrgOn[@]}"; do
    sOpz=${jPrgVerOpz[$sPrg]}
    sPos=${jPrgVerPos[$sPrg]}
    sVer="$sPrg $sOpz | awk '$sPos'"
    sOut=$(eval "$sVer")
    jPrgVer[$sPrg]=$sOut
  done
} ///>

Draw() # ///<
{
  VerificaInstallati
  VerificaSetup
  CaricaVersioniInstallati

  clear

  echo "==================================================="
  echo "       INSTALLATI         "
  echo "---------------------------------------------------"
  for sPrg in "${ssPrgOn[@]}"; do
    echo -e "$sPrg\t\t${jPrgVer[$sPrg]}\t\t${jPrgSetup[$sPrg]} "
  done

  echo "==================================================="
  echo "       DA INSTALLARE      "
  echo "---------------------------------------------------"
  for sPrg in "${ssPrgOff[@]}"; do
    echo -e "$sPrg"
  done
  echo "==================================================="
  echo
  echo

  # echo "================================================"
  # echo "       FOR DEBUG          "
  # echo "--------------------------"
  # echo "PRG:    ${ssPrg[@]}"
  # echo "PRGON:  ${ssPrgOn[@]}"
  # echo "PRGOFF: ${ssPrgOff[@]}"
  # echo "${jPrgVer[@]}"
  # echo "=========================="

  sleep 1

} ///>
InstallPrg() # ///<
{
  sPrg=$1
  if [[ "${!jPrgApt[@]}" =~ "$sPrg" ]]; then
    echo -e "apt install -y ${jPrgApt[$sPrg]}"
    apt install -y ${jPrgApt[$sPrg]}
    sleep 3
  else
    case $sPrg in
    nvim)
      sPath=$(pwd)
      cd /opt
      rm -r nvim-linux64
      rm /usr/bin/nvim
      curl -LO https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz
      tar xzvf nvim-linux64.tar.gz
      rm nvim-linux64.tar.gz
      ln -s /opt/nvim-linux64/bin/nvim /usr/bin/nvim
      cd $sPath
      rm -rf ~/.config/nvim
      ;;
    *)
      echo "================================"
      echo " $sPrg"
      echo "--------------------------------"
      echo " NESSUNA INSTALLAZIONE PREVISTA "
      echo "================================"
      ;;
    esac
  fi
  sleep 3
  Draw
} ///>
InstallAll() # ///<
{
  VerificaInstallati
  for sPrg in "${ssPrgOff[@]}"; do
    InstallPrg $sPrg
  done
  Draw
} ///>

SetupPrg()  # ///<
{
  sPrg=$1
  case $sPrg in
  ranger)
    if [[ "${!jPrgSetup[@]}" =~ "ranger" ]]; then
      echo "=============="
      echo " SETUP ranger "
      echo "=============="
      echo " ${!jPrgApt[ranger]} "
      echo "=============="
    else
      echo "================"
      echo " SETUP ranger  "
      echo "================"
      mkdir $HOME/.config/ranger
      cp ranger/rifle.conf $HOME/.config/ranger/rifle.conf
      sleep 10
      jPrgSetup[ranger]="kui.setup"
    fi
    ;;
  nvim)
    if [[ "${!jPrgSetup[@]}" =~ "nvim" ]]; then
      echo "=============="
      echo " SETUP nvim  "
      echo "=============="
      echo " ${!jPrgApt[nvim]} "
      echo "=============="
    else
      echo "=============="
      echo " SETUP nvim  "
      echo "=============="
      rm -rf ~/.config/nvim
      git clone https://gitlab.com/kui.team/nvim_lazy_setup.git ~/.config/nvim
      jPrgSetup[nvim]="kui.setup (lazyvim)"
    fi
    ;;
  git)
    if [[ "${!jPrgSetup[@]}" =~ "git" ]]; then
      echo "=============="
      echo " SETUP git  "
      echo "=============="
      echo " ${!jPrgApt[git]} "
      echo "=============="
    else
      echo "=============="
      echo " SETUP git  "
      echo "=============="
      git config --global alias.co 'commit -a -m'
      git config --global alias.ck 'checkout'
      git config --global alias.br 'branch'
      git config --global alias.bra 'branch --all'
      git config --global alias.st 'status'
      git config --global alias.tool 'vimdiff'
      git config --global alias.merge 'vimdiff'
      git config --global alias.ls "log --all --decorate --graph --oneline"
      git config --global alias.ll 'log --all --graph --pretty=format:"%C(cyan)(%ci) %<(10) %C(green)%cn%Creset %C(yellow)%h /%C(white)%C(bold)%s%C(reset) %C(auto)%d%Creset"'
      jPrgSetup[git]="kui.setup"
    fi
    sleep 1
    ;;
  *)
    echo
    echo "=============="
    echo " $sPrg"
    echo "--------------"
    echo " NESSUN SETUP"
    echo "=============="
    sleep 1
    ;;
  esac

} ///>
SetupAll()  # ///<
{
  VerificaInstallati
  for sPrg in "${ssPrgOn[@]}"; do
    SetupPrg $sPrg
  done
  Draw
} ///>

Draw
InstallAll
SetupAll


# dialog example ///<

# function1() {
# clear
# echo "Funzione 1 eseguita"
# }
# function2() {
# clear
# echo "Funzione 2 eseguita"
# }
#
# choice=$(dialog --menu "Scegli una operazione:" 15 40 2 \
# 1 "Installazione" \
# 2 "Aggiornamento" \
# --stdout)
#
# case $choice in
# 1) function1 ;;
# 2) function2 ;;
# esac
#
# dialog --infobox "bye bye" 10 20
# sleep 5
# clear

///>
# Show() ///<
# {
# clear
# echo "*****************"
# echo "* KUI.setup 0.0 *"
# echo "*****************"
# echo
# echo -e "PROGRAMMI INSTALLATI:"
# echo -e "Programma          Ver.                           Setup \n"
# git
# if command -v git &>/dev/null; then
# echo -e "git                $(git --version | awk 'NR==1 {print $3}')"
# else
# echo -e "git                NON INSTALLATO"
# fi
# curl
# if command -v curl &>/dev/null; then
# echo -e "curl               $(curl --version | awk 'NR==1 {print $2}')"
# else
# echo -e "curl                NON INSTALLATO"
# fi
# tmux
# if command -v tmux &>/dev/null; then
# echo -e "tmux               $(tmux -V | awk 'NR==1 {print $2}')"
# else
# echo -e "tmux               NON INSTALLATO"
# fi
# nodejs
# if command -v node &>/dev/null; then
# echo -e "node               $(nodejs --version | awk 'NR==1 {print $1}')"
# else
# echo -e "node               NON INSTALLATO"
# fi
# npm
# if command -v npm &>/dev/null; then
# echo -e "npm                $(npm --version | awk 'NR==1 {print $1}')"
# else
# echo -e "npm                NON INSTALLATO"
# fi
# clang
# if command -v clang &> /dev/null
# then
# echo -e "clang              $(clang -v | awk 'NR==1 {print $2}')"  ???????
#	else
#		echo -e "clang              NON INSTALLATO"
#	fi
# gcc
# if command -v gcc &>/dev/null; then
# echo -e "gcc                $(gcc --version | awk 'NR==1 {print $4}')"
# else
# echo -e "gcc                NON INSTALLATO"
# fi
# nvim
# if command -v nvim &>/dev/null; then
# echo -e "nvim               $(nvim -v | awk 'NR==1 {print $2}')       kui.setup (lazy.nvim)"
# else
# echo -e "nvim               NON INSTALLATO"
# fi

# echo
# echo
# } ///>

# example ///<
# path="$(pwd)/app"
# echo "Elenco delle directory in $path:"
# find "$path" -maxdepth 1 -type d | while read dir; do
  # Estrai solo il nome della directory dal percorso completo
  # dirname=$(basename "$dir")
  # Ignora la directory corrente (.)
  # if [ "$dirname" != "." ]; then
    # echo "$dirname"
  # fi
# done
# ///>
