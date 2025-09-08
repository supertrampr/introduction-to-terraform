#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update && sudo apt-get -y install cifs-utils
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

az login --service-principal \
  -u ${sp_client_id} \
  -p ${sp_client_secret} \
  --tenant ${tenant_id} --allow-no-subscriptions

RESOURCE_GROUP_NAME="${resource_group_name}"
STORAGE_ACCOUNT_NAME="${storage_account_name}"
FILE_SHARE_NAME="${file_share_name}"
CREDENTIAL_ROOT="/etc/smbcredentials"
STORAGE_ACCOUNT_KEY=$(az storage account keys list \
  --resource-group $RESOURCE_GROUP_NAME \
  --account-name $STORAGE_ACCOUNT_NAME \
  --query "[0].value" --output tsv | tr -d '"')
SMB_CREDENTIAL_FILE="$CREDENTIAL_ROOT/$STORAGE_ACCOUNT_NAME.cred"
MNT_ROOT="/media"
MNT_PATH="$MNT_ROOT/$STORAGE_ACCOUNT_NAME/$FILE_SHARE_NAME"
HTTP_ENDPOINT=$(az storage account show --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --query "primaryEndpoints.file" --output tsv | tr -d '"')
SMB_PATH=$(echo $HTTP_ENDPOINT | cut -c7-$${#HTTP_ENDPOINT})$FILE_SHARE_NAME

sudo mkdir -p $MNT_PATH
sudo mkdir -p $CREDENTIAL_ROOT

if [ ! -f $$SMB_CREDENTIAL_FILE ]; then
    echo "username=$STORAGE_ACCOUNT_NAME" | sudo tee $SMB_CREDENTIAL_FILE > /dev/null
    echo "password=$STORAGE_ACCOUNT_KEY" | sudo tee -a $SMB_CREDENTIAL_FILE > /dev/null
else
    echo "The credential file $SMB_CREDENTIAL_FILE already exists, and was not modified."
fi

sudo chmod 600 $SMB_CREDENTIAL_FILE
sudo mount -t cifs $SMB_PATH $MNT_PATH -o credentials=$SMB_CREDENTIAL_FILE,serverino,nosharesock,actimeo=30,mfsymlinks