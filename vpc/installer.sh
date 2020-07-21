#!/usr/bin/env bash

## Update machine
DEBIAN_FRONTEND=noninteractive apt -qqy update
DEBIAN_FRONTEND=noninteractive apt-get -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' dist-upgrade
DEBIAN_FRONTEND=noninteractive apt-get -qqy install wget curl build-essential

## Add minio client user 
useradd --system minio-user --shell /sbin/nologin

## Install minio client 
wget https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc
mv mc /usr/local/bin
chown minio-user:minio-user /usr/local/bin/mc 

# /usr/local/bin/mc config host add destination-account https://s3.direct.${destination_account_endpoint}.cloud-object-storage.appdomain.cloud ${destination_account_access_key} ${destination_account_secret_key}
# /usr/local/bin/mc config host add source-account https://s3.direct.${source_account_endpoint}.cloud-object-storage.appdomain.cloud ${source_account_access_key} ${source_account_secret_key}


crontime=`date -d '+1 hour' '+%H'`

cat >mc.json <<EOL
{
	"version": "9",
	"hosts": {
		"destination-account": {
			"url": "https://s3.direct.${destination_account_endpoint}.cloud-object-storage.appdomain.cloud",
			"accessKey": "${destination_account_access_key}",
			"secretKey": "${destination_account_secret_key}",
			"api": "s3v4",
			"lookup": "auto"
		},
		"source-account": {
			"url": "https://s3.direct.${source_account_endpoint}.cloud-object-storage.appdomain.cloud",
			"accessKey": "${source_account_access_key}",
			"secretKey": "${source_account_secret_key}",
			"api": "s3v4",
			"lookup": "auto"
		}
	}
}
EOL



cat >/root/copy-buckets.sh <<EOL
#!/usr/bin/env bash
dt=`date "+%Y%m%d%H%M"`
logfile=/tmp/"`date "+%Y%m%d%H%M"`-log"
/usr/local/bin/mc cp source-account/${source_account_bucket} destination-account/${destination_account_bucket} 
EOL

chmod +x /root/copy-buckets.sh




