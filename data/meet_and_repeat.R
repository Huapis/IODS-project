library(dplyr) 
library(tidyr)
library(ggplot2)

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = TRUE, sep = " ")
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

#Libraries and datasets loaded to the r script. 

str(BPRS)
str(RATS)

summary(BPRS)
summary(RATS)

names(BPRS)
names(RATS)

#Summary of the variables, structure and the column names. 

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)


# Factor variables ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Glimpse the data
glimpse(RATS)

# Convert data to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

# Glimpse the data
glimpse(RATSL)

#Saving the data for the next analyse phase. 
write.table(BPRSL, file="~/R/win-library/4.0/IODS-project/data/BPRSL.txt", row.names = TRUE, sep  =" ")
write.table(RATSL, file="~/R/win-library/4.0/IODS-project/data/RATSL.txt", row.names = TRUE, sep = '\t')
