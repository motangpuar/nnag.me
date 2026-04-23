---
title: "cicd-rapp-client"
date: 2024-01-06
tags: ["Python", "CI/CD", "O-RAN", "rApp", "O2"]
summary: "Consumer rApp for automated gNB testing via the O2 O-Cloud interface. Triggers test runs on real radio equipment as part of a CI/CD pipeline."
category: "oran"
parentProject: "smo-o2"
externalUrl: "https://github.com/motangpuar/cicd-rapp-client"
showToc: false
---

Part of a CI/CD pipeline that runs automated tests against a live gNB deployment. The
rApp subscribes to the O2 interface, detects deployment events, and triggers test suites
on the deployed radio unit.

**Stack:** Python, O2 O-Cloud API, Jenkins
