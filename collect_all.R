collect_all <- function() {
  library(readr)
  library(dplyr)
  library(haven)

  format = "spss"

  export_dir = "export_new/"
  # convert data from MR sessions
  #data_dir = "../data_261124/data"
  data_dir = "../true_logfiles/"
  out_file = paste0(export_dir, "Gruppe_i_MR.sav")
  #convert_dat(data_dir) %>% write_csv(out_file)
  #convert_dat(data_dir) %>% write_sav(out_file)

  df1 <- convert_dat(data_dir)

  # convert data from outside scanner
  data_dir = "../fra_runar/Kontrollgruppedeltakere_med_MR"
  out_file = paste0(export_dir, "Kontrollgruppedeltakere_med_MR.sav")
  #convert_dat_csv(data_dir) %>% write_csv(out_file)
  #convert_dat_csv(data_dir) %>% write_sav(out_file)
  df2 <- convert_dat_csv(data_dir)

  data_dir = "../fra_runar/Kontrollgruppedeltakere_uten_MR"
  out_file = paste0(export_dir, "Kontrollgruppedeltakere_uten_MR.sav")
  #convert_dat_csv(data_dir) %>% write_csv(out_file)
  #convert_dat_csv(data_dir) %>% write_sav(out_file)
  df3 <- convert_dat_csv(data_dir)

  data_dir = "../fra_runar/Behandlingsgruppedeltakere_utenfor_MR"
  out_file = paste0(export_dir, "Behandlingsgruppedeltakere_utenfor_MR.sav")
  #  convert_dat_csv(data_dir) %>% write_csv(out_file)
  # convert_dat_csv(data_dir) %>% write_sav(out_file)
  df4 <- convert_dat_csv(data_dir)

  # combine all
  df <- bind_rows(df1, df2, df3, df4)

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

  return(df)
}
