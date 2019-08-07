# 17일차 수업 - 20190807(수)

library(dplyr)
library(ggplot2)
library(readxl)

##########
### 11번째 프로젝트 - 지역별 연령대 비율
# < 1단계 > 변수 검토 및 전처리(지역, 연령대)
# 1-1. 지역 변수 확인, code_region 변수를 통해 region 파생변수를 생성
# code_region - 1:서울, 2:수도권(인천/경기), 3:부산/경남/울산, 4:대구/경북, 5:대전/충남, 6:강원/충북, 7:광주/전남/전북/제주도

class(welfare$code_region)
table(welfare$code_region)

# 지역번호에 해당한 지역명을 가진 데이터프레임을 생성
list_region <- data.frame(code_region = c(1:7), region = c("서울", "수도권(인천/경기", "부산/경남/울산", "대구/경북", "대전/충남", "강원/충북", "광주/전남/전북/제주도"))

list_region

# welfare와 list_region을 가로 결합하여 region 파생변수 생성
welfare <- left_join(welfare, list_region, id = "code_region")
table(welfare$region)
table(is.na(welfare$region)) # FALSE: 14923, 결측치 데이터는 없음

# 1-2. 연령대 변수 확인 - 3번째 프로젝트에서 이미 확인

# < 2단계 > 분석표(통계요약표)
# 2. 지역별로 그룹하여 연령대 별로 비율을 확인
region_ageg <- welfare %>% 
  filter(!is.na(region) & !is.na(ageg)) %>% 
  group_by(region, ageg) %>% 
  summarise(count = n()) %>% 
  mutate(tot = sum(count)) %>% 
  mutate(ratio = round(count / tot * 100, 2))

View(region_ageg)

# < 3단계 > 시각화 - 막대 그래프
# 세로 막대 그래프
ggplot(data = region_ageg, aes(x = region, y = ratio, fill = ageg)) + geom_col()

# 가로 막대 그래프
ggplot(data = region_ageg, aes(x = region, y = ratio, fill = ageg)) + geom_col() + coord_flip()

##########
### 12-1번째 프로젝트 - 지역별 연령대 중에서 노년층의 비율
# < 2단계 > 분석표
# region_ageg에서 노년층만 추출한 데이터프레임 생성, 내림차순으로 정렬
region_old <- region_ageg %>% 
  filter(ageg == "old") %>% 
  arrange(-ratio)

region_old
#  < 3단계 > 시각화
# 가로 막대 그래프
ggplot(data = region_old, aes(x = reorder(region, ratio), y = ratio)) + geom_col() + coord_flip()

# < 4단계 > 분석 결과
# 분석 결과: "대구/경북" 지역의 노년층이 49.3퍼센트로 가장 높고, 그 다음으로는 "강원/충북", "광주/전남/전북/제주도", "부산/경남/울산", "대전/충남", "서울", "수도권(인천/경기)" 순으로 낮을 결과를 나타냄을 알 수 있다. 노년층이 가장 많은 "대구/경북"은 49.3퍼센트이고, 노년층이 가장 적은 "수도권(인천/경기)"는 31.8퍼센트로 17.5퍼센트의 차이를 나타냄을 알 수 있다.


##########
##########
##########

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
hiphop <- readLines("c:/study/data1/hiphop.txt")
View(hiphop)

class(hiphop) # character

# 특수문자 제거
hiphop <- str_replace_all(hiphop, "\\w", " ") # 모든 특수문자를 공백으로 전환

# 명사 추출
noun <- extractNoun(hiphop)
View(noun)
