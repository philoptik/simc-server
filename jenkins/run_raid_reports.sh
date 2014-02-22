#!/bin/bash

# Gather cpu count, minus one.
#   One CPU is intentionally left unused to avoid overloading.
available_cpus=$(lscpu -p | tail -1 | cut -d , -f 1)

# If the count is 0, we'll have to use the single available CPU
if [ ${available_cpus} -lt 1 ]; then
  available_cpus=1
fi

# Allow whatever launches the script to override the CPU detection
if [ -n "${cpu_count_override}" ]; then
  available_cpus=${cpu_count_override}
fi

# Iterations
simc_iterations=10000
if [ -n "${simc_iterations_override}" ]; then
  simc_iterations=${simc_iterations_override}
fi

SIMC_CLI_PATH="/var/lib/jenkins/jobs/simc-raid-reports/workspace/engine"
SIMC_PROFILES_PATH="/var/lib/jenkins/jobs/simc-raid-reports/workspace/profiles"
SIMC_OUTPUT_PATH="/simc/reports"

${SIMC_CLI_PATH}/simc Raid_T15H.simc iterations=${simc_iterations} html=${SIMC_OUTPUT_PATH}/Raid_T15H.html threads=${available_cpus} hosted_html=1 > ${SIMC_OUTPUT_PATH}/Raid_T15H.txt
${SIMC_CLI_PATH}/simc Raid_T16H.simc iterations=${simc_iterations} html=${SIMC_OUTPUT_PATH}/Raid_T16H.html threads=${available_cpus} hosted_html=1 > ${SIMC_OUTPUT_PATH}/Raid_T16H.txt