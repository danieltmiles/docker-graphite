TIME_ZONE = 'UTC'
SECRET_KEY = '$(date +%s | sha256sum | base64 | head -c 64)'

## Data directories
#WHISPER_DIR = '/opt/graphite/storage/whisper'
#RRD_DIR = '/opt/graphite/storage/rrd'
#DATA_DIRS = [WHISPER_DIR, RRD_DIR] # Default: set from the above variables
#LOG_DIR = '/opt/graphite/storage/log/webapp'
LOG_DIR = '/var/log/graphite'
#INDEX_FILE = '/opt/graphite/storage/index'  # Search index file


# Email Configuration
#EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
#EMAIL_HOST = 'localhost'
#EMAIL_PORT = 25
#EMAIL_HOST_USER = ''
#EMAIL_HOST_PASSWORD = ''
#EMAIL_USE_TLS = False
# To drop emails on the floor, enable the Dummy backend:
#EMAIL_BACKEND = 'django.core.mail.backends.dummy.EmailBackend'


# Authentication Configuration
## LDAP / ActiveDirectory authentication setup
#USE_LDAP_AUTH = True
#LDAP_SERVER = "ldap.mycompany.com"
#LDAP_PORT = 389
#	OR
#LDAP_URI = "ldaps://ldap.mycompany.com:636"
#LDAP_SEARCH_BASE = "OU=users,DC=mycompany,DC=com"
#LDAP_BASE_USER = "CN=some_readonly_account,DC=mycompany,DC=com"
#LDAP_BASE_PASS = "readonly_account_password"
#LDAP_USER_QUERY = "(username=%s)"  #For Active Directory use "(sAMAccountName=%s)"

## REMOTE_USER authentication. See: https://docs.djangoproject.com/en/dev/howto/auth-remote-user/
#USE_REMOTE_USER_AUTHENTICATION = True

# Override the URL for the login link (e.g. for django_openid_auth)
#LOGIN_URL = '/account/login'


# Database Configuration #
##########################
# By default sqlite is used. If you cluster multiple webapps you will need
# to setup an external database (such as MySQL) and configure all of the webapp
# instances to use the same database. Note that this database is only used to store
# Django models such as saved graphs, dashboards, user preferences, etc.
# Metric data is not stored here.
#
# DO NOT FORGET TO RUN 'manage.py syncdb' AFTER SETTING UP A NEW DATABASE
#
# The following built-in database engines are available:
#  django.db.backends.postgresql          # Removed in Django 1.4
#  django.db.backends.postgresql_psycopg2
#  django.db.backends.mysql
#  django.db.backends.sqlite3
#  django.db.backends.oracle
#
# The default is 'django.db.backends.sqlite3' with file 'graphite.db'
# located in STORAGE_DIR
#
#DATABASES = {
#    'default': {
#        'NAME': '/opt/graphite/storage/graphite.db',
#        'ENGINE': 'django.db.backends.sqlite3',
#        'USER': '',
#        'PASSWORD': '',
#        'HOST': '',
#        'PORT': ''
#    }
#}
#


# Cluster Configuration #
#CLUSTER_SERVERS = ["10.0.2.2:80", "10.0.2.3:80"]

## These are timeout values (in seconds) for requests to remote webapps
#REMOTE_STORE_FETCH_TIMEOUT = 6   # Timeout to fetch series data
#REMOTE_STORE_FIND_TIMEOUT = 2.5  # Timeout for metric find requests
#REMOTE_STORE_RETRY_DELAY = 60    # Time before retrying a failed remote webapp
#REMOTE_FIND_CACHE_DURATION = 300 # Time to cache remote metric find results

## Remote rendering settings
# Set to True to enable rendering of Graphs on a remote webapp
#REMOTE_RENDERING = True
# List of IP (and optionally port) of the webapp on each remote server that
# will be used for rendering. Note that each rendering host should have local
# access to metric data or should have CLUSTER_SERVERS configured
#RENDERING_HOSTS = []
#REMOTE_RENDER_CONNECT_TIMEOUT = 1.0

#CARBONLINK_HOSTS = ["127.0.0.1:7002:a", "127.0.0.1:7102:b", "127.0.0.1:7202:c"]
#CARBONLINK_TIMEOUT = 1.0
