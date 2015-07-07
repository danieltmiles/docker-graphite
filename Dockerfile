FROM centos
MAINTAINER Daniel Hess <dan9186@gmail.com>

#Dependencies
RUN yum install -y epel-release && \
    yum update -y && \
    yum upgrade -y && \
    yum install -y bitmap bitmap-fonts gcc memcached pycairo pyOpenSSL python-devel python-gunicorn python-memcached python-pip python-simplejson python-sqlite2 supervisor && \
    yum clean all

RUN pip install whisper \
    'twisted<12.0' \
    carbon \
    'django<1.6' \
    'django-tagging==0.3.6' \
    uwsgi \
    graphite-web \
    pytz

#Supervisord config
ADD ext/supervisord/supervisord.conf /etc/supervisord.conf

#Graphite config
ADD ext/graphite/webapp/ /opt/graphite/webapp/graphite/
ADD ext/graphite/conf/ /opt/graphite/conf/
RUN mkdir -p /opt/graphite/storage/whisper /var/log/graphite
RUN touch /opt/graphite/storage/graphite.db /opt/graphite/storage/index /var/log/graphite/info.log /var/log/graphite/exception.log /var/log/graphite/access.log /var/log/graphite/error.log
RUN chmod 0775 /opt/graphite/storage /opt/graphite/storage/whisper
RUN chmod 0664 /opt/graphite/storage/graphite.db
WORKDIR /opt/graphite/webapp/graphite
RUN python manage.py syncdb --noinput
WORKDIR /

VOLUME /opt/graphite/storage/whisper

ENTRYPOINT ["/usr/bin/supervisord"]
