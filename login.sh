#!/bin/bash

voms-proxy-init -voms vo.aginfra.eu
myproxy-init -d -n
glite-wms-job-delegate-proxy -a
