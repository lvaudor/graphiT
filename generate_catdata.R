
f=function(types,proportions,n){
  result=c()
  for (i in 1:length(types)){
    result=c(result,rep(types[i],round(n*proportions[i])))
  }
  result=sample(result,n,replace=T)
  return(result)
}

n=153
###########
v_haircolor=c("white","brown","red","black")
p_haircolor=c(0.2,0.1,0.2,0.5)
haircolor=f(v_haircolor,p_haircolor,n)
###########
v_hairpattern=c("solid","tortoise","tabby","colorpoint","tipped")
p_hairpattern=c(0.2,0.15,0.4,0.1,0.15)
hairpattern=f(v_hairpattern,p_hairpattern,n)
###########
sex=sample(c("male","female"),n,replace=T)
###########
weight=rep(NA,n)
indmale=which(sex=="male")
indfemale=which(sex=="female")
weight[indmale]=rnorm(length(indmale),5,1)
weight[indfemale]=rnorm(length(indfemale),4.7,1)
weight=round(weight,1)
###########
age=round(rlnorm(n,1.8,0.4))
###########
v_foodtype=c("wet","dry","other")
p_foodtype=c(0.3,0.6,0.1)
foodtype=f(v_foodtype,p_foodtype,n)
###########
data=data.frame(haircolor,hairpattern,sex,weight,age,foodtype)
write.table(data,"catdata.csv",sep=";", row.names=FALSE)

