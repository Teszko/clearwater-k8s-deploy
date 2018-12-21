#!/bin/bash

ip="130.149.212.95"
rate=5
bono_uri="default.svc.cluster.local:5060"

sipp "$bono_uri" -t t1 -sf sipp_register_basic.xml -inf auth_data.csv -i "$ip" -trace_shortmsg -r "$rate"
