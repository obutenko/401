#!/bin/bash -xe

rm -rf rally .rally /root/openrc_tempest
cp /root/openrc /root/openrc_tempest

apt-get install -y git

git clone https://github.com/openstack/rally.git
cd rally
#use this if you have env with ssl
#echo "export OS_CACERT='/var/lib/astute/haproxy/public_haproxy.pem'" >> /root/openrc_tempest

git checkout 01a1b5fc6e242775d126a0f357ea91c38c783404

./install_rally.sh --branch 0.7.0 -d rally-venv/ -y

source /root/rally/rally-venv/bin/activate
source /root/openrc_tempest
rally-manage db recreate
rally deployment create --fromenv --name=tempest
rally verify install --version 2e7d0f026ec81540deef5fe2e4ddf84f484aaa37
rally verify genconfig
rally verify showconfig

