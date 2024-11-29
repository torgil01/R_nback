convert_dat <- function(filename) {
  source(here::here("gen_df.R"))
  source(here::here("read_dat.R"))

  df.raw <- read_dat(filename)
  df <- gen_df(df.raw)

}