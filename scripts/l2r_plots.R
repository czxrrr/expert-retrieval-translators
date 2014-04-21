d <- read.csv("C:/Users/Navid/Documents/GitHub/expert-retrieval-translators/data/l2r_results.csv", header=TRUE, sep = ",")
algorithms <- unlist(d[1])
evaluation_method<- unlist(d[2])
evaluation<- as.numeric(unlist(d[3]))
evaluation_random<- as.numeric(unlist(d[4]))

cols <- c("algorithms"="#f04546","evaluation_method"="#3591d1","evaluation"="#62c76b","evaluation_random"="#62c76b")

df <- data.frame(algorithms, evaluation_method, evaluation, evaluation_random)

library(ggplot2)

ggplot(df, aes(x=reorder(algorithms, -evaluation), fill=evaluation_method)) +
geom_bar(aes(y=evaluation),
	position=position_dodge(), 
	stat="identity") +
geom_line(aes(y=evaluation_random, 
	group=evaluation_method),
	colour="darkgreen",
	lwd = 1)+
geom_errorbar(aes(ymin=evaluation-.01, ymax=evaluation+.01), 
	size=1,
	width=.4,
	position=position_dodge(.9))+
xlab("") +
ylab("") +
ggtitle("") +
theme_bw()+
theme(legend.position="bottom",
	axis.text.x = element_text(angle = 60, hjust = 1))+
scale_fill_discrete("")+
coord_cartesian(ylim = c(.3, 1))