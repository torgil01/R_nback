convert_dat <- function(data_dir) {
  source(here::here("gen_df.R"))
  source(here::here("read_dat.R"))
  source(here::here("get_empty_tibble.R"))


# local functions
  
  get_id <- function(fname) {
    # extract id from filename
    fn <- basename(fname)
    # filename is like
    # id_xxxx
    pos <- str_locate(fn,"_")  
    id <- substring(fn,1,pos[1]-1)  
    return(id)
  }



  # ------ MAIN ------------
  # allocate the final df
  df <- get_empty_tibble()
  
  data_files <- list.files(data_dir, pattern = ".log", full.names =TRUE)
  for (i in 1:length(data_files)) {
    cat("parsing ", data_files[i], "\n")
    df.raw <- read_dat(data_files[i])  
    # check if thest was completed 
    if (any(str_detect(df.raw$desc,"text_13: text = 'Oppgaven er ferdig.") == TRUE)) {
      # complete test 
      df.id <- gen_df(df.raw)
      id <- get_id(data_files[i])
      cat("id = ", id, "\n")
      df.row <- convert_to_row(id, df.id)
      cat(df.row$id[1])
      df <- df %>% add_row(df.row)
    }
    else {
      cat( data_files[i], "is incomplete .. skipping", "\n")      
    }        
  }


  return(df)
  

}