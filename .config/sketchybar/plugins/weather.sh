sketchybar --set $NAME \
  label="Loading..." \
  icon.color=0xff5edaff

WEATHER_JSON=$(curl -s "https://wttr.in/kokkedal?0pq&format=j1")
# Fallback if empty
if [ -z $WEATHER_JSON ]; then
  sketchybar --set $NAME label="$LOCATION"
  return
fi

TEMPERATURE=$(echo $WEATHER_JSON | jq '.current_condition[0].temp_C' | tr -d '"')
WEATHER_DESCRIPTION=$(echo $WEATHER_JSON | jq '.current_condition[0].weatherDesc[0].value' | tr -d '"' | sed 's/\(.\{16\}\).*/\1.../')

sketchybar --set $NAME \
  label="$TEMPERATURE$(echo '°')C • $WEATHER_DESCRIPTION"
