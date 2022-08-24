FROM ubuntu:20.04

WORKDIR /home

ADD interceptors /home/interceptors/
ADD example /home/example/

RUN apt-get update && \
	apt-get install -y bc vim git curl && \
	# Install PHP
	DEBIAN_FRONTEND=noninteractive apt -y install software-properties-common && \
	add-apt-repository -y ppa:ondrej/php && \
	apt-get update && \
	apt -y install php7.4 && \
	apt-get install -y php7.4 php7.4-bcmath php7.4-bz2 php7.4-common php7.4-curl php7.4-decimal php7.4-dev php7.4-json php7.4-intl php7.4-mbstring php7.4-mcrypt php7.4-mysql php7.4-opcache php7.4-pgsql php7.4-readline php7.4-sqlite3 php7.4-ssh2 php7.4-xml php7.4-xmlrpc php7.4-zip php7.4-yaml && \
	apt-get install -y php7.4-dev gcc make re2c autoconf automake libcups2-dev libpcre3-dev build-essential && \
	# Install PHP-CPP tool
	cd /home && \
	git clone https://github.com/CopernicaMarketingSoftware/PHP-CPP.git && \
	cd PHP-CPP/ && \
	make && \
	echo $? && \
	make install && \
	# Build extensions
	cd /home/interceptors && \
	make clean && \
	make all && \
	make install && \
	# Install OpenTelemetry SDK
	apt install -y curl zip unzip php-zip && \
	cd /home && \
	curl -Ss https://getcomposer.org/installer | php && \
	mv composer.phar /usr/local/bin/composer && \
	chmod +x /usr/local/bin/composer && \
	apt-get update -y && \
	cd /home/example && \
	composer require "php-http/guzzle7-adapter" && \
	composer require open-telemetry/opentelemetry


CMD ["sleep","6h"]