library(tidyverse)
library(rvest)

html <- "https://www.ebay.com/fdbk/feedback_profile/pinehurstcoins?filter=feedback_page%3ARECEIVED_AS_SELLER"
feedback <- read_html(html) %>%
  html_element(".overall-rating-summary") %>%
  html_element("table") %>%
  html_table()

#Sys.sleep(10)

#rD[["server"]]$stop()

colnames(feedback) <- c("value", "month1", "month6", "month12")
clean.feedback <- feedback %>%
  mutate(month1 = prettyNum(month1, big.mark = ",", scientific = FALSE),
         month6 = prettyNum(month6, big.mark = ",", scientific = FALSE),
         month12 = prettyNum(month12, big.mark = ",", scientific = FALSE))
colnames(clean.feedback) <- c(" ", "1 Month", "6 Month", "12 Month")

write.csv(clean.feedback, "/srv/shiny-server/execDashboard/execDashboard/data/feedback.csv", row.names = FALSE)