{% if grains['os'] == 'CentOS' %}
httpd:
   pkg:
     - installed

firewall-cmd --permanent --add-port=80/tcp:
   cmd.run

firewall-cmd --reload:
   cmd.run

mariadb-server:
   pkg:
     - installed
mariadb:
   service:
     - running

if echo 'show databases;' | /usr/bin/mysql | grep -q zippyops;then echo 'present';else echo "create database zippyops;" | /usr/bin/mysql;fi:
   cmd.run

if echo 'select user from mysql.user;' | /usr/bin/mysql | grep -q zippyops;then echo 'present';else echo "CREATE USER 'zippyops'@'localhost' IDENTIFIED BY 'zippyops';" | /usr/bin/mysql;fi:
   cmd.run

echo "GRANT USAGE ON *.* TO 'zippyops'@'localhost' IDENTIFIED BY 'zippyops';" | /usr/bin/mysql:
   cmd.run

echo "GRANT ALL privileges ON zippyops.* TO 'zippyops'@'localhost';" | /usr/bin/mysql:
   cmd.run

echo "FLUSH PRIVILEGES;" | /usr/bin/mysql:
   cmd.run

php:
   pkg:
   - installed
php-gd:
   pkg:
   - installed
php-mbstring:
   pkg:
   - installed
php-mysql:
   pkg:
   - installed
php-pear:
   pkg:
   - installed
php-xml:
   pkg:
   - installed

wget:
   pkg:
     - installed
rm -rf /var/www/html/*:
   cmd.run

wget -P /root wget http://wordpress.org/latest.tar.gz;tar xzf /root/latest.tar.gz -C /var/www/html --strip 1:
   cmd.run

cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php:
   cmd.run

sed -i 's/database_name_here/zippyops/g' /var/www/html/wp-config.php:
   cmd.run
sed -i 's/username_here/zippyops/g' /var/www/html/wp-config.php:
   cmd.run
sed -i 's/password_here/zippyops/g' /var/www/html/wp-config.php:
   cmd.run

/var/www/html/.htaccess:
   file.managed:
     - source: salt://saltphp/files/htaccess

#copy_my_image:
#  file.managed:
#    - name: /var/www/html/index.png
#    - source: salt://saltphp/files/index.png
#    - makedirs: True

#copy_my_files:
#  file.managed:
#    - name: /var/www/html/demo.php
#    - source: salt://saltphp/files/demo.php
#    - makedirs: True

cd /var/www/html/:
   cmd.run

curl -utamilselvan:AP2tyb9YWoSpAt9Hsj5hyz8yVDc -O "http://192.168.2.5:8081/artifactory/saltphp-centos/index.png":
   cmd.run

mv /root/index.png /var/www/html/:
   cmd.run

curl -utamilselvan:AP2tyb9YWoSpAt9Hsj5hyz8yVDc -O "http://192.168.2.5:8081/artifactory/saltphp-centos/demo.php":
   cmd.run

mv /root/demo.php /var/www/html/:
   cmd.run

systemctl stop httpd;systemctl start httpd:
   cmd.run



{% elif grains['os'] == 'Ubuntu' %}
apache2:
   pkg:
     - installed

ufw allow 80/tcp:
   cmd.run

mariadb-server:
   pkg:
     - installed
mysql:
   service:
     - running

if echo 'show databases;' | /usr/bin/mysql | grep -q zippyops;then echo 'present';else echo "create database zippyops;" | /usr/bin/mysql;fi:
   cmd.run

if echo 'select user from mysql.user;' | /usr/bin/mysql | grep -q zippyops;then echo 'present';else echo "CREATE USER 'zippyops'@'localhost' IDENTIFIED BY 'zippyops';" | /usr/bin/mysql;fi:
   cmd.run

echo "GRANT USAGE ON *.* TO 'zippyops'@'localhost' IDENTIFIED BY 'zippyops';" | /usr/bin/mysql:
   cmd.run

echo "GRANT ALL privileges ON zippyops.* TO 'zippyops'@'localhost';" | /usr/bin/mysql:
   cmd.run

echo "FLUSH PRIVILEGES;" | /usr/bin/mysql:
   cmd.run

php:
   pkg:
   - installed
php-gd:
   pkg:
   - installed
php-mbstring:
   pkg:
   - installed
php-mysql:
   pkg:
   - installed
php-pear:
   pkg:
   - installed
php-xml:
   pkg:
   - installed

wget:
   pkg:
     - installed
rm -rf /var/www/html/*:
   cmd.run

wget -P /root wget http://wordpress.org/latest.tar.gz;tar xzf /root/latest.tar.gz -C /var/www/html --strip 1:
   cmd.run

cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php:
   cmd.run

sed -i 's/database_name_here/zippyops/g' /var/www/html/wp-config.php:
   cmd.run
sed -i 's/username_here/zippyops/g' /var/www/html/wp-config.php:
   cmd.run
sed -i 's/password_here/zippyops/g' /var/www/html/wp-config.php:
   cmd.run

/var/www/html/.htaccess:
   file.managed:
     - source: salt://saltphp/files/htaccess

#copy_my_image:
#  file.managed:
#    - name: /var/www/html/index.png
#    - source: salt://saltphp/files/index.png
#    - makedirs: True

#copy_my_files:
#  file.managed:
#    - name: /var/www/html/demo.php
#    - source: salt://saltphp/files/demo.php
#    - makedirs: True

curl -utamilselvan:AP2tyb9YWoSpAt9Hsj5hyz8yVDc -O "http://192.168.2.5:8081/artifactory/saltphp-centos/index.png":
   cmd.run

mv /root/index.png /var/www/html/:
   cmd.run

curl -utamilselvan:AP2tyb9YWoSpAt9Hsj5hyz8yVDc -O "http://192.168.2.5:8081/artifactory/saltphp-centos/demo.php":
   cmd.run

mv /root/demo.php /var/www/html/:
   cmd.run

apt-get install libapache2-mod-php:
   cmd.run

a2enmod php7.1:
   cmd.run



systemctl stop apache2;systemctl start apache2:
   cmd.run


{% elif grains['os'] == 'Windows' %}
choc_boot:
   module.run:
     - name: chocolatey.bootstrap

wget:
   chocolatey.installed:
     - name: wget


C:\ProgramData\Chocolatey\bin\choco install -y bitnami-xampp:
  cmd.run

C:\xampp\xampp_start.exe:
  cmd.run

mkdir C:\xampp\htdocs\php:
  cmd.run

del \f C:\Windows\System32\config\systemprofile\index.png:
  cmd.run

del \f C:\xampp\htdocs\php\index.png:
  cmd.run

C:\ProgramData\Chocolatey\bin\wget "http://192.168.2.5:8081/artifactory/saltphp-centos/index.png":
  cmd.run

copy C:\Windows\System32\config\systemprofile\index.png  C:\xampp\htdocs\php\:
  cmd.run


del \f C:\Windows\System32\config\systemprofile\demo.php:
  cmd.run

del \f C:\xampp\htdocs\php\demo.php:
  cmd.run

C:\ProgramData\Chocolatey\bin\wget "http://192.168.2.5:8081/artifactory/saltphp-centos/demo.php":
  cmd.run

copy C:\Windows\System32\config\systemprofile\demo.php  C:\xampp\htdocs\php\:
  cmd.run

#copy_my_files:
#  file.managed:
#    - name: C:\xampp\htdocs\php\demo.php
#    - source: salt://saltphp/files/demo.php
#    - makedirs: True
#copy_my_image:
#  file.managed:
#    - name: C:\xampp\htdocs\php\index.png
#    - source: salt://saltphp/files/index.png
#    - makedirs: True



#C:\xampp\apache\bin\httpd.exe:
#  cmd.run



{% endif %}
