
formants = read.csv(here("data", "formants.csv")) 

text = read.csv(here("data", "text.csv"))


text_list = list()

for (i in 1:64) {
  text_list[[i]] = data.frame(file_name_append = c(paste0(text$Item[i],"_V1"),
                                                   paste0(text$Item[i],"_V2")),
                              sentence = text$Sentence[i],
                              consonant = text$consonant[i],
                              type = text$type[i])
}


text_df = do.call(rbind, text_list) %>% 
  select(file_name_append, type, consonant, sentence) %>% 
  rename("fileID" = "file_name_append") %>% 
  left_join(formants)

text_df %>% 
  write.csv(here("data", "text_tidy.csv"))
