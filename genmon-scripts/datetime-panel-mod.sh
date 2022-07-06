#!/usr/bin/env bash
# Modification of script example from @xtonousou
# https://github.com/xtonousou/xfce4-genmon-scripts
# Dependencies: bash>=3.2, coreutils, file, gawk, procps-ng

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Calculate datetime values
readonly TIME=$(LC_ALL=en_US.UTF-8 date +%I\:%M\ %p)
readonly DATE_FULL=$(LC_ALL=en_US.UTF-8 date +%A\ %d\ %B\ %Y)
readonly DATE=$(LC_ALL=en.US.UTF-8 date +%d\/%m\/%y)
#readonly CAL=$(cal)

# Panel

INFO="<txt>"
INFO+="${TIME}\n"
INFO+="${DATE}"
INFO+="</txt>"

# Tooltip
MORE_INFO="<tool>"
#MORE_INFO+="${CAL}\n"
MORE_INFO+="${DATE_FULL}"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
