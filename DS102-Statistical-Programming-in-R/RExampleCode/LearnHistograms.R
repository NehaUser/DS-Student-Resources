#Learn Histograms

View(faithful)
faith_wait <- ggplot(faithful,aes(x=waiting))
faith_wait+geom_histogram(binwidth = 5, fill = "red", color = "deepskyblue4") + 
ggtitle("Graph for Waiting time of Old Faithful Geyser") +
  xlab("Waititng Time") + 
  ylab("Minutes")

faith_waiterupt <- ggplot(faithful,aes(x= eruptions ))
faith_waiterupt + geom_histogram()
faith_waiterupt + geom_histogram(breaks = seq(1.4, 5.2, by = .2))

faith_waiterupt + geom_histogram(binwidth = .2)






