---
title: "ptp-agent"
date: 2024-01-05
tags: ["Shell", "PTP", "Docker", "5G", "gNB"]
summary: "Docker container that runs a PTP agent for gNB timing synchronization. Drop-in for 5G lab environments."
category: "tooling"
externalUrl: "https://github.com/motangpuar/ptp-agent"
showToc: false
---

5G radio units require sub-microsecond timing from a PTP grandmaster. This container
packages a PTP agent that syncs the gNB host clock, removing the need to configure the
host OS directly. Works with both software PTP and hardware-timestamping NICs.

**Stack:** Shell, linuxptp, Docker
