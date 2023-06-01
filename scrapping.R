# Script to scrap google scholar
# Querry: twitter mining filetype:pdf

# load packages
library(rvest)
library(tidyverse)
library(dplyr)

# define search results URL
first_page <- "https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=twitter+data+mining+filetype%3Apdf&btnG="
# == start reading and scrapping
# read page with results first page
dta_extracted <- read_html(first_page)

# print n results
nresults <- dta_extracted %>% html_elements('.gs_ab_mdw') %>% html_text2() %>% .[2]
nresults <- str_remove_all(strsplit(nresults, " ")[[1]][2], "’")
nresults

# Title
titles <- dta_extracted %>% html_elements('.gs_rt') %>% html_text2()
titles_clean <- str_remove_all(titles, "\\[.*?\\] ")

# Authors, Journal & Year
authors_years_journal_raw <- dta_extracted %>% html_elements('.gs_a') %>% html_text2()
authors_clean <- str_match(authors_years_journal_raw, '^(.*?) \\-')[,2]
years_clean <- str_match(authors_years_journal_raw, '.*(\\d{4}).*')[,2]

# Add N cited by
ncited_by_raw <- dta_extracted %>% html_elements('.gs_fl') %>% html_text2()
ncited_by_clean <- str_match(ncited_by_raw, '(?<=Cited by )\\d*') %>% na.omit()

# Links
links <- dta_extracted %>% html_elements(".gs_or_ggsm [href]:nth-child(1)") %>% html_attr("href")

# Avoiding lenght differences between columns
length(titles_clean) <- 10
length(authors_clean) <- 10
length(years_clean) <- 10
length(ncited_by_clean) <- 10
length(links) <- 10

# Make data frame
df_fr <- data.frame(titles = titles_clean, authors = authors_clean, years = years_clean, ncitedby = ncited_by_clean, linkfiles = links,  stringsAsFactors = FALSE)

#======================Scrap next pages

# seting the variable "page" to 0 and building the URL for the next pages
URL_begin <- "https://scholar.google.com/scholar?start="
page <- 0
URL_end <- "&q=twitter+data+mining+filetype:pdf&hl=en&as_sdt=0,5"

# using a "for" loop to create the URL of each page, increase the value by 10 by 10 until it reaches 90.
for (i in 1:100) {
  page <- page + 10
  page_str <- as.character(page)
  next_page <- paste(URL_begin, page, URL_end, sep = "")
  
  
  #scraping next page
  dta_extracted <- read_html(next_page)
  
  # print n results
  nresults <- dta_extracted %>% html_elements('.gs_ab_mdw') %>% html_text2() %>% .[2]
  nresults <- str_remove_all(strsplit(nresults, " ")[[1]][2], "’")
  print(nresults)
  
  # Title
  titles <- dta_extracted %>% html_elements('.gs_rt') %>% html_text2()
  titles_clean <- str_remove_all(titles, "\\[.*?\\] ")
  
  # Authors, Journal & Year
  authors_years_journal_raw <- dta_extracted %>% html_elements('.gs_a') %>% html_text2()
  authors_clean <- str_match(authors_years_journal_raw, '^(.*?) \\-')[,2]
  years_clean <- str_match(authors_years_journal_raw, '.*(\\d{4}).*')[,2]
  
  # Add N cited by
  ncited_by_raw <- dta_extracted %>% html_elements('.gs_fl') %>% html_text2()
  ncited_by_clean <- str_match(ncited_by_raw, '(?<=Cited by )\\d*') %>% na.omit()
  
  # Links
  links <- dta_extracted %>% html_elements(".gs_or_ggsm [href]:nth-child(1)") %>% html_attr("href")
  
  # Avoiding lenght differences between columns
  length(titles_clean) <- 10
  length(authors_clean) <- 10
  length(years_clean) <- 10
  length(ncited_by_clean) <- 10
  length(links) <- 10
  
  # Make data frame
  df2 <- data.frame(titles = titles_clean, authors = authors_clean, years = years_clean, ncitedby = ncited_by_clean, linkfiles = links,  stringsAsFactors = FALSE)
  
  # combine data from both pages of search results
  df <- bind_rows(df, df2)
  
  # If the value reaches 100, we exit the loop
  if (page == 1000) {
    break
  }
}
# == Save to csv file
write_csv(df, "twitter_mining.csv")

#Import and inspect csv file
dataset <- read_csv("twitter_mining.csv")
View(dataset)


