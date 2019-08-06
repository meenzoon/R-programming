# 16일차 수업 - 20190806(화)

library(dplyr)
library(ggplot2)
library(readxl)

welfare <- read_excel("C:/study/data1/welfare.xlsx", col_names = T)
View(welfare)

##########
### 7번째 프로젝트 - 성별 직업의 빈도 차이 - 성별로 어떤 
# < 1단계 > 변수 검토 및 전처리 - 성별, 직업
# 1-1. 성별 변수 확인 - 1번째 프로젝트에서 이미 확인

# 1-2. 직업 변수 확인 - 6번째 프로젝트에서 이미 확인

# < 2단계 > 분석표(통계요약표)
# 2. 성별로 그룹화하여 직업의 빈도를 차이 확인
# 2-1. 남성의 직업의 빈도 분석표(상위 10개만)
job_male <- welfare %>% filter(!is.na(job) & sex == "M") %>% group_by(job) %>% summarise(count = n()) %>% arrange(-count) %>% head(10)
job_male

# 2-2. 여성의 직업의 빈도 분석표(상위 10개만)
job_female <- welfare %>% filter(!is.na(job) & sex == "F") %>% group_by(job) %>% summarise(count = n()) %>% arrange(-count) %>% head(10)
job_female

# < 3단계 > 시각화 - 가로 막대 그래프
# 3-1. 남성 상위 10개
ggplot(data = job_male, aes(x = reorder(job, count), y = count)) + geom_col() + coord_flip()

# 3-2. 여성 상위 10개
ggplot(data = job_female, aes(x = reorder(job, count), y = count)) + geom_col() + coord_flip()

# < 4단계 > 분석 결과
# 4-1. 남성 상위 10개 - 남성은 '작물재배 종사자'가 가장 지고 있으며, 그 다음 순으로는 '자동차 운전원', '경영관련 사무원', '매장 판매 종사자', '영업 종사자', '청소원 및 환경 미화원' 순으로 많은 직업을 가지고 있다. 

# 4-2. 여성 상위 10개 - 여성은 '작물재배 종사자'가 가장 지고 있으며, 그 다음 순으로는 '청소원 및 환경 미화원', '매장 판매 종사자', '제조관련 단순 종사원', '회계 및 경리 사무원', '의료 복지 관련 서비스 종사자' 순으로 많은 직업을 가지고 있다.

# 4-3. 전체 결과 - 남녀 모두 '작물 재배 종사자'가 가장 많고, 있음을 알 수 있다.

##########
### 8번째 프로젝트 - 종교 유무에 따른 이혼율(종교가 있으면 이혼율이 낮을까?)
# < 1단계 > 변수 검토 및 전처리 (종교, 결혼(이혼))
# 1-1. 종교 변수 확인 - 1: 있음, 2: 없음, 9: 모름/무응답
class(welfare$religion)
table(welfare$religion) # 1: 6694, 2: 8229

# 이 데이터는 종교에 대해서 이상치, 결측치가 없지만 있다고 가정하고 이상치를 결측치로 변경
welfare$religion <- ifelse(welfare$religion %in% c(1, 2), welfare$religion, NA)

# 종교 변수의 값을 변경 - 1 -> YES, 2 -> NO
welfare$religion <- ifelse(welfare$religion == 1, "YES", "NO")
table(welfare$religion) # YES: 6694, NO: 8229

# 1-2. 결혼 변수 확인
# 0: 비해당(미성년), 1: 유배우, 2: 사별, 3:이혼, 4: 별거, 5: 미혼, 6: 기타(사망 등), 9: 모름, 무응답
class(welfare$marriage)
table(welfare$marriage)

# 결혼 변수에서 1->결혼(marriage), 3->이혼(divorce), 2가지 이외의 값은 NA로 처리
welfare$marriage <- ifelse(welfare$marriage == 1, "marriage", 
                           ifelse(welfare$marriage == 3, "divorce", NA))
table(welfare$marriage)

# < 2단계 > 분석표(통계요약표)
# 2-1. 종교 유무에 따른 결혼유지율, 이혼율
religion_marriage <- welfare %>% 
  filter(!is.na(marriage)) %>% 
  group_by(religion, marriage) %>% 
  summarise(count = n()) %>% 
  mutate(tot = sum(count)) %>% 
  mutate(ratio = (count / tot * 100), 2)

religion_marriage

# 2-2. 위의 데이터로부터 종교 유무에 따른 이혼율만 추출
religion_divorce <- religion_marriage %>% 
  filter(marriage == "divorce") %>% 
  select(religion, ratio)

religion_divorce

# < 3단계 > 시각화 - 막대 그래프
ggplot(data = religion_divorce, aes(x = religion, y = ratio)) + geom_col()

# < 4단계 > 분석 결과
# 분석 결과: 종교가 있을 때 이혼율은 8.06퍼센트이고, 종교가 없을 때 이혼율은 9.14퍼센트로, 종교가 있을 때가 없을때보다 1.08퍼센트 낮다는 것을 알 수 있다.

##########
### 9번째 프로젝트 - 연령대별 종교 유무에 따른 이혼율 - 연령대별로 종교가 있으면 이혼율 더 낮을까?
# < 1단계 > 변수 검토 및 전처리(연령대, 종교, 결혼(이혼))
# 1-1. 연령대 변수 확인 - 3번째 프로젝트에서 이미 확인
# 1-2. 종교 변수 확인 - 8번째 프로젝트에서 이미 확인
# 1-3. 결혼 변수 확인 - 8번째 프로젝트에서 이미 확인

# < 2단계 > 분석표(통계요약표)
# 2-1. 연령대별 결혼유지율, 이혼율 분석표
ageg_marriage <- welfare %>% 
  filter(!is.na(marriage)) %>% 
  group_by(ageg, marriage) %>% 
  summarise(count = n()) %>% 
  mutate(tot = sum(count)) %>% 
  mutate(ratio = round(count / tot * 100, 2))

ageg_marriage

# 2-2. 위의 데이터에서 연령대별 이혼율만 추출, 초년의 데이터는 제외
ageg_divorce <- ageg_marriage %>% 
  filter(marriage == "divorce" & ageg != "young") %>% 
  select(ageg, ratio)

ageg_divorce

# < 3단계 > 시각화 - 막대 그래프
ggplot(data = ageg_divorce, aes(x = ageg, y = ratio)) + geom_col()

# < 4단계 > 분석 결과
# 분석 결과: 초년은 데이터 작아서 제외하고, 중년의 이혼율은 9.31퍼센트이고, 노년의 이혼율은 7.96으로 중년의 이혼율이 노년의 이혼율보다 1.35퍼센트 높은 것을 알 수 있다.

##########
### 10번째 프로젝트 - 연려대별 종교 유무에 따른 이혼율
# < 1단계 > 변수 검토 및 전처리(연령대, 종교, 결혼(이혼))
# 1-1. 연령대 변수 확인 - 3번째 프로젝트에서 이미 확인
# 1-2. 종교 변수 확인 - 8번째 프로젝트에서 이미 확인
# 1-3. 결혼 변수 확인 - 8번째 프로젝트에서 이미 확인

# < 2단계 > 분석표(통계요약표)
# 2-1. 연령대별 종교 유무에 따른 결혼유지율, 이혼율 분석표
ageg_religion_marriage <- welfare %>% 
  filter(!is.na(marriage)) %>% 
  group_by(ageg, religion, marriage) %>% 
  summarise(count = n()) %>% 
  mutate(tot = sum(count)) %>% 
  mutate(ratio = round(count / tot * 100, 2))

View(ageg_religion_marriage)

# 2-2. 위의 데이터에서 이혼율만 추출, 
ageg_religion_divorce <- ageg_religion_marriage %>% 
  filter(marriage == "divorce" & ageg != "young") %>% 
  select(ageg, religion, ratio)

ageg_religion_divorce

# < 3단계 > 시각화
# 누적 막대 그래프
ggplot(data = ageg_religion_divorce, aes(x = ageg, y = ratio, fill = religion)) + geom_col()

# 종교 변수를 따로 막대 그래프로 표현
ggplot(data = ageg_religion_divorce, aes(x = ageg, y = ratio, fill = religion)) + geom_col(position = "dodge")

# < 4단계 > 분석 결과
# 분석 결과: 노년일 때 종교가 있을 때는 이혼율이 7.92퍼센트이고, 종교가 없을 때는 8.02퍼센트로 0.1퍼센트의 차이를 보이지만, 중년일 때 종교가 있을 때는 이혼율이 8.3퍼센트이고, 종교가 없을 때는 10.0퍼센트로 거의 2퍼센트에 가까운 차이를 보이고 있다. 이로써 중년일 때 종교의 유무가 노년일 때 보다 이혼율에 미치는 영향이 훨씬 크다는 것을 알 수 있다.