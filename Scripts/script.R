#load the tidyverse package
library("tidyverse")

# read data
gapminder <- read_csv(file = "Data/gapminder-FiveYearData.csv")

# plot - different examples: 
#_______________________________________
ggplot(data = gapminder) +    # use ggplot and specify data, + indicates that command continues
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp))  # specify attributes
# many options, here: a scatter plot, aes=aesthetics with variables specified

ggplot(data = gapminder) +    
  geom_jitter(mapping = aes(x=log(gdpPercap), y=lifeExp,
                        color=continent, size=pop))  #attributes based on data

ggplot(data = gapminder) +    
  geom_jitter(mapping = aes(x=log(gdpPercap), y=lifeExp),
      color="blue", size=2, alpha=0.1)  # specify attributes for ALL - outside aes

ggplot(data = gapminder) +    
  geom_line(mapping = aes(x=year, y=lifeExp, # line, grouped - life expectancy per country
              color=continent, group=country))  

ggplot(data = gapminder) + # boxplot - does the grouping automatically!
  geom_boxplot(mapping = aes(x=continent, y =lifeExp))

ggplot(data = gapminder) +  # double plot, on top of each other!
  geom_jitter(mapping = aes(x=continent, y=lifeExp, colour = continent)) +
  geom_boxplot(mapping = aes(x=continent, y = lifeExp, colour = continent))

ggplot(data = gapminder) +  # the other way round, with transparency
  geom_boxplot(mapping = aes(x=continent, y = lifeExp)) +
  geom_jitter(mapping = aes(x=continent, y=lifeExp, colour = continent), alpha = 0.1)
  
ggplot(data=gapminder, mapping =aes(x=log(gdpPercap), y = lifeExp)) +
  geom_jitter(alpha=0.1, mapping=aes(color=continent)) +  # specify the same argumebnts for both
  geom_smooth(method = "lm") # and some individual ones - lm through ALL data


# Challenge 6
# -------------
# Make a boxplot of life expectancy by year. Hint: You may need to wrap the 
# year variable into the as.character or as.factor function. When was 
# interquartile range of life expectancy the smallest? Make the same plot of 
# log(gdpPercap) per year. Compared to 1952, is the world todat more or less 
# diverse in terms of IQR of gdpPercapita?

ggplot(data=gapminder) +
  geom_boxplot(mapping=aes(x=year, y=lifeExp, group=year))   # group by

ggplot(data=gapminder) +  
  geom_boxplot(mapping=aes(x=as.factor(year), y=log(gdpPercap)))  # as factor

ggplot(data=gapminder) +   # density plot
  geom_deinsity2d(mapping = aes(x=lifeExp, y=gdpPercap))


# NEW STUFF: facet_wrap 
  
ggplot(data=gapminder, mapping = aes(x=gdpPercap, y=lifeExp)) +
  geom_point() +  
  geom_smooth() +  # up to here: same as above
  scale_x_log10() + # x is in log
  facet_wrap(~ continent) # tilde: interpret it as function -> group by??
  
# CHALLENGE 7
# ------------
# Try faceting by year, keeping the linear smoother. Is there any change in slope 
# of the linear trend over the years? What if you look at linear models per 
# continent?

ggplot(data=gapminder, mapping = aes(x=gdpPercap, y=lifeExp)) +
  geom_point() +  
  geom_smooth(method = "lm") +  # up to here: same as above
  scale_x_log10() + # x is in log
  facet_wrap(~ year) # tilde: interpret it as function -> group by??

ggplot(data=gapminder, mapping = aes(x=gdpPercap, y=lifeExp)) +
  geom_point() +  
  geom_smooth(method = "lm", mapping = aes(group=as.factor(year), color=as.factor(year))) +  # up to here: same as above
  scale_x_log10() +                       # above: one coloured line per year
  facet_wrap(~ continent) 


# NEW STUFF: filter

ggplot(data=filter(gapminder, year==2007)) + # a smallerm filtered data source
  geom_bar(mapping=aes(x=continent))  # assumes count

filter(gapminder, year==2007, continent =="Oceania") # only two records

ggplot(data=filter(gapminder, year==2007, continent =="Oceania")) + 
  geom_bar(mapping=aes(x=country, y=pop), stat= "identity")  # not count (there's only one of each! - take the actual value)

ggplot(data=filter(gapminder, year==2007, continent =="Asia")) + 
  geom_bar(mapping=aes(x=country, y=pop), stat="identity") +
  coord_flip() # better readable with horizontal bars!

# coloured set of scatter plots
ggplot(data=gapminder, mapping = aes(x=gdpPercap, y=lifeExp, 
                                     color=continent, size=pop/10^6)) +
  geom_point() +  
  scale_x_log10() +           
  facet_wrap(~ year) +
  # labs are labels
  labs(title="Life expectancy by GDP per capita", 
       subtitle="Life expectancy increased in most countries in the last 50 years",
       # label the aesthetics by naming them directly:
       x="GDP per capita in 1000 USD", y="Life expectancy in years",
       color="Continent", size="Population in millions",
       caption="Source: Gapmider foundation, gapmider.com")

# save the last plot
ggsave("myfancyplot.png")
