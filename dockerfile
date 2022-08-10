FROM ubuntu:20.04

WORKDIR /home

RUN apt-get update && \
	apt -y install software-properties-common && \
	add-apt-repository ppa:ondrej/php && \
	apt-get update && \
	apt -y install php7.4 && \
	apt -y install php7.4-dev libcups2-dev && \
	cd /home && \
	apt install -y bc git vim && \
	git clone https://github.com/CopernicaMarketingSoftware/PHP-CPP.git && \
	cd PHP-CPP/ && \
	make && \
	echo $? && \
	make install

CMD ["sleep","6h"]