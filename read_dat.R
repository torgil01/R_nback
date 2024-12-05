read_dat <- function(filename) {
  library(readr)
  library(dplyr)
  library(stringr)
  library(tidyr)

  # put dat fine in df
  # time = tine from start of experiment (ms)
  # 
  df.dat <- tibble(txt = read_lines(filename) ) %>% 
    separate(txt,c("time","type","desc"), sep = "\\t") %>% 
    mutate(time = as.double(time),type = as.character(type)) %>%
    mutate(type = str_trim(type)) %>% 
    mutate(desc = str_trim(desc))

  # filter the rows we need

  # df.dat %>% 
  #   filter(!str_detect(desc, "^text_24")) %>% 
  #   filter(!str_detect(desc, "^text_25")) %>% 
  #   filter(str_detect(desc,"^text_27")) %>% 
    
  
  df.keep <- df.dat %>%
    filter(type == "DATA")
  

  keep_triggers = c("^text_4: text = 'Her kommer 0-back!",
    "^text_3: text = 'Nå kommer 2-back!",
  "^text: text =",
  "^text_2: text =",
  "^text_5: text =",
  "^text_8: text =",
  "^text_12: text =",
  "^text_21: text =",
  "^text_23: text =",
  "^text_24: text =",
  "^text_26: text =",
  "^text_27: text =", 
  "text_13: text = 'Oppgaven er ferdig.")

  for (i in 1:length(keep_triggers)) {
    df.keep <- df.dat %>% 
      filter(str_detect(desc, keep_triggers[i])) %>%
      bind_rows(df.keep)
  }
  
  # sort by time
  df.keep <- df.keep %>% arrange(time)
  
  return(df.keep)

  
  

  

}
