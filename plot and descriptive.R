library(forcats)
library(tidyverse)

#table1
setwd("C:/Users/dhihr/OneDrive/mpox")
metadata <- read.csv('dat_indo.csv')
metadata <- metadata %>%
  mutate(age_cat = case_when(
    Age <= 12 ~ "0-12",
    Age <= 19 ~ "13-19",
    Age <= 64 ~ "20-64",
    Age > 64 ~ "65+",
    TRUE ~ "Missing",
  ))
metadata <- rename(metadata, label = Virus.name)
#metadata$Submitting.lab <- 'Balai Besar Laboratorium Biologi Kesehatan'
#metadata2 <- read.csv('metadata_samp.csv')
#metadata2 <- metadata2 %>% select(label, location )
#metadata <- metadata %>% select(-location)
#metadata <- left_join(metadata, metadata2, by = "label")
metadata$area <- ifelse(metadata$area == 'Jabodetabek', 'The Greater Jakarta', metadata$area)

library(table1)

table <- metadata
table(table$Submitting.lab)
#table$Sex[table$Sex == "C"] <- "Missing"
#table[table$Submitting.lab == "",] <- "Missing"
#table[table$Clade == "",] <- "Non-Detected"
table$Sex <- ifelse(table$Sex == "M", "Male", 
                    ifelse(table$Sex == "F", "Female", table$Sex))
table(table$Sex)
table(table$age_cat)
table(table$wgs)
table(table$Severity)
table(table$Sex.Orientation)
table(table$Clade)
table(table$Status)
table(table$Travel_hist)
table(table$HIV)
table(table$loc)
table(table$area)
table(table$los)
table(table$Isolation)

#conditional for separator commas

render.categorical <- function(x, ...) {
  c("", sapply(stats.apply.rounding(stats.default(x)), function(y) with(y,
                                                                        sprintf("%s (%s%%)", prettyNum(FREQ, big.mark=","), PCT))))
}

render.strat <- function (label, n, ...) {
  sprintf("<span class='stratlabel'>%s<br><span class='stratn'>(N=%s)</span></span>", 
          label, prettyNum(n, big.mark=","))
}


# Reorder levels for 'Clade'
table$Clade <- table$Clade %>%
  fct_infreq() %>%
  fct_relevel("Non-Detected", after = Inf)

# Reorder factor levels for multiple columns
table <- table %>%
  mutate(across(c(Sex, age_cat, wgs, Severity, Sex.Orientation, Status, HIV, Travel_hist, loc, area, Isolation), ~ fct_infreq(.)))


#labelling
label(table$Sex) <- "Sex"
label(table$loc) <- "Origin Report"
label(table$wgs) <- "Status WGS"
label(table$Severity) <- "Severity Criteria"
label(table$Sex.Orientation) <- "Sex Orientation"
label(table$area) <- "Location"
label(table$Clade) <- "Clade"
label(table$Status) <- "Final Status"
label(table$Travel_hist) <- "Travel History"
label(table$HIV) <- "HIV Status"
label(table$age_cat) <- "Age Group"
label(table$los) <- "Length of Treatment (days)"
label(table$Isolation) <- "Isolation Status"

#table
tab1 <- table1(~Sex + age_cat + Sex.Orientation +Travel_hist + loc + area | wgs
               , data=table, render.categorical=render.categorical, 
               overall=c(left="Total"), render.strat=render.strat, 
               caption = ' ')
tab2 <- table1(~Severity + Clade + HIV + Isolation + los + Status | wgs
               , data=table, render.categorical=render.categorical, 
               overall=c(left="Total"), render.strat=render.strat, 
               caption = ' ')
tab1
tab2

head(metadata$date)

# Convert the date from character to Date type if necessary
metadata$Date.Onset <- as.Date(metadata$Date.Onset , format = "%m/%d/%Y")
metadata$date_diagnosis <- as.Date(metadata$date_diagnosis , format = "%m/%d/%Y")
metadata$date_discharge <- as.Date(metadata$date_discharge , format = "%m/%d/%Y")
metadata$Date.Onset <- as.Date(ifelse(is.na(metadata$Date.Onset), metadata$date_diagnosis, metadata$Date.Onset))

# Create a bar chart with ggplot2
ggplot(metadata, aes(x = Date.Onset, fill = wgs)) +
  geom_bar(stat = "count", width = 10) +  # `width` can be adjusted for appearance
  scale_x_date(date_breaks = "3 month", date_labels = "%Y-%m") +  # Set breaks and labels
  labs(x = "Date", y = "Samples Count", title = "Epicurve Samples") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#Epicurve Cases
#Cases
summary_table <- metadata %>%
  group_by(wgs,Date.Onset) %>%
  summarise(count = n())

# Convert dates to the first date of each month
summary_table <- summary_table %>%
  mutate(first_day_of_month = floor_date(Date.Onset, "month"))
time <- summary_table %>%
  group_by(wgs, first_day_of_month) %>%
  summarize(
    Cases = sum(count))


epicurve <- ggplot(time, aes(x = first_day_of_month, y = Cases, fill = wgs)) +
  geom_bar(stat = "identity", alpha = 0.8) +
  labs(
    title = " ",
    x = "Date",
    y = "Count",
    fill = "Category Cases"
  ) + ggtitle("A. Monthly Cases") +scale_x_date(
    date_breaks = "5 month",  # Set the interval for breaks
    date_labels = "%b-%Y",  # Customize the format (e.g., Aug 22, 2022)
    limits = as.Date(c('2022-07-01','2024-08-01'))
  ) + theme_classic() + theme(
    legend.position = "top")
epicurve <- epicurve + theme(panel.grid.major = element_blank(),  # Removes major grid lines
                 panel.grid.minor = element_blank(),  # Removes minor grid lines
                 axis.title.x=element_blank(),
                 axis.text.x=element_blank(),
                 axis.ticks.x=element_blank())

#Clade
summary_table <- metadata %>%
  group_by(Clade,Date.Onset) %>%
  summarise(count = n())

# Convert dates to the first date of each month
summary_table <- summary_table %>%
  mutate(first_day_of_month = floor_date(Date.Onset, "month"))
time <- summary_table %>%
  group_by(Clade, first_day_of_month) %>%
  summarize(
    Cases = sum(count))
time <- filter(time, Clade != "Non-Detected")

clade <- ggplot(time, aes(x = first_day_of_month, y = Cases, fill = Clade)) +
  geom_bar(position="fill", stat="identity", alpha = 0.8) +
  labs(
    title = " ",
    x = "Month",
    y = "Proportion",
    fill = "Clade"
  ) + scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  ggtitle("B. Proportion of Clades") + scale_x_date(
    date_breaks = "5 month",  # Set the interval for breaks
    date_labels = "%b-%Y",  # Customize the format (e.g., Aug 22, 2022)
    limits = as.Date(c('2022-07-01','2024-08-01'))
  ) + theme_classic() + theme(
    legend.position = "top")
clade

library(patchwork)
epicurve / clade


#additional travel
trvl <- read.csv('travel_data.csv')
trvl$Date <- as.Date(trvl$Date, format = "%m/%d/%Y")
trvl$Year <- as.factor(format(trvl$Date, "%Y"))
ggplot(trvl, aes(x = Date, y = Travel, fill = Year)) +
  geom_bar(stat = "identity") +  # `width` can be adjusted for appearance
  scale_x_date(date_breaks = "3 month", date_labels = "%Y-%m") +  # Set breaks and labels
  labs(x = "Date", y = "Total Tourists", title = " ") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(trvl, aes(x = Date, y = Travel, fill = Year)) +
  geom_bar(stat="identity", alpha = 0.8) +
  labs(
    title = " ",
    x = "Month",
    y = "Total Tourists",
    fill = "Year"
  )  +
   scale_x_date(
    date_breaks = "5 month",  # Set the interval for breaks
    date_labels = "%b-%Y",  # Customize the format (e.g., Aug 22, 2022)
    ) + theme_classic() + theme(
    legend.position = "top")
