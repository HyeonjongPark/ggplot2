library(dplyr)
library(ggplot2)
library(data.table)

# 1.

mtcars # 내장 데이터 확인

## aes는 미적요소를 뜻함.  - 변수에서 값을 가져올때 aes로 묶어준다
p = ggplot(data = mtcars, aes(x=disp, y=mpg)) + geom_point(aes(size = hp, color = wt))

## 통계학적 결과 추가
# 국소 회귀분석(loess)방식으로 그린 추세선 추가 
p + stat_smooth(color = 'black', fill = 'grey')


## facet 추가 - 특정기준에 따라 그래프를 여러개로 나눈다
mtcars$cyl %>% unique()

p + stat_smooth(color = 'black', fill = 'grey') + facet_wrap(~cyl)


head(mtcars)
mtcars %>% class
mtcars$name = rownames(mtcars)

ggplot(data = mtcars, aes(x = name, y = mpg)) + geom_bar(stat = "identity")
# reorder를 이용하여 순차적 정렬
ggplot(data = mtcars, aes(x = reorder(name, mtcars$mpg), y = mpg)) + geom_bar(stat = "identity")
ggplot(data = mtcars, aes(x = reorder(name, -mtcars$mpg), y = mpg)) + geom_bar(stat = "identity")
# x축 텍스트가 겹치는게 보기 싫을 떄, theme 함수를 사용
ggplot(data = mtcars, aes(x = reorder(name, -mtcars$mpg), y = mpg)) + geom_bar(stat = "identity") + theme(axis.text = element_text(angle = 90))
ggplot(data = mtcars, aes(x = reorder(name, -mtcars$mpg), y = mpg)) + geom_bar(stat = "identity") + theme(axis.text = element_text(angle = 90))

# 그래프를 세로로 보고싶을 떄,
ggplot(data = mtcars, aes(x = reorder(name, mtcars$mpg), y = mpg)) + geom_bar(stat = "identity") + coord_flip()

# xlab 과 ylab 지정

p = ggplot(data = mtcars, aes(x = reorder(name, mtcars$mpg), y = mpg)) + geom_bar(stat = "identity") + coord_flip()
p + labs(x = 'x', y = 'y') # x축에 y가 들어간 것을 확인할 수 있다.
p + labs(x="", y="", title = "차량별 연비")

# hjust는 가로로부터 1.25 떨어진 지점에 위치
p + geom_text(aes(label = mpg), size = 3, hjust = 1.25, color = "white")

# 특정 차량을 강조하고 싶을 떄,
p + geom_bar(data = mtcars[mtcars$name == "Honda Civic",], aes(x=name , y=mpg), fill = "skyblue", stat = "identity") + 
  geom_text(aes(label = mpg), size = 3, hjust = 1.25, color = "white")




# 2.

head(economics)
economics %>% class

# geom_line  : lwd는 굵기를 의미한다
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line(color = "orange", lwd = 1)
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line(color = "orange", lwd = 1) + geom_hline(yintercept = mean(economics$unemploy), linetype = 'dashed')

# geom_bar : stat을 넣어줘야 한다.
ggplot(data =economics, aes(x = date, y = unemploy)) + geom_bar(stat = "identity" , color = "orange")

# 현재 plotting 되어있는 그림을 저장한다.
ggsave("./plot/geom_bar.png")







