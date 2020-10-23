# jmeter-kibana

Use Jmeter to load test your application and get nice metrics inside kibana
This repository contains a setup to launch jmeter and gather results inside elasticsearch.
This project aims to bootstrap a feedback loop to load test your application (Run test, visualize results)
Adapt the jmeter test-plan to your needs and also the kibana dashboard.
There is also an example app that use apm-server so you can also use apm to monitor your application performance.
See how to [install an apm agent](https://www.elastic.co/guide/en/apm/get-started/current/components.html)


## Elasticsearch / kibana setup

```bash
$ docker-compose up elasticsearch kibana apm dashboard 
```

This will start a locally elasticsearch / kibana / apm server to monitor you application during the load test. elasticsearch is running on port 9400. It will also install the associated dashboard

## Test plan setup

Load you test plan and edit your scenario. The base scenario will query `/api/v1/search?q=some-queries-from-csv`. Adapt it to your needs.

## Launch a test plan

```bash
$ docker-compose run --rm jmeter
```

THe docker-compose command take a buildNumber as a paramater to identify your tests run. Edit the docker-compose file to set the host / port of your webserver. You can also edit the nbThreads / duration / and rampup parameters used by jmeter for the test.

## Visualize in kibana

Open `http://localhost:5601` and select `dashboard > Jmeter`. Once on dashboard, select your test id and vizualize the result.
