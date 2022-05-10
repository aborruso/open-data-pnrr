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

# Aggiungi URL progetto OpenCUP
mlr -I --csv put '$URL="https://opencup.gov.it/progetto/-/cup/".$CUP' then reorder -f URL "$folder"/../../dati/"$name"/"$name"-PNRR.csv

# Cancella temporanei
find "$folder"/../tmp -iname "*.*" -type f -delete

### localizzazioni ###

nameLoc="opencup-localizzazione"
localizzazione="https://opencup.gov.it/documents/21195/117121/OpenCUP_Localizzazione.zip"

# Scarica dati
wget -O "$folder"/../tmp/"$nameLoc".zip "$localizzazione"
# Decomprimi dati
unzip "$folder"/../tmp/"$nameLoc".zip  -d "$folder"/../tmp

# path file estratto
file=$(find "$folder"/../tmp -iname "*.csv" -type f)

qsvlite fmt -d ";" "$file" >"$folder"/../tmp/tmp.csv

mv "$folder"/../tmp/tmp.csv "$file"

qsvlite join CUP "$folder"/../../dati/"$name"/"$name"-PNRR.csv CUP "$file" >"$folder"/../tmp/tmp.csv

header=$(<"$file" head -n 1)

mlr --csv cut -f "$header" "$folder"/../tmp/tmp.csv >"$folder"/../../dati/"$name"/"$name"-PNRR-localizzazioni.csv

# Cancella temporanei
find "$folder"/../tmp -iname "*.*" -type f -delete

### CIG ###

nameCIG="anac-cig"
URLcig="https://dati.anticorruzione.it/opendata/download/dataset/cup/filesystem/cup_csv_0.zip"

# Scarica dati
wget -O "$folder"/../tmp/"$nameCIG".zip "$URLcig"
# Decomprimi dati
unzip "$folder"/../tmp/"$nameCIG".zip  -d "$folder"/../tmp

# path file estratto
file=$(find "$folder"/../tmp -iname "*.csv" -type f)

qsvlite fmt -d ";" "$file" >"$folder"/../tmp/tmp.csv

mv "$folder"/../tmp/tmp.csv "$file"

qsvlite join CUP "$folder"/../../dati/"$name"/"$name"-PNRR.csv CUP "$file" >"$folder"/../tmp/tmp.csv

header=$(<"$file" head -n 1)

mlr --csv cut -f "$header" "$folder"/../tmp/tmp.csv >"$folder"/../../dati/"$name"/"$name"-PNRR-CIG.csv

# Cancella temporanei
find "$folder"/../tmp -iname "*.*" -type f -delete
