#!/bin/sh

set -e

echo "========================================="
echo "MongoDB Full Cluster Migration"
echo "========================================="

# Validate environment variables
if [ -z "$SOURCE_MONGO_URI" ]; then
    echo "[ERROR] SOURCE_MONGO_URI is not set"
    exit 1
fi

if [ -z "$DEST_MONGO_URI" ]; then
    echo "[ERROR] DEST_MONGO_URI is not set"
    exit 1
fi


echo "========================================="

# Create dump directory
DUMP_DIR="/tmp/mongo-dump"
mkdir -p $DUMP_DIR

# Dump entire cluster
echo "[INFO] Dumping entire cluster from source..."
mongodump --uri="$SOURCE_MONGO_URI" --out=$DUMP_DIR

echo "[INFO] Restoring entire cluster to destination..."
mongorestore --uri="$DEST_MONGO_URI" $DUMP_DIR --drop

echo "[INFO] Cleaning up temporary dump files..."
rm -rf $DUMP_DIR

echo "========================================="
echo "[SUCCESS] Full cluster migration completed!"
echo "========================================="