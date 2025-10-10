# R kode for å konvertere N back logfiler 

For å kjøre koden må du installere først R og så R studio. Se https://posit.co/download/rstudio-desktop/ og https://cran.r-project.org/mirrors.html 
Hvis du har en UiT maskin kan du installere R og R studio via Software center.

## Installere R pakker
Trenger `dplyr`, `stringr`, `here`, `readr`, `rlang`, `tidyr`og `haven` for å kjøre koden

Start R studio og skriv følgende i konsollen for å installere pakkene.

```R 
install.packages('dplyr', 'stringr', 'here', 'readr', 'rlang', 'tidyr', 'haven')
```

## Struktur på data mappen
Data mappen inneholdeer tre undermapper: `export`, `lab` og `skanner`.

```text
data
├───export
├───lab
└───skanner
```

Kopier *.log filene fra N back kjørt i skanner til `skanner` mappen og  *.csv filene fra N back kjørt i lab til `lab` mappen. 

## Konvertere logg filene
For å konvertere logg filene til SPSS format bruker du skriptet `collect_all.R`. Du må først "source" skriptet i konsollet før du kjører det.

```R
source("collect_all.R")
collect_all()
```

Skriptet vil skrive ut ting på konsollet underveis. Når det er ferdig vil du finne SPSS filene i `data/export` mappen. Skulle det oppstå feil vil du kunne se i konsollet hvilken fil det gjelder. Jeg har ikke fullstendig feilsjekking for ufullstendige logg/csv filer, så slike feil skyldes mest sannsynligvis dette. Fjern ufullstendige filer fra mappen og kjør skriptet på nytt.

