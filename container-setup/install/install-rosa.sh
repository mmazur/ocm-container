#!/bin/bash -e

if [ "$I_AM_IN_CONTAINER" != "I-am-in-container" ]; then
  echo "must be run in container";
  exit 1;
fi

echo "in container";

pushd /usr/local/bin
wget https://github.com/openshift/rosa/releases/download/${rosaversion}/rosa-linux-amd64 -O rosa
chmod a+rx rosa
rosa completion bash >  /etc/bash_completion.d/rosa
popd
