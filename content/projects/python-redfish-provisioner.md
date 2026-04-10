---
title: "python-redfish-provisioner"
date: 2024-01-04
tags: ["Python", "Redfish", "Bare Metal", "Infrastructure"]
summary: "Provisions COTS bare metal servers remotely via the Redfish API. No vendor tools required — works with any Redfish-compliant BMC."
category: "tooling"
externalUrl: "https://github.com/motangpuar/python-redfish-provisioner"
showToc: false
---

Bare metal provisioning in O-RAN labs usually involves proprietary vendor tooling tied to
a specific server make. This script talks directly to the Redfish BMC API, so it works
with any COTS server that exposes a standards-compliant Redfish endpoint.

**Stack:** Python, Redfish API (DMTF)
