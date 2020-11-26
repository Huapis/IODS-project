#Miikka Haapakoski
#This is the file description
# original data source http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt

library(dplyr)
library(ggplot2)
library(tidyr)
library(corrplot)
library(knitr)
library(stringr)

##The HDI was created to emphasize that people and their capabilities should be the ultimate criteria for assessing the development of a country, not economic growth alone. The HDI can also be used to question national policy choices, asking how two countries with the same level of GNI per capita can end up with different human development outcomes. These contrasts can stimulate debate about government policy priorities.
#The Human Development Index (HDI) is a summary measure of average achievement in key dimensions of human development: a long and healthy life, being knowledgeable and have a decent standard of living. The HDI is the geometric mean of normalized indices for each of the three dimensions.

#The health dimension is assessed by life expectancy at birth, the education dimension is measured by mean of years of schooling for adults aged 25 years and more and expected years of schooling for children of school entering age. The standard of living dimension is measured by gross national income per capita. The HDI uses the logarithm of income, to reflect the diminishing importance of income with increasing GNI. The scores for the three HDI dimension indices are then aggregated into a composite index using geometric mean. Refer to Technical notes for more details.

#The HDI simplifies and captures only part of what human development entails. It does not reflect on inequalities, poverty, human security, empowerment, etc. The HDRO offers the other composite indices as broader proxy on some of the key issues of human development, inequality, gender disparity and poverty.

#A fuller picture of a country's level of human development requires analysis of other indicators and information presented in the statistical annex of the report.


human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep=",", header=TRUE)

dim(human)
names(human)
str(human)
summary(human)

#Dataset includes 195 observations and 19 variables. 

#Mutating the GNI variable to numeric.

str(human$GNI)
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

#Excluding the unneeded variables and removing all the rows with missing values

keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

human <- select(human, one_of(keep))

complete.cases(human)

data.frame(human[-1], comp = complete.cases(human))

human <- filter(human, complete.cases(human))

str(human)

#Remove the observations which relate to regions instead of countries.

tail(human, 10)

last <- nrow(human) - 7

human <- human[1:last, ]

str(human)

#Define the row names of the data by the country names and remove the country name column from the data. The data should now have 155 observations and 8 variables. Save the human data in your data folder including the row names. You can overwrite your old ‘human’ data. (1 point)

rownames(human) <- human$Country

human <- select(human, -Country)

dim(human)

str(human)

summary(human)

#Human data saved for later use with rownames 

write.xlsx(human,file="~/R/win-library/4.0/IODS-project/data/human.xlsx", rowNames = TRUE)

human <- read.xlsx("~/R/win-library/4.0/IODS-project/data/human.xlsx", rowNames = TRUE)
dim(human)
