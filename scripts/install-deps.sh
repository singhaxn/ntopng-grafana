#!/bin/sh

cd "$(dirname "$0")/.."
SRCDIR=$(pwd)
echo $SRCDIR

mkdir -p grafana/data/plugins grafana/custom redis/data influxdb/data ntopng
chmod -R 777 grafana

# Download sqlite3 plugin for grafana
# required because the grafana container won't have internet access
cd grafana/data/plugins/
rm -rf frser-sqlite-datasource.zip frser-sqlite-datasource
wget "https://grafana.com/api/plugins/frser-sqlite-datasource/versions/3.5.0/download" -O frser-sqlite-datasource.zip
unzip frser-sqlite-datasource.zip

$SRCDIR/scripts/update-luts.sh
