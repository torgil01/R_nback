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

  # 
  df.row <- get_empty_tibble(1)   

  num_correct_0b <- df.id %>% filter(cond == "0b") %>% summarise(sum(correct_resp == TRUE))
  num_correct_2b <- df.id %>% filter(cond == "2b") %>% summarise(sum(correct_resp == TRUE))
  num_miss_0b <- df.id %>% filter(cond == "0b") %>%  filter((correct_resp == FALSE) & is.na(key_resp.rt)) %>% summarise(n())
  num_miss_2b <- df.id %>% filter(cond == "2b") %>%  filter((correct_resp == FALSE) & is.na(key_resp.rt)) %>% summarise(n())
  num_errors_0b <- df.id %>% filter(cond == "0b") %>%  filter((correct_resp == FALSE) & is.na(key_resp.rt)) %>% summarise(n())
  num_errors_2b <- df.id %>% filter(cond == "2b") %>%  filter((correct_resp == FALSE) & is.na(key_resp.rt)) %>% summarise(n())
  rt_correct_0b <- df.id %>% filter(cond == "0b") %>%  filter((correct_resp == TRUE) & !is.na(key_resp.rt)) %>% 
    summarise(mean(key_resp.rt))
  rt_correct_2b <- df.id %>% filter(cond == "2b") %>%  filter((correct_resp == TRUE) & !is.na(key_resp.rt)) %>% 
    summarise(mean(key_resp.rt))
  rt_errors_0b <- df.id %>% filter(cond == "0b") %>%  filter((correct_resp == FALSE) & !is.na(key_resp.rt)) %>% 
    summarise(mean(key_resp.rt))
  rt_errors_2b <- df.id %>% filter(cond == "2b") %>%  filter((correct_resp == FALSE) & !is.na(key_resp.rt)) %>% 
    summarise(mean(key_resp.rt))
  std_correct_0b <- df.id %>% filter(cond == "0b") %>%  filter((correct_resp == TRUE) & !is.na(key_resp.rt)) %>% 
    summarise(sd(key_resp.rt))
  std_correct_2b <- df.id %>% filter(cond == "2b") %>%  filter((correct_resp == TRUE) & !is.na(key_resp.rt)) %>% 
    summarise(sd(key_resp.rt))
  std_errors_0b <- df.id %>% filter(cond == "0b") %>%  filter((correct_resp == FALSE) & !is.na(key_resp.rt)) %>% 
    summarise(sd(key_resp.rt))
  std_errors_2b <- df.id %>% filter(cond == "2b") %>%  filter((correct_resp == FALSE) & !is.na(key_resp.rt)) %>% 
    summarise(sd(key_resp.rt))

}