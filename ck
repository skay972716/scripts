#!/bin/sh
echo -n "Ingresa el nombre de la rama: "
read rama
mapfile -t ramasEncontradas < <(git branch | grep -i $rama)
ramasEncontradasOrigen=${#ramasEncontradas[@]}
#Cortar a un numero definido de ramas
ramasEncontradas=("${ramasEncontradas[@]:0:5}")
numeroRamas=${#ramasEncontradas[@]}
echo "Ramas encontradas: $ramasEncontradasOrigen mostrando $numeroRamas"
index=1
for ramaOpcion in "${ramasEncontradas[@]}"; do
    echo "$index.- $ramaOpcion"
    index=$(($index+1))
done
echo -n "Rama a cambiar: "
read ramaNumero
ramaNumero=$(($ramaNumero-1))
if [[ $ramaNumero -ge $numeroRamas ]] || [[ $ramaNumero -lt 0 ]]; then
    echo "Numero de rama no encontrada"
    exit 1
fi
IFS=" " read -ra arrRamaSeleccionada <<< ${ramasEncontradas[$ramaNumero]}
inUltimaRama=${#arrRamaSeleccionada[@]}
ramaSeleccionada=${arrRamaSeleccionada[$(($inUltimaRama-1))]}
echo "Rama seleccionado: $ramaSeleccionada"
git checkout $ramaSeleccionada
#Pregunta git pull
echo "Deseas hacer un pull a tu rama: $ramaSeleccionada ?"
echo -n "1.- Si     2.- No  : "
read confirmarPull
if [[ $confirmarPull -ne 1 ]]; then
    exit 1
fi
git pull