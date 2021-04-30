#### 변수 ####

goods = "냉장고"

# 변수 사용 시 객체 형태로 사용하는 것을 권장
goods.name = "냉장고"
goods.code = "ref001"
goods.price = 600000

goods.name

# 값을 대입할때에는  = 보다는  <- 사용
goods.name <- "냉장고"
goods.code <- "ref001"
goods.price <- 600000

# 데이터 타입 확인
class(goods.name)
class(goods.price)
mode(goods.name)
mode(goods.price)



#### vector ####

# c()
v <- c(1,2,3,4,5) # 벡터생성
v # 변수 호출
class(v)
mode(v)

(v <- c(1,2,3,4,5)) # 변수 출력 없이 선언 후 바로 출력
(c(1:5)) # 1~5까지 출력

(c(1,2,3,4,"5")) # 문자열로 통일(같은 자료형으로만 묶인다.)
mode(c(1,2,3,4,"5"))

# seq() # 순차적으로 자동으로 만들어주는 함수
(seq(from=1,to=10,by=2)) # 1부터 10까지 2칸씩 
(seq(1,10,2))

# rep() # 반복해서 계속 만들어줌
(rep(1:3,3)) # 1부터 3까지 3번 반복

# 벡터의 접근
v <- c(1:50)
v[10:45] # v에서 10번부터 45까지 출력
length(v) # v의 길이
v[10:(length(v)-5)] # 벡터의 길이만 -5
v[10:length(v)-5] # 양쪽에서 -5

v1 <- c(13, -5, 20:23, 12 , -2:3)
v1

v1[1]
v1[c(2,4)] # 2번째와 4번째의 값을 출력(c()로 묶어줌)
v1[c(4, 5:8, 7)]
v1[-1] # 첫번째 값 삭제
v1[-2] # 두번째 값 삭제
v1[-c(2,4)] # 2번째와 4번째 값 삭제

# 집합 연산
x <- c(1,3,5,7)
y <- c(3,5)

union(x,y) # 합집합
setdiff(x,y) # 차집합
intersect(x,y) # 교집합
union(x,y); setdiff(x,y); intersect(x,y)

# 컬럼명 지정
age <- c(30, 35, 40)
names(age) <- c("홍길동","임꺽정","신돌석")
age

# 특정 변수의 데이터 제거
age <- NULL
age

# 벡터 생성의 또 다른 표현
x <- c(2, 3)
x <- (2:5)
x


#### Factor ####
gender <- c("man","woman","woman","man","man")
gender
mode(gender)

is.factor(gender) # factor의 타입인지 True,False로 나타냄
plot(gender) # 빈도수를 그래프로 생성

ngender <- as.factor(gender) # fector로 강제 변환(범주형)
ngender
class(ngender) # 추상적인 자료형
mode(ngender) # 물리적인 자료형
is.factor(ngender)
plot(ngender)
table(ngender) # 빈도수를 테이블형으로 출력

# factor 함수 사용
gfactor <- factor(gender,levels=c("woman","man"),ordered = TRUE) # 임의로 기술을 주고 woman과 man을 나누고 정렬
gfactor
plot(gfactor)


#### Matrix ####
m <- matrix((1:5)) # 행 우선
m

m <- matrix(c(1:11),nrow = 2) # 행의 개수 지정
m

m <- matrix(c(1:10),nrow = 2, byrow = T) # 행에 의해서 열로 바꿈
m
class(m)
mode(m)

# rbind() : 행 결합, cbind() : 열 결합
x1 <- c(3,4,50:52)
x2 <- c(30,5,6:8,7,8) 
x1
x2

mr <- rbind(x1,x2)
mr
mc <- cbind(x1,x2)
mc

# matrix 차수 확인
x <- matrix(c(1:9),ncol=3) # ncol : 변수의 개수를 카운트
x

length(x); nrow(x); ncol(x); dim(x) # length() : 벡터의 길이, nrow() : 행의 개수 출력, ncol() : 열의 개수 출력, dim() : 행과 열의 개수 모두 출력

# 컬럼명 지정
colnames(x) <- c("one","two","three")
x
colnames(x)

# apply() : python에서의 map
apply(x, 1, max) # 변수, 1 or 2(행 또는 열을 기준으로 처리), 함수 호출
apply(x, 2, max)
apply(x, 1, sum) 
apply(x, 2, sum)


#### data.frame ####

no <- c(1,2,3)
name <- c('hong','lee','kim')
pay <- c(150.25, 250.18, 300.34)

emp <- data.frame(NO=no, NAME=name, PAYMENT=pay)
emp

# read.csv(), read.table(), read.delim() : 파일 불러오기
getwd() # work derectory(작업파일)의 경로를 알림

txtemp <- read.table("../data/emp.txt",fileEncoding = "CP949",encoding = "UTF-8") # 맥은 fileEncodin 해줘야함
txtemp

setwd("../R_Project") # 작업폴더의 위치 변경
getwd()

txtemp <- read.table("emp.txt",header = T, sep=" ",fileEncoding = "CP949",encoding = "UTF-8") # 파일명, header : 변수명 유/무(T/F), sep : 구분자
txtemp
class(txtemp)

csvemp <- read.csv("emp.csv",fileEncoding = "CP949",encoding = "UTF-8") # csv파일 불러올때 쓰이는거 외엔 나머지는 table 사용이 더 효율적
csvemp

csvemp1 <- read.csv("emp.csv",col.names = c("사번","이름","급여"),fileEncoding = "CP949",encoding = "UTF-8") # 컬럼명 변경
csvemp1

csvemp2 <- read.csv("emp2.csv",header=F,col.names = c("사번","이름","급여"),fileEncoding = "CP949",encoding = "UTF-8")
csvemp2
