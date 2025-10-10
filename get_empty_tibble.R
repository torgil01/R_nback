get_empty_tibble <- function(n) {
  library(dplyr)
  df <- data.frame(
    id = character(n),
    file_date = character(n),
    file_time = character(n),
    filename = character(n),
    hit0 = double(n),
    hit2 = double(n),
    false0 = double(n),
    false2 = double(n),
    coreject0 = double(n),
    coreject2 = double(n),
    rt_hit0 = double(n),
    rt_hit2 = double(n),
    rt_false0 = double(n),
    rt_false2 = double(n),
    sd_hit0 = double(n),
    sd_hit2 = double(n),
    sd_false0 = double(n),
    sd_false2 = double(n)  ) 
  return(df)      
}


#tot_hits_0b = integer(n),
    # tot_hits_2b = integer(n),
    # tot_fails_0b = integer(n),
    # tot_fails_2b = integer(n),
    
