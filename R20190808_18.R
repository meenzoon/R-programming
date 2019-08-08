# 18일차 수업 - 20190808(목)

library(dplyr)
library(ggplot2)
library(readxl)

# < 워드 클라우드 프로젝트1 >
# KoNLP(Korea Natural Language Processing) 패키지 - 한글 자연어 분석 패키지
# KoNLP 패키지는 JAVA 언어로 생성 - jdk 설치

# JAVA 환경변수 설정
Sys.setenv(JAVA_HOME = "C:/Program Files/Java/jdk1.8.0_221/")

library(rJava)
library(memoise)
library(KoNLP)
library(stringr)

# 단어 사전 확인 및 설정 (3가지 사전 중 하나를 선택)
# useSystemDic() # 시스템 사전, 28만 단어
# useSejongDic() # 세종 사전, 37만 단어
useNIADic()    # NIA 사전, 98만 단어, 선택한 사전

# 워드 클라우드로 분석할 텍스트를 가져옴.
hiphop <- readLines("C:/study/data1/hiphop.txt")
View(hiphop)

class(hiphop) # character

# 특수문자 제거
hiphop <- str_replace_all(hiphop, "\\W", " ") # 모든 특수문자를 공백으로 전환

# 명사 추출
noun <- extractNoun(hiphop)
View(noun)

# 워드카운트 생성
# 명사 리스트를 문자열 벡터 형태로 변환 -> 워드카운트 생성
wordcount <- table(unlist(noun))

View(wordcount)
class(wordcount) # table 형태

# 벡터 형태의 워드카운트를 데이터프레임으로 변경
df_wordcount <- as.data.frame(wordcount, stringsAsFactors = F)

df_wordcount
View(df_wordcount)
class(df_wordcount) # data.frame 형태

# 변수명 변경
df_wordcount <- rename(df_wordcount, word = Var1, freq = Freq)

dim(df_wordcount)

# 한 글자를 제외하고, 두 글자 이상의 단어만 추출
df_wordcount2 <- filter(df_wordcount, nchar(word) >= 2)

df_wordcount2
View(df_wordcount2)

dim(df_wordcount2) # 2508행 2열

#빈도수로 상위 100개 단어를 추출해서 빈도표를 생성
wc_top100 <- df_wordcount2 %>% arrange(-freq) %>% head(100)
wc_top100

dim(wc_top100) # 100행 2열

###
### 워드클라우드 생성

library(wordcloud)

# RColorBrewer - 글자 색상을 변환하는 내장 패키지

# 색상 목록 생성
pal <- brewer.pal(8, "Dark2")
pal

# 난수 생성
set.seed(123456)

wordcloud(words = wc_top100$word, 
          freq = wc_top100$freq, 
          min.freq = 5, 
          max.words = 500, 
          random.order = F, 
          rot.per = 0.1, 
          scale = c(4, 0.3),
          colors = pal)

##########
# < 워드 클라우드 프로젝트 >
twitter <- read.csv("c:/study/data1/twitter.csv", header = T, stringsAsFactors = F, fileEncoding = "UTF-8")
twitter
View(twitter)
class(twitter) # data.frame
dim(twitter) # 3743행, 5열

twitter <- rename(twitter, num = 번호, id = 계정이름, date = 작성일,content  = 내용)

# 명사 추출
tw_noun <- extractNoun(twitter$content)

View(tw_noun)

class(tw_noun) # 데이터 종류: list

# 워드카운트 생성 - 리스트를 벡터 타입으로 변경하고, 빈도표를 생성
tw_wordcount <- table(unlist(tw_noun))

tw_wordcount
View(tw_wordcount)
class(tw_wordcount) # 데이터 종류: table
dim(tw_wordcount) # 10677행

# 벡터를 데이터프레임 변경
df_tw_wc <- as.data.frame(tw_wordcount, stringsAsFactors = F)

df_tw_wc
View(df_tw_wc)
class(df_tw_wc) # data.frame
dim(df_tw_wc) # 10677행 2열

# 변수 이름 변경
df_tw_wc <- rename(df_tw_wc, word = Var1, freq = Freq)

# 한 글자를 제외하고 두 글자 이상의 단어를 추출
df_tw_wc2 <- filter(df_tw_wc, nchar(word) >= 2)

df_tw_wc2
View(df_tw_wc2)
class(df_tw_wc2) # data.frame
dim(df_tw_wc2) # 10158행, 2열

df_tw_top100 <- df_tw_wc2 %>% arrange(-freq) %>% head(100)
View(df_tw_top100)

# 워드클라우드 생성

# 색상 목록 생성
pal2 <- brewer.pal(8, "Accent")
# pal2 <- brewer.pal(9, "Blues")[5:9]
pal2

# 난수 생성
set.seed(1234)

wordcloud(words = df_tw_top100$word, 
          freq = df_tw_top100$freq, 
          min.freq = 10, 
          max.words = 1000, 
          random.order = F, 
          rot.per = 0.1, 
          scale = c(4, 0.3),
          colors = pal2)
