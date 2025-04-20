# load 'mtcars' dataset ####

setwd('Data/')
getwd()
mtcars

## what kind of object is this ####
## this is a number, you can call this with str(mtcars)
str(mtcars)
## or 
class(mtcars)
#or 
View(mtcars)

### Find cars with an mpg greater than 20 and 4 cyl ####
## save them into a new object

data("mtcars")
dat <- mtcars
dim(dat) # 32 11 shows the dimensions
str(dat)
mpg_greater_20_and_4_cyl <- dat[dat$cyl == 4, ]
mpg_greater_20_and_4_cyl <- dat[dat$mpg > 20, ]

#### Use this one lol #### 
# [row, column]
oopsImessedup <- mtcars
mpg_greater_20_and_4_cyl_haha <- oopsImessedup[oopsImessedup$mpg > 20 & oopsImessedup$cyl == 4, ]

## data(mtcars) # restores mtcars

## convert mpg to a character data type
as.character(oopsImessedup$mpg)
oopsImessedup$mpg <- as.character(oopsImessedup$mpg)
oopsImessedup$new_col <- oopsImessedup$gear * oopsImessedup$cyl

##### convert entire data frame to character data type
#you can put everything in there individually or...
str(oopsImessedup)
names(oopsImessedup)

for (col in names(oopsImessedup)) {
  print(col)
  oopsImessedup[, col] <- as.character(oopsImessedup[, col])
}
str(oopsImessedup)

# or you can: (applies to everything)
apply(oopsImessedup, 2, as.character)

## example of just using a couple of rows
new_input <- oopsImessedup
new_dat_w_new_input = apply(new_input, 2, as.character)

# making a new .csv####
write(new_dat, 'class_projects_28Jan25.csv')

#installing a package
install.packages('tidyverse')

## to call tidyverse
library(tidyverse)

# using tidyverse (shift+command+M does the percent thingy)
mtcars$mpg %>%
  mean()
mean(mtcars$mpg)
