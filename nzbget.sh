#!/bin/bash

exec /sbin/setuser nobody nzbget -c /config/nzbget.conf -s
