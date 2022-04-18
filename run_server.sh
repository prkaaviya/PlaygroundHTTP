# Set top directory 
PROJECT_DIR=`pwd`
SSL_DIR="$PROJECT_DIR/ssl"
KEY_FILE="$SSL_DIR/key.pem"
CERT_FILE="$SSL_DIR/cert.pem"

# Make sure to give proper permissions to .env file to be executed in the container
chmod 764 .env

# Install mkcert utility to create and install certs
brew list mkcert || brew install mkcert

rm -f $KEY_FILE $CERT_FILE || true

mkcert -client -key-file $KEY_FILE -cert-file $CERT_FILE mysite.com "*.mysite.com" mysite.test localhost 127.0.0.1 ::1
mkcert -install

# Use docker to build the web server at localhost
docker-compose build
docker-compose up