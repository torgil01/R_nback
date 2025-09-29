data_dir="../data_261124/data"
convert_dat_csv(data_dir) %>% write_csv("Gruppe_i_MR.csv")


data_dir="../fra_runar/Kontrollgruppedeltakere_med_MR"
convert_dat_csv(data_dir) %>% write_csv("Kontrollgruppedeltakere_med_MR.csv")


data_dir="../fra_runar/Kontrollgruppedeltakere_uten_MR"
convert_dat_csv(data_dir) %>% write_csv("Kontrollgruppedeltakere_uten_MR.csv")

data_dir="../fra_runar/Behandlingsgruppedeltakere_utenfor_MR"
convert_dat_csv(data_dir) %>% write_csv("Behandlingsgruppedeltakere_utenfor_MR.csv")
