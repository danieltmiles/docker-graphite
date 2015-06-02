#Docker Graphite
A lightweight container to manage a graphite session

#Usage
```
GRAPHITE_STORE=/data/graphite

mkdir $GRAPHITE_STORE/log
touch $GRAPHITE_STORE/log/info.log $GRAPHITE_STORE/log/exception.log $GRAPHITE_STORE/log/access.log $GRAPHITE_STORE/log/error.log

docker run -d -v "$GRAPHITE_STORE/log:/var/log/graphite" -v "$GRAPHITE_STORE:/opt/graphite/storage/whisper" -p 80:80 -p 2003:2003 -p 2004:2004 -p 7002:7002 dan9186/graphite
```
