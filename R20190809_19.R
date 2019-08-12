# 19일차 수업 - 20190809(금)

library(dplyr)
library(ggplot2)
library(readxl)
library(rJava)
library(KoNLP)

##########
# < 워드 클라우드 프로젝트 3 >
install.packages("wordcloud2")
library(wordcloud2)

# 사전 선택
useNIADic() # 983012단어

national_song <- readLines("c:/study/data2/애국가(가사).txt")
national_song
class(national_song)

# 명사 추출
noun <- extractNoun(national_song)
noun
class(noun)

# 리스트를 벡터로 변환해서 빈도표를 생성 -> 워드카운트 생성
wc <- table(unlist(noun))
wc
View(wc)
class(wc) # table : 벡터

# 벡터를 데이터프레임으로 변경
df_wc <- as.data.frame(wc, stringsAsFactors = F)

df_wc
View(df_wc)
class(df_wc)
dim(df_wc) # 54 2

# 변수명 변경
df_wc <- rename(df_wc, word = Var1, freq = Freq)

# 두 글자 이상의 단어만 추출
df_wc2 <- filter(df_wc, nchar(word) >= 2)
df_wc2
View(df_wc2)
dim(df_wc2) # 32 2

### 워드클라우드 생성

# wordcloud2 패키지를 이용하여 간단하게 워드클라우드 생성
wordcloud2(df_wc2)

# 배경색상 변경
wordcloud2(df_wc2, color = "random-dark", backgroundColor = "pink")
wordcloud2(df_wc2, color = "random-light", backgroundColor = "black")

# 모양 변경
# shape 옵션 : star, diamond, cardioid, triangle, triangle-forward, pentagon, 기본값은 circle
wordcloud2(df_wc2, fontFamily = "궁서체", size = 1, color = "random-light", backgroundColor = "black", shape = "pentagon")

# 내장된 모양 데이터셋을 활용
# 1.
wordcloud2(demoFreq, size = 1.6, color = rep_len(c("red", "orange", "yellow", "green", "blue", "navy", "purple"), nrow(df_wc2)))

# 2. 
wordcloud2(demoFreq, minRotation = -pi / 6, maxRotation = -pi / 6, rotateRatio = 1, shape = "star")


#####
##########
#####

### 프로젝트 - 미국 주별 범죄율 분석하여 그래프로 표현
USArrests
View(USArrests)
str(USArrests)
dim(USArrests) # 50 4
summary(USArrests)
class(USArrests)

# 주 이름(행 제목)을 변수로 생성해서 데이터프레임을 생성
library(tibble)
crime <- rownames_to_column(USArrests, var = "state")

# state 변수의 모든 값을 소문자로 변경
crime$state <- tolower(crime$state)

View(crime)
dim(crime) # 50 5
summary(crime)
class(crime)

# 미국 지도를 생성하는 패키지 - ggiraphExtra
install.packages("ggiraphExtra")
library(ggiraphExtra)

# 미국 주별 위도 경도를 나타내는 패키지 - maps, mapproj
install.packages("maps")
install.packages("mapproj")
library(maps)
library(mapproj)

# 미국 주별 위도 경도를 나타내는 데이터셋 - state
states_map <- map_data("state")

View(states_map)
dim(states_map) # 15537 6
str(states_map)
summary(states_map)

# 미국 지도에 주별 범죄율 그래프
ggChoropleth(data = crime, # 지도에 표시할 데이터
             aes(fill = Murder, map_id = state), # fill: 색깔로 표현할 변수, map_id: 지역 기준 변수
             map = states_map) # 지도 데이터

# 인터랙티브한 미국 지도에 주별 범죄율 그래프
ggChoropleth(data = crime,
             aes(fill = Assault, map_id = state),
             map = states_map,
             interactive = T) # 인터랙티브 기능


#####
##########
#####

### 프로젝트 - 대한민국 시도별 인구 구분 지도 그래프 (2014년도)
library(stringi)
library(devtools)
devtools::install_github("cardiomoon/kormaps2014")
kormaps2014::korpop1
View(kormaps2014::korpop1)

library(kormaps2014)

# 인구에 관한 통계 자료
# encoding 맞춤, CP949 -> utf-8
str(changeCode(korpop1))
View(changeCode(korpop1))
korpop1 <- rename(korpop1, pop = 총인구_명, name = 행정구역별_읍면동)

View(korpop1)












































