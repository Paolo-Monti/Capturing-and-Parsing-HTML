#!/usr/bin/bash

doc=$(curl -s https://deviceatlas.com/blog/list-of-user-agent-strings) && {echo "$doc" | pup 'td text{}' | grep -v bot} || echo Error
