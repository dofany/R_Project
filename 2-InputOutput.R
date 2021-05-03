#### 키보드 입력 ####
# scan() : 벡터 입력
# edit() : 데이터 프레임 입력

a <- scan() # 숫자 형식의 데이터를 입력: 입력을 중단할 경우에는 빈칸에 엔터키 누르면됨
a

b <- scan(what=character()) # 문자형식의 데이터를 입력
b

df <- data.frame()
df <- edit(df)
df

#### 파일 입력 ####
# read.csv()
# read.table()
# read,xlsx()
# read.spss()

student <- read.table("../data/student.txt",fileEncoding = "CP949",encoding = "UTF-8")
student

student1 <- read.table(file="../data/student1.txt",header=T,fileEncoding = "CP949",encoding = "UTF-8")
student1

student2 <- read.table(file.choose(), header=T, sep=";",fileEncoding = "CP949",encoding = "UTF-8")
student2

student3 <- read.table("../data/student3.txt", header = T,na.strings = c("-","+","&")) # na.strings = : 결측치 변환
student3

# read..xlsx()
install.packages("xlsx")

library(rJava)
library(xlsx)

# studentx <- read.xlsx(file.choose(), sheetIndex=1)
studentx <- read.xlsx(file.choose(), sheetName = "emp2")
studentx

#### read.spss() ####
install.packages("foreign")
library(foreign)

raw_welfare <- read.spss("../data/Koweps_hpc10_2015_beta1.sav", to.data.frame = T) # list 형식으로 받아야해서 True
raw_welfare

#### 화면 출력 ####
# 변수명
# (식)
# print()
# cat()

x <- 10
y <- 20
z <- x + y

z
(z <- x + y)
print(z)
print(z <- x + y)

cat("x + y의 결과는",as.character(z),"입니다.")  # print("x + y의 결과는",as.character(z)," 입니다.")


#### 파일 출력 ####
# write.csv() # csv 파일로 저장
# write.table() # 그 외에 나머지 파일로 저장
# write.xlsx() # 엑셀파일로 저장

studentx <- read.xlsx("../data/studentexcel.xlsx", sheetName = "emp2", encoding = "UTF-8")
studentx
class(studentx)

write.table(studentx, "../data/stud1.txt") # studentx를 파일로 저장
write.table(studentx, "../data/stud2.txt", row.names = F) # 행의 이름(인덱스명)을 저장하지 않겠다.
write.table(studentx, "../data/stud3.txt", row.names = F, quote = F) # 인덱스와 쌍따옴표도 쓰지 않겠다.

write.csv(studentx, "../data/stud4.csv") # studentx를 csv로 저장
library(rJava) # 껐다 키면 다시 실행해줘야함
library(xlsx) # 껐다 키면 다시 실행해줘야함
write.xlsx(studentx, "../data/stud5.xlsx") # 엑셀파일로 저장


#### rda 파일 출력 ###
# save()
# load()

save(studentx, file = "../data/stud6.rda") # 저장 
rm(studentx) # 메모리에서 지우기
studentx

load("../data/stud6.rda") # 변수를 다시 생성하고 불러오기
studentx


#### sink() #### : 분석 결과값 조회하기
data()

data(iris) # 메모리를 불러오기 
head(iris) # 데이터의 앞부분 6개의 관측값 확인
tail(iris) # 마지막 6개의 관측값 확인
str(iris) # 타입 확인

sink("../data/iris.txt") # 싱크(저장할 데이터 파일)
head(iris)
tail(iris)
str(iris)

sink() # 싱크 닫기
