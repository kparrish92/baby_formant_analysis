
# Loading package
library(e1071)
library(caTools)
library(caret)

data = read.csv(here("data", "text_tidy.csv")) %>% 
  filter(f2 > 2000 & f1 > 750 & type == "fricative" | type == "approximant")
  
removed_stimuli = read.csv(here("data", "text_tidy.csv")) %>% 
  filter(f2 < 2000 & f1 < 750 & type == "fricative") %>% 
  select(fileID) %>% 
  separate(fileID, into = c("no", "version")) %>% 
  group_by(no) %>% 
  summarize(n = n()) %>% filter(n == 2) %>% select(no)

as.numeric(removed_stimuli$no)

# 3, 11, 14, 17, 26, 29, 30, 40, 42, 43

# Splitting data into train
# and test data


run_classifier(.7)


mid_formant_df = data %>% select(type, f1, f2, f3)
onset_formant_df = data %>% select(type, f1b, f2b, f3b)
offset_formant_df = data %>% select(type, f1e, f2e, f3e)


run_classifier(mid_formant_df, .7)


run_classifier = function(data, split)
{  
split <- sample.split(data, SplitRatio = split)
train_cl <- subset(data, split == "TRUE")
test_cl <- subset(data, split == "FALSE")

# Fitting Naive Bayes Model 
# to training dataset
#set.seed(120)  # Setting Seed
classifier_cl <- naiveBayes(type ~ ., data = train_cl)
classifier_cl

# Predicting on test data'
y_pred <- predict(classifier_cl, newdata = test_cl)

# Confusion Matrix
cm <- table(test_cl$type, y_pred)
cm

# Model Evaluation
return(confusionMatrix(cm))
}