# 6일차 수업 - 20190723(화)

### for문 확인학습: for문
# 1. 1부터 100까지의 수 중에서 짝수를 출력하시오.
sum <- 0
for(i in 1:100) {
  if(i %% 2 == 0) {
    print(i)
    sum <- sum + i
  }
}
sum

# 2. 1부터 100까지의 수 중에서 3의 배수이고, 4의 배수인 수를 출력하고, 갯수를 구하시오.
count <- 0
for(i in 1:100) {
  if(i %% 3 == 0 & i %% 4 == 0){
    print(i)
    count <- count + 1
  }
}
count

# 3. 1부터 10까지 출력하는 반복문을 만들고, 6이 되면 반복문을 탈출하도록 만드시오.
x <- 1:10
for(i in x) {
  if(i == 6){
    break;
  }
  # print(i)
  cat(i)
}

# 4. 벡터의 값을 차례대로 출력하도록 한다.
x <- c("a", "b", "c", "d", "e")
for(i in x) {
  print(i)
}

# 5,6 1부터 10까지의 수 중에서 5를 제외하고 출력하시오.
for(i in 1:10) {
  #if(i != 5){
  #  print(i)
  #}
  if(i == 5) {
    next
  }
  print(i)
}

### < 확인학습 > : 함수, for문
# 1부터 입력받은 수까지 출력하도록 하는 함수를 만든다.
ft_for1 <- function(x){
  for(i in 1:x) {
    print(i)
  }
}
x <- scan(what = "")
ft_for1(x)

### 패키지 정리
# dplyr - 데이터를 분석할 때 사용하는 다양한 함수를 내장
# ggplot2 - 데이터 시각화를 위한 다양한 함수를 내장, 데이터 분석 연습을 위한 다양한 데이터셋을 포함
# readxl - 엑셀 파일로부터 데이터를 읽어올 때

library(dplyr)
library(ggplot2)
library(readxl)

### 데이터 결합(조인) - dplyr 패키지 활용

# 1. 가로로 결합 - left_join
test1 <- data.frame(
  id = c(1:5),
  midtrem = c(60, 80, 70, 90, 85)
)

test2 <- data.frame(
  id = c(1:5),
  finalterm = c(70, 83, 65, 95, 80)
)

test1
test2

test3 <- left_join(test1, test2, by="id")
test3

# 2. 세로로 결합 - bind_rows() : 세로 결합시 가장 많이 사용하는 함수
group1 <- data.frame(
  id = c(1:5),
  test = c(60, 80, 70, 90, 85)
)

group2 <- data.frame(
  id = c(6:10),
  test = c(70, 83, 65, 95, 80)
)

group1
group2

group3 <- bind_rows(group1, group2)
group3

#####
### 세로 결합(조인) - 3가지 예제, bind_rows(), intersect(), setdiff()
x <- data.frame(
  A = c("a", "b", "c"),
  B = c("t", "u", "v"),
  C = c(1, 2, 3), stringsAsFactors = F
)

y <- data.frame(
  A = c("a", "b", "c"),
  B = c("t", "u", "w"),
  C = c(1, 2, 4), stringsAsFactors = F
)

x
y

# 1-1. bind_rows() - 데이터1 아래에 데이터2를 세로로 합침
xy1 <- bind_rows(x, y)
xy1

# 1-2. intersect() - 데이터1과 데이터2 중에서 같은 데이터만 세로로 합침, 교집합
xy2 <- intersect(x, y)
xy2

# 1-3. setdiff() - 데이터1을 기준으로 데이터2와 비교해서 서로 다른 데이터만 합침
xy3 <- setdiff(x, y)
xy3

xy4 <- setdiff(y, x)
xy4
 
### 가로 결합(조인) - 5가지 예제, left_join(), right_join(), inner_join(), full_join(), bind_cols()
A <- data.frame(
  id = c(1, 2, 3),
  locale = c("seoul", "busan", "daegu")
)
B <- data.frame(
  id = c(1, 2, 4),
  sex = c("M", "F", "M")
)

A
B

# NA - not available, 사용할 수 없는 데이터
# 1-1. left_join() - 왼쪽 데이터를 기준으로 오른쪽 데이터를 기준컬럼(변수)으로 합침
AB1 <- left_join(A, B, by="id")
AB1

# 1-2. right_join() - 오른쪽 데이터를 기준으로 왼쪽 데이터를 기준컬럼(변수)으로 합침
AB2 <- right_join(A, B, by="id")
AB2

# 1-3. inner_join() - 데이터1과 데이터2에서 기준컬럼(변수)
AB3 <- inner_join(A, B, by="id")
AB3

# 1-4. full_join() - 데이터1과 데이터2에서 기준컬럼(변수)를 기준으로 모든 것을 합침
AB4 <- full_join(A, B, by="id")
AB4

# 1-5. bind_cols()
AB5 <- bind_cols(A, B)
AB5

mpg <- as.data.frame(ggplot2::mpg)
View(mpg)

# 데이터의 빈도 확인
table(mpg$fl) # 변수의 빈도를 확인하는 함수
qplot(mpg$fl) # 변수의 빈도를 그래프로 출력하는 함수

# < 확인 학습 > 데이터 결합
# 문제1. mpg에서 연료 타입의 종류는 5가지인데, 각 타입별로 가격을 price_fl이라는 파생변수로 만들어서 추가하시오. (c: 2.35, d: 2.38, e: 2.11, p:2.76, r: 2.22)

# 1번 방법 - 데이터 결합
fuel <- data.frame(
  fl = c("c", "d", "e", "p", "r"),
  price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
  stringsAsFactors = F
)
mpg <- left_join(mpg, fuel, by="fl")
# 2번 방법 - 조건, ifelse() 함수 사용
mpg$price_fl2 <- ifelse(mpg$fl == "c", 2.35,
                        ifelse(mpg$fl == "d", 2.38, 
                               ifelse(mpg$fl == "e", 2.11,
                                      ifelse(mpg$fl == "p", 2.76, 2.22))))

