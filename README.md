#Docker Graphite
A lightweight container to manage a graphite session

#Usage
```
GRAPHITE_STORE=/data/graphite
docker run -d -v "$GRAPHITE_STORE/log:/var/log/graphite" -v "$GRAPHITE_STORE:/opt/graphite/storage/whisper" -p 80:80 -p 2003:2003 -p 2004:2004 -p 7002:7002 dan9186/graphite
```
