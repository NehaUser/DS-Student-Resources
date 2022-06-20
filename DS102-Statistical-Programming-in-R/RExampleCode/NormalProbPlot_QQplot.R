ggplot(faithful, aes(sample = eruptions)) + geom_qq() # not normally distributed

View(morley)

ggplot(morley, aes(sample = Speed)) + geom_qq() # normally distributed


