#!/bin/bash
podman image rm web4crm:latest -f
podman build -f web4crm_Containerfile --tag web4crm:latest
