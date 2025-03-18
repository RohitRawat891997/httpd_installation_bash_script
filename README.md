Setting up Jenkins with Nginx and SSL Certificate on Ubuntu

Prerequisites
Ensure that Jenkins and Java are installed by running the following commands:

jenkins --version
java --version
Step 1: Install Nginx
sudo apt update
sudo apt install nginx vim
Step 2: Install Certbot
sudo apt update
sudo apt install certbot
sudo apt install python3-certbot-nginx
Verify Certbot installation:

certbot --version
Step 3: Configure Nginx for Jenkins
Edit the Nginx configuration file for Jenkins:

sudo vim /etc/nginx/conf.d/jenkins.conf
Paste the following code into the file, replacing “jenkins.example.com” with your domain:

# Jenkins Nginx Proxy configuration
#################################################
upstream jenkins {
  server 127.0.0.1:8080 fail_timeout=0;
}

server {
  listen 80;
  server_name jenkins.example.com;

  location / {
    proxy_set_header        Host $host:$server_port;
    proxy_set_header        X-Real-IP $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header        X-Forwarded-Proto $scheme;
    proxy_pass              http://jenkins;
    # Required for new HTTP-based CLI
    proxy_http_version 1.1;
    proxy_request_buffering off;
    proxy_buffering off; # Required for HTTP-based CLI to work over SSL
  }
}    
Step 4: Validate Nginx configuration
sudo nginx -t
If there are no syntax errors, restart Nginx:

sudo systemctl enable --now nginx
sudo systemctl restart nginx
Step 5: Open Ports on AWS
Open ports 80 and 443 to 0.0.0.0/0 on your AWS security group. Certbot uses port 80.

Step 6: Set up environment variables
export DOMAIN="jenkins.example.com"
export ALERTS_EMAIL="webmaster@example.com"
Step 7: Request SSL Certificate with Certbot
sudo certbot --nginx --redirect -d $DOMAIN --preferred-challenges http --agree-tos -n -m $ALERTS_EMAIL --keep-until-expiring
Your Jenkins server should now be accessible with an SSL certificate, and the connection is secured.


Conclusion
You have successfully set up Jenkins with Nginx as a reverse proxy and obtained an SSL certificate from Let’s Encrypt using Certbot. Your Jenkins server is now secure and can be accessed over HTTPS.

Note: Ensure that you replace “jenkins.example.com” with your actual domain name throughout the documentation.
