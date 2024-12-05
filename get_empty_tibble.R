get_empty_tibble <- function() {
  df <- tibble(id = character(0),
  tot_hits_0b = as.integer(0),
  tot_hits_2b = as.integer(0),
  tot_fails_0b = as.integer(0),
  tot_fails_2b = as.integer(0),
  avg_rt_hit_0b = as.double(0),
  avg_rt_hit_2b = as.double(0),
  avg_rt_fail_0b = as.double(0),
  avg_rt_fail_2b = as.double(0)
  ) 
  return(df)      
}
