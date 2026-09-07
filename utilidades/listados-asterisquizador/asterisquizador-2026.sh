#!/bin/bash

# This script is licensed under
# GPL v3 or Higher.

# Author: Angel Berlanas Vicente
# eMail : a.berlanasvicente@edu.gva.es

pdftotext -layout $1 $1.txt


sed -i "/LISTADO DE ALUMNOS/d" $1.txt
sed -i "/INSTITUTO/d" $1.txt
sed -i "/DIRECCIÓN/d" $1.txt
sed -i "/LOCALIDAD/d" $1.txt
sed -i "/^Orden/d" $1.txt
sed -i "/^Fecha/d" $1.txt
sed -i "/^Página/d" $1.txt
sed -i "/Curso:/d" $1.txt


exit 0
