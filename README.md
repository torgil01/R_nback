# R kode for å konvertere N back logfiler 

**Offline data leses fra csv fil, mens mri data leses fra logfil**

## Installere bibliotek 
Trenger `dplyr`, `stringr`, `here`, `readr`, `tidyr` 

installere disse: 

```R 
install.packages('dplyr', 'stringr', 'here', 'readr', 'tidyr')
```

## A. lese fra csv filene 
For å lese fra csv loggfilene bruker man `convert_dat_csv`. Input er mappen med csv filer. 

```R
 df.csv <- convert_dat_csv("../test_data/")
 ```

Dette gir føgende df:   

```
> glimpse(df.csv)
Rows: 5
Columns: 19
$ id             <chr> "319", "320_2", "320", "321_1", "322_1"
$ trial          <chr> "1", "1", "1", "1", "1"
$ test_date      <date> 2023-06-13, 2023-10-11, 2023-09-26, 2023-10-10, 2023-10-31
$ test_time      <chr> "14h59m", "15h08m", "14h51m", "14h28m", "14h45m"
$ filename       <chr> "319_nback_fmri_nnl_2023-06-13_14h59.40.616.csv", "320_2_nback_fmri_nnl_2023-10-11_15h08.55.719.csv",…
$ num_correct_0b <int> 60, 75, 60, 74, 75
$ num_correct_2b <int> 60, 75, 60, 75, 75
$ num_errors_0b  <int> 15, 0, 15, 1, 0
$ num_errors_2b  <int> 15, 0, 15, 0, 0
$ num_miss_0b    <int> 15, 0, 15, 1, 0
$ num_miss_2b    <int> 15, 0, 15, 0, 0
$ rt_correct_0b  <dbl> NA, 0.4431398, NA, 0.6865206, 0.4635678
$ rt_correct_2b  <dbl> NA, 0.4374741, NA, 0.7036972, 0.4889033
$ rt_errors_0b   <lgl> NA, NA, NA, NA, NA
$ rt_errors_2b   <lgl> NA, NA, NA, NA, NA
$ std_correct_0b <dbl> NA, 0.06552750, NA, 0.07994602, 0.07390334
$ std_correct_2b <dbl> NA, 0.08273352, NA, 0.15706857, 0.14320421
$ std_errors_0b  <dbl> NA, NA, NA, NA, NA
$ std_errors_2b  <dbl> NA, NA, NA, NA, NA
```


## B. lese fra loggfil 
I noen tilfeller er ikke respons lagret i csv filene, men finnes i logg filene. Bruk da `convert_dat`. 

**Eksempel:**

```R 
 df <- convert_dat("../test_data/308_nback_fmri_nnl_2022-10-18_15h25.25.224.log")
```

Dette gir følgende dataframe:  

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

