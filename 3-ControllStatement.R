#### 조건문 ####
# 난수
x <- runif(1) # 기본값 : 0~1사이의 난수 rnorm()
x

# x가 0.5보다 크면 출력
if(x>0.5){
  print(x)
}

# x가 0.5보다 작으면 1-x를 출력하고 그렇지 않으면 x를 출력
if(x<0.5){
  print(1-x)
} else{
  print(x)
}

if(x < 0.5) print(1-x) else print(x)

# ifelse()
ifelse(x<0.5, 1-x, x)

# 디중 조건
avg <- scan()
if(avg >= 90){
  print("당신의 학점은 A입니다.")
} else if(avg >= 80){
  print("당신의 학점은 B입니다.")
} else if(avg >= 70){
  print("당신의 학점은 C입니다.")
} else if(avg >= 60){
  print("당신의 학점은 D입니다.")
} else{
  print("당신의 학점은 F입니다.")
}

# switch(비교문, 실행문1, 실행문2)
a <- "중1"
switch(a, "중1"=print("14살"), "중2"=print("15살"),"중3"=print("16살"))
switch(a, "중1"="14살","중2"="15살")

b <- 3
switch(b, "14살","15살","16살")

empname = scan(what="")
switch(empname, hong=250, lee=350, kim=200,kang=400)

avg <- scan() %/% 10  # %/% : 몫을 정수형으로 구할때 
result <- switch(as.character(avg), "10"="A", "9"="A", "8"="B", "7"="C", "6"="D", "F")
cat("당신의 학점은 ",result,"입니다")

### which() : 값의 위치를 찾아주는 함수
# vector에서 사용
x <- c(2:10)
x
which(x==3) # 위치를 값으로 반환
x[which(x==3)] # 조건에 맞는 원소를 반환

# matrix에서 사용
m <- matrix(1:12, 3, 4)
m
which(m%%3 == 0) # 조건에 맞는 값 자체를 반환
which(m%%3 ==0, arr.ind = F) # arr.ind = F : 인덱스를 사용하지 않음 
which(m%%3 ==0, arr.ind = T) # arr.ind = T :인덱스를 사용

# data.frame에서 사용
no <- c(1:5)
name <- c("지디","탑","대성","태양","승레기")
score <- c(85,78,89,90,74)
exam <- data.frame(학번=no, 이름=name, 성적=score)
exam

# 이름이 지디인 사람 검색
which(exam$이름 == "지디")
exam[which(exam$이름=="지디"),]
exam[1,]

# which.max(), which,min() : 최대값과 최소값의 위치를 찾음(숫자에서만 인식)
# 가장 높은 점수를 가진 학생은 누구인가?
which.max(exam$성적)
exam[which.max(exam$성적),]

# 가장 낮은 점수를 가진 학생은 누구인가?
which.min(exam$성적)
exam[which.min(exam$성적),]

### any() : or, all() : and
x <- runif(5)
x

# x값들 중에서 0.8이상이 있는가?
any(x >= 0.8)

# x값들 중에서 모두 0.7이하인가?
all(x <= 0.7)


#### 반복문 ####

# 1부터 10까지 합계
sum <- 0
for(i in seq(1,10)){
  sum <- sum + i
}
sum

sum <- 0
for(i in 1:10) sum <- sum + i
sum


#### 함수 ####
### 인자없는 함수
test1 <- function(){
  x <- 10
  y <- 10
  #return (x*y)
  x*y
}
test1()

### 인자있는 함수
test2 <- function(x,y){
  a <- x
  b <- y
  return(a-b)
}
test2(10, 20)
test2(y=20, x=10)

### 가변인수 : ...사용 ###
test3 <- function(...){
  # print(list(...)) # 어떤 값인지 모르므로 리스트로 받아와야함
  for(i in list(...)) print(i)
}
test3(10)
test3(10,20)
test3(10,20,30)
test3(10,20,30,40)
test3("3","지디",122)

test4 <- function(a,b,...){
  print(a)
  print(b)
  print("-----------")
  print(list(...))
}

test4(10,20,30,40)


#### 문자열 함수 ####

### stringr: 정규 표현식 활용 ###
install.packages("stringr")
library("stringr") # require(stringr) : 에러없이 통과

str1 <- "지디33태양32탑31"

str_extract(str1, "\\d{2}") # extract : 추출하는 함수 , \ : \는 특수문자로 인식해 \\로 사용
str_extract_all(str1, "\\d{2}") # 숫자 전부 추출
str_extract_all(str1, "[0-9]{2}")

str2 <- "hongkd105leess1002tou25TOM400강감찬2005"
str_extract_all(str2, "[a-zA-Z가-힣]+") # 이름만 추출(한글 : 가-힣)

length(str2) 
str_length(str2) # 문자의 갯수

str_locate(str2, "강감찬") # 찾고자하는 문자 찾기

str2 <- str_c(str2,"유비55") # contain : 맨 뒤에 문자 추가
str2

str3 <- "hongkd105,leess1002,tou25,TOM400,강감찬2005"
str_split(str3, ",") # 문자열을 지정한 문자로 나누기


#### 기본 함수 ####
sample <- data.frame(c1 = c('abc_abcdefg','abc_ABCDE','ccd'), c2 = 1:3)
sample

nchar(sample[1, 1]) # 문자열의 갯수
which(sample[,1] == "ccd") # 문자의 위치 찾기
toupper(sample[1,1]) # 대문자로 변경
tolower(sample[1,1]) # 소문자로 변경
substr(sample[,1], start = 1, stop = 2) # 특정 위치의 문자만 추출
paste0(sample[,1],sample[,2]) # 두개의 데이터를 붙여주는 함수
paste(sample[,1],sample[,2], sep="@@") # 구분자를 넣어줄 수 있다

#### 문자열을 분리해서 하나의 컬럼을 두개의 컬럼으로 확장 ####
install.packages("splitstackshape")
library(splitstackshape)

cSplit(sample, splitCols = "c1", sep="_") # c1의 컬럼을 '_'를 기준으로 분리





