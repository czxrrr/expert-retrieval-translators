d <- read.csv("C:/Users/Navid/Google Drive/TUWIEN/2013W/Seminar/data/aggregation_data.csv", header=TRUE, sep = ",")
gp2 <- as.numeric(unlist(d[1]))
top5 <- as.numeric(unlist(d[3]))
top1 <- as.numeric(unlist(d[2]))
feedback <- as.numeric(unlist(d[4]))

cor.test(feedback, gp2, method="spearman")
cor.test(feedback, gp2, method="kendall")

cor.test(feedback, top5, method="spearman")
cor.test(feedback, top5, method="kendall")

cor.test(feedback, top1, method="spearman")
cor.test(feedback, top1, method="kendall")

