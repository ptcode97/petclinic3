#!/bin/bash

oc apply -f database-imagestream.yaml
oc apply -f database-build.yaml
oc apply -f db-data-persistentvolumeclaim.yaml
oc apply -f database-deploymentconfig.yaml
