FROM debian:latest

MAINTAINER CaptainIgloo <joly.sebastien@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install packages APT
RUN apt-get update
RUN apt-get -y --force-yes install supervisor telnet wget curl vim git nano make gcc g++ apt-transport-https sudo logrotate gnupg2

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

# Install fhem
RUN wget -q https://debian.fhem.de/archive.key
RUN apt-key add archive.key
#RUN wget --no-check-certificate -qO - https://debian.fhem.de/archive.key | apt-key add -
#RUN echo "deb https://debian.fhem.de/nightly ./" > /etc/apt/sources.list.d/fhem.list
RUN echo "deb https://debian.fhem.de/nightly/ /" | tee -a /etc/apt/sources.list.d/fhem.list
RUN apt-get update
RUN apt-get -y --force-yes install fhem

#RUN wget http://fhem.de/fhem-5.8.deb
#RUN dpkg -i fhem-5.8.deb
#RUN apt-get install -f

# Create log directory
RUN mkdir -p /var/log/supervisor

# Setup Logrotate
RUN echo "*/5 *	* * *	/usr/sbin/logrotate /etc/logrotate.conf" >> /etc/crontabs/root
ADD logrotate.conf /etc/logrotate.conf
CMD ["crond", "-f"]

# Setup TZ
RUN echo Europe/Paris > /etc/timezone dpkg-reconfigure -f noninteractive tzdata

# supervisord.conf for supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chown fhem /opt/fhem/fhem.cfg
# Ports
EXPOSE 8083

CMD ["/usr/bin/supervisord"]
