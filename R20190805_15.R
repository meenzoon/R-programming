# 15일차 수업 - 20190805(월)

library(dplyr)
library(ggplot2)
library(readxl)
library(xlsx)

welfare <- write.xlsx(welfare, file = "c:/study/data2/welfare.xlsx")

welfare <- read_excel("c:/study/data1/welfare.xlsx", col_names = T)
View(welfare)

##########
### 3-2번째 프로젝트 - 연령대별 월급의 차이 (20대, 30대, 40대, 50대, 60대, 70대)
# < 1단계 > 변수 검토 및 전처리 (연령대, 월급)
# 1-1. 연령대 변수 확인 -> age로부터 파생변수로 생성
# ageg2 - (20대, 30대, 40대, 50대, 60대, 70대)의 6개 분류, 이 외의 값은 NA 처리
welfare$ageg2 <- ifelse(welfare$age >= 20 & welfare$age < 30, "20대",
                        ifelse(welfare$age >= 30 & welfare$age < 40, "30대",
                               ifelse(welfare$age >= 40 & welfare$age < 50, "40대",
                                      ifelse(welfare$age >= 50 & welfare$age < 60, "50대",
                                             ifelse(welfare$age >= 60 & welfare$age < 70, "60대",
                                                    ifelse(welfare$age >= 70 & welfare$age < 80, "70대", NA))))))

# 1-2. 월급 변수 확인 - 1번째 프로젝트에서 이미 확인

# < 2단계 > 분석표(통계요약표)
# 2. 연령대별로 월급의 평균의 차이
ageg2_income <- welfare %>% 
  filter(!is.na(income) & !is.na(ageg2)) %>% 
  group_by(ageg2) %>% 
  summarise(mean_income = mean(income))

ageg2_income

# < 3단계 > 시각화 - 막대 그래프
ggplot(data = ageg2_income, aes(x = ageg2, y = mean_income)) + geom_col()

# < 4단계 > 분석 결과
# 분석 결과 : 20대의 평균 월급은 189만원, 30대는 287만원, 40대는 가장 많은 345만원, 50대는 319만원, 60대는 198만원의 평균 월급을 받으며, 70대는 76만원의 평균 월급으로 20대의 절반이 되지 않는 가장 적은 월급을 받게 됨을 알 수 있다.

##########
### 4번째 프로젝트 - 연령대 및 성별 월급 차이
# < 1단계 > 변수 확인 및 전처리 (연령대, 성별, 월급)
# 1-1. 연령대 변수 확인 - 3번째 프로젝트에서 이미 확인
# 1-2. 성별 변수 확인 - 1번째 프로젝트에서 이미 확인
# 1-3. 월급 변수 확인 - 1번째 프로젝트에서 이미 확인

# < 2단계 > 분석표(통계요약표)
# 연령대, 성별로 그룹화하여 월급의 평균의 차이
ageg_sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg, sex) %>% 
  summarise(mean_income = mean(income))

ageg_sex_income

# < 3단계 > 시각화 
# 누적 막대 그래프
ggplot(data = ageg_sex_income, aes(x = ageg, y = mean_income, fill = sex)) + geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))

# 성별을 따로 막대 그래프로 표현
ggplot(data = ageg_sex_income, aes(x = ageg, y = mean_income, fill = sex)) + geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young", "middle", "old"))

# < 4단계 > 분석 결과
# 분석 결과 : 초년에는 남성이 206만원, 여성이 178만원으로 조금 밖에 차이가 나지 않지만, 중년이 되면 남성이 400만원, 여성이 220만원으로 거의 두 배 가까이 차이가 나게 되며, 노년에는 남성 203만원, 여성이 84만원으로 평균 월급은 절반으로 줄어들게 되며, 남녀의 월급 차이는 두 배가 넘게 되는 것을 알 수 있다.

##########
### 5번째 프로젝트 - 나이별 성별 월급 차이
# < 1단계 > 변수 검토 및 전처리 (나이, 성별, 월급)
# 1-1. 나이 변수 확인 - 2번째 프로젝트에서 이미 확인
# 1-2. 성별 변수 확인 - 1번째 프로젝트에서 이미 확인
# 1-3. 월급 변수 확인 - 1번째 프로젝트에서 이미 확인

# < 2단계 > 분석표(통계요약표)
# 2. 나이별로 성별로 그룹화하여 평균 월급의 차이
age_sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, sex) %>% 
  summarise(mean_income = mean(income))

View(age_sex_income)

# < 3단계 > 시각화 - 선 그래프
ggplot(data = age_sex_income, aes(x = age, y = mean_income, col = sex)) + geom_line() + geom_point()

# < 4단계 > 분석 결과
# 분석 결과 : 남성의 월급은 50대 후반까지 지속적으로 증가하다가, 이후 급격한 감소를 보이는 반면에, 여성은 30대 초반까지 지속적으로 증가하다가, 50대 초반까지 서서히 감소하게 되며, 이후 급격하게 감소하게 된다. 그리고, 80세가 되면 남녀가 비슷한 월급을 받게 된다.


##########
### 6번째 프로젝트 - 직업별 월급 차이 (상위 10개, 하위 10개)
# < 1단계 > 변수 검토 및 전처리 (직업 코드, 월급)
# 1-1. 직업 코드 변수 확인, 직업 코드 변수로 부터 직업 파생 변수를 생성
# 직종코드표를 데이터프레임으로 생성
list_job <- read_excel("c:/study/data1/Koweps_Codebook.xlsx", col_names = T, sheet = 2)
View(list_job)

# welfare와 list_job 데이터 가로 결합(조인)하여 job이라는 파생 변수를 생성
welfare <- left_join(welfare, list_job, id = "code_job")

# 1-2. 월급 변수 확인 - 1번째 프로젝트에서 이미 확인

# < 2단계 > 분석표(통계요약표)
# 2-1. 직업별로 월급의 평균
job_income <- welfare %>% 
  filter(!is.na(income) & !is.na(job)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))

View(job_income)

# 2-2. 상위 10개 
job_income_top10 <- job_income %>% 
  arrange(-mean_income) %>% head(10)

job_income_top10

# 2-3. 하위 10개
job_income_bottom10 <- job_income %>% 
  arrange(mean_income) %>% head(10)

job_income_bottom10

# < 3단계 > 시각화 - 가로 막대 그래프
# 3-1. 상위 10개
ggplot(data = job_income_top10, aes(x = reorder(job, mean_income), y = mean_income)) + 
  geom_col() +
  coord_flip()

# 3-2. 하위 10개
ggplot(data = job_income_bottom10, aes(x = reorder(job, -mean_income), y = mean_income)) +
  geom_col() + 
  coord_flip()

# < 4단계 >  분석 결과
# 4-1. 상위 10개 분석 결과 : '보험 및 금융 관리자'가 822만원으로 가장 많은 월급을 받고, 그 다음으로는 '의회의원 고위공무원 및 공공단체임원', '인사 및 경영 전문가', '연구 교육 및 법률 관련 관리자', '제관원 및 판금원', '의료진료 전문가' 순으로 많은 월급을 받게 된다.

# 4-2. 하위 10개 분석 결과 : '기타 서비스관련 단순 종사원'이 80만원으로 가장 적은 월급을 받고, 그 다음으로는  '청소원 및 환경 미화원', '가사 및 육아 도우미', '의료 복지 관련 서비스 종사자', '축산 및 사육 관련 종사자', '음식관련 단순 종사원', '판매관련 단순 종사원' 순으로 적은 월급을 받게 된다.

# 4-3. 전체 분석 결과 : 가장 많은 월급을 받는 '보험 및 금융 관리자'가 822만원으로 가장 적은 월급을 받는 '기타 서비스관련 단순 종사원'의 80만원보다 거의 10배 가까운 월급을 받고 있음을 알 수 있다.










































