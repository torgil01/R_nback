collect_all <- function() {
  library(readr)
  library(dplyr)
  library(haven)

  # funs
  source(here::here("convert_dat.R"))
  source(here::here("convert_dat_csv.R"))

  # settings
  format = "spss"
  export_dir = "data/export/"
  data_scanner = "data/skanner"
  data_lab = "data/lab"

  # data from scanner
  df1 <- convert_dat(data_scanner)
  df2 <- convert_dat_csv(data_lab)

  # combine all
  df <- bind_rows(df1, df2)

  df <- df %>%
    mutate(id_comment = str_split(id, "_", simplify = TRUE)[, 2]) %>%
    mutate(id = str_split(id, "_", simplify = TRUE)[, 1])

  # fix id 328
  df <- df %>% mutate(id = ifelse(str_detect(id, "før"), 328, id))
  # fix id 1111
  df <- df %>% mutate(id = ifelse(id == 111, 1111, id))

  # arrange tests by id and date
  df <- df %>%
    group_by(id, source) %>%
    arrange(test_date, .by_group = TRUE) %>%
    mutate(trial = row_number()) %>%
    ungroup()

  # save to spss
  write_sav(df, paste0(export_dir, "nback_all.sav"))
}
