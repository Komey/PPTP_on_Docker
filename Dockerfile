FROM ubuntu:14.04

MAINTAINER Komey <lmh5257@live.cn>

ADD . /home/pptp/

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y pptpd iptables


RUN sed -i "s/#localip 192.168.0.1/localip 192.168.0.1/g" /etc/pptpd.conf && sed -i "s/#remoteip 192.168.0.234-238,192.168.0.245/remoteip 192.168.0.234-238,192.168.0.245/g" /etc/pptpd.conf && sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf


RUN chmod +x /home/pptp/*.sh

EXPOSE 1723

ENTRYPOINT ["/run.sh"]
CMD ["pptpd", "--fg"]
