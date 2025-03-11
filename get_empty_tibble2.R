get_empty_tibble2 <- function(n) {
  library(dplyr)
  df <- data.frame(
    id = character(n),
    trial = character(n),
    test_date = character(n),
    test_time = character(n),
    filename = character(n),
    num_correct_0b = integer(n),
    num_correct_2b = integer(n),
    num_errors_0b = integer(n),
    num_errors_2b = integer(n),
    num_miss_0b = integer(n),
    num_miss_2b = integer(n),
    rt_correct_0b  = double(n),
    rt_correct_2b = double(n),
    rt_errors_0b  = double(n),
    rt_errors_2b  = double(n),
    std_correct_0b = double(n),
    std_correct_2b = double(n),
    std_errors_0b = double(n),
    std_errors_2b = double(n)    
  ) 

 # df$test_date <- as.Date(df$test_date,format ="%Y-%m-%d")

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

  return(df)      
}

