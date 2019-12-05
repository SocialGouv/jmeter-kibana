# jmeter-kibana

Use Jmeter to load test your application and get nice metrics inside kibana
This repository contains a setup to launch jmeter and gather results inside elasticsearch.
This project aims to bootstrap a feedback loop to load test your application (Run test, visualize results)
Adapt the jmeter test-plan to your needs and also the kiban dashboard.
There is alos an apm-server that is running so you can also use apm to monitor your application performance.
See how to [install an apm agent](https://www.elastic.co/guide/en/apm/get-started/current/components.html)

## Jmeter setup

```bash
$ sh install-jmeter.sh
```

Once download / clone the repository, you will need to install jmeter (current version `5.2.1` ).
The script will download / install jmeter, jmeter-plugin-manager, cmdrunner and plugins use in the base test plan (RandomCSVReader, elasticsearchBackend ).
once created the script will create and source an env file to use jmeter.

## Elasticsearch / kibana setup

```bash
$ docker-compose up
```

This will start a locally elasticsearch / kibana / apm server to monitor you application during the load test. elasticsearch is running on port 9400.

Once Kibana is up and running, you will need to import the predefined dashboard `jmeter-dashboard.ndjson`.

## Test plan setup

```bash
$ jmeter
```

Load you test plan and edit your scenario. The base scenario will query `/api/v1/search?q=some-queries-from-csv`. Adapt it to your needs.

## Launch a test plan

```bash
$ sh launchJmeter 1
```

THe script take a buildNumber as a paramater to identify your tests run. Edit the script to set
the host / port of your webserver. In the script you can also edit the nbThreads / duration / and rampup parameters used by jmeter for the test.

## Visualize in kibana

Open `http://localhost:5601` and select `dashboard > Jmeter`. Once on dashboard, select your test id and vizualize the result.
