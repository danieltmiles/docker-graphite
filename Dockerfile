FROM centos
MAINTAINER Daniel Hess <dan9186@gmail.com>

#Dependencies
RUN yum install -y epel-release && \
    yum update -y && \
    yum upgrade -y && \
    yum install -y bitmap bitmap-fonts gcc memcached nginx pycairo pyOpenSSL python-devel python-django python-django-tagging python-gunicorn python-memcached python-pip python-simplejson python-sqlite2 supervisor && \
    yum clean all

RUN pip install whisper \
    'twisted<12.0' \
    carbon \
    gunicorn \
    gunicorn-websocket \
    django-gunicorn \
    uwsgi \
    graphite-web

#Nginx config
ADD ext/conf/nginx/nginx.conf /etc/nginx/nginx.conf

#Supervisord config
ADD ext/conf/supervisord/supervisord.conf /etc/supervisord.conf

#Graphite config
ADD ext/conf/graphite/initial_data.json /opt/graphite/webapp/graphite/
ADD ext/scripts/local_settings.py /opt/graphite/webapp/graphite/
ADD ext/conf/graphite/carbon.conf /opt/graphite/conf/carbon.conf
ADD ext/conf/graphite/storage-schemas.conf /opt/graphite/conf/storage-schemas.conf
RUN cp /opt/graphite/conf/graphite.wsgi.example /opt/graphite/conf/graphite.wsgi
RUN mkdir -p /opt/graphite/storage/whisper
RUN chown -R nginx /opt/graphite/storage
RUN chmod 0775 /opt/graphite/storage /opt/graphite/storage/whisper
RUN touch /opt/graphite/storage/graphite.db /opt/graphite/storage/index
RUN chmod 0664 /opt/graphite/storage/graphite.db
RUN python /opt/graphite/webapp/graphite/manage.py syncdb --noinput

VOLUME /var/log/supervisor
VOLUME /var/log/nginx

ENTRYPOINT ["/usr/bin/supervisord"]
#ENTRYPOINT ["/bin/bash"]
