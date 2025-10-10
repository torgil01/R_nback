summarize_failed_trial <- function(df.id) {
  # Summarize data from n-back trial
  library(dplyr)
  source("get_empty_tibble2.R")

  df.row <- get_empty_tibble2(1)

  df.row$id <- df.id$id[1]
  df.row$trial <- as.character(df.id$trial[1])
  df.row$test_date <- as.character(df.id$date[1])
  df.row$test_time <- df.id$time[1]
  df.row$filename <- df.id$filename[1]
  df.row$complete_trial <- "no"
}
