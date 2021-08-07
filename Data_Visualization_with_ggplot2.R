# Basics of ggplot2
## Graph Components

library(tidyverse)
library(dslabs)
data(murders)

ggplot(data = murders)

## Creating a New Plot
ggplot(data = murders)
p = murders %>% ggplot()
class(p)
print(p) # this is equivalent to simply typing p
p

## Customizing Plots
### Layers
murders %>% ggplot() +
  geom_point(aes(x = population/10^6, y = total))

#### add points layer to predefined ggplot object
p + geom_point(aes(population/10^6, total))

#### add text layer to scatterplot
p + geom_point(aes(population/10^6, total)) +
  geom_text(aes(population/10^6, total, label = abb))

### Tinkering
#### Tinkering with arguments
p + geom_point(aes(population/10^6, total), size = 3) +
  geom_text(aes(population/10^6, total, label = abb))

##### because the points are larger it is hard to see the labels. If we read the help file for geom_text, we see the nudge_x argument, which moves the text slightly to the right or to the left:
p + geom_point(aes(population/10^6, total), size = 3) +
  geom_text(aes(population/10^6, total, label = abb), nudge_x = 1.5)

args(ggplot)
p <- murders %>% ggplot(aes(population/10^6, total, label = abb))
p + geom_point(size = 3) + 
  geom_text(nudge_x = 1.5)

# local aesthetics override global aesthetics
p + geom_point(size = 3) +
  geom_text(aes(x = 10, y = 800, label = "Hello there!"))

## Scales, Labels, and Colors
### log base 10 scale the x-axis and y-axis
p + geom_point(size = 3) +
  geom_text(nudge_x = 0.05) +
  scale_x_continuous(trans = "log10") +
  scale_y_continuous(trans = "log10")

### efficient log scaling of the axes
p + geom_point(size = 3) +
  geom_text(nudge_x = 0.075) +
  scale_x_log10() +
  scale_y_log10()

### Add labels and title
p + geom_point(size = 3) +
  geom_text(nudge_x = 0.075) +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Population in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010")

### Change color of the points
#### redefine p to be everything except the points layer
p <- murders %>%
  ggplot(aes(population/10^6, total, label = abb)) +
  geom_text(nudge_x = 0.075) +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Population in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010")

#### make all points blue
p + geom_point(size = 3, color = "blue")

#### color points by region
p + geom_point(aes(col = region), size = 3)

### Add a line with average murder rate
#### define average murder rate
r <- murders %>%
  summarize(rate = sum(total) / sum(population) * 10^6) %>%
  pull(rate)
#### basic line with average murder rate for the country
p <- p + geom_point(aes(col = region), size = 3) +
  geom_abline(intercept = log10(r))    # slope is default of 1
#### change line to dashed and dark grey, line under points
p + 
  geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
  geom_point(aes(col = region), size = 3)

### Change legend title
p <- p + scale_color_discrete(name = "Region")  


