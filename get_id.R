get_id <- function(fname) {
  # extract id from filename
  fn <- basename(fname)
  # filename is like
  # id_xxxx
  pos <- str_locate(fn,"_")  
  id <- substring(fn,1,pos[1]-1)  
  return(id)
}

