#### 기술 통계량 ####

## table() 
aws <- read.delim("../data/AWS_sample.txt",sep = "#")
head(aws)
str(aws)

table(aws$AWS_ID)
table(aws$AWS_ID, aws$X.) # AWS_ID와 x의 값 개수

table(aws[,c("AWS_ID","X.")])
aws[2500:3100, "X."] = "modified" # 2500부터 3100번까지의 x 값 변경
aws[2500:3100, "X."] 
table(aws$AWS_ID, aws$X.) # AWS_ID와 x의 값 개수

prop.table(table(aws$AWS_ID)) # 확률 구할때 사용
prop.table(table(aws$AWS_ID)) * 100# 백분율

paste0(prop.table(table(aws$AWS_ID))*100 ,"%")

## 기술통계 함수의 모듈화
# 각 컬럼 단위로 빈도와 최대 최소값 계산

test <- read.csv("../data/test.csv",header=T)
head(test)
length(test)
str(test)

table(test$A)
max(test$A)
min(test$A)

data_proc <- function(df){
  for(idx in 1:length(df)){ # 빈도수 
    cat(idx,"번째 컬럼의 빈도 분석 결과")
    print(table(df[idx]))
    cat("\n")
  }
  
  for(idx in 1:length(df)){
    f <- table(df[idx])
    cat(idx,"번째 컬럼의 최대/최소값 결과 : \t")
    cat("max =",max(f), ", min =",min(f),"\n")
  }
}
data_proc(test)


#### plyr, dplyr ####

##plyr
install.packages("plyr")
library(plyr)

x <- data.frame(id=c(1,2,3,4,5,6), height=c(160,171,173,162,165,170))
y <- data.frame(id=c(5,4,1,3,2,7), height=c(55,73,60,57,80,91))
x
y


## 데이터 병합
xy <- join(x,y,by="id", type="left") # by : 공통되는 컬럼, type : left,right,full outer join과 같은 개념
xy

xy <- join(x,y,by="id", type="right") # by : 공통되는 컬럼, type : left,right,full outer join과 같은 개념
xy

xy <- join(x,y,by="id", type="full") # by : 공통되는 컬럼, type : left,right,full outer join과 같은 개념
xy

xy <- join(x,y,by="id", type="inner") # by : 공통되는 컬럼, type : left,right,full outer join과 같은 개념
xy

## 다중 키
x <- data.frame(key1=c(1,1,2,2,3),key2=c('a','b','c','d','e'),val=c(10,20,30,40,50))
y <- data.frame(key1=c(3,2,2,1,1),key2=c('e','d','c','b','a'),val=c(500,400,300,200,100))

xy <- join(x,y, by=c("key1","key2"))
xy

## 기술 통계량
# tapply : 집단 변수를 대상으로 한번에 하나의 통계량을 구할 때 사용(기본 함수)
# ddply : 한번에 여러개의 통계량을 구할 때 사용(plyr 패키지 함수 설치)

head(iris)
str(iris)
unique(iris$Species)

tapply(iris$Sepal.Length, iris$Species,mean) # 평균값
tapply(iris$Sepal.Length, iris$Species,sd) # 표준편차

## plyr 패키지 함수
ddply(iris, .(Species), summarise, avg=mean(Sepal.Length))
ddply(iris, .(Species), summarise, avg=mean(Sepal.Length),sdd = sd(Sepal.Length),max = max(Sepal.Length),min = min(Sepal.Length))


## dplyr
install.packages("dplyr")
library(dplyr)

exam <- read.csv("../data/csv_exam.csv")
exam

## filter()

# 1반 학생들의 데이터 추출
exam[exam$class==1,]
subset(exam, class == 1)

filter(exam, class==1)
exam %>% filter(class==1)

# 2반이면서 영어점수가 80점 이상인 데이터 추출
exam[exam$class==2 & exam$english>= 80,]
exam %>% filter(class==2, english>=80) # %>% : pipe operator

# 1, 3, 5반에 해당하는 데이터만 추출
exam %>% filter(class == 1 | class==3 |class==5)
exam %>% filter(class %in% c(1,3,5)) # %in% : match operator(매칭이 되면 출력)


## select()
# 수학점수만 추출
exam[,3]
exam %>% select(math)

# 반, 수학, 영어점수 추출
exam[,c(2,3,4)]
exam %>% select(class,math,english)

# 수학 점수를 제외한 나머지 컬럼 추출
exam %>% select(-math)

# 1반 학생들의 수학점수만 추출(2명만 표시)
exam %>% filter(class==1) %>% select(class,math) %>% head(2)
exam1 <- filter(exam, class==1)
exam2 <- select(exam1,class,math)


## arange()
exam %>% arrange(math)
exam %>% arrange(desc(math)) # 내림차순
exam %>% arrange(class, sort(math))


## mutate()
exam$sum <- exam$math + exam$english + exam$science
exam

exam$mean <- exam$sum /3
exam

exam <- exam[, -c(6,7)] # 열 삭제
exam

exam <- exam %>% mutate(sum=math+english+science, mean=sum/3) # 변수에 저장해야지 값이 저장됨
exam

## summarise()
exam %>% summarise(mean_math = mean(math))

## groupby()
exam %>% group_by(class) %>% summarise(mean_math=mean(math),sum_math=sum(math),median_mat=median(math),count=n())


## left_join(), bind_rows()
test1 <- data.frame(id=c(1,2,3,4,5), midterm=c(60,70,80,90,85))
test2 <- data.frame(id=c(1,2,3,4,5), midterm=c(70,83,67,95,80))

left_join(test1, test2, by = "id")
bind_rows(test1,test2)


#### 연습문제1 ####
install.packages("ggplot2")
library(ggplot2)

head(ggplot2::mpg)
str(ggplot2::mpg)
class(ggplot2::mpg)

mpg <- as.data.frame(ggplot2::mpg)
names(mpg)
dim(mpg)
View(mpg)

# 배기량(displ)이 4이하인 차량의 모델명, 배기량, 생산년도 조회
mpg %>% filter(displ <= 4) %>% select(model,displ,year)


# 통합연비 파생변수(total)를 만들고 통합연비로 내림차순 정렬을 한 후에 3개의 행만 선택해서 조회
# 통합연비 : total <- (cty + hwy)/2

mpg$total <- (mpg$cty + mpg$hwy)/2
mpg %>% arrange(desc(total)) %>% head(3)


# 회사별로 "suv"차량의 도시 및 고속도로 통합연비 평균을 구해 내림차순으로 정렬하고 1위~5위까지 조회
mpg %>% filter(class=="suv") %>% mutate(sum=cty+hwy, total=sum/2) %>% select(manufacturer,class,total) %>% arrange(desc(total)) %>% head(5)


# 어떤 회사의 hwy연비가 가장 높은지 알아보려고 한다. hwy평균이 가장 높은 회사 세곳을 조회
mpg %>% group_by(manufacturer) %>% summarise(hwy_mean = mean(hwy)) %>% arrange(desc(hwy_mean)) %>% head(3)

# 어떤 회사에서 compact(경차) 차종을 가장 많이 생산하는지 알아보려고 한다. 각 회사별 경차 차종 수를 내림차순으로 조회
mpg %>% group_by(manufacturer) %>% filter(class=="compact") %>% summarize(count = n()) %>% arrange(desc(count))


# 연료별 가격을 구해서 새로운 데이터프레임(fuel)으로 만든 후 기존 데이터셋과 병합하여 출력.
# c:CNG = 2.35, d:Disel = 2.38, e:Ethanol = 2.11, p:Premium = 2.76, r:Regular = 2.22
# unique(mpg$fl)
fuel <- data.frame(fl=c("c","d","e","p","r"), fl_class=c("CNG","Disel","Ethanol","Premium","Regular"), price= c(2.35,2.38,2.11,2.76,2.22))
fuel
left_join(mpg, fuel, by = "fl") 


# 통합연비의 기준치를 통해 합격(pass)/불합격(fail)을 부여하는 test라는 이름의 파생변수를 생성. 이 때 기준은 20으로 한다.
mpg$test <- ifelse(mpg$total >= 20, "pass","fail")
mpg

# test에 대해 합격과 불합격을 받은 자동차가 각각 몇대인가?
table(test)


# 통합연비등급을 A, B, C 세 등급으로 나누는 파생변수 추가:grade
# 30이상이면 A, 20~29는 B, 20미만이면 C등급으로 분류
mpg$grade <- ifelse(mpg$total >= 30, "A", ifelse(mpg$total>=20,"B","C"))
mpg

#### 연습문제2 ####
# 미국 동북부 437개 지역의 인구 통계 정보
midwest <- as.data.frame(ggplot2::midwest)
str(midwest)

# 전체 인구대비 미성년 인구 백분율(ratio_child) 변수를 추가
midwest <- midwest %>% mutate(ratio_child = (poptotal-popadults)/poptotal*100)
midwest

# 미성년 인구 백분율이 가장 높은 상위 5개 지역(county)의 미성년 인구 백분율 출력
midwest %>% arrange(desc(ratio_child)) %>% select(ratio_child, county) %>% head(5)


# 분류표의 기준에 따라 미성년 비율 등급 변수(grade)를 추가하고, 각 등급에 몇개의 지역이 있는지 조회
# 미성년 인구 백분율이 40이상이면 "large", 30이상이면 "middel", 그렇지않으면 "small"
midwest <- midwest %>% mutate(grade = ifelse(midwest$ratio_child >= 40,"large",ifelse(midwest$ratio_child>30,"middel","small")))
table(midwest$grade)


# 전체 인구 대비 아시아인 인구 백분율(ratio_asian) 변수를 추가하고 하위 10개 지역의 state, county, 아시아인 인구 백분율을 출력
midwest <- midwest %>% mutate(ratio_asian = (popasian/poptotal)*100) %>% arrange(ratio_asian) %>% select(state,county,ratio_asian) %>% head(10)
midwest
