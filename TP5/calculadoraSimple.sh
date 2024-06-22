#!/bin/bash

# Funcion para mostrar el menu de opciones
menuOpciones() {
    echo "Bienvenido al menu de la calculadora"
    echo "Seleccione el numero correspondiente a la operacion que desea realizar:"
    echo "1) Suma"
    echo "2) Resta"
    echo "3) Multiplicacion"
    echo "4) Division"
}

# Funcion para leer numero del usuario
numeroIngresado() {
    local numero
    while true; do
        read -p "Ingrese un numero: " numero
          if [[ $numero =~ ^-?[0-9]+$ ]]; then
            echo $numero
            return
        else
            echo "Error, ingrese un numero valido."
        fi
    done
}

# Lee los 2 numeros ingresados por el usuario
echo "Calculadora Simple"
numero1=$(numeroIngresado)
numero2=$(numeroIngresado)

#Bucle para asegurar que ingrese un numero de opcion permitido

opcion_valida=0
while [ $opcion_valida -eq 0 ]; do
    menuOpciones
    read -p "Ingrese su eleccion (1-4): " opcion

    case $opcion in
        1|2|3|4)
            opcion_valida=1
            ;;
        *)
            echo "Error, seleccione una opcion del 1 al 4."
            ;;
    esac
done


# Realizar la operacion seleccionada
case $opcion in

    1)
        resultado=$(($numero1 + $numero2))
        echo "El resultado de la suma es: $resultado"
        ;;
    2)
        resultado=$(($numero1 - $numero2))
        echo "El resultado de la resta es: $resultado"
        ;;
    3)
        resultado=$(($numero1 * $numero2))
        echo "El resultado de la multiplicación es: $resultado"
        ;;
    4)
        if [ $(echo "$numero2 == 0" | bc) -eq 1 ]; then
            echo "Error, la division por cero no está permitida."
        else
            resultado=$(echo "scale=2; $numero1 / $numero2" | bc)
            echo "El resultado de la división es: $resultado"
        fi
        ;;
esac


