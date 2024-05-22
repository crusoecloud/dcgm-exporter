
# Crusoe Cloud DCGM Exporter

This repository contains everything that you should need to install and operate DCGM Exporter, a tool for exposing NVIDIA GPU metrics, on Crusoe Cloud VMs.

## QuickStart 

Firstly, run install.sh, which will install dcgm-exporter, prometheus, and their dependencies.

After that, you can run

```sh
dcgm-exporter 
```

in your vm to start scraping metrics.

You can then run

```sh
curl localhost:9400/metrics
```

to check that metrics are coming through.

If you want to export these metrics to a grafana dashboard outside your vm, you can start prometheus with the prometheus.yml config file included in this repository, by running

```sh
cd prometheus-2.41.0.linux-amd64 && ./prometheus --config.file=../prometheus.yaml
```

With prometheus running, and a Crusoe Firewall Rule allowing ingress traffic to your VM on port 9090, you can try (if 204.52.16.103 is the public IP of your VM) running:

```sh
curl "http://204.52.16.103:9090/api/v1/query?query=DCGM_FI_DEV_GPU_TEMP"
```

and you should see something like

```sh
{"status":"success","data":{"resultType":"vector","result":[]}}%
```

You can then run a Grafana instance outside out the VM and using vm-public-ip:9090 as a data source and the grafana dashboard spec included in the /grafana directory, see your metrics in action.
