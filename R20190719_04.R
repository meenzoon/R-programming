# 4일차 수업 - 20190719(금)

### 연산자(operator)
x1 <- c(1:5)
x2 <- c(6:10)
x3 <- c(1:7)

# 1. 산술 연산자 (+  -  *  /  %/%  %%  **  ^)
x1 + 10
x2 - 3
x1 * 3
x1 / 2
x2 %/% 2 # 나누어서 몫을 구함
x2 %% 2 # 나누어서 나머지를 구함
x2 ** 2 # 승수
x2 ^ 2 # 승수

# 2. 비교 연산자 (>  >=  <  <=  ==  !=)
x4 <- c(3, 2, 5, 4, 1)
x4 > x1
x4 < x1
x4 == x1 
x4 != x1

# 3. 논리 연산자 (&  |)
x1 > 3 & x1 < 5
x1 > 3 | x1 < 3

##### 데이터파일 읽기/쓰기
# 1. xlsx(엑셀) 파일 읽기/쓰기
install.packages("readxl")
library(readxl)

df_exam1 <- read_excel("c:/study/data1/excel_exam.xlsx")
df_exam1
View(df_exam1)
head(df_exam1)
head(df_exam1, 3)
tail(df_exam1)
tail(df_exam1, 3)

df_exam2 <- read_excel("c:/study/data1/excel_exam_novar.xlsx")
df_exam2

df_exam3 <- read_excel("c:/study/data1/excel_exam_novar.xlsx", col_names = F)
df_exam3

install.packages("xlsx")
library(xlsx)

df_exam_sheet1 <- read.xlsx("c:/study/data1/excel_exam_sheet.xlsx", sheetIndex = 3)
df_exam_sheet1

df_exam_sheet2 <- read.xlsx("c:/study/data1/excel_exam_novar.xlsx", sheetIndex = 1, header = F)
df_exam_sheet2

class(df_exam1)
class(df_exam2)
class(df_exam3)
class(df_exam_sheet1)
class(df_exam_sheet2)

write.xlsx(df_exam1, "c:/study/work/df01.xlsx")

# 2. csv 파일 읽기/쓰기
df_exam_csv1 <- read.csv("c:/study/data1/csv_exam.csv", stringsAsFactors = F)
df_exam_csv1
class(df_exam_csv1)

write.csv(df_exam_csv1, "c:/study/work/csv_exam1.csv")

# 3. txt(메모장) 읽기/쓰기
df_txt_data1 <- read.table("c:/study/data2/data_ex.txt", header = T)
df_txt_data1  
class(df_txt_data1)  

df_txt_data2 <- read.table("c:/study/data2/data_ex2.txt") 
df_txt_data2  
  
df_txt_data3 <- read.table("c:/study/data2/data_ex2.txt", header = F, sep = ",")  
df_txt_data3  

df_txt_data4 <- read.table("c:/study/data2/data_ex1.txt", header = F, sep = ",", skip = 3) 
df_txt_data4

df_txt_data5 <- read.table("c:/study/data2/data_ex1.txt", header = T, sep = ",", nrows = 7) 
df_txt_data5

write.table(df_txt_data1, "c:/study/work/df_txt01.txt")














