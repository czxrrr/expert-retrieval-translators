d <- read.csv("C:/Users/Navid/Documents/GitHub/expert-retrieval-translators/data/l2r_cv_results.csv", header=FALSE, sep = ",")
i=5
cv1<- as.numeric(d[i,3])
cv2<- as.numeric(d[i,4])
cv3<- as.numeric(d[i,5])
cv4<- as.numeric(d[i,6])
cv5<- as.numeric(d[i,7])


x = c(cv1,cv2,cv3,cv4,cv5)

d[i,1]
d[i,2]
t.test(x)