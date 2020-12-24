#!/usr/bin/bash

curl -s https://deviceatlas.com/blog/list-of-user-agent-strings | pup 'td text{}' | grep -v bot
