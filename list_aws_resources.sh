#!/bin/bash

#This script helps in listing desired resources across all regions.
#Can be improved and extended further.

# Get a list of all AWS regions
regions=$(aws ec2 describe-regions --query 'Regions[].RegionName' --output text)

# Process user choice using case statement
until [ "$choice" = "0" ]; do

    # Display menu options
    echo "Select the service to list in different regions:"
    echo "1. SNS Topics"
    echo "2. Lambda Functions"
    echo "3. EC2 Instances"
    echo "4. S3 Buckets"
    echo "0. Exit"

    # Read user input
    read choice

    case $choice in
    1)
        echo "Listing SNS Topics in different regions:"
        for region in $regions; do
            echo "Region: $region"
            aws sns list-topics --region $region
            echo "----------------------------------"
        done
        ;;
    2)
        echo "Listing Lambda Functions in different regions:"
        for region in $regions; do
            echo "Region: $region"
            aws lambda list-functions --region $region
            echo "----------------------------------"
        done
        ;;
    3)
        echo "Listing EC2 Instances in different regions:"
        for region in $regions; do
            echo "Region: $region"
            aws ec2 describe-instances --region $region
            echo "----------------------------------"
        done
        ;;
    4)
        echo "Listing S3 Buckets in different regions:"
        for region in $regions; do
            echo "Region: $region"
            aws s3 ls --region $region
            echo "----------------------------------"
        done
        ;;
    0)
        echo "Exiting."
        ;;
    *)
        echo "Invalid choice."
        ;;
    esac
done