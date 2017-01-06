FROM alpine:3.5

# Setup apache and php
RUN apk --update add \
	apache2 \
	php5-apache2 \
	php \
	php5-curl \
	php5-phar \
	php5-openssl \
	php5-ctype \
	php5-json \
	php5-xml \
	php5-mcrypt \
	php5-intl \
	php5-pdo \
	php5-mysqli \
	php5-pdo_mysql \
	php5-pdo_sqlite \
	php5-common \
	php5-iconv \
	php5-zlib \
	git \
	vim \
	bash \
    && rm -f /var/cache/apk/* \ 
    && mkdir /run/apache2 \
    && sed -i 's/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/' /etc/apache2/httpd.conf \
	&& mkdir /app && chown -R apache:apache /app \
	&& sed -i 's#"\/var\/www\/localhost\/htdocs#"\/app\/www#g' /etc/apache2/httpd.conf \
	&& sed -i 's#AllowOverride None#AllowOverride All#g' /etc/apache2/httpd.conf 

COPY . /app
WORKDIR /app

RUN chmod 777 log temp
	&& rm -rf composer* Dockerfile docker* .git
	
EXPOSE 80
CMD ["httpd","-D","FOREGROUND"]