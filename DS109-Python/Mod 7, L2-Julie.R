
install.packages("caret")
install.packages("magrittr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("lmtest")
install.packages("popbio")
install.packages("e1071")
install.packages("zoo")
install.packages("tidyverse")

library("caret")
library("magrittr")
library("dplyr")
library("tidyr")
library("lmtest")
library("popbio")
library("e1071")
library("zoo")
library(tidyverse)
library(readr)


minerals <- read_csv("Desktop/Work/WozU /Datasets/minerals.csv")
View(minerals)


mylogit <- glm(Gold ~ Antimony, data=minerals, family="binomial")

probabilities <- predict(mylogit, type = "response")

minerals$Predicted <- ifelse(probabilities > .5, "pos", "neg")

minerals$PredictedR <- NA
minerals$PredictedR[minerals$Predicted=='pos'] <- 1
minerals$PredictedR[minerals$Predicted=='neg'] <- 0

minerals$PredictedR <- as.factor(minerals$PredictedR)
minerals$Gold <- as.factor(minerals$Gold)

conf_mat <- caret::confusionMatrix(minerals$PredictedR, minerals$Gold)
conf_mat

minerals1 <- minerals %>% 
  dplyr::select_if(is.numeric)

predictors <- colnames(minerals1)

minerals1 <- minerals1 %>%
  mutate(logit=log(probabilities)/(1-probabilities)) %>%
  gather(key= "predictors", value="predictor.value", -logit)

ggplot(minerals1, aes(logit, predictor.value))+
  geom_point(size=.5, alpha=.5)+
  geom_smooth(method= "loess")+
  theme_bw()+
  facet_wrap(~predictors, scales="free_y")

plot(mylogit$residuals)

dwtest(mylogit, alternative="two.sided")

infl <- influence.measures(mylogit)
summary(infl)

summary(mylogit)

logi.hist.plot(minerals$Antimony,minerals$Gold, boxp=FALSE, 
type="hist", col="gray")











