# 20일차 수업 - 20190812(월)

library(dplyr)
library(ggplot2)
library(readxl)

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

library(ggiraphExtra)

ggChoropleth(data = korpop1,
             aes(fill = pop, map_id = code, tooltip = name),
             map = kormap1,
             interactive = T)
### < 프로젝트2 - 2015년도 대한민국 결핵 환자수 구분 그래프 > ###
# tbc - 2001~2015까지 전국 지역별 결핵 환자 데이터
str(changeCode(tbc))
tbc1 <- changeCode(tbc)
View(tbc1)
View(tbc)

# tbc에서 2015년도 데이터 추출
tbc_2015 <- tbc %>% filter(year == 2015)
View(changeCode(tbc_2015))

ggChoropleth(data = tbc_2015,
             aes(fill = NewPts, map_id = code, tooltip = name),
             map = kormap1,
             interactive = T)

##########
### 인터랙티브 그래프 ###
##########
# 1번
# plotly - ggplot에 추가하여 인터랙티브 그래프를 만들어주는 패키지
library(plotly)

mpg <- as.data.frame(ggplot2::mpg)
View(mpg)

# x축에는 배기량(displ), y축은 고속도로 연비(hwy)를 나타내는 산점도 그래프
# 추가: 구동 방식별 고속도로 연비 산점도 그래프 
ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()

ggplotly(ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point())

# 2번
diamonds
View(diamonds)

# 누적
ggplot(data = diamonds, aes(x = cut, fill = clarity)) + geom_bar()

# 막대별로
ggplot(data = diamonds, aes(x = cut, fill = clarity)) + geom_bar(position = "dodge")

ggplotly(ggplot(data = diamonds, aes(x = cut, fill = clarity)) + geom_bar(position = "dodge"))

### 인터랙티브 그래프2 ###

library(dygraphs)

economics <- as.data.frame(ggplot2:economics)
ggplot2::economics
View(ggplot2::economics)

# 데이터 시간 순서의 속성을 가질려면 xtx 데이터 타입으로 설정되어 있어야함
library(xts)

# 날짜별로 실업자수를 확인
eco <- xts(economics$unemploy, order.by = economics$date)
View(eco)
class(eco) # xts zoo

dygraph(eco)
dygraph(eco) %>% dyRangeSelector()

# 2. 날짜별로 실업률을 확인
eco_unemploy <- xts(economics$unemploy/1000, order.by = economics$date)

dygraph(eco_unemploy)

# 3. 날짜별로 저축률을 확인
eco_psavert <- xts(economics$psavert, order.by = economics$date)
dygraph(eco_psavert)

# 2번과 3번을 합침, 날짜별로 실업률 저축률을 함께 확인
eco2 <- cbind(eco_unemploy, eco_psavert)
eco2
View(eco2)

# 변수명 수정
colnames(eco2) <- c("unemploy", "psavert")
View(eco2)

dygraph(eco2)
dygraph(eco2) %>% dyRangeSelector()

### 프로젝트 - 서울시 서대문구 치킨집이 많은 동네를 동별로 시각화

ssc <- read_excel("c:/study/data2/치킨집_가공.xlsx")
View(ssc)
class(ssc) # data.frame
dim(ssc) # 1515 2
summary(ssc)

# 변수명 수정
ssc <- rename(ssc, addr = 소재지전체주소, name = 사업장명)

# addr에서는 동만 필요함, 동만 남기고 나머지는 삭제
address <- substr(ssc$addr, 12, 16)
View(address)

# 숫자 제거
addr1 <- gsub("[0-9]", "", address)
View(addr1)

# 공백 제거
addr2 <- gsub(" ", "", addr1)
addr2

# 동별로 빈도표 생성 -> 동별로 빈도를 세어서 누적
addr3 <- table(addr2) %>%  data.frame()
View(addr3)

# 동별로 빈도가 높은순(내림차순)으로 정렬
addr4 <- addr3 %>% arrange(-Freq)
View(addr4)

# 시각화
ck <- ggplot(data = addr4, aes(x = reorder(addr2, Freq), y = Freq)) + geom_col() + coord_flip() + xlab("서대문구 동명") + ylab("치킨집 수")

# 인터랙티브 그래프
ggplotly(ck)

# 트리맵을 사용하여 시각화
library(treemap)

treemap(addr4, index = "addr2", vSize = "Freq", title = "서울시 서대문구 치킨집 분포 그래프")

