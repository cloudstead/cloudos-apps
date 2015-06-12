#!/bin/bash

BASE=$(cd $(dirname $0) && pwd)
${BASE}/../cloudos-appstore/bin/mcbundle ${BASE}/apps
