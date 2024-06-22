#!/bin/bash

#clave API de weatherapi.com
API_KEY="07ad2a79dd494eda833190301242206"

#Ciudad de la cual quiero obtener el clima
CITY="Carhue"

# URL de la API
URL="http://api.weatherapi.com/v1/current.json?key=${API_KEY}&q=${CITY}"


RESPONSE=$(curl -s $URL)

if echo "$RESPONSE" | grep -q '"error"'; then
  echo "Error: No se pudo obtener la informacion del clima. Verifica tu clave de API y el nombre de la ciudad."
  exit 1
fi


TEMPERATURE=$(echo $RESPONSE | jq '.current.temp_c')
CONDITION=$(echo $RESPONSE | jq -r '.current.condition.text')

# Traduce la condicion climatica a español
case $CONDITION in
  "Sunny") CONDITION_ES="Soleado" ;;
  "Partly cloudy") CONDITION_ES="Parcialmente nublado" ;;
  "Cloudy") CONDITION_ES="Nublado" ;;
  "Overcast") CONDITION_ES="Nublado" ;;
  "Rain") CONDITION_ES="Lluvia" ;;
  "Showers") CONDITION_ES="Chubascos" ;;
  "Thunderstorms") CONDITION_ES="Tormentas eléctricas" ;;
  "Snow") CONDITION_ES="Nieve" ;;
  "Fog") CONDITION_ES="Niebla" ;;
  "Windy") CONDITION_ES="Ventoso" ;;
  "Clear") CONDITION_ES="Despejado" ;;
  *) CONDITION_ES=$CONDITION ;;  # Si no se encuentra en la lista, queda la condicion sin traducir
esac


echo "El clima actual en $CITY es:"
echo "Temperatura: $TEMPERATURE°C"
echo "Condición: $CONDITION_ES"
