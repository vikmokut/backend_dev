#! /bin/bash

today=$(date +%Y%m%d)
weather_report=raw_data_$today
city=casablanca

curl wttr.in/$city --output $weather_report

grep °C $weather_report > temperatures.txt

# extract the current temperature
#obs_tmp=$(cat -A temperatures.txt | head -1 | cut -d "+" -f2 | cut -d "m" -f5 | cut -d "^" -f1 )
#echo "observed temperature = $obs_tmp"

obs_temp=$(cat -A temperatures.txt | head -1 | cut -d"+" -f2 | cut -d"^" -f1)
echo "observed temperature = $obs_temp"

fc_temp=$(cat -A temperatures.txt | head -3 | tail -1 | cut -d"+" -f2 | cut -d"^" -f1)
echo "forecasted temperature = $fc_temp"

TZ='Morocco/Casablanca'

hour=$(TZ='Morocco/Casablanca' date -u +%H) 
day=$(TZ='Morocco/Casablanca' date -u +%d) 
month=$(TZ='Morocco/Casablanca' date +%m)
year=$(TZ='Morocco/Casablanca' date +%Y)

record=$(echo "$year    $month     $day      $obs_temp              $fc_temp")
echo $record>>rx_poc.log
