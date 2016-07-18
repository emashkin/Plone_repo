#!/bin/bash
#  Licensed under the Apache License, Version 2.0 (the "License"); you may
#  not use this file except in compliance with the License. You may obtain
#  a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#  License for the specific language governing permissions and limitations
#  under the License.

exec &> /tmp/PloneInstallation.log

echo "Hello world. Starting Pl one installation."
echo "Current directory - "`cd "$( dirname "$0" )" && pwd`
echo "Installing all packages."
sudo apt-get update
sudo apt-get -y install python-setuptools python-dev build-essential libssl-dev libxml2-dev libxslt1-dev libbz2-dev libjpeg62-dev
sudo apt-get -y install libreadline-dev wv poppler-utils
echo "Installing Plone."

wget --no-check-certificate https://launchpad.net/plone/5.0/5.0.4/+download/Plone-5.0.4-UnifiedInstaller.tgz

tar -xvf Plone-5.0.4-UnifiedInstaller.tgz && echo "Tgz unarchieved."
cd Plone-5.0.4-UnifiedInstaller
./install.sh --password="admin" --instance="test_instance" standalone

echo "Starting up Plone."
cd /opt/plone/test_instance/
bin/plonectl start
echo "Plone started."
#sudo iptables -I INPUT 1 -p tcp -m tcp --dport 443 -j ACCEPT -m comment --comment "by murano, Apache server access on HTTPS port 443"
#sudo iptables -I INPUT 1 -p tcp -m tcp --dport 80 -j ACCEPT -m comment --comment "by murano, Apache server access on HTTP port 80"
