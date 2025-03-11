convert_to_row <- function(id,df,fn) {
  library(dplyr)
  library(stringr)
  source(here::here("get_empty_tibble.R"))
  df.row <- get_empty_tibble(1)    
  df.row$id[1] <- id
  # get date and time from filename
  pos <- str_locate_all(fn,"_")
  mpos <- pos[[1]]
  rw <- dim(mpos)[1] 
  pos_1 <- mpos[rw-1,1] + 1
  pos_2 <- mpos[rw,1] -1
  file_date <- substr(fn,pos_1,pos_2)
  df.row$file_date[1] <- file_date
  df.row$filename[1] <- fn
  df.row$file_time[1] <- paste0(substr(fn,pos_2 + 2,pos_2 + 6),"m")

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
  #
  df.row$std_rt_hit_0b[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = sd(rt)) %>% 
    pull()
  df.row$std_rt_hit_2b[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = sd(rt)) %>% 
    pull()
  #
  df.row$std_rt_fail_0b[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "no") %>% 
    summarize(n = sd(rt)) %>% 
    pull()
  df.row$std_rt_fail_2b[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "no") %>% 
    summarize(n = sd(rt)) %>% 
    pull()
  # 
  df.row$min_rt_hit_0b[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = min(rt)) %>% 
    pull()
  df.row$min_rt_hit_2b[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = min(rt)) %>% 
    pull()
  #
  df.row$max_rt_hit_0b[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = max(rt)) %>% 
    pull()
  df.row$max_rt_hit_2b[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = max(rt)) %>% 
    pull()


  return(df.row)

}
