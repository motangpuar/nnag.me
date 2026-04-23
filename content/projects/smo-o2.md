---
title: "Automated CI/CD Testing for O-RAN via O2 Infrastructure Management"
date: 2024-01-01
tags: ["O-RAN", "Python", "StarlingX", "Kubernetes", "Thesis"]
summary: "Extended O2 IMS/DMS module for the OSC PTI-O2 project. Implements NFO and FOCOM modules contributed upstream via Gerrit. Deployed on StarlingX with OpenShift against a real O-Cloud lab."
category: "oran"
featured: true
featuredOrder: 1
eyebrow: "M.Sc. thesis — NTUST 2024"
externalUrl: "https://github.com/motangpuar/smo-o2"
showToc: true
---

End-to-end 5G testing is hard. Deploying a gNB on real hardware, connecting it to a live
O-RU, running traffic, and collecting results requires coordinating multiple systems that
were never designed to talk to each other automatically. Before this work, every change to
a network function configuration meant manual intervention. An operator would re-tune CPU
allocation, re-deploy containers, and re-run tests by hand.

This framework removes that operator from the loop. It takes a set of test constraints as
input, turns them into deployment requests against an O-Cloud, runs over-the-air traffic
tests against a live O-RU, and collects resource profiling data from the gNB node. The
gNBs are OAI containers running on Kubernetes across two O-Cloud platforms, StarlingX and
OKD. The O-RUs are LiteON and Pegatron units using 7.2x fronthaul split.

## The Problem

![O-Cloud](/img/HPE-ORAN.png "O-RAN Deployment {{< cite id="oran-arch" >}}")

Manual 5G integration testing does not scale. A single configuration change (CPU
isolation, hugepage allocation, fronthaul bandwidth target) requires redeployment and
retesting by hand. On COTS hardware with diverse server profiles, every node needs
individual tuning. There was no mechanism to systematically vary these parameters, deploy
across multiple O-Cloud sites, and collect results without human involvement at each step.


The O-RAN O2 interface defines a standard way for the SMO to manage O-Cloud infrastructure
and deploy network functions. This work uses that interface as the automation boundary.
Everything south of the O2 is handled programmatically.

## What I Built

The pipeline starts with a REST API call to the rApp carrying a test descriptor. The rApp
translates that descriptor into deployment requests toward the NFO, which forwards them to
the target O-Cloud DMS. Once the gNB is up, the rApp sends an ADB command to the UE to
start iperf traffic. A sideload container running on the same node as the gNB measures CPU
and memory usage throughout the test. Results are collected and reported back to the CI/CD
stack.

![O-RAN Architecture](/img/O2-service-perspective.drawio.png "Full system: SMO, O2 interface, O-Cloud, and radio layer")

![VNF Deployment Flow](/img/O2-service-perspective.vnf.png "VNF deployment flow via NFO and DMS")

The test descriptor drives the entire run. It specifies the target O-RU and cell, the Helm
charts to deploy, the CPU cores to isolate, the traffic loads to test, and the duration of
each run.

```json
{
  "testId": "publish-my-own-case",
  "testType": "BANDWIDTH_SCALING",
  "description": "F1 split test - LiteON O-RU - Joule - CU/DU",
  "target": {
    "oduUrn": "urn:o-ran:gnb:joule-liteon",
    "cellUrn": "urn:o-ran:cell:joule-liteon",
    "sideloadInstanceId": "139d2f51-b3c2-4a94-a6a3-401464537f23",
    "cluster": "cc1397ba-b1c4-4a3e-bc8d-6af58ef53818"
  },
  "nf": [
    {
      "artifactName": "oai-cu",
      "artifactRepoUrl": "https://github.com/motangpuar/ocloud-helm-templates.git",
      "branch": "starlingx/liteon",
      "image": {
        "repository": "oaisoftwarealliance/oai-gnb-fhi72",
        "version": "2026.w04"
      },
      "extra": { "amfhost": "192.168.8.103" }
    },
    {
      "artifactName": "oai-du-fhi-72",
      "artifactRepoUrl": "https://github.com/motangpuar/ocloud-helm-templates.git",
      "branch": "starlingx/liteon",
      "image": {
        "repository": "oaisoftwarealliance/oai-gnb-fhi72",
        "version": "2026.w04"
      },
      "parameters": {
        "wr_isolcpus": [8, 14],
        "iperf_bandwidth_mbps": [100, 400, 700]
      },
      "baseline": {
        "wr_isolcpus": 10,
        "memory": "16Gi",
        "hugepages": "16Gi"
      }
    }
  ],
  "execution": {
    "runsPerCase": 1,
    "stabilizationTime": 30,
    "iperfDuration": 60
  }
}
```

## SMO Components

The SMO side consists of three components. NFO handles network function lifecycle over
O2dms. It takes the deployment descriptor from the rApp and translates it into Helm
releases on the target Kubernetes cluster.

{{< repo name="smo-o2" url="https://github.com/motangpuar/smo-o2/tree/master/nfo/k8s" desc="NFO module. Handles VNF deployment lifecycle over O2dms via Helm." tags="Python,O-RAN,StarlingX" >}}

FOCOM manages the O-Cloud infrastructure side over O2ims. It queries available computation
resources from each registered O-Cloud site and feeds that information into placement
decisions for each deployment.

{{< repo name="smo-o2-focom" url="https://github.com/motangpuar/smo-o2-focom" desc="FOCOM module. Queries O-Cloud resource inventory over O2ims." tags="Python,Flask,FOCOM,O2 IMS" >}}

The rApp is the CI/CD entry point. It is triggered by Jenkins on completion of a gNB build,
receives the test descriptor, and orchestrates the full pipeline. It handles deployment,
traffic testing, and result collection.

{{< repo name="cicd-rapp-client" url="https://github.com/motangpuar/cicd-rapp-client" desc="rApp CI/CD client. Orchestrates gNB deployment and over-the-air testing." tags="Python,CI/CD,rApp,O2" >}}

![Proposed CI/CD Pipeline](/img/Thesis-Proposed-Pipeline.png "Proposed CI/CD pipeline")

![rApp Contribution](/img/Thesis-Contribution-RAPP.png "rApp integration with the SMO")

## O-Cloud

Two O-Cloud platforms were used in this work to validate the framework across different
infrastructure stacks.

**StarlingX** is a distributed cloud platform optimized for low-latency edge workloads. It
was the primary platform in this work. The Pegatron O-RU achieved full end-to-end
connectivity on StarlingX across all tested configurations. CPU isolation and real-time
kernel tuning were stable throughout.

**OKD** (the community distribution of OpenShift) was the second target. SR-IOV
configuration and real-time kernel requirements introduced integration challenges that did
not appear on StarlingX. The LiteON O-RU showed failures at high bandwidth loads on this
platform.

## Sideloader

The sideload container runs directly on the same node as the gNB during each test run. It
is not part of the O2 flow. It operates independently, measuring CPU thread utilization,
memory consumption, and hugepage usage at the hardware level. This data is what makes the
experimental results meaningful. You can see exactly what the gNB is doing to the hardware
under each traffic load.

{{< repo name="ocloud-tester-sideload" url="https://github.com/motangpuar/ocloud-tester-sideload" desc="Sideload container for gNB resource profiling on O-Cloud nodes." tags="Docker,O-Cloud,Profiling" >}}

## Results

The framework successfully identified faulty combinations of expected traffic load and CPU
allocation when using 7.2x fronthaul split. Tests were run across two platforms, two O-RU
vendors, and three traffic targets.

| Platform | Deployment Split | O-RU | CPU Allocation | Traffic (Mbps) |
|---|---|---|---|---|
| OKD, StarlingX | Monolithic, F1, NFAPI | LiteON, Pegatron | 8, 14 cores | 100, 400, 700 |

![Experimental Results](/img/Thesis-Experimental-Results.png "Experimental Results")

The CPU affinity data from the sideloader shows thread distribution across cores during
active traffic. Where gNB threads spill onto non-isolated cores, throughput degrades at
higher bandwidth targets.

![CPU Affinity during test](/img/Thesis-Experimental-CPU-Affinity.svg "CPU Affinity during test, thread allocation")

## OSC Contribution

The NFO and FOCOM modules were submitted to the O-RAN Software Community PTI-O2 project
via Gerrit and merged upstream. The code ran in the OSC Asia Pacific lab against a
StarlingX-based O-Cloud with OpenShift worker nodes.

{{< refs >}}
{{< ref id="oran-arch" text="O-RAN Alliance. Architecture Description, 2023." url="https://o-ran.org" >}}
{{< ref id="hpe-oran" text="HPE. Open RAN Architecture Overview." url="https://hpe.com" >}}
{{< /refs >}}
