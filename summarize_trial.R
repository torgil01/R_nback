summarize_trial <- function(df.id) {
  # Summarize data from n-back trial
  # We compute the following variables:
  #
  # num_correct_0b # either correct keypress or no reposne
  # num_correct_2b # either correct keypress or no reposne
  # num_errors_0b  # keypress when there should be none
  # num_errors_2b  # keypress when there should be none
  # num_miss_0b    # no kreypress when there should be one
  # num_miss_2b    # no kreypress when there should be one
  # rt_correct_0b  # mean rt for correct keypress
  # rt_correct_2b  # mean rt for correct keypress
  # rt_errors_0b   # mean rt for incorrect keypress
  # rt_errors_2b   # mean rt for incorrect keypress
  # std_correct_0b # std rt for correct keypress
  # std_correct_2b # std rt for correct keypress
  # std_errors_0b  # std rt for incorrect keypress
  # std_errors_2b  # std rt for incorrect keypress

  #  (a) overall accuracy;
  #  (b) accuracy and/or response times reported for specific trial types (targets, nontargets, lures);
  #  (c) hit and false alarm rates;
  #  (d) signal detection measures of sensitivity and bias.

  # librarys
  library(dplyr)
  # funs
  source("get_empty_tibble2.R")
  #
  df.row <- get_empty_tibble2(1)

  df.row$id <- df.id$id[1]
  df.row$trial <- as.character(df.id$trial[1])
  df.row$test_date <- as.character(df.id$date[1]) # as.Date(df.id$date[1], format ="%Y-%m-%d")
  df.row$test_time <- df.id$time[1]
  df.row$filename <- df.id$filename[1]
  # numm hits pr cond
  df.row$hit0 <- df.id %>%
    filter(cond == "0b") %>%
    summarise(sum(hit)) %>%
    pull()
  df.row$hit2 <- df.id %>%
    filter(cond == "2b") %>%
    summarise(sum(hit)) %>%
    pull()
  # num false positives for cond
  df.row$false0 <- df.id %>%
    filter(cond == "0b") %>%
    summarise(sum(false)) %>%
    pull()
  df.row$false2 <- df.id %>%
    filter(cond == "2b") %>%
    summarise(sum(false)) %>%
    pull()
  # num corejects pr cond
  df.row$coreject0 <- df.id %>%
    filter(cond == "0b") %>%
    summarise(sum(coreject)) %>%
    pull()
  df.row$coreject2 <- df.id %>%
    filter(cond == "2b") %>%
    summarise(sum(coreject)) %>%
    pull()

  # RTs
  df.row$rt_hit0 <- df.id %>%
    filter(cond == "0b") %>%
    filter((hit == 1) & !is.na(key_resp.rt)) %>%
    summarise(mean(key_resp.rt)) %>%
    pull()
  df.row$rt_hit2 <- df.id %>%
    filter(cond == "2b") %>%
    filter((hit == 1) & !is.na(key_resp.rt)) %>%
    summarise(mean(key_resp.rt)) %>%
    pull()
  df.row$sd_hit0 <- df.id %>%
    filter(cond == "0b") %>%
    filter((hit == 1) & !is.na(key_resp.rt)) %>%
    summarise(sd(key_resp.rt)) %>%
    pull()
  df.row$sd_hit2 <- df.id %>%
    filter(cond == "2b") %>%
    filter((hit == 1) & !is.na(key_resp.rt)) %>%
    summarise(sd(key_resp.rt)) %>%
    pull()

  df.row$rt_false0 <- df.id %>%
    filter(cond == "0b") %>%
    filter((false == 1) & !is.na(key_resp.rt)) %>%
    summarise(mean(key_resp.rt)) %>%
    pull()
  df.row$rt_false2 <- df.id %>%
    filter(cond == "2b") %>%
    filter((false == 1) & !is.na(key_resp.rt)) %>%
    summarise(mean(key_resp.rt)) %>%
    pull()
  df.row$sd_false0 <- df.id %>%
    filter(cond == "0b") %>%
    filter((false == 1) & !is.na(key_resp.rt)) %>%
    summarise(sd(key_resp.rt)) %>%
    pull()
  df.row$sd_false2 <- df.id %>%
    filter(cond == "2b") %>%
    filter((false == 1) & !is.na(key_resp.rt)) %>%
    summarise(sd(key_resp.rt)) %>%
    pull()

  return(df.row)
}
