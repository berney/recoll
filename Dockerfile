FROM debian:jessie
MAINTAINER sunde41

RUN echo deb http://www.lesbonscomptes.com/recoll/debian/ jessie main > \
	/etc/apt/sources.list.d/recoll.list &&\
    echo deb-src http://www.lesbonscomptes.com/recoll/debian/ jessie main >> \
	/etc/apt/sources.list.d/recoll.list &&\
    apt-get -qq update && \
    apt-get -qq --force-yes install \
        recoll python-recoll \
        python python-pip git wv \
        aspell aspell-en \
        poppler-utils && \
    apt-get autoremove && apt-get clean && \
    mkdir /data && mkdir -p /root/.recoll && \
    git clone https://github.com/koniu/recoll-webui.git && \
    pip install epub gunicorn

VOLUME /data
EXPOSE 8080

CMD ["/usr/local/bin/gunicorn", "/recoll-webui/webui-wsgi:application", "--bind", "0.0.0.0","--keyfile","/root/sunde41_net.key", "--certfile", "/root/sunde41_net.crt"]
