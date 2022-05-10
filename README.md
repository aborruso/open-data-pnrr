# Informazioni

Raccolta di alcuni dati utili a tema PNRR

## OpenCUP

### CUP legati al PNRR

Su [OpenCUP](https://opencup.gov.it/opendata), nel dataset dei [**Progetti**](https://dati.anticorruzione.it/opendata/download/dataset/cup/filesystem/cup_csv_0.zip) (attenzione è un file che decompresso pesa più di 5 GB), ci sono alcune migliaia di record che nel campo `CODICE_LOCALE_PROGETTO` hanno la stringa `PNRR`.

➡️ Sono stati estratti e pubblicati nel file [`progetti-opencup-PNRR.csv`](dati/progetti-opencup/progetti-opencup-PNRR.csv).

### Informazioni territoriali dei CUP legati al PNRR

Su [OpenCUP](https://opencup.gov.it/opendata) c'è la risorsa denominata [`OpenCUP_Localizzazione`](https://opencup.gov.it/documents/21195/117121/OpenCUP_Localizzazione.zip), con le informazioni territoriali dei CUP.

➡️ Sono state estratte quelli dei CUP legati al PNRR (vedi sopra), nel file [`progetti-opencup-PNRR-localizzazioni.csv`](dati/progetti-opencup/progetti-opencup-PNRR-localizzazioni.csv).

⚠️ **Nota bene**: Per ogni CUP ci può essere più di una riga di localizzazione, perché alcuni progetti si sviluppano in più zone.

### CIG dei CUP legati al PNRR

ANAC pubblica nel suo portale opendata il dataset dei [CIG dei CUP](https://dati.anticorruzione.it/opendata/dataset/cup).

➡️ A partire dai dati OpenCUP di sopra, sono stati estratti i CIG dei CUP legati al PNRR: file [`progetti-opencup-PNRR-CIG.csv`](dati/progetti-opencup/progetti-opencup-PNRR-CIG.csv)

⚠️ **Nota bene**: nel dataset di ANAC sono presenti i CIG soltanto di una piccola porzione dei dati CUP legati al PNRR (dobbiamo verificare il perché).
