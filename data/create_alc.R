#Miikka Haapakoski, 12.11.2020.
#This is a description for the 3rd exercise. 
library(dplyr)
library(ggplot2)
library(GGally)
library(tidyr)


por <- read.table("C:\\Users\\miikk\\Documents\\IODS-project\\data\\student-por.csv", sep = ";", header=TRUE)
math <- read.table("C:\\Users\\miikk\\Documents\\IODS-project\\data\\student-mat.csv", sep = ";", header=TRUE)


por_id <- por %>% mutate(id=1000+row_number()) 
math_id <- math %>% mutate(id=2000+row_number())


free_cols <- c("id","failures","paid","absences","G1","G2","G3")


join_cols <- setdiff(colnames(por_id),free_cols)

pormath_free <- por_id %>% bind_rows(math_id) %>% select(one_of(free_cols))


pormath <- por_id %>% 
  bind_rows(math_id) %>%
 
  group_by(.dots=join_cols) %>%  
  
  summarise(                                                           
    n=n(),
    id.p=min(id),
    id.m=max(id),
    failures=round(mean(failures)),     
    paid=first(paid),                   
    absences=round(mean(absences)),
    G1=round(mean(G1)),
    G2=round(mean(G2)),
    G3=round(mean(G3))    
  ) %>%

  filter(n==2, id.m-id.p>650) %>%  
 
  inner_join(pormath_free,by=c("id.p"="id"),suffix=c("",".p")) %>%
  inner_join(pormath_free,by=c("id.m"="id"),suffix=c("",".m")) %>%
  ungroup %>% mutate(
    alc_use = (Dalc + Walc) / 2,
    high_use = alc_use > 2,
    cid=3000+row_number()
  )
glimpse(pormath)

gather(pormath) %>% glimpse

library(openxlsx)
write.xlsx(pormath,file="C:\\Users\\miikk\\Documents\\IODS-project\\data\\pormath.xlsx")
