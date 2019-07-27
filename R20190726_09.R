# 9일차 수업 - 20190726(금)

library(dplyr)
library(ggplot2)
library(readxl)

mpg <- as.data.frame(ggplot2::mpg)
View(mpg)

### 확인 학습
# 1. 회사별(manufacturer)로 그룹을 나눈 후, 다시 구동 방식별(drv)로 나누어서 도시 연비(cty)의 평균을 확인하시오.
mpg_1 <- mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty))

View(mpg_1)

# 2. 회사별(manufacturer)로 그룹을 나눈 후, suv의 데이터를 추출하고, 도시 연비(cty)와 고속도로 연비(hwy)의 평균을 구해서 복합연비(total) 파생변수를 생성한 후, 복합연비의 평균(mean_total)의 정보를 내림차순으로 정렬하여 5건 확인하시오.
mpg_2 <- mpg %>% group_by(manufacturer) %>% 
  filter(class == "suv") %>% 
  mutate(total = (cty + hwy) / 2) %>% 
  summarise(mean_total = mean(total)) %>% 
  arrange(desc(mean_total)) %>% 
  head(5)

mpg_2

# 3. class별 cty 평균을 내림차순으로 정렬하여 출력하시오.
mpg_3 <- mpg %>% group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(-mean_cty)

mpg_3

# 4. 차종별(class)로 그룹화하여, 어떤 차종의 도시 연비가 높은지 알수 있도록 cty평균이 높은 순으로 3건만 출력하시오.
mpg_4 <- mpg %>% group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(-mean_cty) %>% 
  head(3)

mpg_4

# 5. 어떤 회사의 자동차의 고속도로 연비가 가장 높은지 알고자 할 때, hwy평균이 가장 높은 회사 3곳을 출력하시오.
mpg_5 <- mpg %>% group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(-mean_hwy) %>% 
  head(3)

mpg_5

# 6. 어떤 회사에서 "compact"차종을 가장 많이 생산하는지 알고자 할 때, 각 회사별 "compact" 자동차수를 내림차순으로 정렬하여 출력하시오.
mpg_6 <- mpg %>% group_by(manufacturer) %>% 
  filter(class == "compact") %>% 
  summarise(count = n()) %>% 
  arrange(-count)

mpg_6

##########
### 결측치 데이터를 다루는 방법
# 결측치(missing data) : 존재하지 않는 값, 확인할 수 없는 값
# NA : Not Available

df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA), stringsAsFactors = F)
df

mean(df$score) # 결측치 데이터가 존재하므로 결과는 NA

# 결측치 데이터 확인하는 방법
is.na(df)
is.na(df$sex)
is.na(df$score)

# 결측치 데이터의 빈도를 확인하는 방법
table(is.na(df))
table(is.na(df$sex))
table(is.na(df$score))

# 결측치 데이터가 있는 행 제거
df <- df %>% filter(is.na(score)) # 결측치의 데이터를 저장 -> 주의

df_nomissing <- df %>% filter(!is.na(score)) # 결측치를 제외한 데이터를 저장

mean(df$score) # 결측치 데이터를 제거하고 평균을 구함, 4

# 2개의 결측치 데이터를 제거
df_nomissing2 <- df %>% filter(!is.na(score) & !is.na(sex))

# 모든 결측치 데이터를 제거
df_nomissing3 <- na.omit(df)

df

mean(df$score, na.rm = T)
sum(df$score, na.rm = T)

#####
exam <- read.csv("c:/study/data1/csv_exam.csv", header = T)
exam_na <- exam  # 복사

exam_na

# 결측치 데이터를 만들어 넣는 방법
exam_na[c(3, 8, 15), "math"] <- NA

exam_na  

# 1번 - R 통계 함수 활용
mean(exam_na$math, na.rm = T)
sum(exam_na$math, na.rm = T) 
max(exam_na$math, na.rm = T) 
min(exam_na$math, na.rm = T) 

# 2번 - dplyr 패키지 활용
exam_na %>% summarise(mean_math = mean(math, na.rm = T))
  
exam_na %>% summarise(mean_math = mean(math, na.rm = T),
                      sum_math = sum(math, na.rm = T),
                      max_math = max(math, na.rm = T), 
                      min_math = min(math, na.rm = T))  

exam_na
  
# 결측치 데이터가 행을 활용할 수 있는 방법
# - 결측치 데이터에 결측치의 평균을 대입하는 방법
mean(exam_na$math, na.rm = T) # 55.23529

# NA 데이터인 3, 8, 15행의 math 열에 55를 삽입, 그렇지 않으면 원래의 데이터를 삽입
exam_na$math <- ifelse(is.na(exam_na$math), 55, exam_na$math) 

exam_na








