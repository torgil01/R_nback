# R kode for å konvertere N back logfiler 

## Installere bibliotek 
Trenger `dplyr`, `stringr`, `here`, `readr`, `tidyr` 

installere disse: 

```R 
install.packages('dplyr', 'stringr', 'here', 'readr', 'tidyr')
```

## A. lese fra csv filene 
For å lese fra csv loggfilene bruker man `convert_dat_csv`. Input er mappen med csv filer. 

```R
 df <- convert_dat("../test_data/")
 ```


## B. lese fra loggfil 
I noen tilfeller er ikke respons lagret i csv filene, men finnes i logg filene. Bruk da `convert_dat`. 


## Konvertere logfil
Eksempel 

```R 
 df <- convert_dat("../test_data/308_nback_fmri_nnl_2022-10-18_15h25.25.224.log")
```

Dette gir en dataframe som ser slik ut: 

```
# A tibble: 6 × 8
  trial_type trial_num subtrial_num text  text_onset keypress    rt correct
  <chr>          <int>        <int> <chr>      <dbl> <chr>    <dbl> <chr>  
1 0b                 1            1 E           7.15 ""       NA    ""     
2 0b                 2            2 V           9.95 ""       NA    ""     
3 0b                 3            3 Y          12.9  ""       NA    ""     
4 0b                 4            4 X          15.8  "yes"     1.35 "yes"  
5 0b                 5            5 V          18.6  ""       NA    ""     
6 0b                 6            6 Y          21.5  ""       NA    ""     
```

## samle data fra flere loggfiler 


## Konvertere til SAS , SPSS , Stata 
Bruk `haven` : https://github.com/tidyverse/haven

