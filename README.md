# my-http-playground

### Description 
Set up Apache HTTP server inside a docker container and listen on an external port on the host machine.

### Usage
Use it when you need a dummy HTTP server to listen to a port.

### How-to
1. Clone the repo.
```
git clone https://github.com/prkaaviya/my-http-playground.git
```
2. Execute run_server.sh.
```
bash run_server.sh
Building techstar
[+] Building 4.2s (13/13) FINISHED                                                                                                                                         
 => [internal] load build definition from Dockerfile                                                                                                                  0.0s
 => => transferring dockerfile: 499B                                                                                                                                  0.0s
 => [internal] load .dockerignore                                                                                                                                     0.0s
 => => transferring context: 2B                                                                                                                                       0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest                                                                                                      3.3s
 => [1/8] FROM docker.io/library/ubuntu:latest@sha256:9101220a875cee98b016668342c489ff0674f247f6ca20dfc91b91c0f28581ae                                                0.0s
 => [internal] load build context                                                                                                                                     0.0s
 => => transferring context: 562B                                                                                                                                     0.0s
 => CACHED [2/8] RUN apt-get update                                                                                                                                   0.0s
 => CACHED [3/8] RUN apt-get install -y vim && apt-get install -y lynx &&     apt-get install -y curl && apt-get install -y apache2 &&     apt-get clean              0.0s
 => CACHED [4/8] COPY ./conf/mysite.conf /etc/apache2/sites-available/                                                                                                0.0s
 => CACHED [5/8] RUN mkdir /var/www/html/mysite                                                                                                                       0.0s
 => [6/8] COPY ./html/index.html /var/www/html/mysite                                                                                                                 0.0s
 => [7/8] RUN a2dissite 000-default.conf                                                                                                                              0.3s
 => [8/8] RUN a2ensite mysite.conf                                                                                                                                    0.4s
 => exporting to image                                                                                                                                                0.1s
 => => exporting layers                                                                                                                                               0.0s
 => => writing image sha256:2475eb903e2d78aba1e7b856b19501429a39e91617cb6f3441cbafd390328001                                                                          0.0s
 => => naming to docker.io/library/my-http-playground_techstar                                                                                                        0.0s
Creating network "my-http-playground_default" with the default driver
Creating my-http-playground_techstar_1 ... done
Attaching to my-http-playground_techstar_1
techstar_1  | AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.19.0.2. Set the 'ServerName' directive globally to suppress this message
```
3. Connect to the server from host machine. Make sure the port number on the host is the one mapped to 80 on container.
```
17:32:44:~/Desktop/projects/gitpost/my-http-playground % curl http://localhost:14080/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
</head>
<body>
    <h1>Personal Website - Kaaviya</h1>
    <h2>Index page</h2>   
</body>
</html>% 
```
Here is the uglier version of it:\
<img width="391" alt="image" src="https://user-images.githubusercontent.com/65661406/163390181-46d9feb1-a5b0-4ed9-b384-030092abc791.png">

5. If you need to go inside the container, then use docker exec.
```
docker exec -it my-http-playground_techstar_1 bash
```
5. Some Apache commands to troubleshoot if run into errors.
```
apachectl status
apachectl -S
a2ensite <your-apache-file>.conf
```

### Improvements
- Process HTTPS/TLS requests (with client authentication if needed).
- Create reverse proxy for requests from HTTP to HTTPS.
