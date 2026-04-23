---
title: "smo-o2"
date: 2024-01-01
tags: ["O-RAN", "Python", "StarlingX", "Kubernetes", "Thesis"]
summary: "Extended O2 IMS/DMS module for the OSC PTI-O2 project. Implements NFO and FOCOM modules contributed upstream via Gerrit. Deployed on StarlingX with OpenShift against a real O-Cloud lab."
category: "oran"
featured: true
featuredOrder: 1
eyebrow: "M.Sc. thesis — NTUST 2024"
externalUrl: "https://github.com/motangpuar/smo-o2"
showToc: false
---

The O2 interface sits between the SMO and the O-Cloud. This project extends the upstream
O-RAN Software Community PTI-O2 implementation with NFO and FOCOM modules I wrote during
my M.Sc. thesis at NTUST.

![Hello](/img/O2-service-perspective.drawio.png)
![](/img/O2-service-perspective.vnf.png)

The code was reviewed and merged via the OSC Gerrit process. It ran in the OSC Asia Pacific
lab against a StarlingX-based O-Cloud with OpenShift worker nodes.

Hello

**Stack:** Python, Flask, Robot Framework, Kubernetes, StarlingX, Tox
