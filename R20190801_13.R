# 13일차 수업 - 20190801(목)

##### 변수의 타입

# 1. 연속 변수
v1 <- c(1, 2, 3, 1, 2)
v1
class(v1)
v1 * 10

# 2. 범주 변수: factor
v2 <- c(1, 2, 3, 1, 2)
v2
class(v2)
v2 * 10

# 3. factor타입을 숫자 타입으로 변환
v2 <- as.numeric(v2)
v2
class(v2)
v2 * 10

# 4. factor타입을 문자 타입으로 변환
v3 <- factor(c(1, 2, 3, 1, 2))
v3 <- as.character(v3)
v3
class(v3)
v3 * 10 # character는 *를 할 수 없음

# 5. 문자나 숫자 타입을 factor타입으로 변환
v4 <- as.factor(v3)
v4
class(v4)

# 6. 날짜 타입의 벡터를 생성
day1 <- c("2019-06-01", "2019-07-01", "2019-08-01")
day1
class(day1)
day1 + 10 # 문자를 더하는 것은 의미 없음
day1 - 10 # 문자를 빼는 것은 의미 없음
day1 * 2 # 문자를 곱하는 것은 의미 없음

day2 <- as.Date(day1)
day2
class(day2)
day2 + 10 # 날짜를 더하는 것은 의미 있음
day2 - 10 # 날짜를 빼는 것은 의미 있음
day2 * 2 # 날짜를 곱하는 것은 의미 없음

# R에서 데이터 타입의 종류
# numeric: 숫자, character: 문자, logical: 논리, factor: 범주, Date: 날짜, complex: 복소수

###########################

# foreign 패키지 - R에서 spss 파일을 사용할 수 있도록 하는 패키지
install.packages("foreign")
library(foreign)

# 한국복지패널의 2018년 spss데이터를 데이터프레임으로 
raw_welfare <- read.spss("C:/study/data1/Koweps_hpc13_2018_beta1.sav", to.data.frame = T)
View(raw_welfare)

# 데이터 분석에 필요한 변수를 코딩북에서 선별
# 성별: h13_g3 -> sex
# 출생년도(태어난 연도): h13_g4 -> birth
# 결혼여부(혼인상태): h13_g10 -> marriage
# 종교: h13_g11 -> religion
# 월급: p1302_8aq1 -> income
# 직업 코드: h13_eco9 -> code_job
# 지역 코드(7개 권역별 지역구분): h13_reg7 -> code_region

welfare <- raw_welfare

# 7개의 데이터 변수명 변경
welfare <- rename(welfare,
                  sex = h13_g3, 
                  birth = h13_g4, 
                  marriage = h13_g10, 
                  religion = h13_g11, 
                  income = p1302_8aq1,
                  code_job = h13_eco9,
                  code_region = h13_reg7)

# 7개의 데이터 추출
welfare <- welfare %>% select(sex, birth, marriage, religion, income, code_job, code_region)
View(welfare)

#######
### 1번째 프로젝트 - 성별에 따른 월급의 차이
# < 1단계 > 변수 검토 및 전처리(성별, 월급)
# sex - 1:남, 2:여
# income - 1~9998

table(welfare$sex)
table(is.na(welfare$sex))

table(welfare$income)
table(is.na(welfare$income))




