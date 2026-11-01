# Unified Enterprise Observability Platform with AIOps and SLO Management

A practical, production-ready enterprise Observability Platform deployed on **Microsoft Azure Kubernetes Service (AKS)**, demonstrating complete end-to-end monitoring across Infrastructure, Applications, Metrics, Logs, Traces, Alerts, SLOs, and AIOps.

---

## Architecture Summary

```
                      ┌────────────────────────────────────────┐
                      │          Visual & SRE Layer            │
                      │  Grafana (7 Enterprise Dashboards)     │
                      │  Jaeger UI (Distributed Traces)        │
                      └──────▲──────────────────────────▲──────┘
                             │ (PromQL)                 │ (OTLP/Jaeger)
     ┌───────────────────────┴──────────────┐           │
     │      Prometheus Stack (v3.15)        │           │
     │  - Scrapes Node Exporter & KSM       │           │
     │  - Recording Rules (SLO Burn Rates)  │           │
     │  - Alerting Rules (Infra & Workloads)│           │
     └──────▲───────────────────────────────┘           │
            │                                           │
┌───────────┴───────────────────────────────┐   ┌───────┴──────────────────────┐
│       AKS Cluster Workloads               │   │ OpenTelemetry Collector      │
│  - Sample Microservice (podinfo:6.7.1)    ├──►│ - Receives OTLP Traces       │
│  - Automated Traffic Generator            │   │ - Exports to Jaeger Back-End │
│  - ama-logs (Container Insights Daemon)   │   └──────────────────────────────┘
└───────────┬───────────────────────────────┘
            │
            ▼ (HTTPS via Managed Service Identity)
┌──────────────────────────────────────────────────────────────────────────────┐
│                    Azure Log Analytics (law-observability-poc)               │
│  - Central Plane Logs: kube-apiserver, kube-audit, kube-scheduler            │
│  - Data Plane Logs: ContainerLogV2, KubePodInventory, Perf                   │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## Key Platform Features

1. **Infrastructure & Host Monitoring:** Complete Linux hardware observability (CPU, RAM, Disk IOPS, Network) via Prometheus Node Exporter.
2. **Kubernetes Cluster State:** Real-time visibility into Pod lifecycles, Deployments, and Container restarts via Kube-State-Metrics.
3. **Application Performance Monitoring (APM):** Live tracking of Google's 4 Golden Signals (Throughput, Latency, Error Rate, and Saturation).
4. **Distributed Tracing:** End-to-end distributed transaction tracing with OpenTelemetry Collector and Jaeger.
5. **Centralized Logging & KQL:** Enterprise Kusto Query Language (KQL) library querying over 15,000 real cluster audit and container log records.
6. **SRE Service Level Objectives (SLOs):** Continuous mathematical error budget calculations and multi-burn-rate alerting.
7. **AIOps & Statistical Anomaly Detection:** Mean $\pm 2\sigma$ dynamic confidence intervals and Z-score outlier detection.

---

## 7 Live Enterprise Grafana Dashboards

Located in [`dashboards/`](file:///d:/DevOps/enterprise-observability-poc/dashboards):
1. **1. Kubernetes Cluster Overview** (`k8s-cluster-overview`)
2. **2. Kubernetes Node Monitoring** (`k8s-node-monitoring`)
3. **3. Kubernetes Pod Monitoring** (`k8s-pod-monitoring`)
4. **4. Application Performance Monitoring (APM)** (`apm-monitoring`)
5. **5. Infrastructure Health & Storage** (`infra-health-storage`)
6. **6. SLO & SLA Management** (`slo-sla-management`)
7. **7. AIOps & Anomaly Detection** (`aiops-anomaly-detection`)

---

## Quickstart Access Commands

Run from PowerShell in your workstation:

```powershell
# Open Grafana (User: admin / Pass: Admin@Password123!)
kubectl port-forward -n monitoring svc/grafana 3000:80

# Open Prometheus Expression Browser
kubectl port-forward -n monitoring svc/prometheus-server 9090:80

# Open Jaeger Distributed Tracing UI
kubectl port-forward -n monitoring svc/jaeger 16686:16686

# Open Sample Microservice
kubectl port-forward -n sample-app svc/sample-app 9898:80
```

---

## Full Documentation

- **[System Architecture](file:///d:/DevOps/enterprise-observability-poc/documentation/architecture.md)**
- **[Implementation Guide](file:///d:/DevOps/enterprise-observability-poc/documentation/implementation-guide.md)**
- **[Troubleshooting Runbook](file:///d:/DevOps/enterprise-observability-poc/documentation/runbook.md)**
- **[Test Execution Report](file:///d:/DevOps/enterprise-observability-poc/documentation/test-report.md)**
