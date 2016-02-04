service apache2 stop;
apt-get install build-essential nodejs-legacy npm ruby-full nginx;
npm install -g express bower forever;
npm install && (cd public && bower install);
chmod 777 launch.sh;
./launch.sh;
mv earvinkayonga.com /etc/nginx/sites-enabled/default
service nginx restart
