# Fhem in Debian Docker Container 
![alt text](https://github.com/captainigloo/FHEM58/blob/master/images/docker.jpg)
I'm running this container on my Synology DiskStation 1512+. This docker image contains **FHEM 5.8** and is based on last Debian with few dependencies.

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
