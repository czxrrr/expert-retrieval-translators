d <- read.csv("C:/Users/Navid/Documents/GitHub/expert-retrieval-translators/data/orders_aggregation.csv", header=TRUE, sep = ",")
gp2 <- as.numeric(unlist(d[1]))
top5 <- as.numeric(unlist(d[3]))
top1 <- as.numeric(unlist(d[2]))
feedback <- as.numeric(unlist(d[4]))

gp2_normalized = (gp2-min(gp2))/(max(gp2)-min(gp2))
top5_normalized = (top5-min(top5))/(max(top5)-min(top5))
top1_normalized = (top1-min(top1))/(max(top1)-min(top1))


plot(feedback, gp2_normalized, xlab="", ylab="", pch=19)

