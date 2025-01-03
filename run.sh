#!/bin/bash

# Cek apakah Lighthouse sudah terinstall
if ! command -v lighthouse &> /dev/null; then
    echo "Lighthouse is not installed. Please install Lighthouse first."
    echo "npm install -g lighthouse"
    exit
fi

# Konfigurasi default
HEADLESS="--chrome-flags='--headless'"
USERAGENT='--emulatedUserAgent="Chrome-Lighthouse"'

# Meminta input dari pengguna
read -p "Enter the URL to test: " URL
read -p "Enter the number of iterations: " ITERATIONS
read -p "Use Chrome Headless? (Y/n): " IS_HEADLESS
read -p "Use emulated user agent? (Y/n): " IS_USER_AGENT

# Memeriksa apakah URL dan ITERATIONS tidak kosong
if [ -z "$URL" ] || [ -z "$ITERATIONS" ]; then
    URL="https://www.telkomsel.com/"
    ITERATIONS=1
fi

# Memeriksa apakah IS_HEADLESS adalah "n" atau "N"
if [ "$IS_HEADLESS" = "n" ] || [ "$IS_HEADLESS" = "N" ]; then
    HEADLESS=""
fi

# Memeriksa apakah IS_USER_AGENT adalah "n" atau "N"
if [ "$IS_USER_AGENT" = "N" ] || [ "$IS_USER_AGENT" = "n" ]; then
    USERAGENT=""
fi

# Membuat folder laporan
mkdir -p ./reports
cd ./reports

# Loop untuk menjalankan Lighthouse
for ((i=1; i<=ITERATIONS; i++)); do
    echo "Running Lighthouse Test #$i on $URL..."
    lighthouse "$URL" --form-factor=desktop --preset=desktop --view=true $HEADLESS $USERAGENT
done

echo "All tests completed."
