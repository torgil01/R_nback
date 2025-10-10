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

    # Check if underscores were found
  if (rw >= 2) {
    pos_1 <- mpos[rw-1,1] + 1
    pos_2 <- mpos[rw,1] -1
    
    if (!pos_1 == 0  & !pos_2 == 0) {
      file_date <- substr(fn,pos_1,pos_2)
    } else {
      file_date <- NA
    }
  } else {
    file_date <- NA
    pos_2 <- nchar(fn) # fallback for time extraction
  }

#  pos_1 <- mpos[rw-1,1] + 1
#  pos_2 <- mpos[rw,1] -1
#  if (!pos_1 == 0  & !pos_2 == 0) {
#    file_date <- substr(fn,pos_1,pos_2)
#    }
  df.row$file_date[1] <- file_date
  df.row$filename[1] <- fn
  df.row$file_time[1] <- paste0(substr(fn,pos_2 + 2,pos_2 + 6),"m")


    if (exists("pos_2") && pos_2 + 6 <= nchar(fn)) {
    df.row$file_time[1] <- paste0(substr(fn,pos_2 + 2,pos_2 + 6),"m")
  } else {
    df.row$file_time[1] <- NA
  }
  # # new 
  # # num hits pr cond
  # df.row$hit0 <- df %>%
  #    filter(trial_type == "0b") %>%
  #    summarise(sum(hit)) %>%
  #    pull()
  # # df.row$hit2 <- df.id %>%
  #   filter(cond == "2b") %>%
  #   summarise(sum(hit)) %>%
  #   pull()
  # # num false positives for cond
  # df.row$false0 <- df.id %>%
  #   filter(cond == "0b") %>%
  #   summarise(sum(false)) %>%
  #   pull()
  # df.row$false2 <- df.id %>%
  #   filter(cond == "2b") %>%
  #   summarise(sum(false)) %>%
  #   pull()
  # # num corejects pr cond
  # df.row$coreject0 <- df.id %>%
  #   filter(cond == "0b") %>%
  #   summarise(sum(coreject)) %>%
  #   pull()
  # df.row$coreject2 <- df.id %>%
  #   filter(cond == "2b") %>%
  #   summarise(sum(coreject)) %>%
  #   pull()




  # tot hits 0b & 2b
  df.row$hit0[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = n()) %>% 
    pull()
  df.row$hit2[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = n()) %>% 
    pull()
  # avg rt 0b & 2b
  df.row$rt_hit0[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = mean(rt)) %>% 
    pull()
  df.row$rt_hit2[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = mean(rt)) %>% 
    pull()
    # sd rt 0b & 2b
  df.row$sd_hit0[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = sd(rt)) %>% 
    pull()
  df.row$sd_hit2[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "yes") %>% 
    summarize(n = sd(rt)) %>% 
    pull()


  # tot fail 0b & 2b
  df.row$false0[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "no") %>% 
    summarize(n = n()) %>% 
    pull()
  df.row$false2[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "no") %>% 
    summarize(n = n()) %>% 
    pull()
  # avg rt 0b & 2b fails
  df.row$rt_false0[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "no") %>% 
    summarize(n = mean(rt)) %>% 
    pull()
  df.row$rt_false2[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "no") %>% 
    summarize(n = mean(rt)) %>% 
    pull()
  #

    # sd rt 0b & 2b fails
  df.row$sd_false0[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "no") %>% 
    summarize(n = sd(rt)) %>% 
    pull()
  df.row$sd_false2[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "no") %>% 
    summarize(n = sd(rt)) %>% 
    pull()
  #

    df.row$coreject0[1] <- df %>% filter(trial_type == "0b") %>% 
    filter(correct == "" & keypress == "") %>%       
    summarize(n = n()) %>% 
    pull()

    df.row$coreject2[1] <- df %>% filter(trial_type == "2b") %>% 
    filter(correct == "" & keypress == "") %>%       
    summarize(n = n()) %>% 
    pull()

    

  return(df.row)

}
