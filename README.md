# FhemDebian Docker Container

I'm running this container on my Synology DiskStation 1512+. This docker image contains FHEM and is based on last Debian with few dependencies.

Enabled writing mode Fhem web
echo 'attr WEB editConfig 1' >> /opt/fhem/fhem.cfg

## Run:
```
docker run -d \
	   --net=host \
           -p 8083:8083 \
           -p 51826:51826 \
```
## After starting container :

### To generate a new SSH key run command in console : 
```
dpkg-reconfigure openssh-server
```
### To start SSH daemon run command in console : 
```
/etc/init.d/ssh start
```
### To change Timezone run command in console : 
```
echo Europe/Paris > /etc/timezone dpkg-reconfigure -f noninteractive tzdata
```
