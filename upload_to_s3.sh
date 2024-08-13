#!/bin/bash

UPLOAD_DIR="/path/to/upload/directory"
BUCKET_NAME="my-website-uploads-<yourname>"
TIMESTAMP=$(date +"%Y-%m-%d-%H%M")

# Upload files to S3
aws s3 cp "$UPLOAD_DIR" "s3://$BUCKET_NAME/uploads/$TIMESTAMP/" --recursive

# Log the operation
if [ $? -eq 0 ]; then
    echo "$(date): Upload successful" >> /var/log/s3_upload.log
else
    echo "$(date): Upload failed" >> /var/log/s3_upload.log
fi

# Delete files older than one day
find "$UPLOAD_DIR" -type f -mtime +1 -exec rm {} \;
