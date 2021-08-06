#!/bin/bash

echo 'what script will install environments and dependency for optimum platform on CentOS'

yum install -y psmisc ICU unzip zip
yum update -y
mkdir /usr/bin/dotnet
mv dotnet-runtime-3.1.6-linux-x64.tar.gz /usr/bin/dotnet
tar -xf /usr/bin/dotnet/dotnet-runtime-3.1.6-linux-x64.tar.gz
echo -e 'export DOTNET_ROOT=/usr/bin/dotnet\nPATH = $PATH:/usr/bin/dotnet' | tee  /etc/profile.d/dotnet.sh

firewall-cmd --permanent --add-port=5001/tcp
firewall-cmd --permanent --add-port=11126/tcp
firewall-cmd --reload

echo 'environments and dependency for optimum platform have been installed, proceed to install platform by running install-D-x.x.xx.sh script'