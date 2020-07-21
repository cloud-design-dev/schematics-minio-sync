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

/usr/local/bin/mc config host add destination-account https://s3.${destination_account_endpoint}.cloud-object-storage.appdomain.cloud ${destination_account_access_key} ${destination_account_secret_key}
/usr/local/bin/mc config host add source-account https://s3.${source_account_endpoint}.cloud-object-storage.appdomain.cloud ${source_account_access_key} ${source_account_secret_key}

## Generate new per boot copy job 
cat >/var/lib/cloud/scripts/per-boot/99-copy-buckets.sh <<EOL
#!/usr/bin/env bash 

/usr/local/bin/mc cp source-account destination-account 
EOL

chmod +x /var/lib/cloud/scripts/per-boot/99-copy-buckets.sh




