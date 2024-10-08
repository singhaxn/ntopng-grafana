#!/bin/sh

cd "$(dirname "$0")/.."
SRCDIR=$(pwd)
echo $SRCDIR

{
	cd "$SRCDIR/grafana/custom"
	
	wget "https://raw.githubusercontent.com/sapics/ip-location-db/refs/heads/main/asn/asn-ipv4.csv" -O asn-ipv4.csv
	# wget "https://raw.githubusercontent.com/sapics/ip-location-db/refs/heads/main/asn/asn-ipv6.csv" -O asn-ipv6.csv
	wget "https://standards-oui.ieee.org/oui/oui.csv" -O oui.csv
	
	sqlite3 lut.sqlite3.new < "$SRCDIR/scripts/import_lut.sql"
	
	mv lut.sqlite3 lut.sqlite3.bak
	mv lut.sqlite3.new lut.sqlite3
} 2>&1 | logger -s -t "update-luts"
