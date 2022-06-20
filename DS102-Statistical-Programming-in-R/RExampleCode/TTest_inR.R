# Single Sample Ttest on frostedflakes

t_Obj <- t.test(frostedflakes$Lab , mu = 37)
print(t_Obj)

#Plot a histogram

d <- ggplot(frostedflakes, aes(x = Lab))
d + geom_histogram(binwidth = 1) +
  geom_vline(xintercept = t_Obj$conf.int[1], color = "red") +
  geom_vline(xintercept = t_Obj$conf.int[2], color = "red") +
  geom_vline(xintercept = t_Obj$null.value, color = "green")
 
# To plot a normal distribution curve

ggplot(frostedflakes, aes(sample = Lab)) +
  geom_qq()

#To make a vector of the given values in LakeHuron
Value_LHuron <- c(580.38, 581.86, 580.97, 580.80, 579.79, 580.39, 580.42, 580.82, 581.40, 581.32, 581.44, 581.68, 581.17,
                   580.53, 580.01, 579.91, 579.14, 579.16, 579.55, 579.67, 578.44, 578.24, 579.10, 579.09, 579.35, 578.82,
                  579.32, 579.01, 579.00, 579.80, 579.83, 579.72, 579.89, 580.01, 579.37, 578.69, 578.19, 578.67, 579.55,
                   578.92, 578.09, 579.37, 580.13, 580.14, 579.51, 579.24, 578.66, 578.86, 578.05, 577.79, 576.75, 576.75,
                   577.82, 578.64, 580.58, 579.48, 577.38, 576.90, 576.94, 576.24, 576.84, 576.85, 576.90, 577.79, 578.18,
                   577.51, 577.23, 578.42, 579.61, 579.05, 579.26, 579.22, 579.38, 579.10, 577.95, 578.12, 579.75, 580.85,
                   580.41, 579.96, 579.61, 578.76, 578.18, 577.21, 577.13, 579.10, 578.25, 577.91, 576.89, 575.96, 576.80,
                   577.68, 578.38, 578.52, 579.74, 579.31, 579.89, 579.96)
head(LakeHuron)
View(LakeHuron)
LH.df <- data.frame(Value_LHuron)
LH.df
t_Obj1 <- t.test(LH.df$Value_LHuron , mu = 577)
print(t_Obj1)

#Independent t-test

View(frostedflakes)

t_IndObj <- t.test(frostedflakes$Lab, frostedflakes$IA400, alternative = "two.sided", var.equal = FALSE)
t_IndObj

#library(reshape2)

ff <- melt(frostedflakes, id = "X") # puts the data from both lab and IA400 in 1 column with id telling the source

#to plot box plot
ggplot(ff) + geom_boxplot(aes(x= variable, y = value)) +
  xlab("Test Method") + ylab("Percentage of Sugar")

#Dependent t tests or Paired t test

t_dep <- t.test(scores$postest, scores$pretest, paired = TRUE)
t_dep

mean(scores$pretest)
mean(scores$postest)

ss <- melt(scores, measure.vars = c("pretest", "postest"))

ggplot(ss) + geom_boxplot((aes(x= variable, y= value))) + 
  xlab("Test") + ylab("Score")
#to create histogram 
dd <- scores$postest - scores$pretest
df <- data.frame(dd)
ggplot(df, aes(x = dd)) + geom_histogram(binwidth = 1) +
  xlab("Difference between postest and pretest")





