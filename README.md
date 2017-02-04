## Docker image voor elasticsearch-maintenance

Dit image beschikt over scripts om Elastic Search zo nu en dan op te schonen.

Het maken/update van de image doe je met:
```console
$ docker build -t elasticsearch-maintenance:1.0.8 .
```

Om dit image beschikbaar te hebben in de k8s omgeving(en) moet het nog gepushed worden naar onze repository:
```console
$ docker push alliander/elasticsearch-maintenance:1.0.8
```

*Check het versie nummer voordat je bovenstaande commando's uitvoert! De bedoeling is dat deze repo automatisch gebouwd gaat worden middels Docker Hub of Quay.io. Op dit moment is het nog niet zover en moeten wijzigingen in deze repo's handmatig gepushed worden.*