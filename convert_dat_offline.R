convert_dat_offline <- function(data_dir) {
  source(here::here("gen_df_offline.R"))
  source(here::here("read_dat.R"))
  source(here::here("get_empty_tibble.R"))
  source(here::here("get_id.R"))
  source(here::here("convert_to_row.R"))




  # ------ MAIN ------------
  
  data_files <- list.files(data_dir, pattern = ".log", full.names =TRUE)
  
  # allocate the final df
  df <- get_empty_tibble(length(data_files))
  
  for (i in 1:length(data_files)) {
    cat("parsing ", data_files[i], "\n")
    df.raw <- read_dat(data_files[i])  
    # check if test is complete, we need 
    # 1. the sync trigger at the start 
    # 2. that the test was completed. 
    if ((any(str_detect(df.raw$desc,"text_13: text = 'Oppgaven er ferdig.") == TRUE)) & 
      (any(str_detect(df.raw$desc,"Keypress: space")))) {
      # remove stuff afther end of exp
      last_line <- match(TRUE,str_detect(df.raw$desc,"text_13: text = 'Oppgaven er ferdig."))
      df.raw <- df.raw[1:last_line,]
      # complete test 
      cat("test is complete: ", data_files[i], "\n")
      df.id <- gen_df_offline(df.raw)
      id <- get_id(data_files[i])
      cat("id = ", id, "\n")
      df.row <- convert_to_row(id, df.id,basename(data_files[i]) )
      cat(df.row$id[1])
      df <- df %>% add_row(df.row)
      cat("success ", data_files[i], "\n")
    }
    else {
      cat(data_files[i], "is incomplete .. skipping", "\n")      
    }        
  }

  df <- df %>% filter(id != "")
  # convert date
  df$file_date <- as.Date(df$file_date, format ="%Y-%m-%d")
  # convert time
  return(df)
  

}