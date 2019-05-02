
fuser -k 1080/tcp

ssh -ND 1080 root@streem.tech &
echo chrome instances running: $(pgrep chrome | wc -l)
read -p "Are you sure you want to start the proxy? It will kill all running googlle chrome instances! " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# do dangerous stuff
	killall -9 chrome
	google-chrome --proxy-server="socks5://localhost:1080"
	
fi

read -p "Kill all remaning chrome proxies? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	killall -9 chrome
	
fi
