library(here)
library(tidyverse)
library(stringr)

text = read.csv(here("data", "text.csv"))

text_list = list()

for (i in 1:64) {
text_list[[i]] = data.frame(file_name_append = c(paste0(text$Item[i],"_V1"),
                                paste0(text$Item[i],"_V2")),
           sentence = text$Sentence[i],
           consonant = text$consonant[i],
           type = text$type[i])
}

text_df = do.call(rbind, text_list)

for(thisRun in 1:nrow(text_df))
{
  filename <- text_df$file_name_append[thisRun]  
  direc <- paste("data", "/", "txt_files", "/", 
                 filename, sep = "")
  end <- ".txt"
  path <- paste0(direc,end)
  fileConn<-file(paste0(path))
  writeLines(text_df$sentence[thisRun], fileConn)
  close(fileConn)
}
