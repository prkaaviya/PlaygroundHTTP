# my-http-playground

### Description

Set up Apache HTTP/HTTPS server inside a docker container and listen on an external port on the host machine.

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
```
```
/usr/local/Cellar/mkcert/1.4.3/bin/mkcert
Note: the local CA is not installed in the Firefox trust store.
Run "mkcert -install" for certificates to be trusted automatically ⚠️

Created a new certificate valid for the following names 📜
 - "mysite.com"
 - "*.mysite.com"
 - "mysite.test"
 - "localhost"
 - "127.0.0.1"
 - "::1"

Reminder: X.509 wildcards only go one level deep, so this won't match a.b.mysite.com ℹ️

The certificate is at "/Users/k.ramkumar/Desktop/projects/gitpost/my-http-playground/ssl/cert.pem" and the key at "/Users/k.ramkumar/Desktop/projects/gitpost/my-http-playground/ssl/key.pem" ✅

It will expire on 18 July 2024 🗓

The local CA is already installed in the system trust store! 👍
Warning: "certutil" is not available, so the CA can't be automatically installed in Firefox! ⚠️
Install "certutil" with "brew install nss" and re-run "mkcert -install" 👈

Building techstar
[+] Building 5.2s (20/20) FINISHED                                                                               
 => [internal] load build definition from Dockerfile                                                        0.0s
 => => transferring dockerfile: 37B                                                                         0.0s
 => [internal] load .dockerignore                                                                           0.0s
 => => transferring context: 2B                                                                             0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest                                            3.0s
 => [internal] load build context                                                                           0.3s
 => => transferring context: 3.64kB                                                                         0.3s
 => [ 1/15] FROM docker.io/library/ubuntu:latest@sha256:9101220a875cee98b016668342c489ff0674f247f6ca20dfc9  0.0s
 => CACHED [ 2/15] RUN apt-get update                                                                       0.0s
 => CACHED [ 3/15] RUN apt-get install -y vim && apt-get install -y lynx &&     apt-get install -y curl &&  0.0s
 => CACHED [ 4/15] COPY ./conf/mysite.conf /etc/apache2/sites-available/                                    0.0s
 => CACHED [ 5/15] COPY ./conf/mysite-ssl.conf /etc/apache2/sites-available/                                0.0s
 => CACHED [ 6/15] RUN mkdir /var/www/html/mysite                                                           0.0s
 => CACHED [ 7/15] COPY ./html/index.html /var/www/html/mysite                                              0.0s
 => [ 8/15] COPY ./ssl/key.pem /etc/ssl/private                                                             0.0s
 => [ 9/15] COPY ./ssl/cert.pem /etc/ssl/certs                                                              0.0s
 => [10/15] RUN a2dissite 000-default.conf                                                                  0.2s
 => [11/15] RUN a2ensite mysite.conf                                                                        0.4s
 => [12/15] RUN a2ensite mysite-ssl.conf                                                                    0.2s 
 => [13/15] RUN a2enmod proxy_http                                                                          0.3s 
 => [14/15] RUN a2enmod headers                                                                             0.4s
 => [15/15] RUN a2enmod ssl                                                                                 0.3s 
 => exporting to image                                                                                      0.1s
 => => exporting layers                                                                                     0.0s
 => => writing image sha256:a6674e877f23f21b469968c75bb8a8c7d76123d1f0f57d81e7c59c0a7e60d99d                0.0s
 => => naming to docker.io/library/my-http-playground_techstar                                              0.0s
Recreating my-http-playground_techstar_1 ... done
Attaching to my-http-playground_techstar_1
```

3. Connect to HTTP server from host machine. Make sure the port number on the host is the one mapped to 80 on container.

```
curl http://localhost:14080/index.html
```
```
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

4. Connect to HTTPS server from host machine. Make sure the port number on the host is the one mapped to 443 on container.

```
(echo -ne "GET / HTTP/1.1\r\nHost: localhost:14443\r\n\r\n") | openssl s_client -tls1_2 -quiet -connect localhost:14443
```
```
depth=0 O = mkcert development certificate, OU = k.ramkumar@XXXX(Kaaviya Ramkumar)
verify error:num=20:unable to get local issuer certificate
verify return:1
depth=0 O = mkcert development certificate, OU = k.ramkumar@XXXX (Kaaviya Ramkumar)
verify error:num=21:unable to verify the first certificate
verify return:1
HTTP/1.1 200 OK
Date: Mon, 18 Apr 2022 07:29:21 GMT
Server: Apache/2.4.41 (Ubuntu)
X-owner: prk
Last-Modified: Thu, 14 Apr 2022 11:56:24 GMT
ETag: "bf-5dc9bfbbb8735"
Accept-Ranges: bytes
Content-Length: 191
Vary: Accept-Encoding
X-Content-Type-Options: nosniff
Content-Type: text/html

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

5. If you need to go inside the container, then use docker exec.

```
docker exec -it my-http-playground_techstar_1 bash
```

6. Some Apache commands to troubleshoot if run into errors.

```
apachectl status
apachectl -S
a2ensite <your-apache-file>.conf
```

7. Use this to stop and remove running docker containers.

```
docker stop $(docker ps -aq); docker rm $(docker ps -aq);
```

### Improvements

- Process HTTPS/TLS requests (with client authentication if needed).
- Create reverse proxy for requests from HTTP to HTTPS.
