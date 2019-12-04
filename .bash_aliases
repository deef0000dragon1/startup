eval $(dircolors -b ~/.dircolors)

#Set Bash Prompt to 
#+-streem@mx.streem.tech
#¦----Wed Mar 27, 09:06:06
#+-~:
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\]╔═\[$(tput setaf 2)\]\u@\H\n\[$(tput setaf 1)\]╠════\[$(tput setaf 6)\]\d, \t \n\[$(tput setaf 1)\]╚═\[$(tput setaf 7)\]\w:\[$(tput sgr0)\]"

test -f /etc/profile.d/golang_path.sh && source /etc/profile.d/golang_path.sh
source <(kubectl completion bash)

alias reboot='sudo reboot'
alias update='sudo apt-get upgrade'
alias kubeshell=echo kubectl run -i --tty busybox --image=busybox --restart=Never -- sh 


alias ls='ls -alh --color=auto' ## Use a long listing format ##
alias ll='ls -la'               ## Show hidden files ##
alias l.='ls -d .* --color=auto'

alias cd..='cd ..'

alias grep='grep --color=auto'

alias ports='sudo netstat -tulanp'

alias apt-get="sudo apt-get"
alias update="sudo apt-get update"
alias upgrade="sudo apt-get upgrade"

alias shutdown="sudo shutdown -h now"

alias wget='wget -c'
alias size="du -hs $(pwd)"

###################
#####FUNCTIONS#####
###################

function extract() {
	if [ -z "$1" ]; then
		# display usage if no parameters given
		echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
		echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
		return 1
	else
		for n in $@; do
			if [ -f "$n" ]; then
				case "${n%,}" in
				*.tar.bz2 | *.tar.gz | *.tar.xz | *.tbz2 | *.tgz | *.txz | *.tar) tar xvf "$n" ;;
				*.lzma) unlzma ./"$n" ;;
				*.bz2) bunzip2 ./"$n" ;;
				*.rar) unrar x -ad ./"$n" ;;
				*.gz) gunzip ./"$n" ;;
				*.zip) unzip ./"$n" ;;
				*.z) uncompress ./"$n" ;;
				*.7z | *.arj | *.cab | *.chm | *.deb | *.dmg | *.iso | *.lzh | *.msi | *.rpm | *.udf | *.wim | *.xar)
					7z x ./"$n"
					;;
				*.xz) unxz ./"$n" ;;
				*.exe) cabextract ./"$n" ;;
				*)
					echo "extract: '$n' - unknown archive method"
					return 1
					;;
				esac
			else
				echo "'$n' - file does not exist"
				return 1
			fi
		done
	fi
}

function internet() {
	if ! [ -x "$(command -v speedtest-cli)" ]; then
		echo Error: speedtest-cli not installed. Installing.
		apt install speedtest-cli
	fi
	speedtest-cli >&1
	echo Ping time to google: $(ping -c 1 google.com | grep -oh "time=[0-9.]*") ms

}
