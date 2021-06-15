#### Install packages ####
# install.packages("ggpubr")
# install.packages("gridExtra")
# install.packages("cowplot")
# install.packages("gridGraphics")
# install.packages("grid")
# install.packages("devtools")
# install.packages("roxygen2")
# install.packages("RColorBrewer")
# install.packages("ggrepel")
#### Load packages ####
library(ggpubr)
library("gridExtra")
library("cowplot")
library(tidyverse)
library(ggplot2)
library(gridGraphics)
library(grid)
library(RColorBrewer)
library(ggplot2)
library(ggrepel)
library(randomcoloR)
library(ggplot2)
library(reshape2)
library(RColorBrewer)

### My theme

# theme_qwen<- function() {
#   font <- "serif"
#   
#   ggplot2::theme(
#     
#     #Text format:
#     #This sets the font, size, type and colour of text for the chart's title
#     plot.title = ggplot2::element_text(family=font,
#                                        size=26,
#                                        face="bold",
#                                        color="#043051"),
#     #This sets the font, size, type and colour of text for the chart's subtitle, as well as setting a margin between the title and the subtitle
#     plot.subtitle = ggplot2::element_text(family=font,
#                                           size=23,
#                                           color = "#0a3c62",
#                                           margin=ggplot2::margin(7,0,7,0)),
#     plot.caption = ggplot2::element_blank(),
#     # plot.caption = ggplot2::element_text(family=font,
#     #                                      size=16,
#     #                                      face = "bold",
#     #                                      color = "#063051",
#     #                                      margin=ggplot2::margin(7,50,7,15)),
#     #This leaves the caption text element empty, because it is set elsewhere in the finalise plot function
#     
#     #Legend format
#     #This sets the position and alignment of the legend, removes a title and backround for it and sets the requirements for any text within the legend. The legend may often need some more manual tweaking when it comes to its exact position based on the plot coordinates.
#     legend.position = "top",
#     legend.text.align = 0,
#     legend.background = ggplot2::element_blank(),
#     legend.title = ggplot2::element_blank(),
#     legend.key = ggplot2::element_blank(),
#     legend.text = ggplot2::element_text(family=font,
#                                         size=18,
#                                         face = "bold",
#                                         color="#043051"),
#     
#     #Axis format
#     #This sets the text font, size and colour for the axis test, as well as setting the margins and removes lines and ticks.
#     #In some cases, axis lines and axis ticks are things we would want to have in the chart - the cookbook shows examples of how to do so.
#     axis.title = element_text(family=font, size = 18, face = "bold", color="#043051"),
#     axis.text = element_text(family=font, size = 16, face = "bold", color="#043051"),
#     axis.text.x = ggplot2::element_text(margin=ggplot2::margin(5, b = 10), family=font, color="#043051"),
#     axis.ticks = ggplot2::element_blank(),
#     axis.line = element_line(color = "#043051", arrow = arrow(length = unit(0.3, "lines"), type = "closed")),
#     #Grid lines
#     #This removes all minor gridlines and adds major y gridlines. In many cases you will want to change this to remove y gridlines and add x gridlines. The cookbook shows you examples for doing so
#     panel.grid.minor = ggplot2::element_blank(),
#     panel.grid.major.y = ggplot2::element_line(color="#a9b7be"),
#     panel.grid.major.x = ggplot2::element_line(color="#a9b7be"),
#     panel.border = element_blank(),
#     #Blank background
#     panel.background = element_rect(fill = "#F5F5F0",
#                                     size = 2),
#     #This sets the panel background as blank, removing the standard grey ggplot background colour from the plot
#     
#     #Strip background (#This sets the panel background for facet-wrapped plots to white, removing the standard grey ggplot background colour and sets the title size of the facet-wrap title to font size 22)
#     strip.background = element_rect(fill = "#043051", color = "#043051"),
#     strip.text = element_text(size = rel(0.85), face = "bold", color = "white", margin = margin(5,0,5,0))
#   )
# }

### My colors 

colors_fr_light <- c("#205072", "#E9765B", "#b71540")

### The actual code

mtcars$`car name` <- rownames (mtcars)
mtcars$cyl <- as.factor(mtcars$cyl)

cars_hp <- mtcars %>% group_by(gear) %>%
  ggplot(aes(x=hp, y=fct_reorder(`car name`, hp), fill = hp))+geom_col()+
  scale_fill_gradientn(colors =c("#205072", "#E9765B", "#b71540"))+ylab("Car names")+xlab("Horse power")+
  ggtitle("Most powerful cars")
cars_hp+theme_qwen()

cars_gear <- mtcars %>% group_by(cyl) %>%
  ggplot(aes(x=hp, y=fct_reorder(`car name`, hp), fill = gear))+geom_col()+
  scale_fill_gradientn(colors =c("#205072", "#E9765B", "#b71540"))+ylab("Car names")+xlab("Horse power")+
  ggtitle("Most powerful cars and number of gears in the engine")
cars_gear+theme_qwen()

cars_fuel <- mtcars %>% group_by(cyl) %>%
  ggplot(aes(x=hp, y=fct_reorder(`car name`, hp), fill = mpg))+geom_col()+
  scale_fill_gradientn(colors =c("#205072", "#E9765B", "#b71540"))+ylab("Car names")+xlab("Horse power")+
  ggtitle("Most powerful cars and fuel consumption (Miles per galons of fuel)")
cars_fuel+theme_qwen()

cars_fuel2 <- ggplot(mtcars, aes(x=hp, y=mpg)) +
  geom_point(size=3, aes(color=cyl, shape=cyl)) +
  geom_smooth(method="loess", color="black", se=FALSE) +
  geom_smooth(method="lm", aes(color=cyl, fill=cyl))+ylab("Miles per galons of fuel")+xlab("Horse power")+
  ggtitle("Car fuel consumption depending on horsepower and cylinder")+scale_fill_manual(values = colors_fr_light)+
  scale_color_manual(values = colors_fr_light)
cars_fuel2+theme_qwen()

car_label <- ggplot(mtcars, aes(wt, mpg, color=hp)) +
  geom_point() +
  geom_text_repel(aes(label = rownames(mtcars))) +
  scale_color_gradientn(colors=c("#205072", "#E9765B", "#b71540" ))+
  ylab("Miles per galons of fuel")+xlab("Weight of the car")+ggtitle("Fuel consumption by car weight")
car_label+theme_qwen()

cars_hp <- cars_hp+theme_qwen()+
  theme(legend.position = c(0.95, 0.8))
cars_fuel2 <- cars_fuel2+theme_qwen()+
  theme(legend.position = c(0.95, 0.8))
car_label <- car_label+theme_qwen()+
  theme(legend.position = c(0.95, 0.8))


wrap1 <- ggdraw() +
  draw_plot(cars_hp, x = 0, y = 0, width = .5, height = 1) +
  draw_plot(cars_fuel2, x = .5, y = .5, width = .5, height = .5)  +
  draw_plot(car_label, x=0.5, y=0, width = 0.5, height = 0.5)+
  draw_plot_label(label = c("A", "B", "C"), size = 18,
                  x = c(0, 0.5, 0.5), y = c(1, 1, 0.5))

wrap1
