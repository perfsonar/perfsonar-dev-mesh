# pScheduler Self-Updating Limit Configuration

The files in this directory configure pScheduler with a limit configuration that
downloads a list of hosts considered friendly (i.e., those in the test bed) and
installs a script that keeps it up to date using a cron job.

## Installation
```
# git clone https://github.com/perfsonar/perfsonar-dev-mesh.git
# make -C perfsonar-dev-mesh/pscheduler install
```

## Removal
```
# make -C perfsonar-dev-mesh/pscheduler uninstall
```
