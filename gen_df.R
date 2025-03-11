gen_df <- function(df.raw) {
  # --  
  # read raw df from dat file and restructure
  # -- 
  # traverse df.keep and build final df with following fields
  # trial [0back,2back], letter [A,X..], reponse[na, or responsetime in ms] 
  
  library(dplyr)
  library(stringr)
  
  # constants
  num_rows = 150 # size of experiment
  
  
  get_trial <- function(text_str) {
    # return trial type
    trial = "NA"
    if (str_detect(text_str,"2-back")) {
      trial = "2b"}
      else if (str_detect(text_str,"0-back")) {
        trial = "0b"
      }
      return(trial)
    }
    
    get_text <- function(desc_str) {
      # return the latter that is displayed
      txt = "NA"
      pos <- str_locate(desc_str,"'")    
      st <- pos[1]
      txt <- substring(desc_str,st+1,st+1)
      return(txt)
    }
    
    get_2b_index2 <- function(df,i){
      # i = current pos
      indx = 0
      two_b = 0
      if (df$type[i - 1] == "DATA") {
        indx = 1
      } else {
        indx = 1
        two_b = 1
      }
      if (df$type[i - 2] == "DATA") {
        indx = indx + 1
      } else {
        indx = indx + 1
        two_b = two_b +1 
        return(i - indx)
      }
      if (df$type[i - 3] == "DATA") {
        indx = indx + 1
      } else {
        indx = indx + 1
        two_b = two_b +1
        return(i - indx)
      }
    }
  
  
    get_2b_index <- function(df.raw,i) {    
      # perhaps just count the exp ?
      # count backward two exp and return index
      indx = -1
      #i = i -1
      while (i > 1) {        
        #cat("exp =",df.raw$type[i]," ----> ")
        if (indx == -2) {        
         # cat("i = ",i, "indx = ", indx, "exp =",df.raw$type[i],"cond == break \n")
          break        
        } else {
          if ((df.raw$type[i] == "EXP"))  {
            indx = indx -1   
            i = i -1
            cat("i = ",i, "indx = ", indx, "exp =",df.raw$type[i],"cond == exp \n") 
          } else {
            i = i -1
          }
        }   
        #  else {        
        #   cat("i = ",i, "indx = ", indx, "exp =",df.raw$type[i],"cond == data \n")
        #   i = i - 1
        # }
        
      }
      return(i)
      
    }
    
    remove_double_keypress <- function(df) {
      # remove doube keypresses for easy parsing 
      nrows = dim(df)[1]
      for (i in 1:nrows-1) {
        #cat("cond = ", df$cond[i], "cond+1 = ",df$cond[i+1],"\n")
        if (df$cond[i] == "key" && df$cond[i+1] == "key") {
          df$cond[i+1] = "rm"
        }      
      }
      df <- df %>% filter(cond != "rm")
      return(df)
    }
    
    # adjust time to MRI sync
    start_time <- df.raw %>% 
    filter(desc == "Keypress: s") %>% 
    select(time) %>% 
    pull() %>% 
    as.double()
    df.raw <- df.raw %>% mutate(time = time - start_time) %>%
    filter(time > 0)
    
    # add variable to help parsing 
    df.raw <- df.raw %>% 
    mutate(cond = case_when(
      str_detect(desc,"^Keypress") ~ "key", 
      str_detect(desc, "-back!") ~ "switch",
      str_detect(desc, "text = '") ~ "text"))
      
      # remove double keypresses
      df.raw <- remove_double_keypress(df.raw)
      
      df <- tibble(trial_type = character(num_rows), 
      trial_num = rep(as.integer(NA),num_rows),
      subtrial_num = rep(as.integer(NA),num_rows),
      text = character(num_rows), 
      text_onset = rep(NA,num_rows), 
      keypress = character(num_rows),
      rt = rep(NA, num_rows), 
      correct = rep(NA,num_rows))
      trial_num = 1
      
      trial_type <- "NA"
      i = 1
      nrows = dim(df.raw)[1]
      while (i < nrows) {
        if (df.raw$cond[i] == "switch" ) {
          subtrial_num = 1
          trial_type = get_trial(df.raw$desc[i])
          i <- i + 1
          response  <- "NA"
          rt <- NA
          correct <- ""  
          keypress <- ""
          disp_text  <-  "NA"
          text_onset <- -1
          while (df.raw$cond[i] != "switch") {
            # can be 3 cases
            # 1 text (display text) -> store letter and time
            # 2 keypress -> store time and correct y/n
            # 3 new condiction -> exit while
            if (df.raw$cond[i] == "text") {
              # a letter is displayed
              disp_text <- get_text(df.raw$desc[i])
              text_onset <-  df.raw$time[i]
              
              # the next line may contain a keypress
              if (i == nrows ) {
                break
              }            
              if (df.raw$cond[i+1] == "key") {
                # we may have a keypress before stimuli
                # this has to be dropped
                
                rt = df.raw$time[i+1] - text_onset - 1
                #cat("rt = ", rt, "text_onset =", text_onset,"disp_text =",disp_text, "\n")
                if (!is.na(disp_text)) {
                  
                  
                  keypress = "yes"
                  # determine if response is correct or not
                  if (trial_type == "0b") {
                    if ( disp_text == "X") {
                      correct = "yes"
                    }
                    else 
                    {
                      correct = "no"
                    }
                  }
                  # for 2b
                  if (trial_type == "2b") {
                    if ( subtrial_num < 3) {                  
                      correct = "no"
                    }
                    else  {
                      # this will break in case many keypresses
                      # we have to step back two text displays
                      back_index <- get_2b_index2(df.raw,i) 
                      back2_text = get_text(df.raw$desc[back_index]) 
                      #cat("disp_text = ",disp_text,"back2_text=",back2_text,"i = ", i, "back_index = ", back_index,'\n')
                      if (disp_text == back2_text) {
                        correct = "yes"
                      }
                      else {
                        correct = "no"
                      }
                    }
                  }
                }
                i = i +1 
              }
              # fill row in df
            df$trial_type[trial_num] <- trial_type
            df$trial_num[trial_num] <- as.integer(trial_num)
            df$text[trial_num] <- disp_text
            df$text_onset[trial_num] <- text_onset
            df$keypress[trial_num] <- keypress 
            df$rt[trial_num] <- rt              
            df$correct[trial_num] <- correct
            df$subtrial_num[trial_num] <- as.integer(subtrial_num)
            
            keypress = ''
            rt = NA
            correct = ''
            trial_num = trial_num +1
            subtrial_num = subtrial_num + 1
            
            }
            
            # increment counters
            i = i + 1          
          }                      
        }
      }
      return(df)
}
    
    