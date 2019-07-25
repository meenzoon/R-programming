# 8일차 수업 - 20190725(목)

library(dplyr)
library(ggplot2)
library(readxl)

### 확인 학습
sample <- read_excel("C:/study/data2/Sample1.xlsx", col_names = T)
sample
View(sample)

# 1. sample에서 성별이 남자인 데이터를 확인하시오.
sample %>% filter(SEX == "M")

# 2. sample에서 지역이 서울이고, 나이가 20대인 데이터를 확인하시오.
#sample %>% filter(AREA == "서울") %>% filter(AGE >= 20 & AGE < 30)
sample %>% filter(AREA == "서울" & (AGE >= 20 & AGE < 30))

# 3. sample에서 지역이 서울, 경기, 인천인 데이터를 확인하시오.
sample %>% filter(AREA %in% c("서울", "경기", "인천"))

# 4. sample에서 지역이 제주가 아닌 데이터를 확인하시오.
sample %>% filter(AREA != "제주")

# 5. sample에서 비용이 2016년, 2017년 모두 30만원 이상인 데이터를 확인하시오.
sample %>% filter(AMT16 >= 300000 & AMT17 >= 300000)

exam <- read.csv("c:/study/data1/csv_exam.csv", header = T)
exam
View(exam)
# 3. 정렬 함수 - arrange()
exam %>% filter(class %in% c(1, 2, 3) & english >= 80) %>% select(id, class, english) %>% arrange(-english) %>% head(5)

# 2. 3반이 아닌 반에서 수학점수가 60점이상이고, 과학점수가 60점이상인 학생 데이터에서 영어점수를 제외하여 출력하고, 수학점수가 높은순으로 정렬하고, 수학점수가 같으면 과학점수가 높은순으로 정렬하여 2명을 출력하시오.
exam %>% filter(class != 3 & math >= 60 & science >= 60) %>% select(-english) %>% arrange(-math, -science) %>% head(2)

### 확인 학습
mpg <- as.data.frame(ggplot2::mpg)
View(mpg)

.# 1. mpg에서 자동차 종류(class), 도시 연비(cty) 변수를 추출하여 새로운 데이터를 만드시오.
mpg_cc <- mpg %>% select(class, cty)
View(mpg_cc)

# 2. mpg에서 자동차 종류(class)가 "suv"인 자동차와 "compact"인 자동차 중에서 어떤 자동차의 도시 연비(cty)가 더 높은지 확인하시오.
mpg_suv <- mpg %>% filter(class == "suv")
mpg_compact <- mpg %>% filter(class == "compact")
mean(mpg_suv$cty) # 13.5
mean(mpg_compact$cty) # 20.12766

mpg %>% filter(class == "suv") %>% select(cty)
mpg_suv$cty

# 3. mpg에서 "audi"에서 생산한 자동차 중에서 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 1~5위에 해당하는 자동차의 데이터를 출력하시오.
mpg %>% filter(manufacturer == "audi") %>% arrange(-hwy) %>% head(5)

### 4. 파생변수 생성 - mutate()
# a. 기본 파생변수 생성
exam$tot <- exam$math + exam$english + exam$science
# b. within 이용 파생변수 만들기
exam <- within(exam, tot = math + english + science)
# c. mutate() 이용 파생변수 만들기
exam <- exam %>% mutate(tot = math + english + science)
exam <- exam %>% mutate(ave = tot / 3)

exam <- exam %>% mutate(tot = math + english + science, ave = tot / 3)

# ave가 60점이상이면 "PASS", 그렇지 않으면 "FAIL"이라고 나타내는 test라는 파생변수를 추가하시오.
exam <- exam %>% mutate(test = ifelse(ave >= 60, "PASS", "FAIL"))
exam
table(exam$test)
qplot(exam$test)

### 확인 학습 - mutate()
# 1. cty와 hwy를 더한 합산 연비를 나타내는 tot라는 파생변수를 생성하시오.
mpg <- mpg %>% mutate(tot = cty + hwy)

# 2. 합산연비를 2로 나누어 평균연비를 나타내는 ave를 파생변수로 추가하시오.
mpg <- mpg %>% mutate(ave = tot / 2)

# 3. 평균연비 변수가 가장 높은 자동차 3종의 데이터를 생성하시오.
mpg %>% arrange(-ave) %>% head(3)

# 4. 1~3번 문제를 하나로 연결된 dplyr 패키지의 구문으로 만들어 생성하시오.
mpg_top_ave <- mpg %>% mutate(tot = cty + hwy, ave = tot / 2) %>% arrange(-ave) %>% head(3)
mpg_top_ave
View(mpg_top_ave)

### 5. 그룹 요약 함수 - group_by(), summarise()
# - 그룹별 평균이나 그룹별 빈도와 같은 각 그룹을 요약한 값을 확인

exam %>% summarise(mean_math = mean(math))

# 반별로 (그룹하여) 수학점수의 평균을 높은순으로 확인
exam %>% group_by(class) %>% summarise(mean_math = mean(math)) %>% arrange(-mean_math)

### summarise() 함수 안에서 사용하는 통계 함수
# - mean(): 평균, sum(): 합계, max(): 최댓값, min(): 최소값, median(): 중앙값, sd(): 표준편차, n(): 빈도

exam %>% group_by(class) %>% 
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            max_math = max(math),
            min_math = min(math),
            median_math = median(math),
            n_math = n())


