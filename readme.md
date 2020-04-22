# Grafana Dashboard for OTRS
This is my [Grafana](https://grafana.com/) Dashboard for [OTRS](https://community.otrs.com/).

The [install_grafana.sh](./install_grafana.sh) is a shell script for installing Grafana at CentOS 7.

### Example of install_grafana.sh output
![install_grafana_output](https://i.imgur.com/E4acDy6.png)

# Requirements
- Grafana v6
- Grafana Plugin "grafana-clock-panel"
  
# Import Dashboard
At Grafana:

1. Create > Import
2. Use the ID '12102' (without the quotes) or use the JSON file (paste the content or upload the file).

# Dashboard Screenshot
![Grafana Dashboard for OTRS](https://imgur.com/gJTbYQg.jpg)
