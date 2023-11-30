####1. Set up API authentication####
library(rtoot)
vignette("auth")
auth_setup()

####2. Collect data from #climatechange and confirm relevant hashtags####
## 2.1 collect data from #climatechange
df_climatechange = get_timeline_hashtag(
  hashtag = "climatechange",
  local = FALSE,
  only_media = FALSE,
  limit = 300000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = TRUE,
  verbose = TRUE
)

#inspect the collected dataset
nrow(df_climatechange)#66,396 collected on 19.09.2023

## 2.2 Find other relevant hashtags
# Export the whole nested dataframe within variable "tags"
for (i in 1:length(df_climatechange$tags)) {
  df_tags <- df_climatechange$tags[[i]]
  filename <- paste0("nested_dataframe_", i, ".csv")
  write.csv(df_tags, file = filename, row.names = FALSE)
} 

# Loop through and read the exported 66,396 dataframes
library(dplyr)
df_list <- list()#Create an empty list to store dataframes
for (i in 1:66396) {
  df_combine <- read.csv(paste0("nested_dataframe_", i, ".csv"))
  # Append it to the list
  df_list[[i]] <- df_combine
} 

# Combine all dataframes into one
df_tags_combined <- bind_rows(df_list)

# Count which tag appears how many times
df_tags_combined <- df_tags_combined %>%
  group_by(name) %>%
  mutate(count = n())%>%
  ungroup()%>%
  distinct()

# Sort the dataset by the column count
df_tags_combined <- df_tags_combined[order(df_tags_combined$count, 
                                           decreasing = TRUE), ]

# Select relevant hashtags for further selection
df_tags_selected <- df_tags_combined[1:54,1:3]
write.csv(df_tags_selected, "df_tags_selected.csv")
# [1] "climatechange"      "climate"            "climatecrisis"     
# [4] "environment"        "climateemergency"   "globalwarming"     
# [7] "ecology"            "pollution"          "climatecatastrophe"
# [10] "news"               "climateaction"      "science"           
# [13] "nature"             "sustainability"     "fossilfuels"       
# [16] "politics"           "cop27"              "weather"           
# [19] "biodiversity"       "energy" 

####3. Collect data other hashtags####
####3.1 Collect #climatecrisis####
df_climatecrisis_1 = get_timeline_hashtag(
  hashtag = "climatecrisis",
  local = FALSE,
  only_media = FALSE,
  limit = 500000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = FALSE,
  verbose = TRUE
)
nrow(df_climatecrisis_1)#16,040 entries

# Previous collection stopped at id: 110575770547284527
# Collect rest of the data from above id
df_climatecrisis_2 = get_timeline_hashtag(
  hashtag = "climatecrisis",
  local = FALSE,
  only_media = FALSE,
  max_id = "110575770547284526",
  limit = 500000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = FALSE,
  verbose = TRUE
)
nrow(df_climatecrisis_2)#11,960 entries

df_climatecrisis_2[11960,1]#collection stops at id: 109875740653370284
# Collect rest of the data from above id
df_climatecrisis_3 = get_timeline_hashtag(
  hashtag = "climatecrisis",
  local = FALSE,
  only_media = FALSE,
  max_id = "109875740653370283",
  limit = 500000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = FALSE,
  verbose = TRUE
)
nrow(df_climatecrisis_3)#11,880 entries

df_climatecrisis_3[11880,1]#collection stops at id: 109269336015843618
# Collect rest of the data from above id
df_climatecrisis_4 = get_timeline_hashtag(
  hashtag = "climatecrisis",
  local = FALSE,
  only_media = FALSE,
  max_id = "109269336015843617",
  limit = 500000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = FALSE,
  verbose = TRUE
)
nrow(df_climatecrisis_4)#10,005 entries, done

# Combine four parts of datasets
df_climatecrisis <- rbind(df_climatecrisis_1, 
                          df_climatecrisis_2,
                          df_climatecrisis_3, 
                          df_climatecrisis_4)

# Inspect the collected dataset
# A few data entries were not collected due to technical problem
nrow(df_climatecrisis) #49,885 collected on 25.09.2023

####3.2 Collect #climateemergency####
df_climateemergency = get_timeline_hashtag(
  hashtag = "climateemergency",
  local = FALSE,
  only_media = FALSE,
  limit = 500000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = TRUE,
  verbose = TRUE
)

# Inspect the collected dataset
nrow(df_climateemergency)#23,014 collected on 21.09.2023

####3.3 Collect #globalwarming####
df_globalwarming = get_timeline_hashtag(
  hashtag = "globalwarming",
  local = FALSE,
  only_media = FALSE,
  limit = 500000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = TRUE,
  verbose = TRUE
)

# Inspect the collected dataset
nrow(df_globalwarming)#7,557 collected on 21.09.2023

####3.4 Collect #climatecatastrophe####
df_climatecatastrophe = get_timeline_hashtag(
  hashtag = "climatecatastrophe",
  local = FALSE,
  only_media = FALSE,
  limit = 500000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = TRUE,
  verbose = TRUE
)

# Inspect the collected dataset
nrow(df_climatecatastrophe)#8,873 collected on 21.09.2023

####3.5 Collect #climateaction####
df_climateaction = get_timeline_hashtag(
  hashtag = "climateaction",
  local = FALSE,
  only_media = FALSE,
  limit = 500000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = TRUE,
  verbose = TRUE
)

# Inspect the collected dataset
nrow(df_climateaction)#9,381 collected on 25.09.2023

####3.6 Collect #fossilfuels####
df_fossilfuels = get_timeline_hashtag(
  hashtag = "fossilfuels",
  local = FALSE,
  only_media = FALSE,
  limit = 500000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = TRUE,
  verbose = TRUE
)

# Inspect the collected dataset
nrow(df_fossilfuels)#5,193 collected on 22.09.2023

####3.7 Collect #climatejustice####
df_climatejustice = get_timeline_hashtag(
  hashtag = "climatejustice",
  local = FALSE,
  only_media = FALSE,
  limit = 500000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = TRUE,
  verbose = TRUE
)

# Inspect the collected dataset
nrow(df_climatejustice)#7,605 collected on 25.09.2023

####3.8 Collect #climatestrike####
df_climatestrike = get_timeline_hashtag(
  hashtag = "climatestrike",
  local = FALSE,
  only_media = FALSE,
  limit = 500000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = TRUE,
  verbose = TRUE
)

# Inspect the collected dataset
nrow(df_climatestrike)#5,641 collected on 25.09.2023

####3.9 Collect #eimissions####
df_emissions = get_timeline_hashtag(
  hashtag = "emissions",
  local = FALSE,
  only_media = FALSE,
  limit = 500000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = TRUE,
  verbose = TRUE
)

# Inspect the collected dataset
nrow(df_emissions)#8,126 collected on 25.09.2023

####3.10 Collect #climatebreakdown####
df_climatebreakdown = get_timeline_hashtag(
  hashtag = "climatebreakdown",
  local = FALSE,
  only_media = FALSE,
  limit = 500000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = TRUE,
  verbose = TRUE
)

# Inspect the collected dataset
nrow(df_climatebreakdown)#1,942 collected on 25.09.2023

####3.11 Collect #fossilfuel####
df_fossilfuel = get_timeline_hashtag(
  hashtag = "fossilfuel",
  local = FALSE,
  only_media = FALSE,
  limit = 500000L,
  instance = NULL,
  token = NULL,
  anonymous = FALSE,
  parse = TRUE,
  retryonratelimit = TRUE,
  verbose = TRUE
)

# Inspect the collected dataset
nrow(df_fossilfuel)#4,677 collected on 25.09.2023

####4. Combine datasets and simply handling####
## 4.1 Combine current datasets
df_combine <- rbind(df_climatechange, 
                    df_climatecrisis, 
                    df_climateemergency, 
                    df_climatecatastrophe, 
                    df_globalwarming,
                    df_climateaction,
                    df_fossilfuels,
                    df_climatejustice,
                    df_climatestrike,
                    df_emissions,
                    df_climatebreakdown,
                    df_fossilfuel)
nrow(df_combine)#198,290 entries on 25.09.2023 (Unfiltered dataset)

## 4.2 remove repetition
library(dplyr)
df_combine <- distinct(df_combine, id, .keep_all = TRUE)

## 4.3 keep the ones before 01.09.2023
df_D0_raw$date <-
  gsub("(\\d{4}-\\d{2}-\\d{2}).*", "\\1",
       df_D0_raw$created_at)

# Format the column date to date class
df_D0_raw$date <- as.Date(df_D0_raw$date)
class(df_D0_raw$date)

df_D0_raw <- df_D0_raw[df_D0_raw$date < as.Date("2023-09-01"), ]

## 4.4 remove missing values
df_D0_raw <- df_D0_raw[complete.cases(df_D0_raw$content), ]

####5. Data cleaning####
####5.1. Clean sanitized HTML format####

# Clean HTML content and extract text
df_D0_raw_test <- df_D0_raw #create a test version
df_D0_raw_test$x <- gsub("<[^>]+>", "", df_D0_raw$content)#clean HTML tags using regular expressions
df_D0_raw$cleaned_content <- df_D0_raw_test$x
remove(df_D0_raw_test)#remove the test version

####5.2. Create a new column of Instance and extra cleaning####
# Extract between "https://" and "/users"
df_D0_raw$instance <- sub("/users/.*$", "", df_D0_raw$uri)

# Extra cleaning steps to get clean instance domains
df_D0_raw$instance <- sub("/objects/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/content/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/notes/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/item/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/p/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/videos/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/events/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/2023/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/2022/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/2021/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/2020/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/2019/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/federation/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/api/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/u/.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub("/posts/.*$", "", df_D0_raw$instance)

# Some more cleaning steps
df_D0_raw$instance <- gsub("tag:", "https://", df_D0_raw$instance)
df_D0_raw$instance <- sub(",2017.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub(",2018.*$", "", df_D0_raw$instance)
df_D0_raw$instance <- sub(",2019.*$", "", df_D0_raw$instance)

# Export the column instance separately
df_instance <- data.frame(df_D0_raw$instance)

# Count which instance appears how many times
library(dplyr)
df_instance <- df_instance %>%
  group_by(df_D0_raw.instance) %>%
  mutate(count = n())%>%
  ungroup()%>%
  distinct()

# Sort by the column count
df_instance <- df_instance[order(df_instance$count, 
                                           decreasing = TRUE), ]

nrow(df_instance)#1,590

# Save to excel format for privacy protocol inspection
library(writexl)
write_xlsx(df_instance, "instance_coding.xlsx")

####5.3. Check data privacy protocol in existing instances####

# Privacy protocol coding conducted in excel sheets
# Remove data entries from instances with privacy issues
df_D0_raw <- df_D0_raw[!(grepl("https://mastodon.sdf.org", df_D0_raw$instance)
                         | grepl("https://mastodon.nz", df_D0_raw$instance)
                         | grepl("https://chaos.social", df_D0_raw$instance) 
                         | grepl("https://mastodon.bida.im", df_D0_raw$instance)
                         | grepl("https://mastodon.art", df_D0_raw$instance)
                         | grepl("https://scholar.social", df_D0_raw$instance)
                               | grepl("https://scicomm.xyz", df_D0_raw$instance)
                               | grepl("https://infosec.exchange", df_D0_raw$instance)
                               | grepl("https://eupolicy.social", df_D0_raw$instance)
                               | grepl("https://tldr.nettime.org", df_D0_raw$instance)
                               | grepl("https://hcommons.social", df_D0_raw$instance)
                               #| grepl("https://wien.rocks", df_D0_raw$instance)
                               | grepl("https://toot.cafe", df_D0_raw$instance)
                         | grepl("https://queer.party", df_D0_raw$instance)
                               | grepl("https://genomic.social", df_D0_raw$instance)
                               | grepl("https://maly.io", df_D0_raw$instance)
                               | grepl("https://literatur.social", df_D0_raw$instance)
                               | grepl("https://puntarella.party", df_D0_raw$instance)
                               | grepl("https://jawns.club", df_D0_raw$instance)
                               | grepl("https://meow.social", df_D0_raw$instance)
                               | grepl("https://fr.got-tty.org", df_D0_raw$instance)
                               | grepl("https://social.sdf.org", df_D0_raw$instance)
                               | grepl("https://graphics.social", df_D0_raw$instance)
                               #| grepl("https://social.wildeboer.net", df_D0_raw$instance)
                               | grepl("https://front-end.social", df_D0_raw$instance)
                               | grepl("https://social.lol", df_D0_raw$instance)
                               | grepl("https://dair-community.social", df_D0_raw$instance)
                               | grepl("https://artisan.chat", df_D0_raw$instance)
                               | grepl("https://toot.boston", df_D0_raw$instance)
                               | grepl("https://gladtech.social", df_D0_raw$instance)
                               | grepl("https://mastodon.pirateparty.be", df_D0_raw$instance)
                               #| grepl("https://fedi.at", df_D0_raw$instance)
                         | grepl("https://m.cmx.im", df_D0_raw$instance)      
                         | grepl("https://wikis.world", df_D0_raw$instance)
                               | grepl("https://someone.elses.computer", df_D0_raw$instance)                               
                               | grepl("https://mastodon.pirateparty.be", df_D0_raw$instance)
                               | grepl("https://toot.garden", df_D0_raw$instance)
                         | grepl("https://social.yesterweb.org", df_D0_raw$instance)
                               | grepl("https://dragonscave.space", df_D0_raw$instance)
                               | grepl("https://elekk.xyz", df_D0_raw$instance)
                         | grepl("https://social.heise.de", df_D0_raw$instance)
                               | grepl("https://julialang.social", df_D0_raw$instance)
                               | grepl("https://nagoyadon.jp", df_D0_raw$instance)
                               | grepl("https://coales.co", df_D0_raw$instance)                               
                               | grepl("https://mastodon.pirateparty.be", df_D0_raw$instance)
                               | grepl("https://cktn.todon.de", df_D0_raw$instance)
                               | grepl("https://mastodon.moule.world", df_D0_raw$instance)
                               | grepl("https://akkoma.thesandbox.net", df_D0_raw$instance)
                         | grepl("https://bsd.network", df_D0_raw$instance)
                               | grepl("https://cultur.social", df_D0_raw$instance)
                               | grepl("https://fedified.com", df_D0_raw$instance)
                               | grepl("https://aoir.social", df_D0_raw$instance)                               
                               | grepl("https://mastodon.pirateparty.be", df_D0_raw$instance)
                               | grepl("https://old.mermaid.town", df_D0_raw$instance)), ]

nrow(df_D0_raw)#128,239 data entries after cleaning
# Save the dataset after removing privacy concerns (D0)
save(df_D0_raw, file = "df_D0_raw_128239.RData")

####6. Volume Analysis####

## 6.1 Map issue attention over all time

# Create another data frame for volume analysis
df_D0_raw_alltime <- data.frame(df_D0_raw$date)
df_D0_raw_alltime$df_D0_raw.date <- as.Date(df_D0_raw_alltime$df_D0_raw.date)

# Count the appearance time
library(dplyr)
df_D0_raw_alltime <- df_D0_raw_alltime %>%
  group_by(df_D0_raw.date) %>%
  mutate(count = n())%>%
  ungroup()%>%
  distinct()

# Visualization
library("ggplot2")

ggplot(df_D0_raw_alltime, aes(x = df_D0_raw.date, y = count)) +
  geom_line() +  # Use geom_line instead of geom_bar
  labs(title = "Number of toots across time",
       x = "Post Time",
       y = "Number of toots") +
  annotate(geom="text", x=as.Date("2022-10-27"), y= -10, 
           label="Aquisition of Twitter by Elon Musk concluded")+
  annotate(geom="point", x=as.Date("2022-10-27"), y= 37, size=6, shape=21, fill="blue") +
  annotate(geom="text", x=as.Date("2019-09-19"), y= 500, 
           label="September 2019 climate strikes")+
  annotate(geom="point", x=as.Date("2019-09-19"), y= 441, size=6, shape=21, fill="red") +
  annotate(geom="text", x=as.Date("2019-01-01"), y= 250, 
           label="Global Climate Strikes started")+
  annotate(geom="point", x=as.Date("2019-03-15"), y= 180, size=6, shape=21, fill="red") +
  theme_classic() +
  scale_x_date(date_breaks = "6 months", date_labels = "%b %Y")

## 6.2 Map issue attention after the Elon events (April 2022)

# Keep the data after from Jan 2022 to now
df_D0_raw_2022 <- df_D0_raw[df_D0_raw$date > as.Date("2022-08-01"), ]
df_D0_raw_2022 <- data.frame(df_D0_raw_2022$date)
df_D0_raw_2022$df_D0_raw_2022.date <- as.Date(df_D0_raw_2022$df_D0_raw_2022.date)

# Count the appearance time
library(dplyr)
df_D0_raw_2022 <- df_D0_raw_2022 %>%
  group_by(df_D0_raw_2022.date) %>%
  mutate(count = n())%>%
  ungroup()%>%
  distinct()

# Check specific toots on significant days
# df_D0_raw_check <- df_D0_raw[df_D0_raw$date > as.Date("2022-10-27"), ]
# df_D0_raw[278, 2]
# names(df_D0_raw)
# summary(df_D0_raw$media_attachments)
# sumrow <- sum(lengths(df_D0_raw$media_attachments) == 0)
# 88378/128239
# mean(df_D0_raw_check$count)
# df_D0_raw_check <- df_D2_SA[df_D2_SA$date > as.Date("2022-10-27"), ]
# nrow(df_D0_raw_check)

# Visualization (after 2022)
ggplot(df_D0_raw_2022, aes(x = df_D0_raw_2022.date, y = count)) +
  geom_line() +
  labs(title = "Number of toots across time",
       x = "Post Time",
       y = "Number of toots") +
  annotate(geom="text", x=as.Date("2022-10-27"), y= -10, 
           label="Aquisition of Twitter by Elon Musk concluded")+
  annotate(geom="point", x=as.Date("2022-10-27"), y= 37, size=6, shape=21, fill="blue") +  
  annotate(geom="text", x=as.Date("2022-11-07"), y= 600, 
           label="UN climate change conference (COP27)")+
  annotate(geom="point", x=as.Date("2022-11-07"), y= 556, size=6, shape=21, fill="green") +
  annotate(geom="text", x=as.Date("2023-07-25"), y= 820, 
           label="July Heat Waves")+
  annotate(geom="point", x=as.Date("2023-07-25"), y= 776, size=6, shape=21, fill="orange") +
  annotate(geom="text", x=as.Date("2023-01-12"), y= 510, 
           label="Exxon Predicted Global Warming Years Ago")+
  annotate(geom="point", x=as.Date("2023-01-12"), y= 470, size=6, shape=21, fill="orange") +
  annotate(geom="text", x=as.Date("2023-03-20"), y= 490, 
           label="New IPCC Report Released")+
  annotate(geom="point", x=as.Date("2023-03-20"), y= 444, size=6, shape=21, fill="green") +
  annotate(geom="text", x=as.Date("2023-06-08"), y= 590, 
           label="Forest Fire Across North-America")+
  annotate(geom="point", x=as.Date("2023-06-08"), y= 547, size=6, shape=21, fill="orange") +
  theme_classic() +
  scale_x_date(date_breaks = "2 months", date_labels = "%b %Y")

####7. Topic modeling ####

####7.1. Preprocessing####
####7.1.1. Detect non-English content####
# Remove link from the content 
df_D0_raw$content_nolinks <- gsub("http\\S+|www\\S+", "", df_D0_raw$cleaned_content)

# Inspect the language of content without links with textcat
library(textcat)
df_D0_raw$language_textcat <- textcat(df_D0_raw$content_nolinks) 

# Inspect the language of content without links with cld2
library(cld2)
df_D0_raw$language_cld2 <- cld2::detect_language(df_D0_raw$content_nolinks)

# Inspect the language of content without links with cld3
install.packages("cld3")
library(cld3)
df_D0_raw$language_cld3 <- cld3::detect_language(df_D0_raw$content_nolinks)

# Save relevant column for intercoding against human
df_languagecheck <- data.frame(df_D0_raw$id, df_D0_raw$uri, 
                               df_D0_raw$language, df_D0_raw$content_nolinks,
                               df_D0_raw$language_cld2, df_D0_raw$language_textcat,
                               df_D0_raw$language_cld3)

# Sample 500 random data entries from the dataset
intercoding_sample <- df_languagecheck[sample(nrow(df_D0_raw), 500), ]

# Save the sample to xlsx for intercoding
library(writexl)
write_xlsx(intercoding_sample, "intercoding_sample.xlsx")

# Intercoding finished in excel sheets
# Read the coded column
library(readxl)
intercoding_sample <- read_excel("intercoding_sample.xlsx")

# Calculate Cohen's Kappa value in four pairs
library(irr)

#1. API against human coding
kappa_result_API <- kappa2(intercoding_sample[,c(5,9)], weight = "unweighted")
print(kappa_result_API)#0.454 Moderate

#2. cld2 against human coding
kappa_result_cld2 <- kappa2(intercoding_sample[,c(5,6)], weight = "unweighted")
print(kappa_result_cld2)#0.977 Almost perfect
  #Chosen

#3. textcat against human coding
kappa_result_textcat <- kappa2(intercoding_sample[,c(5,7)], weight = "unweighted")
print(kappa_result_textcat)#0.661 Substantial

#4. cld3 against human coding
kappa_result_cld3 <- kappa2(intercoding_sample[,c(5,8)], weight = "unweighted")
print(kappa_result_cld3)#0.652 Substantial

# Keep cld2 as the language in the post
df_D0_raw <- subset(df_D0_raw, select = -c(language, language_cld3, language_textcat))

# Create a dataset especially for topic modeling with only English content
df_D1_TM <- df_D0_raw[df_D0_raw$language_cld2 == "en", ]
df_D1_TM <- df_D1_TM[complete.cases(df_D1_TM$language_cld2), ]
nrow(df_D1_TM)#116488 data entries

####7.1.2. Create data for author-pooled LDA####

## 1. Create a new column of user profile links
df_D1_TM$user <- sub("/statuses/.*$", "", df_D1_TM$uri)

# Keep id, user, uri, content without link
df_D1_TM <- subset(df_D1_TM, select = c(id, url, created_at, content_nolinks, language_cld2, user))

## 2. Group the dataset by users
# Count which user appears how many times
library(dplyr)
df_D1_TM <- df_D1_TM %>%
  group_by(user) %>%
  mutate(count = n())%>%
  ungroup()%>%
  distinct()

# Sort by the column count
df_D1_TM <- df_D1_TM[order(df_D1_TM$count, 
                                 decreasing = TRUE), ]

# Group the content by user
library(dplyr)

df_D1_TM <- df_D1_TM %>%
  group_by(user) %>%
  summarise(Combined_Content = paste(content_nolinks, collapse = " "))

colnames(df_D1_TM)[2] ="text"

nrow(df_D1_TM)#18,538 data entries for author-pooled LDA
save(df_D1_TM, file = "df_D1_TM_18538.RData")

## 3. Calculate average word count

# Function to calculate word count
word_count <- function(text) {
  words <- unlist(strsplit(as.character(text), "\\s+"))
  return(length(words))
}

# Apply the function to each row
df_D1_TM$word_count <- sapply(df_D1_TM$text, word_count)

# Calculate the average word count
average_word_count <- mean(df_D1_TM$word_count)

# Print the result
print(average_word_count)#262.73 -> 263
# Omit the column
df_D1_TM <- subset(df_D1_TM, select=-word_count)

## 4. Basic cleaning
# Remove encoding noises
df_D1_TM$text <- gsub("&#39;", "'", df_D1_TM$text)
df_D1_TM$text <- gsub("&amp;", "&", df_D1_TM$text)
df_D1_TM$text <- gsub("&quot;", "", df_D1_TM$text)
df_D1_TM$text <- gsub("&gt;", ">", df_D1_TM$text)
df_D1_TM$text <- gsub("&nbsp;@", "@", df_D1_TM$text)
df_D1_TM$text <- gsub("«&nbsp;", "«", df_D1_TM$text)
df_D1_TM$text <- gsub("&lt;", "<", df_D1_TM$text)
df_D1_TM$text <- gsub("&nbsp;", " ", df_D1_TM$text)

# Remove emojis
remove_emojis <- function(text) { # Function to remove emojis from a text
  # Define a regular expression to match emojis
  emoji_pattern <- "[\U0001F600-\U0001F6FF]|[\U0001F300-\U0001F5FF]|[\U0001F680-\U0001F6FF]|[\U0001F700-\U0001F77F]|[\U0001F780-\U0001F7FF]|[\U0001F800-\U0001F8FF]|[\U0001F900-\U0001F9FF]|[\U0001FA00-\U0001FA6F]|[\U0001FA70-\U0001FAFF]|[\U00002702-\U000027B0]|[\U000024C2-\U0001F251]"

  # Remove emojis using gsub
  text_cleaned <- gsub(emoji_pattern, "", text)
  
  return(text_cleaned)
}

df_D1_TM$text <- remove_emojis(df_D1_TM$text)
df_D1_TM$text[19]

# Remove noises of special signs
  # Noises: hashtags (#), `, |, +, °
df_D1_TM$text <- gsub("#", "", df_D1_TM$text)

grepl(pattern = "`", x = df_D1_TM$text)
df_D1_TM$text <- gsub("`", "", df_D1_TM$text)
df_D1_TM$text[554]

#grepl(pattern = "|", x = df_D1_TM$text)
#df_D1_TM$text <- gsub("|", "", df_D1_TM$text)
#df_D1_TM$text[c(1,2,3)] - does not work

#grepl(pattern = "+", x = df_D1_TM$text)
#df_D1_TM$text <- gsub("+", "", df_D1_TM$text)
#df_D1_TM$text[c(1,2,3)] - does not work

grepl(pattern = "=", x = df_D1_TM$text)
df_D1_TM$text <- gsub("=", "", df_D1_TM$text)
df_D1_TM$text[963]

grepl(pattern = "*", x = df_D1_TM$text)
df_D1_TM$text <- gsub("*", "", df_D1_TM$text)
df_D1_TM$text[8]

# 5. Save the dataset for now
nrow(df_D1_TM)#18,538
save(df_D1_TM, file = "df_D1_TM_18538.RData")#save the dataset for now

####7.1.3. Transforming into BOW (DFM) corpus####
library(quanteda)
## 7.1.3.1. check encoding issues
writeLines(df_D1_TM$text[1])#no line break
# Check "\n"
grepl(pattern = "\n", x = df_D1_TM$text)#but some are TRUE
# Remove the "\n"
df_D1_TM$text <- gsub(pattern = "\n", replacement = " ", x = df_D1_TM$text)

df_D1_TM$text[c(1, 88, 89, 90, 627)]

## 7.1.3.2. tokenization
  #split word strings into tokens
tokens_MAS <- tokens(df_D1_TM$text,
                     what = c("word"),
                     remove_separators = TRUE,
                     include_docvars = TRUE,
                     ngrams = 1L,
                     remove_numbers = FALSE,#do not remove numbers, puncts yet
                     remove_punct = FALSE,
                     remove_symbols = FALSE,
                     remove_hyphens = FALSE)
tokens_MAS[1:2]

####7.1.3.3. collocation####
library(quanteda.textstats)

# Find 5-word collocation
col5 <-
  tokens_MAS %>%
  tokens_select(pattern = "^[A-Z]",
                valuetype = "regex",
                case_insensitive = FALSE,
                padding = TRUE) %>%
  textstat_collocations(min_count = 10,
                        size = 5,
                        tolower = FALSE)
library(writexl)
write_xlsx(col5, "col5.xlsx")

# Combine 5-word collocation
multiword_5 <- c("United Nations Climate Change Conference", "North Atlantic Sea Surface Temperature",
                 "Island Rail Corridor Freight Analysis", "East African Crude Oil Pipeline",
                 "Abu Dhabi National Oil Company")
tokens_MAS <- tokens_compound(tokens_MAS,
                              pattern = phrase(multiword_5))

# Find 4-word collocation
col4 <-
  tokens_MAS %>%
  tokens_select(pattern = "^[A-Z]",
                valuetype = "regex",
                case_insensitive = FALSE,
                padding = TRUE) %>%
  textstat_collocations(min_count = 10,
                        size = 4,
                        tolower = FALSE)

write_xlsx(col4, "col4.xlsx")

# Combine 4-word collocation
multiword_4 <- c("CWB Observation Data Inquire", "Copernicus Climate Change Service",
                 "Atlantic Meridional Overturning Circulation", "Fossil Fuel Non-Proliferation Treaty",
                 "Global Warming Policy Foundation", "Architects Climate Action Network",
                 "Federal Energy Regulatory Commission", "The International Energy Agency",
                 "Natural Resources Defense Council", "The United Arab Emirates",
                 "UN Climate Change Conference", "The Inflation Reduction Act",
                 "Central Weather Bureau Taiwan")
tokens_MAS <- tokens_compound(tokens_MAS,
                              pattern = phrase(multiword_4))

# Find 3-word collocation
col3 <-
  tokens_MAS %>%
  tokens_select(pattern = "^[A-Z]",
                valuetype = "regex",
                case_insensitive = FALSE,
                padding = TRUE) %>%
  textstat_collocations(min_count = 10,
                        size = 3,
                        tolower = FALSE)
write_xlsx(col3, "col3.xlsx")

# Combine 3-word collocation
multiword_3 <- c("Paris Climate Agreement", "New South Wales",
                 "Global Carbon Project", "Coordinated Universal Time",
                 "Green New Deal", "The Washington Post",
                 "The Getty Center", "National Climate Assessment",
                 "American Petroleum Institute", "Environmental Policy Act",
                 "World Resources Institute", "British Antarctic Survey",
                 "Inside Climate News", "Energy Information Administration",
                 "Earth Overshoot Day", "World Weather Attribution",
                 "European Green Deal", "The Great Displacement",
                 "Clean Water Act", "International Space Station",
                 "UN Climate Summit", "The European Union",
                 "PBS News Hour", "European Investment Bank",
                 "Energy Charter Treaty", "International Monetary Fund",
                 "New York Times", "New York City",
                 "New Year's Eve", "Eunice Newton Foote",
                 "European Environment Agency", "Nature Restoration Law",
                 "International Energy Agency", "The United Nations",
                 "World War II", "The European Commission",
                 "United Arab Emirates", "National Wildlife Refuge",
                 "Sharm El Sheikh", "Climate Ambition Summit",
                 "Imperial College London", "The World Bank",
                 "The New Yorker", "Great Salt Lake",
                 "Climate Tipping Points", "Don't Look Up",
                 "Los Angeles Times","University College London",
                 "Kim Stanley Robinson","UN's Intergovernmental Panel",
                 "Inflation Reduction Act","World Health Organization"
                 )
tokens_MAS <- tokens_compound(tokens_MAS,
                        pattern = phrase(multiword_3))

# Find 2-word collocation
col2 <-
  tokens_MAS %>%
  tokens_select(pattern = "^[A-Z]",
                valuetype = "regex",
                case_insensitive = FALSE,
                padding = TRUE) %>%
  textstat_collocations(min_count = 15,
                        size = 2,
                        tolower = FALSE)
write_xlsx(col2, "col2.xlsx")

# Combine 2-word collocation
library(readxl)
excel_file <- read_xlsx("col2_selected.xlsx")
multiword_2 <- as.character(excel_file$collocation)
tokens_MAS <- tokens_compound(tokens_MAS,
                              pattern = phrase(multiword_2))

##7.1.3.4. Remove Punctuations
tokens_MAS <-
  tokens_MAS %>%
  tokens_remove(pattern = "^[[:punct:]]+$", # regex for toks consisting solely of punct class chars
                valuetype = "regex",
                padding = TRUE)
tokens_MAS[1:2]

## 7.1.3.5. normalize to lower case
  # Before that, remove lower case "us", to not confuse with "US" after lowercase
tokens_MAS <- tokens_remove(tokens_MAS, "us")

tokens_MAS <-
  tokens_MAS %>%
  tokens_tolower
tokens_MAS[1:2]

## 7.1.3.6. Remove other noises

# Remove stopwords
print(stopwords("english"))

tokens_MAS <- tokens_remove(tokens_MAS, stopwords("english"))
tokens_MAS[1:2]

# Remove sampling hashtag keywords
tokens_MAS <- tokens_remove(tokens_MAS, c("climateaction", "climatebreakdown", "climatechange",
                                  "climatecrisis", "climateemergency", "globalwarming",
                                  "climatecatastrophe", "fossilfuels", "climatejustice",
                                  "climatestrike", "emissions", "fossilfuel"))
tokens_MAS[1:20]

# Remove noises of punctuation, numbers, and extra stopwords

# Remove some punctuation
tokens_MAS <- tokens_remove(tokens_MAS, pattern = c(">","~","#", "amp", "|", "$", "£"))

# Remove +
tokens_MAS <- tokens_remove(tokens_MAS, pattern = "\\+", valuetype = "regex")

# Remove numbers
tokens_MAS <- tokens_remove(tokens_MAS, pattern = "\\b\\d+\\b", valuetype = "regex")

# Remove some stopwords
tokens_MAS <- tokens_remove(tokens_MAS, c("can", "now", "one", "get", "like", "just", "since", "also"))

# Remove encoding noises
pattern_nbsp <- "\\bnbsp\\b"
pattern_quote <- "\\bquote\\b"

# Remove matching tokens from the corpus
tokens_MAS <- tokens_remove(tokens_MAS, pattern = c(pattern_nbsp, pattern_quote), valuetype = "regex")

## 7.1.3.7. Remove empty tokens
tokens_MAS <-
  tokens_MAS %>%
  tokens_remove("")

tokens_MAS[1:5]

####7.2. Run model####
## Construct a dfm (Document-Feature-Matrix)
dfm_MAS <- dfm(tokens_MAS)

## Topic modeling analysis
library(topicmodels)
library(tm)

# Removing rare/frequent words (trim the dtm)
dfm_MAS <- quanteda::dfm_trim(dfm_MAS, 
                   min_docfreq = 0.005, 
                   max_docfreq = 0.90, # try different threshold
                   docfreq_type = "prop", 
                   verbose = TRUE)
  # Remove all features that occur in less than 0.5% of all documents or in more than 99% of all documents

#0.99 not so good
#0.95 is chosen

# Transform to dtm (Dynamic Topic Model)
dtm_MAS <- convert(dfm_MAS, to = "topicmodels")

# ## Search tokens
# token_to_search <- "alberta"
# # Search for the token in the column names (terms)
# matching_columns <- colnames(dtm_MAS)[grep(token_to_search, colnames(dtm_MAS), ignore.case = TRUE)]
# 
# result <- dtm_MAS[, matching_columns]
# print(result)

## run LDA: experiments with different ks
# Trial 1, k = 5
MAS.model_5 <- LDA(dtm_MAS, k = 5)
terms(MAS.model_5, 20)

df_model5 <- data.frame(terms(MAS.model_5, 20))
write_xlsx(df_model5, "df_model5.xlsx")

# Trial 2, k = 20
MAS.model_20 <- LDA(dtm_MAS, k = 20)
terms(MAS.model_20, 20) 

df_model20 <- data.frame(terms(MAS.model_20, 20))
write_xlsx(df_model20, "df_model20_ver2.xlsx")
saveRDS(MAS.model_20, file = "MAS.model_20_ver2.rds")# some repetitions

# Trial 3, k = 50
MAS.model_50 <- LDA(dtm_MAS, k = 50)
terms(MAS.model_50, 20) 

# Trial 4, k = 15 
MAS.model_15 <- LDA(dtm_MAS, k = 15)
terms(MAS.model_15, 20) 
class(MAS.model_15) #LDA_VEM

## Determine k
## 15 topics is a good choice ##
library(writexl)
df_model15 <- data.frame(terms(MAS.model_15, 20))
write_xlsx(df_model15, "df_model15_ver9.xlsx")

# Save model for later analysis
saveRDS(MAS.model_15, file = "MAS.model_15_ver9.rds")

####7.3 Visualization####

# Map frequency of each top word
install.packages("tidytext")
install.packages("ggplot2")

# Load required libraries
library(tidytext)
library(ggplot2)
library(dplyr)

# Extract the top 20 words for each topic
top_words <- tidy(MAS.model_15, matrix = "beta") %>%
  group_by(topic) %>%
  top_n(20, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

top_words
top_words <- top_words %>%
  mutate(topic = ifelse(topic == "1", "1. Weather event record", topic))%>%
  mutate(topic = ifelse(topic == "2", "2. Climate science and carbon emissions", topic))%>%
  mutate(topic = ifelse(topic == "3", "3. Aviation Emissions and Climate Activism", topic))%>%
  mutate(topic = ifelse(topic == "4", "4. Climate Action and Global Climate Event", topic))%>%
  mutate(topic = ifelse(topic == "5", "5. Energy Transition and Climate Policy", topic))%>%
  mutate(topic = ifelse(topic == "6", "6. User interests", topic))%>%
  mutate(topic = ifelse(topic == "7", "7. Global Environmental Issues and Activism", topic))%>%
  mutate(topic = ifelse(topic == "8", "8. ", topic))%>%
  mutate(topic = ifelse(topic == "9", "9. Climate Activism and Social Change", topic))%>%
  mutate(topic = ifelse(topic == "10", "10. Climate Policy and Environmental Challenges in Canada", topic))%>%
  mutate(topic = ifelse(topic == "11", "11. Clean Energy and Sustainable Technologies", topic))%>%
  mutate(topic = ifelse(topic == "12", "12. Climate Change and Sociopolitical Activism", topic))%>%
  mutate(topic = ifelse(topic == "13", "13. Urgent Climate Action for Global Sustainability", topic))%>%
  mutate(topic = ifelse(topic == "14", "14. Climate Change Impact on Extreme Weather Events", topic))%>%
  mutate(topic = ifelse(topic == "15", "15. Environmental Conservation and Biodiversity Protection", topic))


# Specify 15 different R colors
topic_colors <- c("#E41A1C", "#377EB8", "#4DAF4A", "#FF7F00", "#FDBF6F", 
                  "#A65628", "#984EA3", "#999999", "#FFFF33", "#A1D99B",
                  "#8DD3C7", "#B2DF8A", "#FB9A99", "#FC8D62", "#66C2A5")

# Create the horizontal bar plot with facet_wrap
ggplot(top_words, aes(x = beta, y = reorder(term, beta), fill = factor(topic))) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~topic, scales = "free", ncol = 2) +
  scale_fill_manual(values = topic_colors) +
  labs(title = "Top 20 Words in Each Topic",
       x = "Frequency",
       y = "Term") +
  theme_minimal() +
  theme(legend.position = "none")


####8. Sentiment analysis####
####8.1 Data preparation####

# Create a dataset exclusively for sentiment analysis #

## Select necessary columns
# select id, date, uri, content_nolinks
library(dplyr)
df_D2_SA <- select(df_D0_raw, c(id, date, uri, content_nolinks, language_cld2))
colnames(df_D2_SA)[4] ="text"

## Data cleaning
# Check encoding issues
# Check "\n" as in line breaks
grepl(pattern = "\n", x = df_D2_SA$text)#but some are TRUE (e.g., row 814)
# Remove the "\n"
df_D2_SA$text <- gsub(pattern = "\n", replacement = " ", x = df_D2_SA$text)
# Confirm
grepl(pattern = "\n", x = df_D2_SA$text[814])#FALSE

# Remove encoding noises
df_D2_SA$text <- gsub("&#39;", "'", df_D2_SA$text)
df_D2_SA$text <- gsub("&amp;", "&", df_D2_SA$text)
df_D2_SA$text <- gsub("&quot;", "", df_D2_SA$text)
df_D2_SA$text <- gsub("&gt;", ">", df_D2_SA$text)
df_D2_SA$text <- gsub("&nbsp;@", "@", df_D2_SA$text)
df_D2_SA$text <- gsub("«&nbsp;", "«", df_D2_SA$text)
df_D2_SA$text <- gsub("&lt;", "<", df_D2_SA$text)
df_D2_SA$text <- gsub("&nbsp;", " ", df_D2_SA$text)

# Keep English content
df_D2_SA <- df_D2_SA[df_D2_SA$language_cld2 == "en", ]
df_D2_SA <- df_D2_SA[complete.cases(df_D2_SA$language_cld2), ]
nrow(df_D2_SA)#116,488 data entries

# Save the dataset to transfer to python
# VADER and RoBERTa model run in python
save(df_D2_SA, file = "df_D2_SA.RData")

# Sample 500 toots for human coding
senti_coding <- df_D2_SA[sample(nrow(df_D2_SA), 1000), ]
library(writexl)
write_xlsx(senti_coding, "senti_coding.xlsx")

# Compare codings from human, roberta, and VADER
# Read in data
library(readxl)
senti_coding <- read_excel("senti_result_test.xlsx")

# Confusion matrix for RoBERTa
conf_matrix_RoBERTa <- table(senti_coding$senti_human, 
                                 senti_coding$senti_roberta_label)

# Confusion matrix for VADER
conf_matrix_vader <- table(senti_coding$senti_human, 
                           senti_coding$senti_vader_label)

# Define function to calculate precision
precision <- function(conf_matrix) {
  diag(conf_matrix) / rowSums(conf_matrix)
}

# Define function to calculate recall
recall <- function(conf_matrix) {
  diag(conf_matrix) / colSums(conf_matrix)
}

# Define function to calculate F1
f1 <- function(precision, recall) {
  2 * (precision * recall) / (precision + recall)
}

# Precision, recall, F1 for RoBERTa
precision_RoBERTa <- precision(conf_matrix_RoBERTa)
recall_RoBERTa <- recall(conf_matrix_RoBERTa)
f1_RoBERTa <- f1(precision_RoBERTa, recall_RoBERTa)

# Precision, recall, F1 for VADER
precision_vader <- precision(conf_matrix_vader)
recall_vader <- recall(conf_matrix_vader)
f1_vader <- f1(precision_vader, recall_vader)

# Print results
## RoBERTa against human coding
print(precision_RoBERTa)
# -1         0         1 
# 0.7905983 0.8870968 0.8607595  
print(recall_RoBERTa)
# -1         0         1 
# 0.9685864 0.7603687 0.7472527  
print(f1_RoBERTa)
# -1         0         1 
# 0.8705882 0.8188586 0.8000000  

## VADER against human coding
print(precision_vader)
# -1         0         1 
# 0.5641026 0.4086022 0.8481013 
print(recall_vader)
# -1         0         1 
# 0.7374302 0.6551724 0.3284314
print(f1_vader)
# -1         0         1 
# 0.6392252 0.5033113 0.4734982 

## RoBERTa is better, hence it is chosen for later sentiment analysis ##
## Sentiment analysis conducted in python ## 

####8.2 Run sentiment model####
# Get result from python analysis
load("df_D2_SA_1.RData")
df_D2_SA_1 <- dataset
remove(dataset)

# Rename the label
colnames(df_D2_SA_1)[8] = "Positive"
colnames(df_D2_SA_1)[7] = "Neutral"
colnames(df_D2_SA_1)[6] = "Negative"

# Format the column date to date class
df_D2_SA_1$date <- as.Date(df_D2_SA_1$date)
class(df_D2_SA_1$date)

#### 8.3 Visualize scores over time ####

# Re-arrange data frame
library(dplyr)

df_D2_SA_1 <- df_D2_SA_1 %>%
  group_by(time = format(date, "%Y-%m")) %>%
  summarise(Negative = sum(Negative),
            Neutral = sum(Neutral),
            Positive = sum(Positive)) %>%
  ungroup()

df_D2_SA_1$time <- as.Date(paste0(df_D2_SA_1$time, "-01"))

## 8.3.1. Map the score in line graph (all time)
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(viridis)

ggplot(df_D2_SA_1, aes(x = time)) +
  geom_line(aes(y = Positive, color = "Positive")) +
  geom_line(aes(y = Negative, color = "Negative")) +
  geom_line(aes(y = Neutral, color = "Neutral")) +
  labs(title = "Scores Over Time",
       x = "Date",
       y = "Score") +
  theme_minimal()+
  scale_x_date(date_breaks = "6 months", date_labels = "%b %Y")+
  annotate(geom="text", x=as.Date("2020-05-01"), y= 650, 
           label="<- September 2019 climate strikes")+
  annotate(geom="vline", x=as.Date("2019-09-01"), xintercept = as.Date("2019-09-01"), linetype = "dashed") 
  

## 8.3.2. Map the scores as line graph after Dec 2021
df_D2_SA_subset <- df_D2_SA_1 %>% filter(time >= as.Date("2022-09-01"))

ggplot(df_D2_SA_subset, aes(x = time)) +
  geom_line(aes(y = Positive, color = "Positive")) +
  geom_line(aes(y = Negative, color = "Negative")) +
  geom_line(aes(y = Neutral, color = "Neutral")) +
  labs(title = "Scores Over Time (after December 2021)",
       x = "Date",
       y = "Score") +
  theme_minimal()+
  scale_x_date(date_breaks = "1 month", date_labels = "%b %Y")+
  annotate(geom="text", x=as.Date("2022-12-10"), y= 4800, 
           label="<- COP27 and consequential climate strikes")+
  annotate(geom="vline", x=as.Date("2022-11-01"), xintercept = as.Date("2022-11-01"), linetype = "dashed") 


## 8.3.2. Map the score in percentages
library(tidyr)
library(ggstream)
library(ggplot2)

# Use the pivot_longer function to reshape the data
SA_long <- pivot_longer(df_D2_SA_1, 
                          cols = c(Negative, Positive, Neutral), 
                          names_to = "label", 
                          values_to = "score")#all time
SA_long$score <- round(SA_long$score,5)

SA_long_subset <- pivot_longer(df_D2_SA_subset, 
                        cols = c(Negative, Positive, Neutral), 
                        names_to = "label", 
                        values_to = "score")#after Elon Musk
SA_long_subset$score <- round(SA_long_subset$score,5)


ggplot(SA_long, aes(x = time, y = score, fill = label, alpha = 0.5)) +
  geom_stream(type = "proportional") +
  scale_x_date(date_breaks = "4 months", date_labels = "%b %Y")+
  labs(title = "Sentiment scores Over Time",
       x = "Date",
       y = "Percentage")+
  guides(alpha = FALSE)

ggplot(SA_long_subset, aes(x = time, y = score, fill = label, alpha = 0.5)) +
  geom_stream(type = "proportional") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b %Y")+
  labs(title = "Sentiment scores over time after Elon Musk bought Twitter",
       x = "Date",
       y = "Percentage")+
  guides(alpha = FALSE)

####9. In-depth qualitative analysis####
## 9.1 Find the active domain from the column domain name
# Selected from df_instances

## 9.2 Find the active user from the column User name
# Extract between "https://" and "/statuses"
df_D0_raw$user <- sub("/statuses/.*$", "", df_D0_raw$uri)

# Keep user column
library(dplyr)
df_user <- select(df_D0_raw, user)

# Count which user appears how many times
df_user <- df_user %>%
  group_by(user) %>%
  mutate(count = n())%>%
  ungroup()%>%
  distinct()

# Sort by the column count
df_user <- df_user[order(df_user$count, 
                           decreasing = TRUE), ]

# Save an xlsx file for coding
library(writexl)
write_xlsx(df_user, "user_coding.xlsx")
