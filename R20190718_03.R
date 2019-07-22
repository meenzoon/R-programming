# 3일차 수업 - 20190718(목)

### 2. 행렬(Matrix) : 2차원 형의 데이터 구조 (같은 타입)
x <- c(1:6)

m1 <- matrix(x, nrow=2, ncol=3); m1 # 2행 3열 행렬, 열 우선
m2 <- matrix(x, nrow=3, ncol=2); m2 # 3행 2열의 행렬, 열 우선
m3 <- matrix(x, nrow=3, ncol=2, byrow=T); m2 # 3행 2열의 행렬, 행 우선

dim(m3) # 행(데이터의 건수)과 열(데이터의 변수)을 확인 함수

### 3. 배열(Array) : 3차원 이상의 데이터 구조 (같은 타입)
a1 <- array(x, c(2, 2, 3))

dim(a1)

### 4. 리스트(List) : 1차원 구조, 리스트 원소가 다시 리스트가 될수 있으므로 계층적 데이터 확인
list1 <- list(c(1, 2, 3), c("A", "B", "C"))
class(list1)

### 5. 데이터프레임(DataFrame) : 2차원 형태의 데이터 구조, (여러 가지 타입)

## 데이터프레임을 생성하는 방법
# 1. 벡터를 먼저 생성한 후 벡터를 통해서 데이터프레임을 생성
id <- c(1:10)
name <- c("김진태", "이민영", "강태환", "심권호", "남민수", "최민수", "장동건", "한효주", "송혜교", "강동원")
sex <- c("M", "F", "M", "M", "M", "M", "M", "F", "F", "M")
age <- c(20, 35, 65, 45, 33, 32, 36, 57, 18, 22)
area <- c("제주", "대구", "인천", "서울", "부산", "서울", "광주", "통영", "울산", "강릉")

df1 <- data.frame(id, name, sex, age, area)

df1
View(df1) # 데이터를 테이블 형태로 확인
head(df1) # 데이터를 앞에서부터 6건 확인
tail(df1) # 데이터를 뒤에서부터 6건 확인
head(df1, 3) # 데이터를 앞에서부터 3건 확인
tail(df1, 4) # 데이터를 뒤에서부터 4건 확인
summary(df1) # 통계 요약 정보 확인

dim(df1) # 10행 5열, 10개의 데이터, 5개의 변수

df1$name
df1$area
df1$age

s_mean <- mean(df1$age) # 평균
s_max <- max(df1$age) # 최댓값
s_min <- min(df1$age) # 최솟값
s_sum <- sum(df1$age) # 합계
s_median <- median(df1$age) # 중앙값
sort(df1$age)

# 2. 데이터프레임을 생성시에 변수를 만드는 방법
fruit_sales <- data.frame(
  fruit = c("사과", "딸기", "수박", "포도", "바나나"),
  price = c(1500, 5000, 15000, 7000, 3000),
  volume = c(30, 25, 40, 27, 50))

fruit_sales
View(fruit_sales)
head(fruit_sales, 2)
tail(fruit_sales, 3)

# R에 내장되어 있는 데이터셋을 확인
data(package = .packages(all.available = T))

mtcars
View(mtcars)

help(mtcars)
?mtcars

mtcars <- mtcars
class(mtcars)

mt1 <- mtcars$mpg / mtcars$cyl
mt2 <- with(mtcars, mpg / cyl)


# 새로운 변수를 생성하여 데이터프레임에 추가하는 방법 
mtcars$x <- mtcars$mpg / mtcars$cyl
mt3 <- within(mtcars, x <- mpg / cyl)


dim(mtcars)
dim(mt3)
View(mt3)

# 데이터프레임 열(변수) 수정/추가/삭제
df2 <- data.frame(
  name = c("Kim", "Lee", "Park", "Kang", "Han"),
  age = c(33, 25, 41, 52, 29),
  height = c(180, 178, 172, 176, 185), stringsAsFactors = F)

str(df2)
class(df2)

# 수정
df2[4, 1] <- "Choi" # 변수 하나의 값을 바꿈
df2[3, 3] <- 175
df2[5,] <- c("Hong", 39, 175) # 행 전체의 값을 바꿈

# 추가
df2[6,] <- c("Yuk", 32, 185) # 행 데이터를 추가

# 삭제
df2 <- df2[-2,] # 행을 삭제
df2[,-2] # 열을 삭제
df2[-4, -2] # 행과열을 모두 삭제

###