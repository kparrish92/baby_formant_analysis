plot_data %>% 
  select(type, f1,f2,f3,f1e,f2e,f3e,f1b,f2b,f3b, fileID) %>% 
  rbind(no_coart_data) %>% 
  pivot_longer(f1:f3b, names_to = "formant_e", values_to = "hertz") %>% 
  mutate(time_point = 
           case_when(
             formant_e == "f1" | formant_e == "f2" | formant_e == "f3" ~ "mid",
             formant_e == "f1b" | formant_e == "f2b" | formant_e == "f3b" ~ "onset",
             formant_e == "f1e" | formant_e == "f2e" | formant_e == "f3e" ~ "offset"
           )) %>% 
  mutate(formant = 
           case_when(
             formant_e == "f1" | formant_e == "f1e" | formant_e == "f1b" ~ "f1",
             formant_e == "f2" | formant_e == "f2e" | formant_e == "f2b" ~ "f2",
             formant_e == "f3" | formant_e == "f3e" | formant_e == "f3b" ~ "f3"
           )) %>% 
  group_by(consonant, formant, time_point) %>% 
  summarise(mean_formant = mean(hertz)) 
library(here)
library(tidyverse)
# plots 

plot_data = read.csv(here("data", "text_tidy.csv"))

no_coart_data = read.csv(here("data", "formants_nocoart.csv")) %>% 
  mutate(type = "no_coart")


# compare coart and non 


plot_data %>% 
  select(type, f1,f2,f3,f1e,f2e,f3e,f1b,f2b,f3b, fileID) %>% 
  rbind(no_coart_data) %>% 
  ggplot(aes(y = f1, x = f2, color = type)) + geom_point(size = 2) + scale_x_reverse() + 
  scale_y_reverse() + theme_minimal()

plot_data %>% 
  select(type, f1,f2,f3,f1e,f2e,f3e,f1b,f2b,f3b, fileID) %>% 
  rbind(no_coart_data) %>% 
  ggplot(aes(y = f1e, x = f2e, color = type)) + geom_point(size = 2) + scale_x_reverse() + 
  scale_y_reverse() + theme_minimal()


plot_data %>% 
  select(type, f1,f2,f3,f1e,f2e,f3e,f1b,f2b,f3b, fileID) %>% 
  rbind(no_coart_data) %>% 
  ggplot(aes(y = f1b, x = f2b, color = type)) + geom_point(size = 2) + scale_x_reverse() + 
  scale_y_reverse() + theme_minimal()



# 3, 11, 14, 17, 26, 29, 30, 40, 42, 43



plot_data_tp = plot_data %>% 
  select(fileID, type, consonant, f1,f2,f3,f1e,f2e,f3e,f1b,f2b,f3b) %>% 
  pivot_longer(f1:f3b, names_to = "formant_e", values_to = "hertz") %>% 
  mutate(time_point = 
           case_when(
             formant_e == "f1" | formant_e == "f2" | formant_e == "f3" ~ "mid",
             formant_e == "f1b" | formant_e == "f2b" | formant_e == "f3b" ~ "onset",
             formant_e == "f1e" | formant_e == "f2e" | formant_e == "f3e" ~ "offset"
           )) %>% 
  mutate(formant = 
           case_when(
             formant_e == "f1" | formant_e == "f1e" | formant_e == "f1b" ~ "f1",
             formant_e == "f2" | formant_e == "f2e" | formant_e == "f2b" ~ "f2",
             formant_e == "f3" | formant_e == "f3e" | formant_e == "f3b" ~ "f3"
           )) %>% 
  group_by(consonant, formant, time_point) %>% 
  summarise(mean_formant = mean(hertz)) 


plot_data_tp$time_point <- factor(plot_data_tp$time_point, levels=c("onset", "mid", "offset"))

plot_data_tp %>% 
  ggplot(aes(x = time_point, y = mean_formant, color = formant, group = formant)) + geom_point() + 
  facet_wrap(~consonant) + geom_line() + theme_minimal()


plot_type = plot_data %>% 
  select(type, f1,f2,f3,f1e,f2e,f3e,f1b,f2b,f3b, fileID) %>% 
  rbind(no_coart_data) %>% 
  pivot_longer(f1:f3b, names_to = "formant_e", values_to = "hertz") %>% 
  mutate(time_point = 
           case_when(
             formant_e == "f1" | formant_e == "f2" | formant_e == "f3" ~ "mid",
             formant_e == "f1b" | formant_e == "f2b" | formant_e == "f3b" ~ "onset",
             formant_e == "f1e" | formant_e == "f2e" | formant_e == "f3e" ~ "offset"
           )) %>% 
  mutate(formant = 
           case_when(
             formant_e == "f1" | formant_e == "f1e" | formant_e == "f1b" ~ "f1",
             formant_e == "f2" | formant_e == "f2e" | formant_e == "f2b" ~ "f2",
             formant_e == "f3" | formant_e == "f3e" | formant_e == "f3b" ~ "f3"
           )) %>% 
  group_by(type, formant, time_point) %>% 
  summarise(mean_formant = mean(hertz)) 


plot_type$time_point <- factor(plot_type$time_point, levels=c("onset", "mid", "offset"))

plot_type %>% 
  ggplot(aes(x = time_point, y = mean_formant, color = formant, group = formant)) + geom_point() + 
  facet_wrap(~type) + geom_line() + theme_minimal()


