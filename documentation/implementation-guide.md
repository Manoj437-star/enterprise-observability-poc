# Step-by-Step Implementation Guide

Follow this guide to deploy and operate the Unified Enterprise Observability Platform.

---

## Prerequisites
- **Workstation OS:** Windows 10/11 with PowerShell 7+
- **CLI Tools:**
  - Azure CLI (`az`) v2.50+
  - Kubernetes CLI (`kubectl`) v1.28+
  - Helm v3.10+
  - Terraform v1.5+
- **Azure Account:** Active Azure subscription with Contributor access.

---

## Step 1: Infrastructure as Code (Terraform)

Navigate to the terraform directory:
```powershell
Set-Location D:\DevOps\enterprise-observability-poc\terraform
```

Initialize provider plugins and modules:
```powershell
terraform init
```

Validate and format code:
```powershell
terraform fmt
terraform validate
```

Review execution plan:
```powershell
terraform plan
```

Apply infrastructure changes:
```powershell
terraform apply -auto-approve
```

---

## Step 2: Configure Kubernetes Access

Retrieve cluster credentials into your local kubeconfig:
```powershell
az aks get-credentials --resource-group rg-observability-poc --name aks-observability-poc --overwrite-existing
```

Verify node connectivity:
```powershell
kubectl get nodes -o wide
```

---

## Step 3: Deploy Metrics Stack (Prometheus)

Install Prometheus using the custom values file:
```powershell
helm install prometheus D:\DevOps\enterprise-observability-poc\helm\prometheus-29.40.3.tgz `
  -f D:\DevOps\enterprise-observability-poc\helm\prometheus-values.yaml `
  -n monitoring --create-namespace
```

Verify monitoring workloads and persistent storage:
```powershell
kubectl get pods,pvc -n monitoring
```

---

## Step 4: Deploy Visualization Stack (Grafana)

Add the Grafana chart repository:
```powershell
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

Install Grafana with automated Prometheus data source provisioning:
```powershell
helm install grafana grafana/grafana `
  -f D:\DevOps\enterprise-observability-poc\helm\grafana-values.yaml `
  -n monitoring
```

Import all 7 enterprise dashboards into the Grafana pod:
```powershell
$pod = (kubectl get pods -n monitoring -l "app.kubernetes.io/name=grafana" -o jsonpath="{.items[0].metadata.name}")

kubectl cp D:\DevOps\enterprise-observability-poc\dashboards\1-k8s-cluster-overview.json "monitoring/${pod}:/var/lib/grafana/dashboards/default/1-k8s-cluster-overview.json"
kubectl cp D:\DevOps\enterprise-observability-poc\dashboards\2-k8s-node-monitoring.json "monitoring/${pod}:/var/lib/grafana/dashboards/default/2-k8s-node-monitoring.json"
kubectl cp D:\DevOps\enterprise-observability-poc\dashboards\3-k8s-pod-monitoring.json "monitoring/${pod}:/var/lib/grafana/dashboards/default/3-k8s-pod-monitoring.json"
kubectl cp D:\DevOps\enterprise-observability-poc\dashboards\4-application-performance-monitoring.json "monitoring/${pod}:/var/lib/grafana/dashboards/default/4-application-performance-monitoring.json"
kubectl cp D:\DevOps\enterprise-observability-poc\dashboards\5-infrastructure-health.json "monitoring/${pod}:/var/lib/grafana/dashboards/default/5-infrastructure-health.json"
kubectl cp D:\DevOps\enterprise-observability-poc\dashboards\6-slo-sla-management.json "monitoring/${pod}:/var/lib/grafana/dashboards/default/6-slo-sla-management.json"
kubectl cp D:\DevOps\enterprise-observability-poc\dashboards\7-aiops-anomaly-detection.json "monitoring/${pod}:/var/lib/grafana/dashboards/default/7-aiops-anomaly-detection.json"
```

---

## Step 5: Deploy Sample Workload & Traffic Generator

Apply the microservice and traffic generator manifests:
```powershell
kubectl apply -f D:\DevOps\enterprise-observability-poc\sample-app\sample-app.yaml
```

Verify deployment status:
```powershell
kubectl get pods -n sample-app -o wide
```

---

## Step 6: Deploy OpenTelemetry Collector & Jaeger

Deploy OpenTelemetry Collector and the Jaeger back-end:
```powershell
kubectl apply -f D:\DevOps\enterprise-observability-poc\otel\otel-collector.yaml
```

Verify OpenTelemetry Collector trace ingestion logs:
```powershell
kubectl logs -n monitoring -l "app=otel-collector" --tail=20
```
