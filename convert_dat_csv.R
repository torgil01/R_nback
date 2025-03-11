convert_dat_csv <- function(data_dir) {
  # libs
  library(dplyr)

  # funs
  source(here::here("get_empty_tibble2.R"))
  source(here::here("summarize_trial.R"))
  source(here::here("convert_csv.R"))




  # ------ MAIN ------------
  
  csv_files <- list.files(data_dir, pattern = ".csv", full.names =TRUE)
  
  # allocate the final df
  df <- get_empty_tibble2(length(csv_files))
  
  for (i in 1:length(csv_files)) {
    cat("parsing ", csv_files[i], "\n")
    df.csv <- convert_csv(csv_files[i])  
    # check if the test was completed
    if (dim(df.csv)[1] == 150) {
      # ok 
      cat("test is complete: ", csv_files[i], "\n")
      df.row <- summarize_trial(df.csv)
      df <- df %>% add_row(df.row)
    }
    else {
      cat(csv_files[i], "is incomplete .. skipping", "\n")      
    }       
  } 
  
  df <- df %>% filter(id != "")
  # replace NaN with NA 
  df <- df %>% mutate_all(~ifelse(is.nan(.), NA, .))
  df$test_date <- as.Date(df$test_date) # , format ="%Y-%m-%d"
  return(df)
  

}