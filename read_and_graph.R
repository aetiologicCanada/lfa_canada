library(tidyverse)
# hand-hacked from here:
#https://www.canada.ca/en/public-health/services/diseases/2019-novel-coronavirus-infection/symptoms/testing/increased-supply.html
fieldnames=c("prov", "test", "delivered", "deployed", "used" )

infile=here::here("scraped_data_20_April.txt")
lfa_canada <-read.table(infile, header=FALSE) %>% 
  set_names(fieldnames) %>% 
  mutate(data_date = lubridate::ymd("2021-04-20"))
lfa_canada %>% group_by(prov) %>% 
  summarize(all_delivered= sum(delivered, na.rm = TRUE),
            all_deployed = sum(deployed,  na.rm = TRUE),
            all_used     = sum(used,      na.rm = TRUE)
  ) %>% 
  mutate(deployed_rate =  all_deployed/all_delivered,
         used_rate     =  all_used/all_delivered) -> lfa_summary

lfa_summary %>% ggplot + 
  geom_point(aes(x=prov, y=used_rate))

