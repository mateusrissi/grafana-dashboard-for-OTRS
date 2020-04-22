#!/usr/bin/bash


# install_grafana.sh - Install Grafana

# Site:       https://www.linkedin.com/in/mateusrissi/
# Author:     Mateus Rissi

#  This script will install Grafana and create a user at the choosen database.
#
#  Examples:
#      # ./install_grafana.sh

# History:
#   v1.0.0 22/04/2020, Mateus:
#       - Start
#       - Funcionalities

# Tested on:
#   bash 4.2.46
# --------------------------------------------------------------------------- #


# VARIABLES
read -r -d '' grafana_repo_content <<'EOF'
[grafana]
name=grafana
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
EOF

tasks_to_execute="
    create_grafana_repo
    install_grafana_dependencies
    install_grafana
    enable_grafana
    install_grafana_clock_panel
    create_grafana_user_mysql
"

install_grafana_log_file="/var/log/install_grafana_log_file.txt"
random_passwd="$(date +%s | sha256sum | base64 | head -c 32)"

database_passwd="YjBkYTlhYzVhY2U3NDUzYjVhOTVkOGUy"
database_name="otrs"
database_table_name="*"

red="\033[31;1m"
green="\033[32;1m"
no_color="\033[0m"

read -r -d '' info_to_show <<EOF
==================================================================
    MYSQL grafana@localhost: $random_passwd

    Grafana Login: admin
    Grafana Password: admin
==================================================================
EOF


# FUNCTIONS
create_grafana_repo() {
    echo "${grafana_repo_content}" > /etc/yum.repos.d/grafana.repo
}

install_grafana_dependencies() {
    yum check-update
    yum -y install fontconfig
    yum -y install freetype*
    yum -y install urw-fonts
}

install_grafana() {
    yum check-update
    yum -y install grafana
}

enable_grafana() {
    systemctl daemon-reload
    systemctl enable grafana-server
    systemctl start grafana-server
}

install_grafana_clock_panel() {
    grafana-cli plugins install grafana-clock-panel
    systemctl restart grafana-server
}

create_grafana_user_mysql() {
    mysql -u root -p$database_passwd -e "create user 'grafana'@'localhost' identified by '"${random_passwd}"';"
    mysql -u root -p$database_passwd -e "grant select on ${database_name}.${database_table_name} to 'grafana'@'localhost';"
    mysql -u root -p$database_passwd -e "flush privileges;"
}

# EXEC
for task in $tasks_to_execute; do

    echo "Running ${task}... "

    $task >> $install_grafana_log_file 2>&1

    if [ $? -eq 0 ]; then
        echo -e "${green}ok${no_color}\n"
    else
        echo -e "${red}fail${no_color}\n"
    fi
done

echo "$info_to_show"

# This still does not work. It's a attempt of importing a dashboard (JSON file) through the CLI.
#curl -X POST -H "Content-Type: application/json" -d '{"name":"apikey", "role": "Admin"}' http://admin:admin@localhost:3000/api/auth/keys > api_key.txt
#api_key="$(cut -d "\"" -f 8 api_key.txt)"
#curl -X POST --insecure -H "Authorization: Bearer ${api_key}" -H "Content-Type: application/json" -d @grafana-dashboard.json http://localhost:3000/api/dashboards/import
