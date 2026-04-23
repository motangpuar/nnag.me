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
stack: "Python, Flask, Robot Framework, Kubernetes, StarlingX, Tox"
---

The O2 interface sits between the SMO and the O-Cloud. This project extends the upstream
O-RAN Software Community PTI-O2 implementation with NFO and FOCOM modules I wrote during
my M.Sc. thesis at NTUST.

## OpenRAN
![O-Cloud](/img/HPE-ORAN.png "The O2 interface {{< cite id="oran-arch" >}} sits between the SMO and the O-Cloud.")

OpenRAN is a new paradigm where we try to rewrite how the telco industry should behave.

## O-Cloud
![O-Cloud](/img/Thesis-OCloud-Reference.png)

### StarlingX

### Openshift

## Automated
![Hello](/img/O2-service-perspective.drawio.png)
![VNF](/img/O2-service-perspective.vnf.png)
![Proposed Pipeline](/img/Thesis-Proposed-Pipeline.png)
![Proposed Pipeline](/img/Thesis-Contribution-RAPP.png)


{{< repo name="smo-o2" url="https://github.com/motangpuar/smo-o2/tree/master/nfo/k8s" desc="Extended O2 IMS/DMS module. NFO and FOCOM modules contributed upstream via Gerrit." tags="Python,O-RAN,StarlingX" >}}

{{< repo name="smo-o2-focom" url="https://github.com/motangpuar/smo-o2-focom" desc="MVP FOCOM implementation. Handles O-Cloud infrastructure orchestration via the O2ims provisioning interface." tags="Python, Flask, FOCOM, O2 IMS" >}}

{{< repo name="cicd-rapp-client" url="https://github.com/motangpuar/cicd-rapp-client" desc="Consumer rApp for automated gNB testing via the O2 O-Cloud interface. Triggers test suites against live radio equipment." tags="Python, CI/CD, rApp, O2" >}}

{{< repo name="ocloud-tester-sideload" url="https://github.com/motangpuar/ocloud-tester-sideload" desc="Sideload container for gNB profiling and fault injection on O-Cloud deployed workloads." tags="Docker, O-Cloud, Profiling" >}}


| Platform      | Deployment Split      | O-RU             | CPU Allocation | Traffic       |
| ---             | ---                     | ---                | ---              | ---             |
| OKD,StarlingX | Monolitich, F1, NFAPI | LiteON, Pegatron | 8,14         | 100,400,700 |

![Proposed Pipeline](/img/Thesis-Experimental-Results.png "Experimental Results")

![Proposed Pipeline](/img/Thesis-Experimental-CPU-Affinity.svg "CPU Affinity during test, thread allocation")


The code was reviewed and merged via the OSC Gerrit process. It ran in the OSC Asia Pacific
lab against a StarlingX-based O-Cloud with OpenShift worker nodes.

The O2 interface {{< cite id="oran-arch" >}} sits between the SMO and the O-Cloud.

{{< refs >}}
{{< ref id="oran-arch" text="O-RAN Alliance. Architecture Description, 2023." url="https://o-ran.org" >}}
{{< ref id="hpe-oran" text="HPE. Open RAN Architecture Overview." url="https://hpe.com" >}}
{{< /refs >}}


