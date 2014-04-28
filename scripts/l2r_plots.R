d <- read.csv("C:/Users/Navid/Documents/GitHub/expert-retrieval-translators/data/l2r_results.csv", header=TRUE, sep = ",")
algorithms <- unlist(d[1])
methods<- unlist(d[2])
evaluation<- as.numeric(unlist(d[3]))
cimin<- as.numeric(unlist(d[4]))
cimax<- as.numeric(unlist(d[5]))
random<- as.numeric(unlist(d[6]))


df <- data.frame(algorithms, methods, evaluation, cimin, cimax, random)

library(ggplot2)

ggplot(df, aes(x=reorder(algorithms, -evaluation), fill=methods)) +
geom_bar(aes(y=evaluation),
	position=position_dodge(), 
	stat="identity") +
geom_line(aes(y=random, 
	group=methods),
	colour="darkgreen",
	lwd = 1)+
geom_errorbar(aes(ymin=cimin, ymax=cimax), 
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