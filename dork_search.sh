#!/bin/bash

domains="example.com acme-corp.com liferay.com exoscale.com snowbridge.io ourbit.com glia.com"

> all_results.txt

for domain in $domains; do
  query="site:*.$domain intext:\"drive.google.com\""
  url="https://www.google.com/search?q=$(echo $query | sed 's/ /+/g')"
  echo "Searching for: $domain"

  results=$(curl -A "Mozilla/5.0" -s "$url" | grep "drive.google.com")

  if [ -n "$results" ]; then
    echo
    echo "-----------------------------"
    echo "Google Drive found for: $domain"
    echo "$results"
    echo "-----------------------------"
    echo
    echo "Domain: $domain" >> all_results.txt
    echo "$results" >> all_results.txt
    echo "------------------" >> all_results.txt
  else
    echo "No Drive found for: $domain"
  fi

  sleep $((RANDOM % 5 + 3))
done

echo "Done! Full results are in all_results.txt"
