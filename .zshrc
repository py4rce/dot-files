#sudo vi ~/.zshrc
#source ~/.zshrc

create_scan_directory() {
    NAME=${1:-$(date +%Y%m%d-%T)}
    SCAN_DIRECTORY=$NAME
    mkdir -p "$SCAN_DIRECTORY"
    echo "$SCAN_DIRECTORY"
}

serve() {
    DIR=${2:-$(pwd)}
    echo "Serving files from $DIR"
	PORT=${1:-80}
	python3 -m http.server "$PORT"
}

#print and copy your ip to your clipboard
me(){
ifconfig eth0 | grep "inet " | cut -b 9- | cut  -d" " -f2
ifconfig eth0 | grep "inet " | cut -b 9- | cut  -d" " -f2 | tr -d '\n' | xclip -sel clip
}


# connect to vpn
function conectar(){
	sudo openvpn ~/Documents/change_this_to_your_openvpn_file.ovpn 
}
 

# funciones
function cat1 {
    cat  "$1" --language "java"
}
 
#Alias 
#sudo apt install bat
alias cat='batcat' 
alias ls='lsd --group-directories-first'
 
