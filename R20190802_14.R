# 14일차 수업 - 20190802(금)

# foreign 패키지 - R에서 spss 파일을 사용할 수 있도록 하는 패키지
install.packages("foreign")
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

# 한국복지패널의 2018년 spss 데이터를 데이터프레임으로 저장
raw_welfare <- read.spss("c:/study/data1/Koweps_hpc13_2018_beta1.sav", to.data.frame = T)
View(raw_welfare)

# 데이터 분석에 필요한 변수를 코딩북에서 선별
# 성별: h13_g3
# 출생년도(태어난 연도): h13_g4
# 결혼여부(혼인상태): h13_g10 
# 종교: h13_g11
# 월급(일한달의 월평균 임금): p1302_8aq1
# 직업 코드: h13_eco9
# 지역 코드(7개 권역별 지역구분): h13_reg7

welfare <- raw_welfare 

# 7개의 변수명 변경
welfare <- rename(welfare,
                  sex = h13_g3,
                  birth = h13_g4,
                  marriage = h13_g10,
                  religion = h13_g11, 
                  income = p1302_8aq1,
                  code_job = h13_eco9,
                  code_region = h13_reg7)
View(welfare)

# 7개의 변수를 추출해서 저장
welfare <- welfare %>% select(sex, birth, marriage, religion, income, code_job, code_region)
View(welfare)

##########
### 1번째 프로젝트 - 성별에 따른 월급의 차이
# < 1단계 > 변수 검토 및 전처리 (성별, 월급)
# 성별 : sex - 1:남, 2:여
# 월급 : income - 1~9998

table(welfare$sex)
table(is.na(welfare$sex)) # FALSE: 14923, TRUE: 0 -> 결측치가 없는 데이터

table(welfare$income)
table(is.na(welfare$income)) # FALSE: 4563, TRUE: 10360 -> 결측치가 10360개

# 1-1. 성별 변수 전처리
# 현재 성별 변수에는 이상치, 결측치가 없고, 만약 이상치 데이터가 있다고 가정하면
# 성별에 있는 이상치 데이터를 결측치로 변경
welfare$sex <- ifelse(welfare$sex %in% c(1, 2), welfare$sex, NA)
welfare$sex <- ifelse(!(welfare$sex %in% c(1, 2)), NA, welfare$sex)

# 성별 변수 값 변경 - 1:M, 2:F
welfare$sex <- ifelse(welfare$sex == 1, "M", "F")

table(welfare$sex)
qplot(welfare$sex)

# 1-2. 월급 변수 전처리
# 1~9998 이외의 값은 이상치로 판별하고, 이 값들을 결측치로 변경
welfare$income <- ifelse(welfare$income < 1 | welfare$income > 9998, NA, welfare$income)

table(welfare$income)
table(is.na(welfare$income)) # FALSE: 4556, TRUE: 10367 -> 7건의 이상치가 결측치로 변경

# < 2단계 > 분석표(통계요약표)
# 2. 성별 월급 평균 분석표
sex_income <- welfare %>%
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))

sex_income # F: 179, M: 347

# < 3단계 > 막대 그래프
ggplot(data = sex_income, aes(x = sex, y = mean_income)) + geom_col()

# < 4단계> 분석 결과
# 분석 결과 : 남성은 월 평균 347만원, 여성은 월 평균 179만원의 급여를 받고 있으며, 남성이 여성의 거의 두 배 가까운 급여를 받고 있음을 알 수 있다.


##########
### 2번째 프로젝트 - 나이에 따른 월급 차이
# < 1단계 > 변수 검토 및 전처리(나이, 월급)
# 나이 : birth - 1900~2017, 출생년도를 통해 나이 변수 생성
# 월급 : income - 1~9998

class(welfare$birth)
summary(welfare$birth)
table(welfare$birth)
table(is.na(welfare$birth))

# 1-1. 출생년도 변수 전처리, 나이라는 파생변수 생성
# 현재 성별 변수에는 이상치, 결측치 데이터는 없고, 이상치 데이터가 있다고 가정하면
# birth 변수에 있는 이상치 데이터를 결측치로 변경
welfare$birth <- ifelse(welfare$birth < 1900 | welfare$birth > 2017, NA, welfare$birth)

# 출생년도(birth)를 통해 나이(age)라는 파생변수를 생성
welfare$age <- 2018 - welfare$birth + 1

# 1-2. 월급 변수 전처리 - 프로젝트 1에서 이미 실행

# < 2단계 > 분석표(통계요약표)
# 2. 나이에 따른 월급의 평균 분석표
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))

View(age_income)
summary(age_income)

# < 3단계 > 선(시계열) 그래프
ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line() + geom_point()

# < 4단계 > 분석 결과
# 분석 결과 : 19세부터 90만원의 월급을 받기 시작하고, 이후로 지속적으로 증가하다가 45세에 378만원으로 가장 많은 월급을 받게 되며, 59세까지는 조금씩 월급이 감소하다가, 이후로 지속적으로 감소하게 되며, 74세 이후로는 19세보다 적은 월급을 받게 된다.


##########
### 3번째 프로젝트 - 연령대(3개: 초년, 중년, 노년)에 따른 월급 차이
# < 1단계 >  변수 검토 및 전처리 (연령대, 월급)
# 1-1. 연령대 변수 생성 (파생변수)
# 연령대의 구분 - 초년(young): 30세 미만, 중년(middle): 30~60세 미만, 노년(old): 60세 이상
welfare$ageg <- ifelse(welfare$age < 30, "young",
                       ifelse(welfare$age < 60, "middle", "old"))

table(welfare$ageg) # young: 3679, middle: 5223, old: 6021
qplot(welfare$ageg)

# 1-2. 월급 변수 전처리 - 1번 프로젝트에서 이미 생성

# < 2단계 > 분석표(통계요약표)
ageg_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income = mean(income))

ageg_income # young: 188, middle: 320, old: 135

# < 3단계 > 막대 그래프
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + geom_col()

# 변수의 값이름으로 순서를 정하는 방법 : young - middle - old 순으로 정렬
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))

# < 4단계 > 분석 결과
# 분석 결과 : 초년은 188만원의 월급을 받고, 중년은 320만원의 월급을 받고, 노년은 초년보다도 적은 135만원의 평균월급을 받는다.

































































