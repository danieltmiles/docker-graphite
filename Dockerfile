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
    django-tagging \
    uwsgi \
    graphite-web

#Supervisord config
ADD ext/conf/supervisord/supervisord.conf /etc/supervisord.conf

#Graphite config
ADD ext/conf/graphite/initial_data.json /opt/graphite/webapp/graphite/
ADD ext/scripts/local_settings.py /opt/graphite/webapp/graphite/
ADD ext/conf/graphite/carbon.conf /opt/graphite/conf/carbon.conf
ADD ext/conf/graphite/storage-schemas.conf /opt/graphite/conf/storage-schemas.conf
RUN mkdir -p /opt/graphite/storage/whisper /var/log/graphite
RUN touch /opt/graphite/storage/graphite.db /opt/graphite/storage/index /var/log/graphite/info.log /var/log/graphite/exception.log /var/log/graphite/access.log /var/log/graphite/error.log
RUN chmod 0775 /opt/graphite/storage /opt/graphite/storage/whisper
RUN chmod 0664 /opt/graphite/storage/graphite.db
RUN python /opt/graphite/webapp/graphite/manage.py syncdb --noinput

VOLUME /opt/graphite/storage/whisper

RUN yum -y install vim

ENTRYPOINT ["/usr/bin/supervisord"]
