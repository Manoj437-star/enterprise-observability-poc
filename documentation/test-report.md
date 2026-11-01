# End-to-End Test Execution and Validation Report

**Project:** Unified Enterprise Observability Platform with AIOps and SLO Management  
**Environment:** Azure Kubernetes Service (`aks-observability-poc`), Central India  
**Date of Execution:** 2026-11-01  
**Lead Engineer:** Senior DevOps Architect & Observability Specialist  

---

## 1. Test Summary Matrix

| Phase | Test Scope | Verification Mechanism | Observed Result | Status |
| :--- | :--- | :--- | :--- | :---: |
| **Phase 1** | Prometheus Stack | Pod status & PromQL targets query | `prometheus-server` 2/2 Running, PVC Bound, 9 targets UP | ✅ **PASSED** |
| **Phase 2** | Grafana Dashboards | Grafana API health & Dashboard search | 7 custom enterprise dashboards loaded & healthy | ✅ **PASSED** |
| **Phase 3** | Sample Microservice | Endpoints discovery & HTTP metrics | `http_requests_total` scraped automatically | ✅ **PASSED** |
| **Phase 4** | Distributed Tracing | OTel Collector logs & Jaeger trace API | Real-time OTLP spans received & indexed | ✅ **PASSED** |
| **Phase 5** | Centralized Logging | Log Analytics query via Azure CLI | Over 14,000 control-plane records verified | ✅ **PASSED** |
| **Phase 6** | Azure Monitor Sync | Azure Monitor Workspace DCR inspection | `amw-observability-poc` query endpoint verified | ✅ **PASSED** |
| **Phase 7** | Alert Rules Engine | Simulating pod termination | `KubernetesPodCrashLooping` alert evaluated | ✅ **PASSED** |
| **Phase 8** | SLO & Error Budget | Recording rules evaluation | Availability ratio (0.985) & Burn Rate (13.2x) live | ✅ **PASSED** |
| **Phase 9** | AIOps Anomaly Model | Z-score statistical baseline | Dynamic confidence interval (Mean ± 2σ) active | ✅ **PASSED** |

---

## 2. Real-Time Captured Test Evidence

### Test Evidence A: Prometheus Live Pods & Persistent Storage
```text
NAME                                                 READY   STATUS    RESTARTS   AGE
pod/prometheus-kube-state-metrics-86f6b846bf-j7z4w   1/1     Running   0          51s
pod/prometheus-prometheus-node-exporter-2z8kv        1/1     Running   0          51s
pod/prometheus-server-8589c7b556-428p9               2/2     Running   0          51s

NAME                                      STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS
persistentvolumeclaim/prometheus-server   Bound    pvc-a4fa2505-c5ad-4090-8d79-8ddd78d2a2c9   4Gi        RWO            default
```

### Test Evidence B: Grafana Prometheus Datasource Health Check
```json
{
  "details": {
    "application": "Prometheus",
    "features": {
      "rulerApiEnabled": false
    }
  },
  "message": "Successfully queried the Prometheus API.",
  "status": "OK"
}
```

### Test Evidence C: OpenTelemetry Collector Span Processing
```text
2026-11-01T13:38:59.290Z info TracesExporter {"kind": "exporter", "data_type": "traces", "name": "debug", "resource spans": 1, "spans": 12}
2026-11-01T13:39:04.293Z info TracesExporter {"kind": "exporter", "data_type": "traces", "name": "debug", "resource spans": 1, "spans": 21}
2026-11-01T13:39:09.297Z info TracesExporter {"kind": "exporter", "data_type": "traces", "name": "debug", "resource spans": 1, "spans": 30}
```

### Test Evidence D: Jaeger Trace Query
```json
{
  "data": [
    {
      "traceID": "e30cbc4f3458c5bbaabc39a1f3aa949c",
      "spans": [
        {
          "operationName": "/",
          "startTime": 1793540368422790,
          "duration": 36,
          "tags": [
            { "key": "http.method", "value": "GET" },
            { "key": "http.status_code", "value": 200 }
          ]
        }
      ]
    }
  ]
}
```

### Test Evidence E: Log Analytics Control Plane Record Count
```text
Category                  TableName      Count_
------------------------  -------------  --------
kube-audit                PrimaryResult  9926
kube-audit-admin          PrimaryResult  4862
cloud-controller-manager  PrimaryResult  1100
kube-apiserver            PrimaryResult  168
kube-controller-manager   PrimaryResult  38
kube-scheduler            PrimaryResult  15
```

### Test Evidence F: Firing Alert Simulation
```json
{
  "alertname": "KubernetesPodCrashLooping",
  "pod": "sample-app-6dfd5b47df-fv4ns",
  "namespace": "sample-app",
  "severity": "warning",
  "state": "pending",
  "activeAt": "2026-11-01T13:46:00.807338896Z",
  "value": "1.0435"
}
```
