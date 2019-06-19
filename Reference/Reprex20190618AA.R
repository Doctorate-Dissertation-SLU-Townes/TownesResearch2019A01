# reprex-data
mtcars <- structure(list(mpg = c(21, 21, 22.8, 21.4, 18.7, 18.1, 14.3, 
                                 24.4, 22.8, 19.2, 17.8, 16.4, 17.3, 15.2, 10.4, 10.4, 14.7, 32.4, 
                                 30.4, 33.9, 21.5, 15.5, 15.2, 13.3, 19.2, 27.3, 26, 30.4, 15.8, 
                                 19.7, 15, 21.4), 
                         cyl = c(6, 6, 4, 6, 8, 6, 8, 4, 4, 6, 6, 8,
                               8, 8, 8, 8, 8, 4, 4, 4, 4, 8, 8, 8, 8, 4, 4, 4, 8, 6, 8, 4), 
                         disp = c(160, 160, 108, 258, 360, 225, 360, 146.7, 140.8,
                                167.6, 167.6, 275.8, 275.8, 275.8, 472, 460, 440, 78.7, 75.7,
                                71.1, 120.1, 318, 304, 350, 400, 79, 120.3, 95.1, 351, 145, 301, 121), 
                         hp = c(110, 110, 93, 110, 175, 105, 245, 62, 95, 
                                123, 123, 180, 180, 180, 205, 215, 230, 66, 52, 65, 97, 150,
                                150, 245, 175, 66, 91, 113, 264, 175, 335, 109), 
                         drat = c(3.9, 3.9, 3.85, 3.08, 3.15, 2.76, 3.21, 3.69, 3.92, 3.92, 3.92, 
                                  3.07, 3.07, 3.07, 2.93, 3, 3.23, 4.08, 4.93, 4.22, 3.7, 2.76, 
                                  3.15, 3.73, 3.08, 4.08, 4.43, 3.77, 4.22, 3.62, 3.54, 4.11), 
                         wt = c(2.62, 2.875, 2.32, 3.215, 3.44, 3.46, 3.57, 3.19,
                                3.15, 3.44, 3.44, 4.07, 3.73, 3.78, 5.25, 5.424, 5.345, 2.2, 
                                1.615, 1.835, 2.465, 3.52, 3.435, 3.84, 3.845, 1.935, 2.14, 
                                1.513, 3.17, 2.77, 3.57, 2.78), 
                         qsec = c(16.46, 17.02, 18.61, 
                                  19.44, 17.02, 20.22, 15.84, 20, 22.9, 18.3, 18.9, 17.4, 17.6, 
                                  18, 17.98, 17.82, 17.42, 19.47, 18.52, 19.9, 20.01, 16.87, 
                                  17.3, 15.41, 17.05, 18.9, 16.7, 16.9, 14.5, 15.5, 14.6, 18.6), 
                         vs = c(0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 
                                0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1), 
                         am = c(1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 
                                0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1), 
                         gear = c(4, 4, 4, 3, 3, 3, 3, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 4, 4, 4, 3, 3, 3, 
                                  3, 3, 4, 5, 5, 5, 5, 5, 4), 
                         carb = c(4, 4, 1, 1, 2, 1, 4, 
                                  2, 2, 4, 4, 3, 3, 3, 4, 4, 4, 1, 2, 1, 1, 2, 2, 4, 2, 1, 
                                  2, 2, 4, 6, 8, 2)), 
                    row.names = c("Mazda RX4", "Mazda RX4 Wag", "Datsun 710", "Hornet 4 Drive", 
                                  "Hornet Sportabout", "Valiant", "Duster 360", "Merc 240D", 
                                  "Merc 230", "Merc 280", "Merc 280C", "Merc 450SE", 
                                  "Merc 450SL", "Merc 450SLC", "Cadillac Fleetwood", 
                                  "Lincoln Continental", "Chrysler Imperial", "Fiat 128", "Honda Civic", 
                                  "Toyota Corolla", "Toyota Corona", "Dodge Challenger", "AMC Javelin", 
                                  "Camaro Z28", "Pontiac Firebird", "Fiat X1-9", "Porsche 914-2", 
                                  "Lotus Europa", "Ford Pantera L", "Ferrari Dino", "Maserati Bora",
                                  "Volvo 142E"), class = "data.frame")

# load packages
library(tidyverse)
library(janitor)
library(naniar)

# r pipe does not work
mtcars %>%
  miss_var_summary(order = TRUE) %>%
  miss_case_summary(order = TRUE) %>%
  get_dupes(mpg) %>%
  get_dupes()

# r long form works fine
miss_var_summary(mtcars, order = TRUE)
miss_case_summary(mtcars, order = TRUE)
get_dupes(mtcars, mpg)
get_dupes(mtcars)

# r dummy variables not created properly
mtcars %>%
  mutate(gear01 = if(gear == 1) {gear01 = 1} else {gear01 = 0}) %>%
  mutate(gear02 = if(gear == 2) {gear02 = 1} else {gear02 = 0}) %>%
  mutate(gear03 = if(gear == 3) {gear03 = 1} else {gear03 = 0}) %>%
  mutate(gear04 = if(gear == 4) {gear04 = 1} else {gear04 = 0}) %>%
  mutate(gear05 = if(gear == 5) {gear05 = 1} else {gear05 = 0}) -> mtcars01
view(mtcars01)

# Session Info
R version 3.5.3 (2019-03-11)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 16299)

Matrix products: default

locale:
  [1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252   
[3] LC_MONETARY=English_United States.1252 LC_NUMERIC=C                          
[5] LC_TIME=English_United States.1252    

attached base packages:
  [1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
  [1] janitor_1.2.0   naniar_0.4.2    forcats_0.4.0   stringr_1.4.0   dplyr_0.8.1    
[6] purrr_0.3.2     readr_1.3.1     tidyr_0.8.3     tibble_2.1.1    ggplot2_3.1.1  
[11] tidyverse_1.2.1

loaded via a namespace (and not attached):
  [1] Rcpp_1.0.1       pillar_1.4.1     compiler_3.5.3   cellranger_1.1.0
[5] plyr_1.8.4       tools_3.5.3      zeallot_0.1.0    jsonlite_1.6    
[9] lubridate_1.7.4  nlme_3.1-137     gtable_0.3.0     lattice_0.20-38 
[13] pkgconfig_2.0.2  rlang_0.3.4      cli_1.1.0        rstudioapi_0.10 
[17] haven_2.1.0      withr_2.1.2      xml2_1.2.0       httr_1.4.0      
[21] vctrs_0.1.0      generics_0.0.2   hms_0.4.2        grid_3.5.3      
[25] tidyselect_0.2.5 glue_1.3.1       R6_2.4.0         fansi_0.4.0     
[29] readxl_1.3.1     modelr_0.1.4     magrittr_1.5     scales_1.0.0    
[33] backports_1.1.4  visdat_0.5.3     rvest_0.3.4      assertthat_0.2.1
[37] colorspace_1.4-1 utf8_1.1.4       stringi_1.4.3    lazyeval_0.2.2  
[41] munsell_0.5.0    broom_0.5.2      crayon_1.3.4   