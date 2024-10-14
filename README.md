# primitive-core-monitor

For use with [Datadog](https://www.datadoghq.com/).

## Setup


1. clone repo
2. `sudo cp systemd/primitive_core_monitor.service /etc/systemd/system/`
3. `sudo systemctl daemon-reload`
4. `sudo systemctl start primitive_core_monitor.service`
5. `sudo systemctl enable primitive_core_monitor.service`
6. `sudo systemctl status primitive_core_monitor.service`
