get_empty_tibble <- function(n) {
  library(dplyr)
  df <- data.frame(
    id = character(n),
    file_date = character(n),
    file_time = character(n),
    filename = character(n),
    tot_hits_0b = integer(n),
    tot_hits_2b = integer(n),
    tot_fails_0b = integer(n),
    tot_fails_2b = integer(n),
    avg_rt_hit_0b = double(n),
    avg_rt_hit_2b = double(n),
    avg_rt_fail_0b = double(n),
    avg_rt_fail_2b = double(n),
    std_rt_hit_0b = double(n),
    std_rt_hit_2b = double(n),
    std_rt_fail_0b = double(n),
    std_rt_fail_2b = double(n), 
    min_rt_hit_0b = double(n),
    min_rt_hit_2b = double(n),   
    max_rt_hit_0b = double(n),
    max_rt_hit_2b = double(n)
  ) 
  return(df)      
}

