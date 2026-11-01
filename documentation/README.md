# Unified Enterprise Observability Platform with AIOps and SLO Management

[![Kubernetes](https://img.shields.io/badge/Kubernetes-AKS_v1.36-blue.svg)](https://azure.microsoft.com/services/kubernetes-service/)
[![Terraform](https://img.shields.io/badge/Terraform-v1.5+-purple.svg)](https://www.terraform.io/)
[![Prometheus](https://img.shields.io/badge/Prometheus-v3.15-orange.svg)](https://prometheus.io/)
[![Grafana](https://img.shields.io/badge/Grafana-v10+-brightgreen.svg)](https://grafana.com/)
[![OpenTelemetry](https://img.shields.io/badge/OpenTelemetry-v0.96-blueviolet.svg)](https://opentelemetry.io/)

A complete, production-grade cloud-native observability platform built on Microsoft Azure Kubernetes Service (AKS), HashiCorp Terraform, Prometheus, Grafana, OpenTelemetry, Jaeger, and Azure Log Analytics.

---

## 1. Executive Summary

Modern enterprise architectures demand unified visibility across the "Three Pillars of Observability" (Metrics, Logs, and Traces), complemented by Site Reliability Engineering (SRE) Service Level Objectives (SLOs) and AIOps-driven anomaly detection.

This platform provides:
- **Infrastructure & Cluster Metrics:** Prometheus v3.15, Node Exporter, and Kube-State-Metrics scraping live hardware, cAdvisor, and Kubernetes API states.
- **Unified Dashboards:** 7 dedicated Grafana dashboards covering Cluster Overview, Node Health, Pod Performance, APM Golden Signals, Infrastructure Storage, SLO Tracking, and AIOps Statistical Anomaly Detection.
- **Distributed Tracing:** OpenTelemetry Collector pipeline exporting distributed trace spans to a Jaeger back-end.
- **Centralized Logging:** Azure Log Analytics Workspace ingesting AKS control plane logs (`kube-apiserver`, `kube-audit`, `kube-scheduler`) and container stdout/stderr logs via Container Insights (`ama-logs`).
- **SLO & Error Budget Management:** Continuous Prometheus Recording Rules calculating availability ratios, latency thresholds, and error budget burn rates.
- **AIOps & Root Cause Analysis:** Dynamic $3\sigma$ Z-score statistical baseline analysis detecting abnormal application spikes without static threshold guesswork.

---

## 2. Directory Structure

```text
enterprise-observability-poc/
├── alerts/
│   └── prometheus-alerts.yaml          # Prometheus Alert Rules definition
├── dashboards/
│   ├── 1-k8s-cluster-overview.json     # Cluster CPU, RAM, and Pod distribution
│   ├── 2-k8s-node-monitoring.json      # Node IOPS, Network, and Host Load
│   ├── 3-k8s-pod-monitoring.json       # Workload CPU, RAM, and Restarts
│   ├── 4-application-performance.json  # APM Golden Signals (RPS, Latency, 5xx)
│   ├── 5-infrastructure-health.json    # PVC storage, API latency, System load
│   ├── 6-slo-sla-management.json       # Availability SLI, Latency SLI, Burn Rate
│   └── 7-aiops-anomaly-detection.json  # Mean ± 2σ baseline & Z-score detection
├── documentation/
│   ├── README.md                       # Platform overview & Quickstart
│   ├── architecture.md                 # Deep-dive architecture & dataflow
│   ├── implementation-guide.md         # Step-by-step setup guide
│   ├── runbook.md                      # SRE troubleshooting procedures
│   └── test-report.md                  # Verification & end-to-end test evidence
├── helm/
│   ├── grafana-values.yaml             # Custom lightweight Grafana Helm values
│   ├── prometheus-values.yaml          # Custom Prometheus values with rules
│   └── prometheus-29.40.3.tgz          # Packaged Prometheus community chart
├── kql/
│   ├── 1-container-errors.kql          # KQL: Container stdout error analysis
│   ├── 2-pod-restarts.kql              # KQL: CrashLoopBackOff detection
│   ├── 3-application-failures.kql      # KQL: OOMKilled & Exit Code non-zero
│   ├── 4-node-resource-pressure.kql    # KQL: Perf table CPU and Memory trends
│   ├── 5-request-analysis.kql          # KQL: API server status code breakdown
│   └── 6-availability-analysis.kql      # KQL: Pod uptime availability SLI
├── otel/
│   └── otel-collector.yaml             # OTel Collector + Jaeger DaemonSet/Deploy
├── sample-app/
│   └── sample-app.yaml                 # Multi-replica microservice + Traffic generator
└── terraform/
    ├── aks.tf                          # AKS cluster + Container Insights + Diag Settings
    ├── log-analytics.tf                # Azure Log Analytics Workspace
    ├── main.tf                         # Resource Group definition
    ├── monitoring.tf                   # Azure Monitor Workspace (Managed Prometheus)
    ├── outputs.tf                      # Terraform export variables
    ├── providers.tf                    # AzureRM v4.81.0 provider
    ├── terraform.tfvars                # Region and naming parameters
    └── variables.tf                    # Input variable declarations
```

---

## 3. Quickstart: Port-Forwarding URLs

To access the local web UIs from your workstation, run the following PowerShell commands:

```powershell
# 1. Grafana Dashboard (Credentials: admin / Admin@Password123!)
kubectl port-forward -n monitoring svc/grafana 3000:80

# 2. Prometheus Expression Browser & Rule Status
kubectl port-forward -n monitoring svc/prometheus-server 9090:80

# 3. Jaeger Distributed Tracing UI
kubectl port-forward -n monitoring svc/jaeger 16686:16686

# 4. Sample Microservice UI
kubectl port-forward -n sample-app svc/sample-app 9898:80
```
