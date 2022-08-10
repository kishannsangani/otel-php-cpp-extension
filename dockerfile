FROM ubuntu:20.04

WORKDIR /home

ADD hello_world_interceptor /home/hello_world_interceptor/
ADD sample /home/sample/

RUN apt-get update && \
	# Install PHP
	apt -y install software-properties-common && \
	add-apt-repository ppa:ondrej/php && \
	apt-get update && \
	apt -y install php7.4 && \
	apt -y install php7.4-dev libcups2-dev && \
	# Install PHP-CPP tool
	cd /home && \
	apt install -y bc git vim && \
	git clone https://github.com/CopernicaMarketingSoftware/PHP-CPP.git && \
	cd PHP-CPP/ && \
	make && \
	echo $? && \
	make install && \
	# Build extensions
	cd /home/hello_world_interceptor && \
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
	cd /home/sample && \
	composer require "php-http/guzzle7-adapter" && \
	composer require open-telemetry/opentelemetry


CMD ["sleep","6h"]