#!/bin/bash

#This script helps to communicate and retrieve information from GitHub

# Prompt user for Personal Access Token (PAT)
read -s -p "Enter your Personal Access Token: " PAT

# Prompt for API endpoint
read -p "Enter the GitHub API endpoint you want to access: " API_ENDPOINT

API="https://api.github.com/${API_ENDPOINT}"

# Make the GitHub API call and display repository URLs
response=$(curl -s -H "Authorization: token ${PAT}" ${API})

# Check if the response is JSON and contains an array
if jq -e '. | if type == "array" then true else false end' <<< "$response" >/dev/null; then
    # Display array items as repository URLs
    jq -r '.[] | .html_url' <<< "$response"
else
    # Display full response
    echo "$response"
fi
