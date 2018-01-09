FROM debian:latest

MAINTAINER CaptainIgloo69 <joly.sebastien@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install packages APT
RUN apt-get update
RUN apt-get -y --force-yes install supervisor telnet wget curl vim git nano make gcc g++ apt-transport-https sudo logrotate 
# gnupg2 cron apt-utils systemd-sysv

# Install perl packages
RUN apt-get -y --force-yes install libalgorithm-merge-perl \
libclass-isa-perl \
libcommon-sense-perl \
libdpkg-perl \
liberror-perl \
libfile-copy-recursive-perl \
libfile-fcntllock-perl \
libio-socket-ip-perl \
libjson-perl \
libnet-telnet-perl \
libjson-xs-perl \
libmail-sendmail-perl \
libsocket-perl \
libswitch-perl \
libsys-hostname-long-perl \
libterm-readkey-perl \
libterm-readline-perl-perl \
libdevice-serialport-perl \
libio-socket-ssl-perl \
libwww-perl \
libcgi-pm-perl \
sqlite3 \
libdbd-sqlite3-perl \
libtext-diff-perl

# Install APT fhem
#RUN wget -q https://debian.fhem.de/archive.key
#RUN apt-key add archive.key
#RUN wget --no-check-certificate -qO - https://debian.fhem.de/archive.key | apt-key add -
#RUN echo "deb https://debian.fhem.de/nightly ./" > /etc/apt/sources.list.d/fhem.list
#RUN echo "deb https://debian.fhem.de/stable/ /" | tee -a /etc/apt/sources.list.d/fhem.list
#RUN apt-get update
#RUN apt-get -y --force-yes install fhem # La commande ne passe pas

# Install DPKG fhem
RUN wget http://fhem.de/fhem-5.8.deb
RUN dpkg -i fhem-5.8.deb
RUN apt-get install -f

# Create log directory
RUN mkdir -p /var/log/supervisor

# Setup Logrotate
#RUN echo "* * */5 * 0 /usr/sbin/logrotate /etc/logrotate.conf" >> /etc/crontabs/root
#ADD logrotate.conf /etc/logrotate.conf
#CMD ["crond", "-f"]

# Setup TZ
RUN echo Europe/Paris > /etc/timezone dpkg-reconfigure -f noninteractive tzdata

ENV RUNVAR fhem


# Setup sshd on port 2222 and allow root login / password = fhem58
RUN apt-get -y --force-yes install openssh-server && apt-get clean
RUN sed -i 's/Port 22/Port 2222/g' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN echo "root:fhem58" | chpasswd
RUN /bin/rm  /etc/ssh/ssh_host_*

# Cleaning APT
RUN apt-get clean

# supervisord.conf for supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Owner fhem.cfg
RUN chown fhem /opt/fhem/fhem.cfg

# SSH / Fhem ports 
EXPOSE 2222 7072 8083 8084 8085

ADD run.sh /root/run.sh
ENTRYPOINT ["./run.sh"]

CMD ["/usr/bin/supervisord"]

