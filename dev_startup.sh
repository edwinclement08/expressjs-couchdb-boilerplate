#!/bin/sh
rm -rf /usr/src/app/node_modules/*
ln -s /usr/src/_temp/node_modules/* /usr/src/app/node_modules

nodemon --inspect=0.0.0.0 ./bin/www
