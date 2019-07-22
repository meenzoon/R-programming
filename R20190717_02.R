# 2일차 수업 - 20190717(수)

### 변수 : 값을 저장하는 공간
# 변수의 이름을 만드는 규칙
# 1. 알파벳, 숫자, 기호는 .(점), _(언더바)를 사용
# 2. 알파벳 대소문자 구분
# 3. 첫문자로는 숫자, _(언더바)는 사용 불가
# 4. 첫문자 .(점)은 R 내부에서 사용, 가급적이면 사용하지 않는 것을 권장
# 가급적이면 변수 이름은 의미있게 지어주는 권장

a = 10
b <- 20
c <- 30; c
(d <- 40)

rm(a) # 변수 삭제
rm(list = ls()) # 모든 변수 제거

str(a) # 변수의 구조 확인
ls.str() # 모든 변수의 구조 확인

# 데이터 타입 : numeric(숫자), charactor(문자), factor(범주), Date(날짜), POSIXct(날짜, 시간), logical(논리)
x1 <- 23; class(x1) # 정수, 데이터의 타입 확인
x2 <- 23.3; class(x2) # 실수
x3 <- "Hello"; class(x3) # 문자열
x4 <- factor(c("one", "two", "three")); class(x4) # 범주
x5 <- c("one", "two", "three"); class(x5)
x6 <- as.Date("2019-06-25"); class(x6)
x7 <- as.POSIXct("2019-06-25 12:30:35"); class(x7)
x8 <- TRUE; class(x8)

Sys.Date()
Sys.time()
Sys.timezone()
Sys.info()

# 아주 중요함
### 데이터 구조 
# 단일형 - 벡터(Vector) : 1차원, 행렬(Matrix) : 2차원, 배열(Array) : 3차원 이상
# 다중형 - 리스트(List) : 1차원, 데이터프레임(DataFrame) : 2차원

### 1. 벡터(Vector)
x1 <- 10 # 단일 데이터
x2 <- 1:10 # 연속 데이터

# c() : combine, 여러 벡터 데이터를 연결하여 하나의 긴 벡터 데이터로 만드는 함수
x3 <- c(1:10)
x4 <- c(10, 20, 25, 37, 44) # 숫자 벡터 데이터
x5 <- c("John", "Mary", "Peter") # 문자 벡터 데이터
x6 <- c("A", 10, 10.5)
class(x6)

x7 <- c(1, 2, 3, c(4, 5), c(6, 7, 8))
class(x7)
length(x7) # 데이터의 갯수

# seq() : sequence, 연속 데이터
x8 <- seq(1, 10) # 1부터 10까지 1씩 증가
x9 <- seq(from=1, to=10, by=2) # 1부터 10까지 2씩 증가, 생략해도 적용됨, 디폴트
x10 <- seq(1, 9, length.out=3) # 길이 3개

# 1:10, c(1:10), seq(1, 10) 같은 결과

# rep() : repeat, 반복 데이터
x11 <- rep(1, 10)
x12 <- rep("ABC", 10)
x13 <- rep(c("A", "B", "C"), 3)
x14 <- rep(seq(1:4), times=3) # 1~4를 3번 반복
x15 <- rep(seq(1:4), each=3) # 1~4를 각각 3번 반복
x16 <- rep(seq(1:4), length.out=10) # 1~4를 반복하여 10개를 저장

x17 <- c(TRUE, FALSE, TRUE, FALSE) # 논리 데이터, 참(TRUE, T), 거짓(FALSE, F)
30 > 10
30 < 10

x18 <- c(3, 3, 1)
x19 <- c(1, 3, 2)
x18 > x19 # TRUE FALSE FALSE
x18 < x19 # FALSE FALSE TRUE

## 벡터 데이터의 선택/제외
# 어떤 학급의 키 측정값 7개
v1 <- c(180, 168, 172, 155, 190, 175, 185)

# 1. 인덱스로 선택
v1[3]
v1[5]
v1[c(2, 4, 6)]
v1[c(2:5)]

# 2. 인덱스로 제외
v1[-5]
v2 <- v1[c(-2, -4, -6)]
v1 <- v1[-5]

v2 <- c(Park=180, Jung=168, Kim=172, Lee=155, Han=190, Kang=175, Choi=185)
v2["Kim"]
v2[c("Kim", "Lee", "Park")]

# 3. 논리값으로 선택
v2[c(T, F, F, T, T, F, T)]
v3 <- v2[v2 > 170]

## 벡터 데이터의 정렬
sort(v2)
sort(v2, decreasing=T)







