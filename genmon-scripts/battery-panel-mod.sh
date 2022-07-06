#!/usr/bin/env bash
# Modification of script example from @xtonousou
# https://github.com/xtonousou/xfce4-genmon-scripts
# Dependencies: acpi, bash>=3.2, coreutils, file, gawk, grep, xfce4-power-manager

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# As of Linux kernel 2.6.x you need to use /sys/class/power_supply/BATX (X=integer)
readonly MANUFACTURER=$(awk '{print $1}' /sys/class/power_supply/BAT*/manufacturer)
readonly MODEL=$(awk '{print $1}' /sys/class/power_supply/BAT*/model_name)
readonly SERIAL_NUMBER=$(awk '{print $1}' /sys/class/power_supply/BAT*/serial_number)
readonly TECHNOLOGY=$(awk '{print $1}' /sys/class/power_supply/BAT*/technology)
readonly TYPE=$(awk '{print $1}' /sys/class/power_supply/BAT*/type)
readonly ENERGY_FULL=$(awk '{$1 = $1 / 1000000; print $1}' /sys/class/power_supply/BAT*/energy_full)
readonly ENERGY_DESIGN=$(awk '{$1 = $1 / 1000000; print $1}' /sys/class/power_supply/BAT*/energy_full_design)
readonly ENERGY=$(awk '{$1 = $1 / 1000000; print $1}' /sys/class/power_supply/BAT*/energy_now)
readonly VOLTAGE=$(awk '{$1 = $1 / 1000000; print $1}' /sys/class/power_supply/BAT*/voltage_now)
readonly RATE=$(awk '{$1 = $1 / 1000000; print $1}' /sys/class/power_supply/BAT*/power_now)
readonly BATTERY=$(awk '{print $1}' /sys/class/power_supply/BAT*/capacity)
readonly TEMPERATURE=$(acpi -t | awk '{print $4}')
readonly TIME_UNTIL=$(acpi | awk '{print $5}')

if hash xfce4-power-manager-settings &> /dev/null; then
  INFO+="<click>xfce4-power-manager-settings</click>"
fi

INFO+="<txt>"
if acpi -a | grep -i "off-line" &> /dev/null; then # if AC adapter is offline
  if [ "${BATTERY}" -lt 10 ]; then # if battery is less than 10%
    INFO+="<span weight='Bold' fgcolor='White' bgcolor='Red'>" # make the text bold red
  else
    INFO+="<span weight='Regular' fgcolor='White'>" # make the text white
  fi
elif acpi -a | grep -i "on-line" &> /dev/null; then # if AC adapter is online
  INFO+="<span weight='Bold' fgcolor='Light Green'>" # make the text bold light green
else # if battery is in unknown state (no battery at all, throttling, etc.)
  INFO+="<span weight='Bold' fgcolor='Yellow'>" # make the text bold yellow
fi
INFO+="${BATTERY}%"
INFO+="</span>"
INFO+="</txt>"

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="┌ ${MANUFACTURER} ${MODEL}\n"
MORE_INFO+="├─ Serial number: ${SERIAL_NUMBER}\n"
MORE_INFO+="├─ Technology: ${TECHNOLOGY}\n"
MORE_INFO+="├─ Temperature: +${TEMPERATURE}℃\n"
MORE_INFO+="├─ Energy: ${ENERGY} Wh\n"
MORE_INFO+="├─ Energy when full: ${ENERGY_FULL} Wh\n"
MORE_INFO+="├─ Energy (design): ${ENERGY_DESIGN} Wh\n"
MORE_INFO+="├─ Rate: ${RATE} W\n"
if acpi -a | grep -i "off-line" &> /dev/null; then # if AC adapter is offline
  if [ "${BATTERY}" -eq 100 ]; then # if battery is fully charged
    MORE_INFO+="└─ Voltage: ${VOLTAGE} V"
  else
    MORE_INFO+="└─ Remaining Time: ${TIME_UNTIL}"
  fi
elif acpi -a | grep -i "on-line" &> /dev/null; then # if AC adapter is online
  if [ "${BATTERY}" -eq 100 ]; then # if battery is fully charged
    MORE_INFO+="└─ Voltage: ${VOLTAGE} V"
  else
    MORE_INFO+="└─ Time to fully charge: ${TIME_UNTIL}"
  fi
else # if battery is in unknown state (no battery at all, throttling, etc.)
  MORE_INFO+="└─ Voltage: ${VOLTAGE} V"
fi
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
