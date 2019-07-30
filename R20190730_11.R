# 11일차 수업 - 20190730(화)

# 그래프 만들기
# 3. 선(시계열) 그래프 - 시간에 따라 달라지는 데이터를 표현할 때 사용. ex) 날씨, 주식, 환율...
View(airquality)
# 날짜별 온도의 변화를 선 그래프로 확인
# x축: Day, Y축: Temp
ggplot(data = airquality, aes(x = Day, y= Temp)) + 
  geom_line(size = 2, color = "#9999CC") +
  geom_point(color = "cyan")

# 4. 상자그림 - 데이터의 분포를 직사각형 형태의 상자그림으로 표현
# mpg에서 구동방식별 고속도로연비를 상자그림으로 표현
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

### < 선 그래프, 상자그림 확인 학습 >
## 1. economics에서 시간에 따른 실업자 수의 증감 추이를 선 그래프로 표현
View(economics)
ggplot(data = economics, aes(x = date, y = unemploy)) +
  geom_line(size = 3, color = "#9999CC")

## 2. economics에서 시간에 따른 저축률의 증감 추이를 선그래프로 표현하시오.
ggplot(data = economics, aes(x = date, y = psavert)) +
  geom_line(size = 3, color = "#E4F7BA")

## 3. mpg에서 차종이 "compact", "subcompact", "suv"인 자동차의 도시연비를 알아보려고 합니다. 세 차종의 cty를 나타낸 상자 그림을 만들어 보시오.
View(mpg)
mpg_class <- mpg %>% filter(class %in% c("compact", "subcompact", "suv"))
ggplot(data = mpg_class, aes(x = class, y = cty)) + geom_boxplot()

# 5. 히스토그램 - 도수 분포를 기둥 모양의 막대 그래프로 표현
# airquality에서 온도를 히스토그램으로 표현
airquality
ggplot(data = airquality, aes(x = Temp)) + geom_histogram(binwidth = 1)

##########

# R 내장함수와 dplyr 패키지 함수의 차이
exam <- read.csv("c:/study/data1/csv_exam.csv", header = T)
exam
exam[]
exam[,]

# 1. 행 확인
# R 내장함수
exam[5,]
exam[c(1, 3, 5),]
exam[c(5:10),]

#dplyr 패키지
exam %>% slice(5)
exam %>% slice(c(1,3,5))
exam %>% slice(c(5:10))

# 2. 열 확인
# R 내장 함수
exam[,3]
exam[,c(3:5)]
exam[,c(1,2,5)]

exam[,"math"]
exam[,c("math", "english", "science")]
exam[,c("id", "class", "science")]

# dplyr 패키지
exam %>% select(3)
exam %>% select(c(3:5))
exam %>% select(c(1,2,5))

exam %>% select(math)
exam %>% select(math, english, science)
exam %>% select(id, class, science)

# 행과 열을 함께 확인
# R 내장 함수
exam[c(5:8), c(1,2,5)] # 행: 5~8, 열: 1, 2, 5
exam[c(1:4, 9:12), c(1, 2, 4)] # 행: 1~4와 9~12, 열: 1, 2, 4

# dplyr 패키지
exam %>% slice(c(5:8)) %>% select(c(1, 2, 5))
exam %>% slice(c(1:4, 9:12)) %>% select(c(1, 2, 4))

### 4. 조건을 만족하는 행 확인
# R 내장함수
exam[exam$math >= 60, ]
subset(exam, math >= 60)

exam[exam$english >= 70 & exam$science >= 70,]
subset(exam, english >= 70 & science >= 70)

# dplyr
exam %>% filter(math >= 60)
exam %>% filter(english >= 70 & science >= 70)
