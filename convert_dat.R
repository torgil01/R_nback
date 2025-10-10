convert_dat <- function(data_dir) {
  library(dplyr)

  source(here::here("gen_df.R"))
  source(here::here("get_id.R"))
  source(here::here("convert_to_row.R"))
  source(here::here("get_empty_tibble.R"))
  source(here::here("read_dat.R"))

  # ------ MAIN ------------

  data_files <- list.files(data_dir, pattern = ".log", full.names = TRUE)

  # allocate the final df
  df <- get_empty_tibble(length(data_files))

  for (i in 1:length(data_files)) {
    cat("parsing ", data_files[i], "\n")
    df.raw <- read_dat(data_files[i])
    # check if test is complete, we need
    # 1. the sync trigger at the start
    # 2. that the test was completed.
    if (
      (any(
        str_detect(df.raw$desc, "text_13: text = 'Oppgaven er ferdig.") == TRUE
      )) &
        (any(str_detect(df.raw$desc, "Keypress: s")))
    ) {
      # remove stuff after end of exp
      last_line <- match(
        TRUE,
        str_detect(df.raw$desc, "text_13: text = 'Oppgaven er ferdig.")
      )
      df.raw <- df.raw[1:last_line, ]
      # complete test
      cat("test is complete: ", data_files[i], "\n")
      df.id <- gen_df(df.raw)
      id <- get_id(data_files[i])
      cat("id = ", id, "\n")
      df.row <- convert_to_row(id, df.id, basename(data_files[i]))
      cat(df.row$id[1])
      df <- df %>% add_row(df.row)
      cat("success ", data_files[i], "\n")
    } else {
      cat(data_files[i], "is incomplete .. skipping", "\n")
    }
  }

  # some cleanup
  df <- df %>% filter(id != "") %>% mutate(id = str_remove(id, "\\.$"))

  # add source label
  df <- df %>% mutate(source = "MR")

  # convert date
  df$file_date <- as.Date(df$file_date, format = "%Y-%m-%d")
  # convert time

  # rename vars for consistency
  df <- df %>%
    rename(test_date = file_date, test_time = file_time)
  return(df)
}
