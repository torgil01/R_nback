summarize_trial2 <- function(df.id) {
  # Summarize data from n-back trial
  library(dplyr)
  source("get_empty_tibble2.R")

  df.row <- get_empty_tibble2(1)

  df.row$id <- df.id$id[1]
  df.row$trial <- as.character(df.id$trial[1])
  df.row$test_date <- as.character(df.id$date[1])
  df.row$test_time <- df.id$time[1]
  df.row$filename <- df.id$filename[1]
  df.row$complete_trial <- "yes"

  # # Correct responses (either correct keypress or correct no-response)
  # df.row$num_correct_0b <- df.id |> filter(cond == "0b") |> filter(corrAns == "space") |> filter(key_resp.keys == "space") |>
  #   filter(correct_resp == TRUE) |> nrow()
  # df.row$num_correct_2b <- df.id |> filter(cond == "2b") |> filter(corrAns == "space") |> filter(key_resp.keys == "space") |>
  #   filter(correct_resp == TRUE) |> nrow()

  # # Misses: should have responded but didn't (correct_resp == FALSE AND no response)
  # df.row$num_miss_0b <- df.id |> filter(cond == "0b" & correct_resp == FALSE & is.na(key_resp.rt)) |> nrow()
  # df.row$num_miss_2b <- df.id |> filter(cond == "2b"& correct_resp == FALSE & is.na(key_resp.rt)) |> nrow()

  # # Errors: gave wrong response (correct_resp == FALSE AND did respond)
  # df.row$num_errors_0b <- df.id |> filter(cond == "0b" & correct_resp == FALSE & !is.na(key_resp.rt)) |> nrow()
  # df.row$num_errors_2b <- df.id |> filter(cond == "2b" & correct_resp == FALSE & !is.na(key_resp.rt)) |> nrow()

  # RT calculations with NaN handling
  # df.row$rt_correct_0b <- df.id |> filter(cond == "0b", correct_resp == TRUE, !is.na(key_resp.rt)) |>
  #   summarise(rt = ifelse(n() > 0, mean(key_resp.rt), NA_real_)) |> pull()
  # df.row$rt_correct_2b <- df.id |> filter(cond == "2b", correct_resp == TRUE, !is.na(key_resp.rt)) |>
  #   summarise(rt = ifelse(n() > 0, mean(key_resp.rt), NA_real_)) |> pull()
  # df.row$rt_errors_0b <- df.id |> filter(cond == "0b", correct_resp == FALSE, !is.na(key_resp.rt)) |>
  #   summarise(rt = ifelse(n() > 0, mean(key_resp.rt), NA_real_)) |> pull()
  # df.row$rt_errors_2b <- df.id |> filter(cond == "2b", correct_resp == FALSE, !is.na(key_resp.rt)) |>
  #   summarise(rt = ifelse(n() > 0, mean(key_resp.rt), NA_real_)) |> pull()

  # # SD calculations with NaN handling
  # df.row$std_correct_0b <- df.id |> filter(cond == "0b", correct_resp == TRUE, !is.na(key_resp.rt)) |>
  #   summarise(std = ifelse(n() > 1, sd(key_resp.rt), NA_real_)) |> pull()
  # df.row$std_correct_2b <- df.id |> filter(cond == "2b", correct_resp == TRUE, !is.na(key_resp.rt)) |>
  #   summarise(std = ifelse(n() > 1, sd(key_resp.rt), NA_real_)) |> pull()
  # df.row$std_errors_0b <- df.id |> filter(cond == "0b", correct_resp == FALSE, !is.na(key_resp.rt)) |>
  #   summarise(std = ifelse(n() > 1, sd(key_resp.rt), NA_real_)) |> pull()
  # df.row$std_errors_2b <- df.id |> filter(cond == "2b", correct_resp == FALSE, !is.na(key_resp.rt)) |>
  #   summarise(std = ifelse(n() > 1, sd(key_resp.rt), NA_real_)) |> pull()

  # num hits pr cond
  df.row$hit0 <- df.id %>%
    filter(cond == "0b") %>%
    summarise(sum(hit)) %>%
    pull()
  df.row$hit2 <- df.id %>%
    filter(cond == "2b") %>%
    summarise(sum(hit)) %>%
    pull()
  # num false positives for cond
  df.row$false0 <- df.id %>%
    filter(cond == "0b") %>%
    summarise(sum(false)) %>%
    pull()
  df.row$false2 <- df.id %>%
    filter(cond == "2b") %>%
    summarise(sum(false)) %>%
    pull()
  # num corejects pr cond
  df.row$coreject0 <- df.id %>%
    filter(cond == "0b") %>%
    summarise(sum(coreject)) %>%
    pull()
  df.row$coreject2 <- df.id %>%
    filter(cond == "2b") %>%
    summarise(sum(coreject)) %>%
    pull()

  # RTs
  df.row$rt_hit0 <- df.id %>%
    filter(cond == "0b") %>%
    filter((hit == 1) & !is.na(key_resp.rt)) %>%
    summarise(mean(key_resp.rt)) %>%
    pull()
  df.row$rt_hit2 <- df.id %>%
    filter(cond == "2b") %>%
    filter((hit == 1) & !is.na(key_resp.rt)) %>%
    summarise(mean(key_resp.rt)) %>%
    pull()
  df.row$sd_hit0 <- df.id %>%
    filter(cond == "0b") %>%
    filter((hit == 1) & !is.na(key_resp.rt)) %>%
    summarise(sd(key_resp.rt)) %>%
    pull()
  df.row$sd_hit2 <- df.id %>%
    filter(cond == "2b") %>%
    filter((hit == 1) & !is.na(key_resp.rt)) %>%
    summarise(sd(key_resp.rt)) %>%
    pull()

  df.row$rt_false0 <- df.id %>%
    filter(cond == "0b") %>%
    filter((false == 1) & !is.na(key_resp.rt)) %>%
    summarise(mean(key_resp.rt)) %>%
    pull()
  df.row$rt_false2 <- df.id %>%
    filter(cond == "2b") %>%
    filter((false == 1) & !is.na(key_resp.rt)) %>%
    summarise(mean(key_resp.rt)) %>%
    pull()
  df.row$sd_false0 <- df.id %>%
    filter(cond == "0b") %>%
    filter((false == 1) & !is.na(key_resp.rt)) %>%
    summarise(sd(key_resp.rt)) %>%
    pull()
  df.row$sd_false2 <- df.id %>%
    filter(cond == "2b") %>%
    filter((false == 1) & !is.na(key_resp.rt)) %>%
    summarise(sd(key_resp.rt)) %>%
    pull()

  return(df.row)
}
