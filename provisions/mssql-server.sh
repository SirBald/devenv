#!/bin/sh

# Password for the SA user (required)
MSSQL_SA_PASSWORD='SA_vagrant'

# Product ID of the version of SQL server you're installing
# Must be evaluation, developer, express, web, standard, enterprise, or your 25 digit product key
# Defaults to developer
MSSQL_PID='express'

# Install SQL Server Full Text Search (optional)
# SQL_INSTALL_FULLTEXT='y'


# Import the public repository GPG keys.
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
# Register the Microsoft SQL Server Ubuntu repository for SQL Server 2019.
add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list)"
add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/prod.list)"

# Install SQL Server.
apt-get update
apt-get install -y mssql-server

# Configure SQL Server.
MSSQL_SA_PASSWORD=$MSSQL_SA_PASSWORD MSSQL_PID=$MSSQL_PID /opt/mssql/bin/mssql-conf -n setup accept-eula

# Install additional developers tools.
ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev

BASHRC_FILE='/home/vagrant/.bashrc'
BASHRC_MSSQL_TOOLS_PATH='export PATH="$PATH:/opt/mssql-tools/bin"'
if ! grep -Fxq "${BASHRC_MSSQL_TOOLS_PATH}" "${BASHRC_FILE}"; then
  echo "\n" >> "${BASHRC_FILE}"
  echo "${BASHRC_MSSQL_TOOLS_PATH}" >> "${BASHRC_FILE}"
fi

# Optional SQL Server Full Text Search installation.
if [ ! -z $SQL_INSTALL_FULLTEXT ]; then
    apt-get install -y mssql-server-fts
fi

# Restart SQL Server after installing.
systemctl restart mssql-server
