getwd()
# to go to a different directory, type out the entire file path like /Users/batman...
list.files()
# Here is a note ####
## 2nd Level of note ####
### ?list.files() ####
#### any command with a ? in front will give you an explanation ####
echo 'this is a first commit'
'this' # '' indicates a string####
list.files(path = 'Assignments/')
list.files(path = 'Assignments/', recursive = T)
list.files(path = 'Assignments/', recursive = F)

# recursive = F (default): only search the current directory ####
# resursive = T : search current and subdirectories ####


list.files(path = 'Data/', pattern = '.txt', recursive = T)
list.files(path = 'Data/', pattern = '.csv') ## prints results


## How many files under 'Data/' directory, including subdirectories

total_files <- list.files(path = 'Data/', recursive = T) ## saves results
# When naming, do not add spaces but use and underscore

length(total_files)
length(list.files(path = 'Data/', recursive = T))

echo 'some' # print on screen

echo 'some' > README.md #save into README.md


# echo in bash = print() in R
print('something')
print(total_files)

print(list.files(path = 'Assignments', recursive = F))

list.files() # () means that it is a function



?list.files

list.files(path = 'Data/', pattern = '.csv')

list.files(path = 'Data/', pattern = '^b', recursive = T) # ^ means files beginning with a certain letter

list.files(path = 'Data/', pattern = '^B', recursive = T)

## to learn more, search: regex (regular expressions)

# end with
list.files(path = 'Data/', pattern = 'b$', recursive = T)


# read a file
readLines('Data/cleaned_bird_data.csv')

# in R, = and <- are the same

line = readLines('Data/cleaned_bird_data.csv')
length(line)


line = readLines('Data/wide_income_rent.csv')
line
length(line)


## read a file and save into an object
df_rent_by_state = read.csv('Data/wide_income_rent.csv')
df_rent_by_state
dim(df_rent_by_state) # 2 53 [no. of rows, no of columns]

df_rent_by_state_no_header = read.csv('Data/wide_income_rent.csv', header = F) # saying that you do not have a header, so anything not numerical has a value
dim(df_rent_by_state_no_header)

df_rent_by_state = read.csv('Data/wide_income_rent.csv', row.names = 1)
df_rent_by_state


read.csv("Data/wingspan_vs_mass.csv")

df <- read.csv("Data/wingspan_vs_mass.csv")

head(df, 5)

b_files <- list.files(path = "Data", pattern = "^b", full.names = TRUE, recursive = TRUE)

cat("First line of files starting with 'b':\n")
for (file in b_files) {
  first_line <- readLines(file, n = 1)
  cat(paste("File:", file, "\nFirst line:", first_line, "\n\n"))
}

getwd()

#Using a different code

list.files('Data/', pattern = '^b', recursive = T)


read.csv()

readLines('Data/data-shell/creatures/basilisk.dat', n = 1)

readLines('Data/Messy_Take2/b_df.csv', n = 1)

# In class

vec <- c(1, 2, 3)

bfile <- list.files(pattern = '^b', recursive = T)

## Option 1
for (file in bfile) {
  setwd('/Users/batman/Desktop/BIOL3100/Data_Course_HENSTROM/Data/')
  readLines(file, n = 1)
}

## Option 2
for (file in bfile) {
  filepath <- paste0('/Users/batman/Desktop/BIOL3100/Data_Course_HENSTROM/Data/', file)
  print(filepath)
  first_line <- readLines(filepath, n = 1)
  print(first_line)
}

## Option 3
for (file in bfile) {
  current_wd = getwd()
  filepath <- paste0(current_wd, '/', file)
  ##print(filepath)
  first_line <- readLines(filepath, n = 1)
  print(first_line)
}

for (variable in vector) {
  readLines(filename, n = 1)
}

## number 8 now
list.files(pattern = '^b', recursive = T)

bfile
for (file in bfile) {
  filepath <- paste0('/Users/batman/Desktop/BIOL3100/Data_Course_HENSTROM/Data/', file)
  print(filepath)
  #first_line <- readLines(filepath, n = 1)
  #print(first_line)
}

## str(something) or is.vector(something) tells if it is a vector
## arr <- array(1:18), dim = (something)
vec <- c(1,2,3)
str()
is.vector(vec)

chr <- as.character(vec)
chr[1]

dat <- read.csv('1620_scores.csv')
dim(dat) #89 25
dat[3, 4]
dat[1:3, 1:4] #[row, col]

dat[,3]
data("mtcars")
dat <- mtcars
dim(dat) # 32 11
str(dat)

## get cars with cyl greater than 4
cyl_greater_4 <- dat[dat$cyl > 4, ]

dat$cyl > 4 ## shows how logical everything is as a whole document

## pull out mpg data and calculate average, min, and max mpg
str(dat)
car_mpg = dat$mpg
mean(car_mpg)
summary(dat$mpg)
max(dat$mpg)
min(dat$mpg)
# both below do the same thing
dat[, c("mpg", "cyl")] ## [rows, columns] with c, we can build a vector
dat[, c(1:2)]

dat[c(1,2,6), c("mpg", "cyl")]



## Back to assignment 2 ####
list.files(pattern = '.csv', recursive = T)

## convert 'mpg' to character in mtcars data frame

## convert entire data frame to character

str(car_mpg)
chrmpg = as.character(car_mpg)
dat$mpg = chrmpg
str(dat)

dat$mpg_num = as.numeric(chrmpg) ## created a column
View(dat)
str(dat)
