convert_csv <- function(csv_file) {
  library(readr)
  library(dplyr)
  library(rlang)

  df_raw <- read_csv(csv_file)
  cond_array = c("0b","2b","0b","2b","0b","2b","0b","2b","0b","2b")
  df.list = vector(mode = "list", length = 10)
  trial=1:150
  for (i in 1:10) {
    v1 <- paste0("letter",i-1)
    v2 <- paste0("target",i-1)
    v3 <- paste0("corrAns",i-1)
    vars = c(v1,v2,v3)
    df.list[[i]] <- df_raw %>% 
      select(matches(vars)) %>% 
      filter(!is.na(!!sym(vars[[1]][1]))) %>%
      slice_head(n = 15) %>% 
      mutate(cond = cond_array[i]) %>%      
      rename_with(~gsub('[[:digit:]]+', "", .))
    trial = trial +1
  } # block verified

  df <- bind_rows(df.list[[1]],
    df.list[[2]],
    df.list[[3]],
    df.list[[4]],
    df.list[[5]],
    df.list[[6]],
    df.list[[7]],
    df.list[[8]],
    df.list[[9]],
    df.list[[10]])
    df <- df %>% mutate(trial = trial )
  
    df <- df %>% mutate(corrAns = if_else(corrAns =="space", "a","None"))
  
  
  
  # letter blocks : paradigm uses only the 1st 15 letters of each block
  # The order is 0b - 2b - 0b - 2b .. (5 of each)
  # we only need 
  # key_resp.keys key_resp_?.keys
  # key_resp.rt "key_resp_?.rt
  # no order in the numbering 
  num_str = c("." ,"_2." ,"_3.", "_4.","_12.","_13.","_14.","_16.","_15.","_6.")    
  df.list = vector(mode = "list", length = 10)
  for (i in 1:10) {
    v1 <- paste0("key_resp",num_str[i],"keys")
    v2 <- paste0("key_resp",num_str[i],"rt")  
    vars = c(v1,v2)
    df.list[[i]] <- df_raw %>% 
      select(matches(vars)) %>% 
      filter(!is.na(!!sym(vars[[1]][1]))) %>%
      slice_head(n = 15) %>%       
      rename_with(~gsub('[[:digit:]]+', "", .))   
    if (i > 1) {
      df.list[[i]] <- df.list[[i]]  %>%
        rename(key_resp.rt = key_resp_.rt,
          key_resp.keys = key_resp_.keys)      
    }
  } # block verified

  df.resp <- bind_rows(df.list[[1]],
    df.list[[2]],
    df.list[[3]],
    df.list[[4]],
    df.list[[5]],
    df.list[[6]],
    df.list[[7]],
    df.list[[8]],
    df.list[[9]],
    df.list[[10]])
  
  df.resp <- df.resp %>% mutate(trial = trial )  
  df <- df %>% left_join(df.resp)
  df <- df %>% mutate(correct_resp = if_else(corrAns == key_resp.keys,TRUE,FALSE))
  return(df)
}
  
  