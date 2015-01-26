#!/bin/bash

BASE=$(cd $(dirname $0) && pwd)
../cloudos-appstore/bin/cbundler ${BASE}/apps
