#### 기본 내장 그래프 ####

### plot()
# plot(y출 데이터, 옵션)
# plot(x출 데이터, y축 데이터, 옵션)

y <- c(1,1,2,2,3,3,4,4,5,5)
plot(y)

x <- 1:10
y <- 1:10
plot(x,y)

plot(x,y,xlim = c(0,20), ylim = c(0,30), main="Graph",type="p",pch=4,cex=.3,col="red", lty="solid") 
# xlim : x축의 눈금 , ylim : y축의 눈금, main : 타이틀, type : 선 모양, pch : 점 모양, cexx : 점의 크기를 비율로 설정, col : 색깔 , lty : 라인 스타일
# type = "p", "l", "b", "o", "n"
# lty : "blank", "solid", "dashed", "dotted", "dotdash", "longdash", "twodash"

str(cars)
head(cars)
plot(cars, type="l")

# 같은 속도일때 제동거리가 다를 경우 대체적인 추세를 알기 어렵다. 속도에 대한 평균 제동거리를 구해서 그래프로 그려보자.
plot(tapply(cars$dist, cars$speed, mean), type ='o', xlab = "speed", ylab = "dist") # xlab,ylab : x축,y축의 이름 

### points()
with(iris,{
  plot(iris$Sepal.Width, iris$Sepal.Length) 
  plot(iris$Petal.Width, iris$Petal.Length)
})

with(iris,{
  plot(Sepal.Width, Sepal.Length) # 기존 그래프에 추가
  points(Petal.Width, Petal.Length,col="red") # 기존 그래프에 추가
})


### lines()
plot(cars)
lines(lowess(cars)) # y = ax +b 또는 y = ax2 + bx + c와 같은 형태

### barplot(), hist(), pie(), mosaicplot(), pair(), persp(), contour(), ...

### 그래프 배열열
head(mtcars)

# 한 장에 그래프 4개 동시에 그리기
par(mfrow=c(2,2))
plot(mtcars$wt, mtcars$mpg)
plot(mtcars$wt, mtcars$disp)
hist(mtcars$wt)
boxplot(mtcars$wt)

par(mfrow=c(1,1))
plot(mtcars$wt, mtcars$mpg)

# 행 또는 열마다 그래프 개수를 다르게 설정
layout(matrix(c(1,2,1,3),2,2,byrow=T)) # c(1,1,2,3) : 첫번째 그래프가 두번째 자리에도 있는것 , 2,2 : 4개의 그래프 크기 
plot(mtcars$wt, mtcars$mpg)
plot(mtcars$wt, mtcars$disg)
hist(mtcars$wt)

par(mfrow=c(1,1))


#### 특이한 그래프 ####

x <- c(1,3,6,8,9)
y <- c(12,56,78,32,9)

plot(x,y)
arrows(3, 56, 1, 12) # 시작점,끝점을 잇는 선
text(4,40,"이것은 샘플입니다.",str=60)

### 꽃잎 그래프
x <- c(1,1,1,2,2,2,2,2,2,3,3,4,5,6,6,6)
y <- c(2,1,4,2,3,2,2,2,2,2,1,1,1,1,1,1)
plot(x,y)

z <- data.frame(x,y)
sunflowerplot(z)

### 별 그래프
# 데이터의 전체적인 윤곽을 살펴보는 그래프
# 데이터 항목에 대한 변화의 정도를 한눈에 파악
mtcars
str(mtcars)

stars(mtcars[1:4], flip.labels = F, key.loc=c(13,1.0), draw.segments = T) # key.loc = unit키를 그릴 위치 선정

      
### symbols
x <- c(1,2,3,4,5)
y <- c(2,3,4,5,6)
z <- c(10, 5, 100, 20, 10)

symbols(x,y,z)


#### ggplot2 ####
# http://www.r-graph-gallery.com/ggplot2-package.html

# 레이어 지원
# 1) 배경 설정
# 2) 원하는 그래프 추가(잠,선,막대,...)
# 3) 설정 추가(축 범위, 색, 표식, ...)

install.packages("ggplot2")
library(ggplot2)

### 산포도
head(mpg)
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() # 배경 설정 + 원하는 그래프 추가
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() + xlim(3,6) + ylim(10,30) # 원하는 부분 집중적으로 확인

