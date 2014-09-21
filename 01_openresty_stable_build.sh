#!/bin/bash
echo ""
echo -ne "\033[33m ################################################\033[0m \n"
echo -ne "\033[33m # The build automation scripts for OpenResty	#\033[0m \n"
echo -ne "\033[33m # Maintainer: Yongbok Kim (ruo91@yongbok.net)	#\033[0m \n"
echo -ne "\033[33m ################################################\033[0m \n"
echo ""

# Variables for OpenResty
OPENRESTY_UGID=nginx
OPENRESTY_PREFIX=/etc/openresty
OPENRESTY_SBIN_PATH=/usr/sbin/nginx
OPENRESTY_LOCK_PATH=/tmp/openresty.lock
OPENRESTY_PID_PATH=/var/run/openresty.pid
OPENRESTY_ERROR_LOGS=/var/log/openresty-error.log

# Step 1. The requirements of packages for OpenResty
function install_packages {
	if [ `cat /etc/issue | awk '{printf $1}'` == "Debian" ]; then
		apt-get update && apt-get install -y git curl build-essential libreadline6-dev \
		ncurses-dev libpcre++-dev libssl-dev libgeoip-dev libxml2-dev libxslt-dev libgd2-xpm-dev libperl-dev zlib1g-dev libpcre3 libpcre3-dev

		groupadd -g 81 nginx && useradd -d /var/www -c "Nginx User" -u 81 -g 81 -s /sbin/nologin nginx

		sleep 5
		echo -ne "\033[33m - Step 1. The requirements of packages for OpenResty: [\033[0m"
		echo -ne "\033[32m Complete\033[0m"
		echo -ne "\033[33m ]\033[0m \n"
		echo ""

	elif [ `cat /etc/issue | awk '{printf $1}'` == "Ubuntu" ]; then
		apt-get update && apt-get install -y git curl build-essential libreadline6-dev \
		ncurses-dev libpcre++-dev libssl-dev libgeoip-dev libxml2-dev libxslt-dev libgd2-xpm-dev libperl-dev zlib1g-dev libpcre3 libpcre3-dev

		groupadd -g 81 nginx && useradd -d /var/www -c "Nginx User" -u 81 -g 81 -s /sbin/nologin nginx

		sleep 5
		echo -ne "\033[33m - Step 1. The requirements of packages for OpenResty: [\033[0m"
		echo -ne "\033[32m Complete\033[0m"
		echo -ne "\033[33m ]\033[0m \n"
		echo ""

	elif [ `cat /etc/issue | head -n 1 | awk '{printf $1}'` == "CentOS" ]; then
		yum groupinstall -y "Development Tools"
		yum install -y curl readline-devel pcre-devel openssl-devel \
		ncurses-devel openssl-devel libxml2-devel libxslt-devel gd-devel zlib-devel perl-devel perl-ExtUtils-Embed

		if [ `rpm -q --queryformat '%{VERSION}' centos-release` == "5" ]; then
			curl -LO "http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el5.rf.x86_64.rpm"
			rpm -ivh rpmforge-release*.rpm
			sed -i '/^enabled/ s:.*:enabled = 0:' /etc/yum.repos.d/rpmforge.repo
			rm -f rpmforge-release*
			yum install --enablerepo=rpmforge -y git geoip-devel

		elif [ `rpm -q --queryformat '%{VERSION}' centos-release` == "6" ]; then
			rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
			sed -i '/^enabled/ s:.*:enabled = 0:' /etc/yum.repos.d/rpmforge.repo
			rm -f rpmforge-release*
			yum install --enablerepo=rpmforge -y git geoip-devel
		fi

		groupadd -g 81 nginx && useradd -d /var/www -c "Nginx User" -u 81 -g 81 -s /sbin/nologin nginx

		sleep 5
		echo -ne "\033[33m - Step 1. The requirements of packages for OpenResty: [\033[0m"
		echo -ne "\033[32m Complete\033[0m"
		echo -ne "\033[33m ]\033[0m \n"
		echo ""

	elif [ `cat /etc/issue | head -n 1 |awk '{printf $1}'` == "Fedora" ]; then
		yum groupinstall -y "Development Tools"
		yum install -y git curl readline-devel pcre-devel openssl-devel \
		geoip-devel ncurses-devel openssl-devel libxml2-devel libxslt-devel gd-devel zlib-devel perl-devel perl-ExtUtils-Embed

		groupadd -g 81 nginx && useradd -d /var/www -c "Nginx User" -u 81 -g 81 -s /sbin/nologin nginx

		sleep 5
		echo -ne "\033[33m - Step 1. The requirements of packages for OpenResty: [\033[0m"
		echo -ne "\033[32m Complete\033[0m"
		echo -ne "\033[33m ]\033[0m \n"
		echo ""

	else
		echo -ne "\033[31m- Does not support from script.\033[0m \n"
		exit 0
	fi
}

# Step 2. Build for OpenResty
function build_openresty {
	./configure --prefix=$OPENRESTY_PREFIX \
	--user=$OPENRESTY_UGID \
	--group=$OPENRESTY_UGID \
	--sbin-path=$OPENRESTY_SBIN_PATH \
	--conf-path=$OPENRESTY_PREFIX/nginx/nginx.conf \
	--error-log-path=$OPENRESTY_ERROR_LOGS \
	--pid-path=$OPENRESTY_PID_PATH \
	--lock-path=$OPENRESTY_LOCK_PATH \
	--with-file-aio \
	--with-ipv6 \
	--with-http_realip_module \
	--with-http_addition_module \
	--with-http_xslt_module \
	--with-http_image_filter_module \
	--with-http_geoip_module \
	--with-http_sub_module \
	--with-http_dav_module \
	--with-http_flv_module \
	--with-http_iconv_module \
	--with-http_gzip_static_module \
	--with-http_random_index_module \
	--with-http_secure_link_module \
	--with-http_degradation_module \
	--with-http_stub_status_module \
	--with-http_perl_module \
	--with-pcre --with-pcre-jit --with-md5-asm --with-sha1-asm \
	--http-client-body-temp-path=$OPENRESTY_PREFIX/tmp/client_body_temp \
	--http-proxy-temp-path=$OPENRESTY_PREFIX/tmp/proxy_temp \
	--http-fastcgi-temp-path=$OPENRESTY_PREFIX/tmp/fastcgi_temp
	make && make install && mkdir -p $OPENRESTY_PREFIX/tmp/{client_body_temp,proxy_temp,fastcgi_temp}
	cp conf/nginx.conf $OPENRESTY_PREFIX/nginx
	cp -r conf/vhosts $OPENRESTY_PREFIX/nginx
	cp -r conf/html $OPENRESTY_PREFIX/nginx

	sleep 5
	echo -ne "\033[33m - Step 2. Build for OpenResty: [\033[0m"
	echo -ne "\033[32m Complete\033[0m"
	echo -ne "\033[33m ]\033[0m \n"
	echo ""
}

# Main
# Do you want to really a build?
echo -ne "\033[33m- Do you want to really a build?\033[0m"
echo -ne "\033[33m yes(y) or no(n)\033[0m: "

read user_input

if  [ "$user_input" == "yes" ]; then
	install_packages
	download_pagespeed
	build_openresty

elif [ "$user_input" == "y" ]; then
	install_packages
	download_pagespeed
	build_openresty

elif [ "$user_input" == "no" ]; then
	exit 0

elif [ "$user_input" == "n" ]; then
	exit 0
fi

echo ""
echo -ne "\033[33m ########################################################\033[0m \n"
echo -ne "\033[33m #	The successful completion of the build.		#\033[0m \n"
echo -ne "\033[33m ########################################################\033[0m \n"
echo -ne "\033[33m # Binary:		$OPENRESTY_SBIN_PATH			#\033[0m \n"
echo -ne "\033[33m # Config files:	$OPENRESTY_PREFIX/nginx		#\033[0m \n"
echo -ne "\033[33m ########################################################\033[0m \n"
echo ""

# Initializes for variables
unset OPENRESTY_UGID OPENRESTY_PREFIX \
OPENRESTY_SBIN_PATH OPENRESTY_LOCK_PATH OPENRESTY_PID_PATH OPENRESTY_ERROR_LOGS