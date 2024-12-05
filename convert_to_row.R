convert_to_row <- function(id,df) {
  library(dplyr)
  source(here::here("get_empty_tibble.R"))
  df.row <- get_empty_tibble()    
  df.row$id[1] <- id
  # tot hits 0b & 2b
  df.row$tot_hits_0b[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = n()) %>% 
    pull()
  df.row$tot_hits_2b[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = n()) %>% 
    pull()
  # avg rt 0b & 2b
  df.row$avg_rt_hit_0b[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = mean(rt)) %>% 
    pull()
  df.row$avg_rt_hit_2b[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = mean(rt)) %>% 
    pull()
  # tot fail 0b & 2b
  df.row$tot_fails_0b[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "no") %>% 
    summarize(n = n()) %>% 
    pull()
  df.row$tot_fails_2b[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "no") %>% 
    summarize(n = n()) %>% 
    pull()
  # avg rt 0b & 2b fails
  df.row$avg_rt_fail_0b[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "no") %>% 
    summarize(n = mean(rt)) %>% 
    pull()
  df.row$avg_rt_fail_2b[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "no") %>% 
    summarize(n = mean(rt)) %>% 
    pull()
  
  return(df.row)

}
