# Elasticsearch cluster on Kubernetes
 
This repository contains a solution to deploy an Elasticsearch cluster with a Kibana user interface to Kubernetes. Solution is offered in the form of a Helm chart and describes a 7.X-compatible highly-available, resilient Elasticsearch cluster with a Kibana frontend.
 
## Prerequisites
You need to have the following tools installed on your machine to deploy a solution to Kubernetes.
 
[Helm v3.X](https://helm.sh/docs/intro/install/) - package manager for Kubernetes to install Elasticsearch.
 
[Kubectl v1.25](https://kubernetes.io/docs/tasks/tools/#kubectl) - The Kubernetes command-line tool that will assist in handling authentication to the cluster
 
 
## Installation
 
1. Clone the repository
2. Ensure that you have access to the Kubernetes cluster via [kubeconfig](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/) file.
 
**GCP Example**: Authenticating to *GKE* cluster:
 
```bash
gcloud container clusters get-credentials <cluster-name> --region <cluster-region>
```

**AWS Example**: Authenticating to *EKS* cluster:
```bash
aws eks --region <cluster-region> update-kubeconfig --name <cluster_name>
```
 
3. Create a new namespace for the solution:
```bash
kubectl create namespace <installation_namespace>
```
**NOTE:** This step depends on your technical requirements. You can also leverage any existing namespace in your cluster.
 
4. Install the release using Helm:
```bash
helm upgrade --install elasticsearch ./elasticsearch -n <installation_namespace>
```
5. You can test that the Elasticsearch is healthy and can accept data by running tests:
```bash
helm test elasticsearch
```
**NOTE:** Test should return *Phase:Succeeded* status
 
## Design Decisions
 
**Helm** - Helm was used to pack the installation. Helm is a useful tool to combine several Kubernetes manifests in one logical unit, and centrally control variables passed to said manifests. Helm also allows adding custom logic in terms of functions and templates that make the solution more customizable. Tests can also be defined and executed as a part of the Helm pipeline.
 
**Replica count** - Solution is designed to start Elasticsearch nodes with the same Elasticsearch roles which means that all nodes are master-eligible and can be elected as a new master. Generally, it's not recommended to have more than 3 master nodes in any cluster due to possible complexity and lag it will introduce, so the amount of replicas is set to 3. This solution implies that given a requirement to scale out to more than 3 nodes, this approach would be refactored and 3 dedicated master nodes will be deployed.
 
**Stateful Set** - is used as a controller for Elasticsearch deployment due to the stateful nature of the application. We need to have a persistent mapping between the processing unit in a form of pod and a storage for Elasticsearch to function correctly.

**Pod Disruption Budget** - is set up to limit the amount of pods that can be down during the voluntary disruption to the service to increase resiliency of the Elasticsearch cluster.

**Anti affinity** - is used to spread the Elasticsearch nodes across the Kubernetes nodes and increase the availability of the application. This setting ensures the application can function in case of hardware issue with one of the nodes.