#!/bin/bash -e

if [ "$I_AM_IN_CONTAINER" != "I-am-in-container" ]; then
  echo "must be run in container";
  exit 1;
fi

echo "in container";

pushd /usr/local/bin
wget https://github.com/openshift-online/ocm-cli/releases/download/${ocmversion}/ocm-linux-amd64 -O ocm
chmod a+rx ocm
ocm completion > /etc/bash_completion.d/ocm
popd
