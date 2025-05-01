# Define variables
LOCAL_ARCHIVE="rootfs-main.tar.gz"
REPO_URL="https://api.github.com/repos/ctOS-devs/rootfs/releases/latest"
VERSION_FILE="rootfs_version.txt"

# Function to download the latest release
download_latest() {
    curl -L -o "$LOCAL_ARCHIVE" "$DOWNLOAD_URL"
    if [ $? -eq 0 ]; then
    	if [ ! -d rootfs ]; then
    		mkdir rootfs
    	fi
        rm -rf rootfs/*
        tar -xf rootfs-main.tar.gz -C rootfs/
        EXTRACTED_DIR=$(find "rootfs" -mindepth 1 -maxdepth 1 -type d -name "ctOS-devs-rootfs-*")
        mv $EXTRACTED_DIR/* rootfs/
        rm -r $EXTRACTED_DIR rootfs-main.tar.gz
    else
        echo "Failed to download the latest release."
        return 1
    fi
}

# Check if the version file exists
if [ -f "$VERSION_FILE" ]; then
    LOCAL_VERSION=$(cat "$VERSION_FILE")

    # Check if the remote version is accessible
    if curl --output /dev/null --silent --head --fail "$REPO_URL"; then
        # Get the latest release information
        LATEST_INFO=$(curl -s "$REPO_URL")

        # Extract the latest version and download URL without jq
        LATEST_VERSION=$(echo "$LATEST_INFO" | grep -oP '"tag_name": "\K(.*?)(?=")')
        DOWNLOAD_URL=$(echo "$LATEST_INFO" | grep -oP '"tarball_url": "\K(.*?)(?=")')

        # Compare versions
        if [ "$LOCAL_VERSION" != "$LATEST_VERSION" ]; then
            download_latest
            echo $LATEST_VERSION > $VERSION_FILE
        fi
    fi
else
	LOCAL_VERSION=""
    # Check if the remote version is accessible
    if curl --output /dev/null --silent --head --fail "$REPO_URL"; then
        # Get the latest release information
        LATEST_INFO=$(curl -s "$REPO_URL")
        
        # Extract the latest version and download URL
        LATEST_VERSION=$(echo "$LATEST_INFO" | grep -oP '"tag_name": "\K(.*?)(?=")')
        DOWNLOAD_URL=$(echo "$LATEST_INFO" | grep -oP '"tarball_url": "\K(.*?)(?=")')
        
        download_latest
        echo $LATEST_VERSION > $VERSION_FILE
    else
    	# Error - can't download
        return 1
    fi
fi
