# 5일차 수업 - 20190722(월)

# dplyr(디플라이어) - 데이터 분석을 위한 여러 가지 함수 포함
install.packages("dplyr")
library(dplyr)
install.packages("readxl")
library(readxl)

score <- read_excel("c:/study/data1/excel_exam.xlsx", col_names = TRUE)
score
View(score)

#rename() - 변수명 수정
score <- rename(score, math = mat)
score <- rename(score, english = eng)
score <- rename(score, science = sci)

score <- rename(score, mat = math, eng = english, sci = science)
score

# 파생변수 - 기존에 존재하는 변수로부터 새로운 변수를 생성
# R의 기본 기능을 이용한 방법법
score$tot <- score$mat + score$eng + score$sci
score$ave <- score$tot / 3

# within() 함수를 사용하여 파생변수 생성
score <- within(score, tot <- mat + eng + sci)
score <- within(score, ave <- tot / 3)

# 1. 평균 점수가 60점이상이면 "PASS", 그렇지 않으면 "FAIL"이라고 나타내도록 test라는 파생변수를 추가하시오.
score$test <- ifelse(score$ave >= 60, "PASS", "FAIL")

# 2. 평균 점수가 90점이상이면 "A", 80점 이상이면 "B", 70점이상이면 "C", 60점이상이면 "D", 나머지는 "F"라고 나타내는 파생변수 grade를 추가하시오.
score$grade <- ifelse(score$ave >= 90, "A"
                      , ifelse(score$ave >= 80, "B"
                               , ifelse(score$ave >= 70, "C"
                                        , ifelse(score$ave >= 60, "D", "F"))))

install.packages("ggplot2")
library(ggplot2)

mpg <- as.data.frame(ggplot2::mpg)
mpg
View(mpg)
help(mpg)

# 평균 연비
ave <- (mpg$cty + mpg$hwy) / 2
ave
# 각 차들의 전체 평균 연비
mean(ave)

# < 확인학습 >
# 문제1. mpg에서 cty를 city, hwy를 highway로 이름을 변수 이름을 수정하시오.
mpg <- rename(mpg, city = cty)
mpg <- rename(mpg, highway = hwy)


# 문제2. mpg에서 city와 highway의 평균연비를 mean이라는 파생 변수로 추가하시오.
# mpg <- within(mpg, mean <- (city + highway) / 2)
mpg$mean <- (mpg$city + mpg$highway) / 2
mpg

# 문제3. mpg에서 평균연비가 30이상이면 "Excellent", 20이상이면 "Good", 그 외에는 "Bad"라고 나타내는 파생변수 efficiency를 추가하시오.
mpg$efficiency <- ifelse(mpg$mean >= 30, "Excellent"
                         , ifelse(mpg$mean >= 20, "Good", "Bad"))

### 조건문 - if문, switch문
# 1. if문
x <- 75

#콘솔로부터 입력받는 함수
x <- scan(what = "")

if(x >= 90) {
  print("A학점")
} else if(x >= 80) {
  print("B학점")
} else if(x >= 70) {
  print("C학점")
} else if(x >= 60) {
  print("D학점")
} else {
  print("F학점")
}

area <- "seoul"
area <- scan(what = "")

if(area == "seoul") {
  print("서울에 있습니다.")
} else {
  print("서울이 아닌 다른곳에 있습니다.")
}

s <- ifelse(area == "seoul", "서울에 있습니다.", "서울이 아닌 다른곳에 있습니다.")

# 함수 생성, function
ft_if1 <- function(x) {
  if(x >= 90) {
    print("A학점")
  } else if(x >= 80) {
    print("B학점")
  } else if(x >= 70) {
    print("C학점")
  } else if(x >= 60) {
    print("D학점")
  } else {
    print("F학점")
  }

}

# 함수 사용
ft_if1(95)
ft_if1(85)

# 2. switch문
x <- "four"

switch(x, 
       one = 1,
       two = 2,
       3)

# 반복문 - for, while, repeat
# 1. for문
# 1부터 100까지의 수를 더한 값을 출력
sum <- 0
for(i in 1:100) {
  sum <- sum + i
}
sum

# 2. while문
sum <- 0; i <- 1
while(i <= 100) {
  sum <- sum + i
  i <- i + 1
}
sum

# 3. repeat문 - 조건반복이 아닌 무한반복하는 제어문, 조건문과 break문을 통해서 반복문을 탈출함
sum <- 0; i <- 1
repeat {
  sum <- sum + i
  i <- i + 1
  if(i > 100) {
    break;
  }
}
sum

### for문 확인학습
# 1. 1부터 100까지의 수 중에서 짝수를 출력하시오.
sum <- 0
for(i in 1:100){
  if(i %% 2 == 0){
    print(i)
    sum <- sum + i
  }
}
sum




