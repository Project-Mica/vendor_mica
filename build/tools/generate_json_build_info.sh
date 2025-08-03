#!/bin/bash
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
NC="\033[0m"

# The base URL where the file is hosted.
BASE_URL="https://dl.aswinaskurup.xyz/MicaOS/${device_code}"


findPayloadOffset() {
    build=$1
    info=$(zipdetails "$build")
    foundBin=0
    while IFS= read -r line; do
        if [[ $foundBin == 1 ]]; then
            echo "$line" | grep -q "PAYLOAD"
            res=$?
            if [[ $res == 0 ]]; then
                hexNum=$(echo "$line" | cut -d ' ' -f1)
                echo $(( 16#$hexNum ))
                break
            fi
            continue
        fi
        echo "$line" | grep -q "payload.bin"
        res=$?
        [[ $res == 0 ]] && foundBin=1
    done <<< "$info"
}

if ! [ "$1" ]; then
    echo -e "${RED}No file provided${NC}"
    if ! return 0 &> /dev/null; then
        exit 0
    fi
fi

file_path=$1
file_dir=$(dirname "$file_path")
file_name=$(basename "$file_path")

if ! [ -f "$file_path" ]; then
    echo -e "${RED}File does not exist${NC}"
    if ! return 0 &> /dev/null; then
        exit 0
    fi
fi

# Use MICA_EDITION for the filename.
if [ -n "${MICA_EDITION}" ]; then
    edition=$(echo "${MICA_EDITION}" | tr '[:upper:]' '[:lower:]')
    output_filename="full_${edition}.json"
else
    
    if ! return 0 &> /dev/null; then
        exit 1
    fi
fi


# Calculate the MD5 checksum
# Use md5sum for Linux, or md5 for macOS/BSD
md5_hash=$(md5sum "$file_path" | awk '{print $1}')
if [ -z "$md5_hash" ]; then
    # Fallback for macOS/BSD
    md5_hash=$(md5 -q "$file_path")
fi

echo -e "${GREEN}Generating JSON file: ${YELLOW}${output_filename}${NC}"

isPayload=0
[ -f payload_properties.txt ] && rm payload_properties.txt
if unzip "$file_path" payload_properties.txt; then
    isPayload=1
    offset=$(findPayloadOffset "$file_path")
    keyPairs=$(cat payload_properties.txt | sed "s/=/\": \"/" | sed 's/^/            \"/' | sed 's/$/\"\,/')
    keyPairs=${keyPairs%?}
fi

datetime=$(date +%s)

# Start building the JSON file
{
    echo "{"
    echo "  \"response\": ["
    echo "    {"
    echo "      \"datetime\": ${datetime},"
    echo "      \"filename\": \"${file_name}\","
    echo "      \"url\": \"${BASE_URL}${file_name}\","
    echo -n "      \"md5\": \"${md5_hash}\""
} > "${file_dir}/${output_filename}"

# Conditionally add the payload section
if [[ $isPayload == 1 ]]; then
    {
        echo ","
        echo "      \"payload\": ["
        echo "        {"
        echo "          \"offset\": ${offset},"
        echo "${keyPairs}"
        echo "        }"
        echo "      ]"
    } >> "${file_dir}/${output_filename}"
fi

# Close the JSON structure
{
    echo "    }"
    echo "  ]"
    echo "}"
} >> "${file_dir}/${output_filename}"


echo -e "${GREEN}OTA JSON generated and saved as ${YELLOW}${output_filename}${NC}"
