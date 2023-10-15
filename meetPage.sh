#!/bin/bash
#Importar variables de colores desde "colores.sh"
source colores.sh

# Funciones
function setColor {
    local color="$1"
    printf "${color}"
}
function resetColor {
    printf "${endColour}"
}
function mostrar_mensaje {
    printf ">> %s\n" "$1"
    sleep 1
}
function hacer_ping {
    ping -c 1 "$1" 2>/dev/null | grep -c "64 bytes"
}
function obtener_direccion_ip {
    dig +short "$1" | head -1 | tr -d '[:space:]'
}
function copiar_a_portapapeles {
    printf "%s" "$1" | xclip -selection clipboard
}

# Inicio del script
name_dominio="$1"
setColor "${yellowColour}"
mostrar_mensaje "Guardando la dirección: $name_dominio"
mostrar_mensaje "Listo para hacer ping..."
resetColor
if hacer_ping "$name_dominio" >/dev/null; then
    setColor "${greenColour}"
    mostrar_mensaje "Ping exitoso"
    resetColor
    resultado=true
    ip=$(obtener_direccion_ip "$name_dominio")
    setColor "${turquoiseColour}"
    printf "Dirección: %s\n" "$name_dominio"
    printf "IP: %s\n" "$ip"
    copiar_a_portapapeles "$ip"
    printf "La dirección IP se ha copiado en el portapapeles.%s\n"
    resetColor
else
    setColor "${redColour}"
    mostrar_mensaje "Ping fallido"
    resetColor
fi
setColor "${yellowColour}"
mostrar_mensaje "Gracias!"
resetColor
