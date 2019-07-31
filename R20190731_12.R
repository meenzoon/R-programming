# 12일차 수업 - 20190731(수)

##### 확인 학습
# 1. 수학점수 50점이상, 영어점수 80이상인 학생들을 대상으로 각 반의 전 과목 총평균을 구하시오.
exam <- read.csv("c:/study/data1/csv_exam.csv", header = T)

### dplyr
exam %>% filter(math >= 50 & english >= 80) %>% 
  group_by(class) %>% 
  summarise(mean_class = mean(math + english + science)/3) %>% 
  arrange(-mean_class)

# 답안
exam %>% filter(math >= 50 & english >= 80) %>% 
  group_by(class) %>% 
  mutate(tot = (math + english + science) / 3) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(-mean_tot)
###

### 내장함수
exam_class <- subset(exam, math >= 50 & english >= 80)
aggregate((exam_class$math + exam_class$english + exam_class$science) / 3 ~ exam_class$class, exam_class, mean)

# 답안
exam_r <- exam
exam_r$tot <- (exam_r$math + exam_r$english + exam_r$science) / 3
aggregate(data = exam_r[exam_r$math >= 50 & exam_r$english >= 80,], tot~class, mean)
###

# lapply(split((exam$math + exam$english + exam$science) / 3, exam$class), mean)

# 2. "compact"와 "suv" 차종의 도시 및 고속도로 평균연비의 평균을 구하시오.
mpg <- as.data.frame(ggplot2::mpg)
### dplyr
mpg_dplyr <- mpg %>% filter(class == "compact" | class == "suv") %>% 
  group_by(class) %>% 
  mutate(tot = (cty + hwy) / 2) %>% 
  summarise(mean_tot = mean(tot))
mpg_dplyr
###

### 내장함수
mpg_r <- subset(mpg, class == "compact" | class == "suv")
mpg_r$tot <- (mpg_r$cty + mpg_r$hwy) / 2
aggregate(data = mpg_r[mpg_r$class == "compact" | mpg_r$class == "suv",], tot~class, mean)
mpg_r

## 내장함수 활용2
mpg$tot <- (mpg$cty + mpg$hwy) / 2
mpg
df_com <- mpg[mpg$class == "compact",]
View(df_com)
df_suv <- mpg[mpg$class == "suv",]
View(df_suv)
mean(df_com$tot)
mean(df_suv$tot)
###

##### 
# 그래프 응용
# 1. 누적 막대 그래프
View(mtcars)
library(ggplot2)
# 실린더 종류별 빈도를 파악하여, 기어를 누적 막대그래프로 표현
ggplot(data = mtcars, aes(x = cyl)) + geom_bar(aes(fill = factor(gear)))

# 2. 선버스트 그래프
ggplot(data = mtcars, aes(x = cyl)) + geom_bar(aes(fill = factor(gear))) + coord_polar()

# 3. 원형 그래프
ggplot(data = mtcars, aes(x = cyl)) + geom_bar(aes(fill = factor(gear))) + coord_polar(theta = "y")

# 4. 선 그래프
View(economics)
ggplot(data = economics, aes(x = date, y = psavert)) + geom_line() + geom_abline(intercept = 12.18671, slope = -0.000544)
# intercept: y절편, slope: 기울기

ggplot(data = economics, aes(x = date, y = psavert)) + geom_line() + geom_hline(yintercept = mean(economics$psavert))
# 저축률의 평균 수평선을 그려줌

x_intercept <- filter(economics, psavert == min(economics$psavert))$date

ggplot(data = economics, aes(x = date, y = psavert)) + geom_line() + geom_vline(xintercept = x_intercept)
# 저축률이 가장 낮은 날짜에 수직선을 그려줌

# 5. 그래프에 텍스트를 추가하는 방법
View(airquality)

ggplot(data = airquality, aes(x = Day, y = Temp)) + geom_point() + geom_text(aes(label = Temp, vjust = -2, hjust = -2))
# +: 아래/왼쪽, -:위/오른쪽

# 6. 그래프를 강조할 때 사용하는 방법 - 도형, 화살표
# 1
ggplot(data = mtcars, aes(x = wt, y = mpg)) + geom_point() + 
  annotate("rect", xmin = 3, xmax = 4, ymin = 12, ymax = 21, fill = "skyblue", alpha = 0.5)
# 2
ggplot(data = mtcars, aes(x = wt, y = mpg)) + geom_point() + 
  annotate("rect", xmin = 3, xmax = 4, ymin = 12, ymax = 21, fill = "skyblue", alpha = 0.5) +
  annotate("segment", x = 2.5, xend = 3.7, y = 10, yend = 17, color = "red", arrow = arrow())
# 3
ggplot(data = mtcars, aes(x = wt, y = mpg)) + geom_point() + 
  annotate("rect", xmin = 3, xmax = 4, ymin = 12, ymax = 21, fill = "skyblue", alpha = 0.5) +
  annotate("segment", x = 2.5, xend = 3.7, y = 10, yend = 17, color = "red", arrow = arrow()) + 
  annotate("text", x = 3.8, y = 18, label = "추천", color = "red")
