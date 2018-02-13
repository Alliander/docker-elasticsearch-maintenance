## docker-elasticsearch-maintenance (curator)

De docker image stamt af van Python.
Vervolgens wordt hier m.b.v. Pip de [elasticsearch curator](https://github.com/elastic/curator) aan toegevoegd.

Via Jenkins wordt de cronjob vervolgens op zowel het test als het productie cluster uitgerold.

In de `action_file.yml` file kun je de verschillende [curator acties](https://www.elastic.co/guide/en/elasticsearch/client/curator/current/actions.html) definieren.
