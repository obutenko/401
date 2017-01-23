#!/bin/bash -xe
source /root/rally/rally-venv/bin/activate
for i in {1..10}; do
    mkdir /root/run-$i && \
    rally verify start --regex tempest.api.identity --concurrency 8 > /root/run-$i/tests.log && \
    rally verify results --html --output-file /root/run-$i/result.html
done
