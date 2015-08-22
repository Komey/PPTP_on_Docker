#!/bin/bash


USER=${USER:-user}
PASS=${PASS:-user}
echo "Your user info (user: ${USER}, password: ${PASS})"
echo "${USER}  pptpd  ${PASS}  *" >>/etc/ppp/chap-secrets

DNS1 = ${DNS1:-8.8.8.8}
DNS2 = ${DNS2:-4.4.4.4}
echo "Using DNS setting DNS1 DNS2"
sed -i "s/#ms-wins 10.0.0.3/ms-wins  ${DNS1}/g" /etc/ppp/pptpd-options
sed -i "s/#ms-wins 10.0.0.4/ms-wins  ${DNS2}/g" /etc/ppp/pptpd-options

iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE

service pptpd restart

exec "$@"

