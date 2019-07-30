# 10일차 수업 - 20190729(월)

library(dplyr)
library(ggplot2)
library(readxl)

# < 결측치 데이터 처리 확인 학습 >
mpg <- as.data.frame(ggplot2::mpg)
View(mpg)
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA

# 1. 구동방식별로 고속도로연비 평균이 어떻게 다른지 알아보려고 합니다. 분석을 하기 전에 두 변수에 결측치 데이터가 있는지 확인해야 합니다. drv변수와 hwy변수에 결측치가 몇 개 있는지 알아보시오.
table(is.na(mpg$drv))
table(is.na(mpg$hwy))

# 2. filter()를 이용하여 hwy변수의 결측치 데이터를 제외하고, 어떤 구동 방식의 hwy 평균이 높은지 확인하시오.
mpg_nomissing <- mpg %>% filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(drv_hwy = mean(hwy)) %>% 
  arrange(-drv_hwy)
View(mpg_nomissing)

#####
# 이상치(outlier) - 존재할 수 없는 값, 극단적인 값(정상적인 범위를 벗어난 값)

# 1. 이상치 데이터를 판별
# sex - 남:1, 여:2, 3: outlier
# score - 1~5사이의 값, 6이상은 outlier
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1), 
                     score = c(5, 4, 3, 4, 2, 6))
outlier

table(outlier$sex)
table(outlier$scroe)

# 2. 이상치를 결측치 변경
outlier$sex <- ifelse(!outlier$sex %in% c(1, 2), NA, outlier$sex)
outlier$score <- ifelse(outlier$score <= 0 | outlier$score >= 6, NA, outlier$score)
outlier

# 3. 분석 작업 - 성별에 따른 score 평균
outlier_sex <- outlier %>% filter(!is.na(sex) & !is.na(score)) %>% group_by(sex) %>% summarise(sex_mean = mean(score))
outlier_sex

# 상자그림
# 밑에서부터 하단 극단치 0%, 1분위수 25%, 2분위수 50%, 3분위수 75%, 상단 극단치 100%, 그 이외의 값은 outlier
# 1. 이상치 확인
boxplot(mpg$hwy)

boxplot(mpg$hwy)$stats # 상자그림에서의 각 분위수에 해당하는 값을 출력

# 2. 이상치를 처리 -> 결측치 변경, 결측치 확인
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

# 3. 구동방식별 고속도로 연비의 평균을 높은순으로 확인
mpg %>% 
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_drv = mean(hwy)) %>% 
  arrange(-mean_drv)

mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T)) %>% 
  arrange(-mean_hwy)

##########

# 그래프 만들기 - ggplot2 패키지 안에 포함되어 있는 함수

# 1. 산점도 - x축, y축에 점으로 데이터를 표현, 변수와 변수와의 관계를 나타낼 때 사용
# 배기량(displ)별 고속도로 연비(hwy)를 산점도 표현
# x축: displ, y축: hwy
ggplot(data = mpg, aes(x = displ, y = hwy)) + # 데이터, 축
  geom_point() + # 그래프의 종류
  xlim(3, 6) + # x축의 범위
  ylim(10, 30) # y축의 범위

# 2. 막대 그래프 - 데이터의 크기를 막대로 표현, 변수(그룹)간의 차이를 나타낼 때 사용
# 구동방식별 고속도로 연비의 평균을 막대 그래프로 표현
mpg_drv <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))

mpg_drv

ggplot(data = mpg_drv, aes(x = drv, y = mean_hwy)) + geom_col() # 정렬 X

ggplot(data = mpg_drv, aes(x = reorder(drv, mean_hwy), y = mean_hwy)) + geom_col() # 오름차순 정렬

# 2-1. 막대 그래프 - 단순히 빈도를 누적하여 나타내는 그래프
# 구동방식(drv)에 따른 빈도수
ggplot(data = mpg, aes(x = drv)) + geom_bar()
table(mpg$drv)

# 차종에 따른 빈도수
ggplot(data = mpg, aes(x = class)) + geom_bar()
table(mpg$class)

# 연료에 따른 빈도수
ggplot(data = mpg, aes(x = fl)) + geom_bar()
table(mpg$fl)

# geom_col() - 요약 정보(통계 정보)
# geom_bar() - 원재료의 정보를 그대로 표현(빈도)

# < 산점도 확인학습 >
mpg <- as.data.frame(ggplot2::mpg)
# 1. mpg에서 도시연비와 고속도로연비 간에 어떤 관계가 있는지 확인하려고 합니다. x축은 cty, y축은 hwy로 된 산점도를 만들어 보시오.
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()

# 2. midwest에서 전체 인구와 아시아인 인구 간에 어떤 관계가 있는지 확인하려고 합니다. x축은 poptotal, y축은 popasian로 된 산점도를 만들어 보시오. 전체 인구는 50만명 이하, 아시아인 인구는 1만명 이하인 지역만 산점도에 표시되도록 설정하시오.
View(midwest)
ggplot(data = midwest, aes(x = poptotal, y = popasian)) +
  geom_point() +
  xlim(0, 500000) +
  ylim(0, 10000)

# < 막대 그래프 확인학습 >
# 1. 어떤 회사에서 생산한 "suv"차종의 도시연비가 높은지 확인하려고 합니다. "suv" 차종을 대상으로 평균 도시연비가 가장 높은 회사 다섯 곳을 막대 그래프로 표현하시오. 막대는 연비가 높은 순으로 정렬하여 표현하시오.
mpg_bar <- mpg %>% 
  filter(class == "suv") %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(-mean_cty) %>% 
  head(5)

ggplot(data = mpg_bar, aes(x = reorder(manufacturer, mean_cty), y = mean_cty)) + geom_col()

# 2. 자동차 중에서 어떤 차종이 많은지 알아보려고 합니다. 자동차 종류별 빈도를 표현한 막대그래프를 만들어보시오.
ggplot(data = mpg, aes(x = class)) + geom_bar()
