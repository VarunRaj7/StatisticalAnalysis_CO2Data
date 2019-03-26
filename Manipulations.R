# loading package library(dplyr) 
 
# Getting to data to df  df<-CO2 
 
# Changing the concentration levels as described in 1. Part-A  
df2 <- df %>% 
       mutate (conc_new=case_when(conc==95 ~ "1", conc==175 ~ "2",conc==250 ~ "3", conc==350 ~ "4",conc==500 ~ "5", conc==675 ~ "6",conc==1000 ~ "7")) 
 
# Getting relevant data columns df3<-df2[, c(1:3,6,5)] 
 
# Changing the type and treatment as described in 1. Part-A 

df4 <- df3 %>% 
       mutate (Type_new=case_when(Type=="Quebec" ~ "Q", Type=="Mississippi" ~ "M"), Treament_new = case_when(Treatment=="nonchilled"~"NC",Treatment=="chilled"~"C")) 
 
# Getting relevant data columns 

df5<-df4[, c(1,6,7,4,5)] 
 
# Writing df to a file 

write.csv (x=df5,file="C:/Users/Varun/Desktop/Spring 2019/Statistical Computing/co2_n.csv") 
