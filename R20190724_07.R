# 7일차 수업 - 20190724(수)

#midwest - 미국 중서부 지역의 인구통계 자료
### 확인 학습
# 문제1. ggplot2의 midwest 데이터를 데이터프레임 형태로 불러온 데이터의 특징을 파악하시오.
library(ggplot2)
library(dplyr)

midwest <- as.data.frame(ggplot2::midwest)
View(midwest)
#head(midwest, 10)
#tail(midwest, 10)
#str(midwest)
#class(midwest)
#dim(midwest)

# 문제2. poptotal변수를 total, popasian변수를 asian으로 수정하시오.
midwest <- rename(midwest, total = poptotal, asian = popasian)
View(midwest)

# 문제3. total, asian 변수를 이용하여 '전체 인구 대비 아시아 인구 백분율'을 나타내는 asian_ratio라는 파생변수를 만들고, 히스토그램을 만들시오.
midwest$asian_ratio <- midwest$asian / midwest$total * 100
hist(midwest$asian_ratio)

# 문제4. 아시아 인구 백분율의 전체 평균을 구하고, 평균을 초과하면 "large", 그 외에는 "small"을 나타내는 파생변수 group을 생성하시오.
midwest$group <- ifelse(midwest$asian_ratio > mean(midwest$asian_ratio), "large", "small")

# 문제5. "large", "small"에 해당하는 지역이 얼마나 되는지 빈도표와 빈도 막대 그래프를 만들어서 확인하시오.
table(midwest$group)
qplot(midwest$group)

##### 데이터 처리(가공) - dplyr
exam <- read.csv("C:/study/data1/csv_exam.csv", header = T)
exam

# 1. 행추출 함수 - filter()\
# %>% - dplyr 패키지에서만 사용하는 연산자, 파이프 연산자, 체인 연산자
exam %>% filter(class == 3)
exam %>% filter(math >= 60)
exam %>% filter(class != 1)
exam %>% filter(class == 2 | class == 3 | class == 4 | class == 5)
exam %>% filter(class %in% c(2,3,4,5)) # 매칭(matching) 연산자
exam %>% filter(math >= 60 & science >= 70)

class5 <- exam %>% filter(class == 5)
class_pass <- exam %>% filter(math >= 60 & science >= 60 & english >= 60)

### 확인 학습
mpg <- as.data.frame(ggplot2::mpg)
View(mpg)
# 문제1. 자동차 배기량에 따라 고속도로 연비가 다른지 확인하고자 할때, displ(배기량)이 4이하인 자동차와 5이상인 자동차 중에서 어떤 자동차의 고속도로 연비(hwy)가 평균적으로 더 높은지 확인하시오.
displ4 <- mpg %>% filter(displ <= 4)
displ5 <- mpg %>% filter(displ >= 5)
mean(displ4$hwy)
mean(displ5$hwy)

# 문제2. 자동차 제조회사에 따라 도시 연비가 다른지 알아보고자 할 때, "audi"와 "toyota" 중에서 어느 제조사(manufacturer)의 도시 연비(cty)가 평균적으로 더 높은지 확인하시오.
manu_audi <- mpg %>% filter(manufacturer == "audi")
manu_toyota <- mpg %>% filter(manufacturer == "toyota")
mean(manu_audi$cty)
mean(manu_toyota$cty)

# 문제3. "chevolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보고자 할 때, 이 회사들의 데이터를 추출한 후 hwy 전체 평균을 구하시오.
manu_cfh <- mpg %>% filter(manufacturer %in% c("chevolet", "ford", "honda"))
mean(manu_cfh$hwy)

# 2. 열추출 함수 - select()
exam

exam %>% select(math)
exam %>% select(math, science)
exam %>% select(class, math, science)
exam %>% select(-id, -english)
  ``
# filter() 함수와 select() 함수를 조합하여 사용
# %>% 체인 연산자
exam %>% filter(class %in% c(1, 2)) %>% select(-english)

# 1,2,3반에서 수학점수가 60점이상이고, 과학점수가 60점 이상인 학생의 class, math, science 점수를 확인하시오.
exam %>% filter(class %in% c(1,2,3) & math >= 60 & science >= 60) %>% select(class, math, science)

# 1,2,3반에서 영어점수가 80점이상인 학생의 id, class, english를 앞에서 5건만 확인하시오.
exam %>% filter(class %in% c(1,2,3) & english >= 80) %>% select(id, class, english) %>% head(5)
















