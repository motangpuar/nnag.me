---
title: "o2-ims-worker"
date: 2024-01-03
tags: ["Go", "O-RAN", "O2 IMS", "Kubernetes"]
summary: "Go implementation of an O2 IMS worker. Handles IMS resource polling and state reconciliation against a Kubernetes-backed O-Cloud."
category: "oran"
parentProject: "smo-o2"
externalUrl: "https://github.com/motangpuar/o2-ims-worker"
showToc: false
---

A lightweight Go service that polls O2 IMS endpoints and reconciles resource state against
a Kubernetes cluster. Written in Go because the polling loop and concurrent reconciliation
benefit from goroutines without the overhead of a Python async framework.

**Stack:** Go, Kubernetes client-go, O2ims REST API
