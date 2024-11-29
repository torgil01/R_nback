gen_df <- function(df.raw) {
# --  
# read raw df from dat file and restructure
# -- 
# traverse df.keep and build final df with following fields
# trial [0back,2back], letter [A,X..], reponse[na, or responsetime in ms] 

num_rows = 150 # size of experiment
  library(dplyr)
  library(stringr)
  
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

 remove_double_keypress <- function(df) {
  # remove doube keypresses for easy parsing 
    nrows = dim(df)[1]
    for (i in 1:nrows-1) {
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
            rt = df.raw$time[i+1] - text_onset
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
                back2_text = get_text(df.raw$desc[i-2])  
                if (disp_text == back2_text) {
                  correct = "yes"
                }
                else {
                  correct = "no"
                }
              }
            }
            i = i +1 
          }
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

          # increment counters
          trial_num = trial_num +1
          subtrial_num = subtrial_num + 1
          i = i + 1          
          }                      
      }
  }
  return(df)
}

