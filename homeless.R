


library(tidyverse)
library(janitor)
library(here)
library(scales)
library(ggthemes)
library(MCOE)

con <- mcoe_sql_con()




homeless <- tbl(con, "HOMELESS") %>%
    # filter(
    #     County_Code %in% c("00", "27"),
    #     District_Code == "00000",
    #     Grade == 13
    # ) %>%
    # #  head(100) %>%
    collect()


homeless.mry <- homeless %>%
    filter(county_code %in% c("00","27"))



homeless.dist <- homeless.mry %>%
    filter(aggregate_level == "D",
           charter_school == "No",
           reporting_category == "TA",
           dass == "All",
           academic_year == max(academic_year)) %>%
    mutate(homeless_percent = homeless_student_enrollment/cumulative_enrollment)
