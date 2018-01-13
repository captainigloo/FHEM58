# FhemDebian Docker Container 

I'm running this container on my Synology DiskStation 1512+. This docker image contains FHEM 5.8 and is based on last Debian with few dependencies.

- SSHD is setup on port 2222
- Login/password : root/fhem58
- Enabled writing mode Fhem web
```
echo 'attr WEB editConfig 1' >> /opt/fhem/fhem.cfg
```
## Run :
```
docker run -d \
	   --net=bridge \
           -p 2222:2222 \
           -p 7072:7072 \	   
           -p 8083:8083 \
           -p 8084:8084 \
	   -p 8085:8085 \
	   --device=<path to device> \
	   --restart=always
	   -e TZ=Europe\Paris \
	   
```
## After starting container :

- To generate a new SSH key run command in console : 
```
dpkg-reconfigure openssh-server
```
- To start SSH daemon run command in console : 
```
/etc/init.d/ssh start
```
- To change Timezone : 
- With command "Docker run"
```
-e TZ=Europe\Paris \
```
- run command in console 
```
echo Europe/Paris > /etc/timezone dpkg-reconfigure -f noninteractive tzdata
```
