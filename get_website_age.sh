#!/bin/bash

# Author: @tamecalm on Instagram
# Description: This script retrieves the age and details of a website and exports the results to an HTML file.

# Function to display usage information
usage() {
    echo "Usage: $0"
    exit 1
}

# Ask for the website input
read -p "Please enter the website domain (e.g., example.com): " DOMAIN

# Check if the input is empty
if [ -z "$DOMAIN" ]; then
    echo "Error: No domain provided."
    usage
fi

# Function to get website age and details
get_website_age() {
    echo "Retrieving information for: $DOMAIN"

    # Check if whois command is available
    if ! command -v whois &> /dev/null; then
        echo "Error: 'whois' command not found. Please install it to continue."
        exit 1
    fi

    # Use whois to get the registration date and other details of the domain
    WHOIS_OUTPUT=$(whois "$DOMAIN")

    # Check if we retrieved whois data successfully
    if [ -z "$WHOIS_OUTPUT" ]; then
        echo "Error: Unable to retrieve information for $DOMAIN."
        return 1
    fi

    # Extract the creation date from the output
    CREATION_DATE=$(echo "$WHOIS_OUTPUT" | grep -i 'Creation Date\|Created\|Registered On' | head -n 1)
    EXPIRATION_DATE=$(echo "$WHOIS_OUTPUT" | grep -i 'Expiration Date\|Expires On' | head -n 1)
    STATUS=$(echo "$WHOIS_OUTPUT" | grep -i 'Domain Status' | head -n 1)

    # Check if we retrieved the creation date successfully
    if [ -z "$CREATION_DATE" ]; then
        echo "Error: Unable to retrieve registration date for $DOMAIN."
        return 1
    fi

    # Extract creation date
    CREATION_DATE=$(echo "$CREATION_DATE" | awk '{for(i=3;i<=NF;i++) printf $i " "; print ""}')
    
    # Extract expiration date
    EXPIRATION_DATE=$(echo "$EXPIRATION_DATE" | awk '{for(i=3;i<=NF;i++) printf $i " "; print ""}')
    
    # Convert creation and expiration dates to timestamps
    CREATION_TIMESTAMP=$(date -d "$CREATION_DATE" +%s)
    EXPIRATION_TIMESTAMP=$(date -d "$EXPIRATION_DATE" +%s)
    CURRENT_TIMESTAMP=$(date +%s)

    # Calculate the age of the website in years, months, and days
    AGE_YEARS=$(( (CURRENT_TIMESTAMP - CREATION_TIMESTAMP) / (365*24*60*60) ))
    AGE_MONTHS=$(( ((CURRENT_TIMESTAMP - CREATION_TIMESTAMP) % (365*24*60*60)) / (30*24*60*60) ))
    AGE_DAYS=$(( ((CURRENT_TIMESTAMP - CREATION_TIMESTAMP) % (30*24*60*60)) / (24*60*60) ))

    # Prepare HTML output
    HTML_OUTPUT="website_info.html"
    {
        echo "<!DOCTYPE html>"
        echo "<html lang='en'>"
        echo "<head>"
        echo "    <meta charset='UTF-8'>"
        echo "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
        echo "    <title>Website Age Information</title>"
        echo "    <style>"
        echo "        body { font-family: 'Arial', sans-serif; margin: 0; padding: 20px; background-color: #f4f4f9; color: #333; }"
        echo "        h1 { color: #4a4a4a; text-align: center; }"
        echo "        .container { max-width: 800px; margin: auto; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); background: white; }"
        echo "        .info { margin-bottom: 20px; padding: 10px; border: 1px solid #eaeaea; border-radius: 5px; }"
        echo "        footer { text-align: center; margin-top: 20px; }"
        echo "        a { color: #007bff; text-decoration: none; }"
        echo "        a:hover { text-decoration: underline; }"
        echo "    </style>"
        echo "</head>"
        echo "<body>"
        echo "    <div class='container'>"
        echo "        <h1>Website Age Information</h1>"
        echo "        <div class='info'>"
        echo "            <strong>Website:</strong> $DOMAIN<br>"
        echo "            <strong>Creation Date:</strong> $CREATION_DATE<br>"
        echo "            <strong>Expiration Date:</strong> $EXPIRATION_DATE<br>"
        echo "            <strong>Domain Status:</strong> $(echo "$STATUS" | awk '{for(i=3;i<=NF;i++) printf $i " "; print ""}')<br>"
        echo "            <strong>Age of Website:</strong> $AGE_YEARS year(s), $AGE_MONTHS month(s), and $AGE_DAYS day(s)<br>"
        echo "        </div>"
        echo "        <footer>"
        echo "            <p>Author: <a href='https://instagram.com/tamecalm' target='_blank'>@tamecalm</a> on Instagram</p>"
        echo "        </footer>"
        echo "    </div>"
        echo "</body>"
        echo "</html>"
    } > "$HTML_OUTPUT"

    echo "Website information has been saved to $HTML_OUTPUT"
}

# Get the age of the provided domain
get_website_age "$DOMAIN"
