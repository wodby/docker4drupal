#!/bin/sh
docker run --rm -v ${PWD}:/var/www/html:cached wodby/base-python \
 /bin/bash -c "apk add --update npm python2 make g++ && npm install -g gulp \
 && cd /var/www/html/aadlorg/web/themes/custom/aadl && npm install --unsafe-perm"
