#!/bin/bash

# This script is licensed under
# GPL v3 or Higher.

# Author: Angel Berlanas Vicente
# eMail : a.berlanasvicente@edu.gva.es


mascara() {
    local palabra=$1
    local longitud=${#palabra}

    if [ $longitud -gt 3 ]; then
        local prefijo="${palabra:0:3}"
        local num_asteriscos=$(( longitud - 3 ))
        local asteriscos=$(printf '\*%.0s' $(seq 1 "$num_asteriscos"))
        echo "${prefijo}${asteriscos}"
    else
        echo "$palabra"
    fi
}


pdftotext -layout $1 $1.txt


mkdir -p PDFS/
rm -f PDFS/*

cat head.yml > PDFS/000-Intro.md


sed -i "/LISTADO DE ALUMNOS/d" $1.txt
sed -i "/INSTITUTO/d" $1.txt
sed -i "/DIRECCIÓN/d" $1.txt
sed -i "/LOCALIDAD/d" $1.txt
sed -i "/^Orden/d" $1.txt
sed -i "/^Fecha/d" $1.txt
sed -i "/^Página/d" $1.txt
sed -i "/Curso:/d" $1.txt
sed -i "/^$/d" $1.txt

nom_aux_clase="test"
num_clase="0"

while read line; do

    #echo "$line"

    rc=0
    echo $line| grep -q "^GRUPO" || rc=1

    if [ $rc -eq 0 ]; then
        nom_aux_clase=$(echo $line|cut -d " " -f2)
        let num_clase=$num_clase+1
        file_clase=$(printf "%03d" $num_clase)
        #echo $file_clase
        touch PDFS/${file_clase}-${nom_aux_clase}.md

        echo "\\newpage" > PDFS/${file_clase}-${nom_aux_clase}.md
        echo "" >> PDFS/${file_clase}-${nom_aux_clase}.md
        echo "" >> PDFS/${file_clase}-${nom_aux_clase}.md
        echo "# $nom_aux_clase " >> PDFS/${file_clase}-${nom_aux_clase}.md
        echo "" >> PDFS/${file_clase}-${nom_aux_clase}.md
        echo "| Nombre               |  Apellidos                        |  ">> PDFS/${file_clase}-${nom_aux_clase}.md
        echo "|----------------------|------------------------| ">> PDFS/${file_clase}-${nom_aux_clase}.md
    else
        line=$(echo $line| tr -s " ")
        nia=$(echo $line| cut -d " " -f2)
        apellidos_nombre=$(echo $line| cut -d " " -f3-)
        aux_ape=$(echo $apellidos_nombre| cut -d "," -f1)
        nombre=$(echo $apellidos_nombre |rev | cut -d "," -f1 |rev)
        nombre_solo=$(echo $nombre | sed -e "s/[0-9].*//g")
        apellidos=""
        for ape in $aux_ape; do
            apellidos="$apellidos $(mascara $ape)"
        done
        echo "| $nombre_solo | $apellidos | ">> PDFS/${file_clase}-${nom_aux_clase}.md
    fi


done < $1.txt

fecha=$(date +%Y%m%d%H%M)

cd PDFS/ && pandoc -H ../rsrc/config-a4.tex -o ../$fecha-Listado.pdf *.md && cd ..

echo "Tienes el PDF en : ../$fecha-Listado.pdf"

exit 0
