[![Docker Build Status](https://img.shields.io/docker/build/captainigloo69/fhem58.svg)](https://hub.docker.com/r/captainigloo69/fhem58/) [![Docker Pulls](https://img.shields.io/docker/pulls/captainigloo69/fhem58.svg)](https://hub.docker.com/r/captainigloo69/fhem58/) 
[![Docker Stars](https://img.shields.io/docker/stars/captainigloo69/fhem58.svg)](https://hub.docker.com/r/captainigloo69/fhem58/)

# FHEM 5.8 in Debian Docker Container

|![Registry Overview.](https://raw.githubusercontent.com/captainigloo/FHEM58/master/images/fhem.png)|I'm running this container on my Synology DiskStation 1512+. This docker image contains **FHEM 5.8** and is based on last Debian with few Perl dependencies and few APT install. This setup is tested with several types of USB dongles with : **/dev/ttyACM0@115200** and **/dev/ttyUSB2@57600**.|
| ------------- | :------------- |


- SSHD is setup on **port 2222**
- Login/password : **root/fhem58**
- Enabled writing mode Fhem web

```
echo 'attr WEB editConfig 1' >> /opt/fhem/fhem.cfg
```

# Run :

```shell
docker run -d \
	   --net=bridge \
	   --name=fhem
	   --hostname=FhemCtrl \
           -p 2222:2222 \
           -p 7072:7072 \	   
           -p 8083:8083 \
           -p 8084:8084 \
	   -p 8085:8085 \
	   -v /etc/localtime:/etc/localtime \
	   --device=<path to device> \
	   --restart=always \
	   -e TZ=<timezone> \
	   captainigloo69/fhem58
```

**Example**

```shell-script
docker run -ti -d --name=fhemUSB --hostname=Fhem58 -p 7072:7072 -p 8083:8083 -p 8084:8084 -p 8085:8085 -p 2222:2222 --restart=always --device=/dev/ttyUSB2:/dev/ttyUSB2 -v /etc/localtime:/etc/localtime -e TZ="Europe/Paris" captainigloo69/fhem58
```

# After starting container :

- **To generate a new SSH key run command in console :** 
```
dpkg-reconfigure openssh-server
```
- **To start SSH daemon run command in console :** 
```
/etc/init.d/ssh start
```
- **To change Timezone run command in console** (if not use parameter ```Docker run with "-e TZ=<timezone>"```) **:**
```
echo Europe/Paris > /etc/timezone dpkg-reconfigure -f noninteractive tzdata
```

# Article in French :

[Domotique-info](http://www.domotique-info.fr/2013/11/fhem-passerelle-oregon-di-o-blyss-enocean/)

![Registry Overview.](http://i0.wp.com/www.domotique-info.fr/wp-content/uploads/2013/10/Domotique-Info-fhem-architecture-potentielle.png?w=741)
