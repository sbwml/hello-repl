#!/bin/bash

export PATH="~/nginx/sbin:~/v2ray/sbin:$PATH"

if [ ! -d "~/nginx" ];then
	\cp -ax .nginx ~/nginx
fi
if [ ! -d "~/v2ray" ];then
	\cp -ax .v2ray ~/v2ray
fi

if [ $UUID ];then
    cat > ~/v2ray/etc/config.json <<EOF
{"log":{"access":"/dev/null","error":"/dev/null","loglevel":"warning"},"inbounds":[{"port":10000,"listen":"0.0.0.0","protocol":"vmess","settings":{"clients":[{"id":"$UUID","alterId":0}]},"streamSettings":{"network":"ws","wsSettings":{"path":"/vmess"}}},{"port":20000,"listen":"0.0.0.0","protocol":"vless","settings":{"clients":[{"id":"$UUID"}],"decryption":"none"},"streamSettings":{"network":"ws","wsSettings":{"path":"/vless"}}}],"outbounds":[{"protocol":"freedom","settings":{}}],"dns":{"server":["8.8.8.8","8.8.4.4","localhost"]}}
EOF
fi

v2ray -config ~/v2ray/etc/config.json >/dev/null 2>&1 &
nginx -g 'daemon off;'
