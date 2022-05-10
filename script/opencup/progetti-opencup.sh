#!/bin/bash

set -x
set -e
set -u
set -o pipefail

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

name="progetti-opencup"
file="OpenCup_Progetti.csv"

mkdir -p "$folder"/../tmp
mkdir -p "$folder"/../../dati/"$name"

find "$folder"/../tmp -iname "*.*" -type f -delete

# URL progetti
URL="https://opencup.gov.it/documents/21195/117121/OpenCUP_Progetti.zip"

# Scarica dati
wget -O "$folder"/../tmp/"$name".zip "$URL"
# Decomprimi dati
unzip "$folder"/../tmp/"$name".zip  -d "$folder"/../tmp

# Estrai soltanto i dati PNRR
qsvlite search -d ";" -i -s CODICE_LOCALE_PROGETTO PNRR "$folder"/../tmp/"$file" >"$folder"/../../dati/"$name"/"$name"-PNRR.csv

# Ordina per CUP
qsv sort -s CUP "$folder"/../../dati/"$name"/"$name"-PNRR.csv >"$folder"/../../dati/"$name"/tmp.csv
mv "$folder"/../../dati/"$name"/tmp.csv "$folder"/../../dati/"$name"/"$name"-PNRR.csv

# Cancella temporanei
find "$folder"/../tmp -iname "*.*" -type f -delete
