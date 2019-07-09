R Notebook: Improving Construct Validity in Studies of Technology
Transfer
================
Malcolm S. Townes
(July 09, 2019)

## Introduction

This is an R Notebook for an investigation of improving construct
validity in studies of technology transfer.

## Project Set Up

The following code chunk enables the R Notebook to integrate seemlessly
with the project organization format. This is normally included in the R
Notebook to simplify file calls and enable file portability but it has
been causing an error. Per Dr. Christopher Prener of Saint Louis
University, the error is generated because the `here::here()` function
has not been tested with certain combinations of functions. To work
around this problem, I’ve embedded the `here()` function where I enter a
file path when necessary.

## Load Dependencies

The following code chunk loads package dependencies required to perform
the necessary tasks. Basic tasks include importing, reading, wrangling,
and cleaning data; selecting a subset of the data; checking for unique
observations, and analyzing missing
    data.

    ## -- Attaching packages ------------------------------------------- tidyverse 1.2.1 --

    ## v ggplot2 3.1.1     v purrr   0.3.2
    ## v tibble  2.1.1     v dplyr   0.8.1
    ## v tidyr   0.8.3     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.4.0

    ## -- Conflicts ---------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

    ## here() starts at D:/TownesResearch2019A01

    ## 
    ## Attaching package: 'janitor'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     chisq.test, fisher.test

    ## 
    ## Attaching package: 'ordinal'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     slice

    ## 
    ## Attaching package: 'MASS'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     select

    ## Loading required package: zoo

    ## 
    ## Attaching package: 'zoo'

    ## The following objects are masked from 'package:base':
    ## 
    ##     as.Date, as.Date.numeric

    ## Loading required package: carData

    ## 
    ## Attaching package: 'car'

    ## The following object is masked from 'package:boot':
    ## 
    ##     logit

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     recode

    ## The following object is masked from 'package:purrr':
    ## 
    ##     some

    ## Classes and Methods for R developed in the
    ## Political Science Computational Laboratory
    ## Department of Political Science
    ## Stanford University
    ## Simon Jackman
    ## hurdle and zeroinfl functions by Achim Zeileis

    ## ResourceSelection 0.3-4   2019-01-08

## Load Raw Data

The following code chunk imports the raw data from the `txt` file for
the NBER data set for the period 1963 to 1999.

## Subset Data

The following code chunk creates a subset of the data for the period
1990 through 1995.

## Sample Data

The following code chunk takes a sample of 2,000 cases from the data
subset for the period 1990 through 1995.

## Clean Data Phase 1

The following code chunk reorganizes the variables and eliminates
variables not used in the analysis.

## Inspect Sample Data

The following code chunk evaluates the data sample to determine if
additional data cleaning is necessary. It first checks for missing data
for each variable. It then checks for missing data for each variable in
each case. Then it checks for duplicate cases with the `PATENT` variable
to determine if that variable can be used as a unique identifier for
each case. Finally, it checks for duplicate cases across all variables
to ensure that each case is unique.

    ## # A tibble: 10 x 3
    ##    variable n_miss pct_miss
    ##    <chr>     <int>    <dbl>
    ##  1 GENERAL     327     16.4
    ##  2 FWDAPLAG    327     16.4
    ##  3 ORIGINAL     48      2.4
    ##  4 BCKGTLAG     34      1.7
    ##  5 PATENT        0      0  
    ##  6 GYEAR         0      0  
    ##  7 CRECEIVE      0      0  
    ##  8 CAT           0      0  
    ##  9 CLAIMS        0      0  
    ## 10 CMADE         0      0

    ## # A tibble: 2,000 x 3
    ##     case n_miss pct_miss
    ##    <int>  <int>    <dbl>
    ##  1   346      4       40
    ##  2   516      4       40
    ##  3   590      4       40
    ##  4  1176      4       40
    ##  5  1224      4       40
    ##  6  1470      4       40
    ##  7  1664      4       40
    ##  8  1792      4       40
    ##  9  1111      3       30
    ## 10  1337      3       30
    ## # ... with 1,990 more rows

    ## # A tibble: 4 x 11
    ##   PATENT dupe_count GYEAR CRECEIVE   CAT CLAIMS CMADE GENERAL ORIGINAL
    ##    <int>      <int> <int>    <int> <int>  <int> <int>   <dbl>    <dbl>
    ## 1 4.99e6          2  1991        0     1     15     9      NA    0.370
    ## 2 4.99e6          2  1991        0     1     15     9      NA    0.370
    ## 3 5.30e6          2  1994        0     1      2     6      NA    0.278
    ## 4 5.30e6          2  1994        0     1      2     6      NA    0.278
    ## # ... with 2 more variables: FWDAPLAG <dbl>, BCKGTLAG <dbl>

    ## No variable names specified - using all columns.

    ## # A tibble: 4 x 11
    ##   PATENT GYEAR CRECEIVE   CAT CLAIMS CMADE GENERAL ORIGINAL FWDAPLAG
    ##    <int> <int>    <int> <int>  <int> <int>   <dbl>    <dbl>    <dbl>
    ## 1 4.99e6  1991        0     1     15     9      NA    0.370       NA
    ## 2 4.99e6  1991        0     1     15     9      NA    0.370       NA
    ## 3 5.30e6  1994        0     1      2     6      NA    0.278       NA
    ## 4 5.30e6  1994        0     1      2     6      NA    0.278       NA
    ## # ... with 2 more variables: BCKGTLAG <dbl>, dupe_count <int>

## Adjust for Missing Data

The following code chunk modifies cases with missing data, removes
duplicate cases, and then evaluates the data sample to determine if
additional cleaning is necessary. It first assigns a value of `0` to
instances of `NA` in the data for the `GENERAL` variable. It then
assigns a value of `1` to instances of `NA` in the data for the
`ORIGINAL` variable. For the `FWDAPLAG` and `BCKGTLAG` variables it
assigns the maximum value in the data for each variable to instances of
missing data. It then removes duplicate cases. The code chunk then
checks for missing data for each variable in each case and missing data
for each case. Then it checks for duplicate cases with the `PATENT`
variable to determine if that variable can be used as a unique
identifier for each observation. Finally, it checks for duplicate
observations across all variables to ensure that each case is unique.

    ## # A tibble: 10 x 3
    ##    variable n_miss pct_miss
    ##    <chr>     <int>    <dbl>
    ##  1 PATENT        0        0
    ##  2 GYEAR         0        0
    ##  3 CRECEIVE      0        0
    ##  4 CAT           0        0
    ##  5 CLAIMS        0        0
    ##  6 CMADE         0        0
    ##  7 GENERAL       0        0
    ##  8 ORIGINAL      0        0
    ##  9 FWDAPLAG      0        0
    ## 10 BCKGTLAG      0        0

    ## # A tibble: 1,998 x 3
    ##     case n_miss pct_miss
    ##    <int>  <int>    <dbl>
    ##  1     1      0        0
    ##  2     2      0        0
    ##  3     3      0        0
    ##  4     4      0        0
    ##  5     5      0        0
    ##  6     6      0        0
    ##  7     7      0        0
    ##  8     8      0        0
    ##  9     9      0        0
    ## 10    10      0        0
    ## # ... with 1,988 more rows

    ## No duplicate combinations found of: PATENT

    ## # A tibble: 0 x 11
    ## # ... with 11 variables: PATENT <int>, dupe_count <int>, GYEAR <int>,
    ## #   CRECEIVE <int>, CAT <int>, CLAIMS <int>, CMADE <int>, GENERAL <dbl>,
    ## #   ORIGINAL <dbl>, FWDAPLAG <dbl>, BCKGTLAG <dbl>

    ## No variable names specified - using all columns.

    ## No duplicate combinations found of: PATENT, GYEAR, CRECEIVE, CAT, CLAIMS, CMADE, GENERAL, ORIGINAL, FWDAPLAG, BCKGTLAG

    ## # A tibble: 0 x 11
    ## # ... with 11 variables: PATENT <int>, GYEAR <int>, CRECEIVE <int>,
    ## #   CAT <int>, CLAIMS <int>, CMADE <int>, GENERAL <dbl>, ORIGINAL <dbl>,
    ## #   FWDAPLAG <dbl>, BCKGTLAG <dbl>, dupe_count <int>

## Central Tendency

The following code chunk calculates measures of central tendency in the
sample data for each of the
    variables.

    ##      PATENT            GYEAR         CRECEIVE           CAT       
    ##  Min.   :4890423   Min.   :1990   Min.   : 0.000   Min.   :1.000  
    ##  1st Qu.:5034806   1st Qu.:1991   1st Qu.: 1.000   1st Qu.:2.000  
    ##  Median :5185746   Median :1993   Median : 3.000   Median :4.000  
    ##  Mean   :5184975   Mean   :1993   Mean   : 4.952   Mean   :3.725  
    ##  3rd Qu.:5336132   3rd Qu.:1994   3rd Qu.: 6.000   3rd Qu.:5.000  
    ##  Max.   :5479597   Max.   :1995   Max.   :99.000   Max.   :6.000  
    ##      CLAIMS           CMADE            GENERAL          ORIGINAL     
    ##  Min.   :  1.00   Min.   :  0.000   Min.   :0.0000   Min.   :0.0000  
    ##  1st Qu.:  6.00   1st Qu.:  4.000   1st Qu.:0.0000   1st Qu.:0.0000  
    ##  Median : 10.00   Median :  7.000   Median :0.0907   Median :0.4444  
    ##  Mean   : 12.69   Mean   :  8.398   Mean   :0.2578   Mean   :0.3828  
    ##  3rd Qu.: 17.00   3rd Qu.: 11.000   3rd Qu.:0.5000   3rd Qu.:0.6250  
    ##  Max.   :101.00   Max.   :158.000   Max.   :0.8800   Max.   :1.0000  
    ##     FWDAPLAG         BCKGTLAG    
    ##  Min.   : 0.000   Min.   : 0.00  
    ##  1st Qu.: 3.000   1st Qu.: 6.50  
    ##  Median : 4.000   Median :10.75  
    ##  Mean   : 4.959   Mean   :15.13  
    ##  3rd Qu.: 6.000   3rd Qu.:18.50  
    ##  Max.   :10.500   Max.   :85.14

## Histograms

The following code chunk displays histograms for the variables of
primary interest to enable visual inspection of the data to evaluate
whether or not they fit normal
    distributions.

    ## Saving 7 x 5 in image

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Saving 7 x 5 in image

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Saving 7 x 5 in image

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Saving 7 x 5 in image

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Saving 7 x 5 in image

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Saving 7 x 5 in image

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Saving 7 x 5 in image

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Saving 7 x 5 in image

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Saving 7 x 5 in image

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

## Scatter Plots

The following code chunk displays scatter plots with `CRECEIVE` as the
dependent variable against each of the the primary independent variables
of interest to visually inspect for linear relationships between the
dependent variable and each of the independent variables.
![](TownesResearch2019A01_files/figure-gfm/scatter-plots-1.png)<!-- -->

    ## Saving 7 x 5 in image

![](TownesResearch2019A01_files/figure-gfm/scatter-plots-2.png)<!-- -->

    ## Saving 7 x 5 in image

![](TownesResearch2019A01_files/figure-gfm/scatter-plots-3.png)<!-- -->

    ## Saving 7 x 5 in image

![](TownesResearch2019A01_files/figure-gfm/scatter-plots-4.png)<!-- -->

    ## Saving 7 x 5 in image

![](TownesResearch2019A01_files/figure-gfm/scatter-plots-5.png)<!-- -->

    ## Saving 7 x 5 in image

![](TownesResearch2019A01_files/figure-gfm/scatter-plots-6.png)<!-- -->

    ## Saving 7 x 5 in image

![](TownesResearch2019A01_files/figure-gfm/scatter-plots-7.png)<!-- -->

    ## Saving 7 x 5 in image

![](TownesResearch2019A01_files/figure-gfm/scatter-plots-8.png)<!-- -->

    ## Saving 7 x 5 in image

## Q-Q Plots

The following code chunk displays Quantile-Quantile (Q-Q) plots to check
for normal distribution in the data sample for each variable of primary
interest.

    ## png 
    ##   2

    ## png 
    ##   2

    ## png 
    ##   2

    ## png 
    ##   2

    ## png 
    ##   2

    ## png 
    ##   2

    ## png 
    ##   2

    ## png 
    ##   2

## Pairwise Correlation Coefficients

The following code chunk calculates the pairwise correlation
coefficients for all variables in the sample data using the Pearson
product-moment correlation function.

    ## [1] Correlation Coefficients

## Clean Data 2

The following code chunk creates additional variables needed for the
binary logistic regression, ordinal logistic regression, and multiple
regression analyses and removes variables that will not be used. It
first creates a new variable called `CRECbinary` that converts the
`CRECEIVE` variable into a dichotomous variable. It then creates a
series of dummy variables for the nominal `CAT` variable to use in
multiple regression analysis.

## Observation Counts 1

The following code chunk determines the number of observations for each
outcome of each nominal and ordinal independent variable to determine if
the sample size is large enough for logistic regression analysis, which
requires at least 10 observations for the least frequent outcome for
each independent
    variable.

    ## [1] Count Observations for Each Outcome of Each Nominal and Ordinal Variable

    ## # A tibble: 6 x 2
    ##   GYEAR `n()`
    ##   <int> <int>
    ## 1  1990   301
    ## 2  1991   339
    ## 3  1992   331
    ## 4  1993   332
    ## 5  1994   347
    ## 6  1995   348

    ## # A tibble: 48 x 2
    ##    CRECEIVE `n()`
    ##       <int> <int>
    ##  1        0   325
    ##  2        1   307
    ##  3        2   265
    ##  4        3   234
    ##  5        4   172
    ##  6        5   142
    ##  7        6    98
    ##  8        7    73
    ##  9        8    60
    ## 10        9    44
    ## # ... with 38 more rows

    ## # A tibble: 2 x 2
    ##   CRECbinary `n()`
    ##        <dbl> <int>
    ## 1          0   325
    ## 2          1  1673

    ## # A tibble: 6 x 2
    ##     CAT `n()`
    ##   <int> <int>
    ## 1     1   380
    ## 2     2   207
    ## 3     3   211
    ## 4     4   376
    ## 5     5   432
    ## 6     6   392

    ## # A tibble: 2 x 2
    ##   CAT01 `n()`
    ##   <dbl> <int>
    ## 1     0  1618
    ## 2     1   380

    ## # A tibble: 2 x 2
    ##   CAT02 `n()`
    ##   <dbl> <int>
    ## 1     0  1791
    ## 2     1   207

    ## # A tibble: 2 x 2
    ##   CAT03 `n()`
    ##   <dbl> <int>
    ## 1     0  1787
    ## 2     1   211

    ## # A tibble: 2 x 2
    ##   CAT04 `n()`
    ##   <dbl> <int>
    ## 1     0  1622
    ## 2     1   376

    ## # A tibble: 2 x 2
    ##   CAT05 `n()`
    ##   <dbl> <int>
    ## 1     0  1566
    ## 2     1   432

    ## # A tibble: 2 x 2
    ##   CAT06 `n()`
    ##   <dbl> <int>
    ## 1     0  1606
    ## 2     1   392

    ## # A tibble: 57 x 2
    ##    CLAIMS `n()`
    ##     <int> <int>
    ##  1      1    46
    ##  2      2    55
    ##  3      3   101
    ##  4      4   107
    ##  5      5   117
    ##  6      6   123
    ##  7      7   112
    ##  8      8   133
    ##  9      9   113
    ## 10     10   107
    ## # ... with 47 more rows

    ## # A tibble: 49 x 2
    ##    CMADE `n()`
    ##    <int> <int>
    ##  1     0    34
    ##  2     1   108
    ##  3     2   159
    ##  4     3   182
    ##  5     4   179
    ##  6     5   175
    ##  7     6   152
    ##  8     7   151
    ##  9     8   131
    ## 10     9   118
    ## # ... with 39 more rows

## Clean Data 3

The following code chunk groups cases where the outcome level for
`CRECEIVE` is greater than or equal to 15 citations cases for the
logistic regression analysis because most of those outcome levels do not
have enough cases individually for logistic regression analysis which
requires at least 10 cases for the least frequent outcome level of each
independent variable.

## Observation Counts 2

The following code chunk re-checks the number of observations for each
outcome level of each nominal and ordinal independent variable to
determine if the sample size is large enough for logistic regression
analysis, which requires at least 10 observations for the least frequent
outcome for each independent
    variable.

    ## [1] Count Observations for Each Outcome of Each Nominal and Ordinal Variable

    ## # A tibble: 6 x 2
    ##   GYEAR `n()`
    ##   <int> <int>
    ## 1  1990   301
    ## 2  1991   339
    ## 3  1992   331
    ## 4  1993   332
    ## 5  1994   347
    ## 6  1995   348

    ## # A tibble: 48 x 2
    ##    CRECEIVE `n()`
    ##       <int> <int>
    ##  1        0   325
    ##  2        1   307
    ##  3        2   265
    ##  4        3   234
    ##  5        4   172
    ##  6        5   142
    ##  7        6    98
    ##  8        7    73
    ##  9        8    60
    ## 10        9    44
    ## # ... with 38 more rows

    ## # A tibble: 2 x 2
    ##   CRECbinary `n()`
    ##        <dbl> <int>
    ## 1          0   325
    ## 2          1  1673

    ## # A tibble: 16 x 2
    ##    CRECordinal `n()`
    ##          <dbl> <int>
    ##  1           0   325
    ##  2           1   307
    ##  3           2   265
    ##  4           3   234
    ##  5           4   172
    ##  6           5   142
    ##  7           6    98
    ##  8           7    73
    ##  9           8    60
    ## 10           9    44
    ## 11          10    43
    ## 12          11    33
    ## 13          12    26
    ## 14          13    18
    ## 15          14    19
    ## 16          15   139

    ## # A tibble: 6 x 2
    ##     CAT `n()`
    ##   <int> <int>
    ## 1     1   380
    ## 2     2   207
    ## 3     3   211
    ## 4     4   376
    ## 5     5   432
    ## 6     6   392

    ## # A tibble: 2 x 2
    ##   CAT01 `n()`
    ##   <dbl> <int>
    ## 1     0  1618
    ## 2     1   380

    ## # A tibble: 2 x 2
    ##   CAT02 `n()`
    ##   <dbl> <int>
    ## 1     0  1791
    ## 2     1   207

    ## # A tibble: 2 x 2
    ##   CAT03 `n()`
    ##   <dbl> <int>
    ## 1     0  1787
    ## 2     1   211

    ## # A tibble: 2 x 2
    ##   CAT04 `n()`
    ##   <dbl> <int>
    ## 1     0  1622
    ## 2     1   376

    ## # A tibble: 2 x 2
    ##   CAT05 `n()`
    ##   <dbl> <int>
    ## 1     0  1566
    ## 2     1   432

    ## # A tibble: 2 x 2
    ##   CAT06 `n()`
    ##   <dbl> <int>
    ## 1     0  1606
    ## 2     1   392

    ## # A tibble: 57 x 2
    ##    CLAIMS `n()`
    ##     <int> <int>
    ##  1      1    46
    ##  2      2    55
    ##  3      3   101
    ##  4      4   107
    ##  5      5   117
    ##  6      6   123
    ##  7      7   112
    ##  8      8   133
    ##  9      9   113
    ## 10     10   107
    ## # ... with 47 more rows

    ## # A tibble: 49 x 2
    ##    CMADE `n()`
    ##    <int> <int>
    ##  1     0    34
    ##  2     1   108
    ##  3     2   159
    ##  4     3   182
    ##  5     4   179
    ##  6     5   175
    ##  7     6   152
    ##  8     7   151
    ##  9     8   131
    ## 10     9   118
    ## # ... with 39 more rows

## Binary Logistic Regression Analysis

The following code chunk uses the new dichotomous variable
`CRECbinomial` as the dependent variable in the binary logistic
regression. It then displays the results.

    ## 
    ## Call:
    ## glm(formula = CRECbinary ~ GYEAR + as.factor(CAT) + CMADE + CLAIMS + 
    ##     ORIGINAL + GENERAL + FWDAPLAG + BCKGTLAG, family = binomial, 
    ##     data = Sample90to95C, na.action = na.omit)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.3879   0.0000   0.0000   0.0000   2.6810  
    ## 
    ## Coefficients:
    ##                   Estimate Std. Error z value Pr(>|z|)
    ## (Intercept)      1.862e+01  4.195e+04   0.000    1.000
    ## GYEAR            3.122e-01  8.802e-01   0.355    0.723
    ## as.factor(CAT)2  5.187e+01  2.259e+05   0.000    1.000
    ## as.factor(CAT)3  5.759e+01  3.690e+04   0.002    0.999
    ## as.factor(CAT)4  7.629e+01  3.578e+04   0.002    0.998
    ## as.factor(CAT)5  1.854e+01  4.344e+04   0.000    1.000
    ## as.factor(CAT)6  6.174e+01  3.574e+04   0.002    0.999
    ## CMADE           -1.979e-02  1.877e-01  -0.105    0.916
    ## CLAIMS          -2.364e-02  1.741e-01  -0.136    0.892
    ## ORIGINAL         2.192e+00  4.565e+00   0.480    0.631
    ## GENERAL          7.098e+01  3.623e+04   0.002    0.998
    ## FWDAPLAG        -6.876e+01  2.461e+03  -0.028    0.978
    ## BCKGTLAG         2.785e-03  5.399e-02   0.052    0.959
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 1774.459  on 1997  degrees of freedom
    ## Residual deviance:    9.167  on 1985  degrees of freedom
    ## AIC: 35.167
    ## 
    ## Number of Fisher Scoring iterations: 25

    ## [1] Raise e to the Coefficients

    ##     (Intercept)           GYEAR as.factor(CAT)2 as.factor(CAT)3 
    ##    1.222174e+08    1.366461e+00    3.365555e+22    1.023373e+25 
    ## as.factor(CAT)4 as.factor(CAT)5 as.factor(CAT)6           CMADE 
    ##    1.358901e+33    1.129561e+08    6.530469e+26    9.804027e-01 
    ##          CLAIMS        ORIGINAL         GENERAL        FWDAPLAG 
    ##    9.766327e-01    8.956214e+00    6.686125e+30    1.375684e-30 
    ##        BCKGTLAG 
    ##    1.002789e+00

    ## [1] Obtain the McFadden Pseudo R-squared

    ##          llh      llhNull           G2     McFadden         r2ML 
    ##   -4.5834781 -887.2297285 1765.2925008    0.9948339    0.5866786 
    ##         r2CU 
    ##    0.9967854

    ## [1] Confidence Intervals for the Coefficients

    ## Waiting for profiling to be done...

    ##                         2.5 %        97.5 %
    ## (Intercept)     -1.826634e+03  1863.8768502
    ## GYEAR           -1.172910e+00     3.1238384
    ## as.factor(CAT)2 -1.318477e+04 12167.4434610
    ## as.factor(CAT)3 -1.931872e+03  1946.4876791
    ## as.factor(CAT)4 -1.497483e+03  1650.0673202
    ## as.factor(CAT)5 -1.713920e+03  2004.7750073
    ## as.factor(CAT)6 -1.609277e+03  1805.9906612
    ## CMADE           -6.494402e-01     0.2746325
    ## CLAIMS          -5.800099e-01     0.2256378
    ## ORIGINAL        -6.365958e+00    14.7947578
    ## GENERAL         -1.362734e+03  1526.2734452
    ## FWDAPLAG        -5.237472e+02 -1119.5494180
    ## BCKGTLAG        -1.688275e-01     0.1194676

    ## [1] Hosemer-Lemeshow Goodness of Fit Test

    ##           Length Class  Mode     
    ## statistic 1      -none- numeric  
    ## parameter 1      -none- numeric  
    ## p.value   1      -none- numeric  
    ## method    1      -none- character
    ## data.name 1      -none- character
    ## observed  4      xtabs  numeric  
    ## expected  4      xtabs  numeric

    ##                     yhat0        yhat1  y0   y1
    ## [2.22e-16,1.25e-10]   200 1.148984e-09 200    0
    ## (1.25e-10,1]          125 1.673000e+03 125 1673

## Ordinal Logistic Regression Analysis

The following code chunk performs an ordinal logistic regression
analysis on the data sample using `CRECEIVE` as the dependent variable.
It then displays the results. It performs the analysis two different
ways for comparison.

    ## [1] Ordinal Logistic Regression Method 01

    ## formula: 
    ## as.factor(CRECordinal) ~ GYEAR + as.factor(CAT) + CMADE + CLAIMS + ORIGINAL + GENERAL + FWDAPLAG + BCKGTLAG
    ## data:    Sample90to95C
    ## 
    ##  link  threshold nobs logLik   AIC     niter max.grad cond.H 
    ##  logit flexible  1998 -3952.10 7958.20 7(2)  4.51e-07 9.9e+13
    ## 
    ## Coefficients:
    ##                  Estimate Std. Error z value Pr(>|z|)    
    ## GYEAR           -0.365924   0.026953 -13.577  < 2e-16 ***
    ## as.factor(CAT)2  0.942450   0.163457   5.766 8.13e-09 ***
    ## as.factor(CAT)3  0.928549   0.164576   5.642 1.68e-08 ***
    ## as.factor(CAT)4  0.493043   0.136760   3.605 0.000312 ***
    ## as.factor(CAT)5  0.034448   0.134614   0.256 0.798027    
    ## as.factor(CAT)6  0.297271   0.135203   2.199 0.027899 *  
    ## CMADE            0.024240   0.005091   4.761 1.92e-06 ***
    ## CLAIMS           0.017572   0.004548   3.864 0.000112 ***
    ## ORIGINAL        -0.852045   0.157334  -5.416 6.11e-08 ***
    ## GENERAL          4.644408   0.185912  24.982  < 2e-16 ***
    ## FWDAPLAG        -0.488523   0.021583 -22.634  < 2e-16 ***
    ## BCKGTLAG        -0.006676   0.003265  -2.044 0.040926 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Threshold coefficients:
    ##       Estimate Std. Error z value
    ## 0|1    -733.01      53.75  -13.64
    ## 1|2    -730.94      53.73  -13.60
    ## 2|3    -729.88      53.73  -13.59
    ## 3|4    -729.10      53.73  -13.57
    ## 4|5    -728.54      53.72  -13.56
    ## 5|6    -728.07      53.72  -13.55
    ## 6|7    -727.72      53.72  -13.55
    ## 7|8    -727.43      53.72  -13.54
    ## 8|9    -727.17      53.72  -13.54
    ## 9|10   -726.95      53.72  -13.53
    ## 10|11  -726.72      53.72  -13.53
    ## 11|12  -726.52      53.72  -13.53
    ## 12|13  -726.34      53.72  -13.52
    ## 13|14  -726.21      53.72  -13.52
    ## 14|15  -726.05      53.71  -13.52

    ## [1] "Ordinal Logistic Regression Method 02"

    ## Call:
    ## polr(formula = as.factor(CRECordinal) ~ GYEAR + as.factor(CAT) + 
    ##     CMADE + CLAIMS + ORIGINAL + GENERAL + FWDAPLAG + BCKGTLAG, 
    ##     data = Sample90to95C, Hess = TRUE, model = TRUE, method = "logistic")
    ## 
    ## Coefficients:
    ##                     Value Std. Error    t value
    ## GYEAR           -0.365915  9.756e-05 -3750.5274
    ## as.factor(CAT)2  0.942448  1.115e-01     8.4527
    ## as.factor(CAT)3  0.928546  1.095e-01     8.4802
    ## as.factor(CAT)4  0.493042  9.072e-02     5.4347
    ## as.factor(CAT)5  0.034456  8.924e-02     0.3861
    ## as.factor(CAT)6  0.297260  9.029e-02     3.2922
    ## CMADE            0.024240  5.009e-03     4.8389
    ## CLAIMS           0.017572  4.546e-03     3.8649
    ## ORIGINAL        -0.852066  1.236e-01    -6.8949
    ## GENERAL          4.644389  6.795e-02    68.3507
    ## FWDAPLAG        -0.488513  2.004e-02   -24.3722
    ## BCKGTLAG        -0.006675  3.241e-03    -2.0599
    ## 
    ## Intercepts:
    ##       Value        Std. Error   t value     
    ## 0|1      -732.9911       0.0020 -369549.4531
    ## 1|2      -730.9229       0.1050   -6958.2905
    ## 2|3      -729.8599       0.1114   -6549.0132
    ## 3|4      -729.0789       0.1144   -6373.8457
    ## 4|5      -728.5245       0.1166   -6248.4878
    ## 5|6      -728.0492       0.1189   -6122.7410
    ## 6|7      -727.6995       0.1209   -6018.6841
    ## 7|8      -727.4124       0.1228   -5922.1601
    ## 8|9      -727.1485       0.1249   -5823.4243
    ## 9|10     -726.9330       0.1265   -5745.7368
    ## 10|11    -726.6987       0.1287   -5644.7307
    ## 11|12    -726.4988       0.1303   -5575.8923
    ## 12|13    -726.3228       0.1312   -5537.6347
    ## 13|14    -726.1877       0.1315   -5524.3396
    ## 14|15    -726.0301       0.1318   -5508.7824
    ## 
    ## Residual Deviance: 7904.203 
    ## AIC: 7958.203

    ## [1] "Ordinal Logistic Regression with P-values"

    ##                         Value   Std. Error       t value p values (t dist)
    ## GYEAR           -3.659147e-01 9.756353e-05 -3.750527e+03           0.00000
    ## as.factor(CAT)2  9.424477e-01 1.114961e-01  8.452738e+00           0.00000
    ## as.factor(CAT)3  9.285464e-01 1.094952e-01  8.480247e+00           0.00000
    ## as.factor(CAT)4  4.930423e-01 9.072128e-02  5.434693e+00           0.00000
    ## as.factor(CAT)5  3.445585e-02 8.923836e-02  3.861103e-01           0.69946
    ## as.factor(CAT)6  2.972598e-01 9.029238e-02  3.292191e+00           0.00101
    ## CMADE            2.424001e-02 5.009381e-03  4.838924e+00           0.00000
    ## CLAIMS           1.757160e-02 4.546481e-03  3.864879e+00           0.00011
    ## ORIGINAL        -8.520660e-01 1.235786e-01 -6.894933e+00           0.00000
    ## GENERAL          4.644389e+00 6.794942e-02  6.835069e+01           0.00000
    ## FWDAPLAG        -4.885132e-01 2.004388e-02 -2.437219e+01           0.00000
    ## BCKGTLAG        -6.675213e-03 3.240554e-03 -2.059899e+00           0.03954
    ## 0|1             -7.329911e+02 1.983472e-03 -3.695495e+05           0.00000
    ## 1|2             -7.309229e+02 1.050435e-01 -6.958291e+03           0.00000
    ## 2|3             -7.298599e+02 1.114458e-01 -6.549013e+03           0.00000
    ## 3|4             -7.290789e+02 1.143860e-01 -6.373846e+03           0.00000
    ## 4|5             -7.285245e+02 1.165921e-01 -6.248488e+03           0.00000
    ## 5|6             -7.280492e+02 1.189090e-01 -6.122741e+03           0.00000
    ## 6|7             -7.276995e+02 1.209067e-01 -6.018684e+03           0.00000
    ## 7|8             -7.274124e+02 1.228289e-01 -5.922160e+03           0.00000
    ## 8|9             -7.271485e+02 1.248661e-01 -5.823424e+03           0.00000
    ## 9|10            -7.269330e+02 1.265169e-01 -5.745737e+03           0.00000
    ## 10|11           -7.266987e+02 1.287393e-01 -5.644731e+03           0.00000
    ## 11|12           -7.264988e+02 1.302928e-01 -5.575892e+03           0.00000
    ## 12|13           -7.263228e+02 1.311612e-01 -5.537635e+03           0.00000
    ## 13|14           -7.261877e+02 1.314524e-01 -5.524340e+03           0.00000
    ## 14|15           -7.260301e+02 1.317950e-01 -5.508782e+03           0.00000
    ##                 p values (Normal)
    ## GYEAR                     0.00000
    ## as.factor(CAT)2           0.00000
    ## as.factor(CAT)3           0.00000
    ## as.factor(CAT)4           0.00000
    ## as.factor(CAT)5           0.69942
    ## as.factor(CAT)6           0.00099
    ## CMADE                     0.00000
    ## CLAIMS                    0.00011
    ## ORIGINAL                  0.00000
    ## GENERAL                   0.00000
    ## FWDAPLAG                  0.00000
    ## BCKGTLAG                  0.03941
    ## 0|1                       0.00000
    ## 1|2                       0.00000
    ## 2|3                       0.00000
    ## 3|4                       0.00000
    ## 4|5                       0.00000
    ## 5|6                       0.00000
    ## 6|7                       0.00000
    ## 7|8                       0.00000
    ## 8|9                       0.00000
    ## 9|10                      0.00000
    ## 10|11                     0.00000
    ## 11|12                     0.00000
    ## 12|13                     0.00000
    ## 13|14                     0.00000
    ## 14|15                     0.00000

## Multiple Regression Model Selection

The following code chunk performs regressions using the sequential
replacement method with `CRECEIVE` as the dependent variable and subsets
of the independent variables. It then displays the summary statistics to
enable identification of the best regression model.

    ## Subset selection object
    ## Call: regsubsets.formula(CRECEIVE ~ GYEAR + as.factor(CAT) + CMADE + 
    ##     CLAIMS + ORIGINAL + GENERAL + FWDAPLAG + BCKGTLAG, data = Sample90to95C, 
    ##     nbest = 2, method = "exhaustive")
    ## 12 Variables  (and intercept)
    ##                 Forced in Forced out
    ## GYEAR               FALSE      FALSE
    ## as.factor(CAT)2     FALSE      FALSE
    ## as.factor(CAT)3     FALSE      FALSE
    ## as.factor(CAT)4     FALSE      FALSE
    ## as.factor(CAT)5     FALSE      FALSE
    ## as.factor(CAT)6     FALSE      FALSE
    ## CMADE               FALSE      FALSE
    ## CLAIMS              FALSE      FALSE
    ## ORIGINAL            FALSE      FALSE
    ## GENERAL             FALSE      FALSE
    ## FWDAPLAG            FALSE      FALSE
    ## BCKGTLAG            FALSE      FALSE
    ## 2 subsets of each size up to 8
    ## Selection Algorithm: exhaustive
    ##          GYEAR as.factor(CAT)2 as.factor(CAT)3 as.factor(CAT)4
    ## 1  ( 1 ) " "   " "             " "             " "            
    ## 1  ( 2 ) " "   " "             " "             " "            
    ## 2  ( 1 ) " "   " "             "*"             " "            
    ## 2  ( 2 ) " "   "*"             " "             " "            
    ## 3  ( 1 ) " "   "*"             "*"             " "            
    ## 3  ( 2 ) "*"   " "             "*"             " "            
    ## 4  ( 1 ) "*"   "*"             "*"             " "            
    ## 4  ( 2 ) " "   "*"             "*"             " "            
    ## 5  ( 1 ) "*"   "*"             "*"             " "            
    ## 5  ( 2 ) "*"   "*"             "*"             " "            
    ## 6  ( 1 ) "*"   "*"             "*"             " "            
    ## 6  ( 2 ) "*"   "*"             "*"             "*"            
    ## 7  ( 1 ) "*"   "*"             "*"             "*"            
    ## 7  ( 2 ) "*"   "*"             "*"             " "            
    ## 8  ( 1 ) "*"   "*"             "*"             "*"            
    ## 8  ( 2 ) "*"   "*"             "*"             "*"            
    ##          as.factor(CAT)5 as.factor(CAT)6 CMADE CLAIMS ORIGINAL GENERAL
    ## 1  ( 1 ) " "             " "             " "   " "    " "      "*"    
    ## 1  ( 2 ) " "             " "             " "   " "    " "      " "    
    ## 2  ( 1 ) " "             " "             " "   " "    " "      "*"    
    ## 2  ( 2 ) " "             " "             " "   " "    " "      "*"    
    ## 3  ( 1 ) " "             " "             " "   " "    " "      "*"    
    ## 3  ( 2 ) " "             " "             " "   " "    " "      "*"    
    ## 4  ( 1 ) " "             " "             " "   " "    " "      "*"    
    ## 4  ( 2 ) " "             " "             " "   " "    "*"      "*"    
    ## 5  ( 1 ) " "             " "             " "   " "    " "      "*"    
    ## 5  ( 2 ) " "             " "             " "   "*"    " "      "*"    
    ## 6  ( 1 ) " "             " "             " "   "*"    " "      "*"    
    ## 6  ( 2 ) " "             " "             " "   " "    " "      "*"    
    ## 7  ( 1 ) " "             " "             " "   "*"    " "      "*"    
    ## 7  ( 2 ) " "             " "             " "   "*"    "*"      "*"    
    ## 8  ( 1 ) " "             " "             " "   "*"    "*"      "*"    
    ## 8  ( 2 ) " "             " "             " "   "*"    " "      "*"    
    ##          FWDAPLAG BCKGTLAG
    ## 1  ( 1 ) " "      " "     
    ## 1  ( 2 ) "*"      " "     
    ## 2  ( 1 ) " "      " "     
    ## 2  ( 2 ) " "      " "     
    ## 3  ( 1 ) " "      " "     
    ## 3  ( 2 ) " "      " "     
    ## 4  ( 1 ) " "      " "     
    ## 4  ( 2 ) " "      " "     
    ## 5  ( 1 ) "*"      " "     
    ## 5  ( 2 ) " "      " "     
    ## 6  ( 1 ) "*"      " "     
    ## 6  ( 2 ) "*"      " "     
    ## 7  ( 1 ) "*"      " "     
    ## 7  ( 2 ) "*"      " "     
    ## 8  ( 1 ) "*"      " "     
    ## 8  ( 2 ) "*"      "*"

![](TownesResearch2019A01_files/figure-gfm/regression-subsets-1.png)<!-- -->

## Multiple Regression Analysis

The following code chunk performs a multiple regression analysis on the
data sample using the selected model. It then displays the results.

    ## 
    ## Call:
    ## lm(formula = CRECEIVE ~ GYEAR + CAT02 + CAT03 + CAT04 + CLAIMS + 
    ##     ORIGINAL + GENERAL + FWDAPLAG, data = Sample90to95C, na.action = na.omit)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -10.593  -2.956  -0.850   1.035  87.029 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 998.65051  171.81537   5.812 7.16e-09 ***
    ## GYEAR        -0.49997    0.08621  -5.799 7.73e-09 ***
    ## CAT02         3.05106    0.48425   6.301 3.64e-10 ***
    ## CAT03         3.45773    0.47537   7.274 5.01e-13 ***
    ## CAT04         1.37359    0.37734   3.640 0.000279 ***
    ## CLAIMS        0.05989    0.01527   3.921 9.13e-05 ***
    ## ORIGINAL     -1.55882    0.50028  -3.116 0.001860 ** 
    ## GENERAL       9.57013    0.56144  17.046  < 2e-16 ***
    ## FWDAPLAG     -0.21028    0.05332  -3.944 8.31e-05 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 6.357 on 1989 degrees of freedom
    ## Multiple R-squared:  0.2373, Adjusted R-squared:  0.2342 
    ## F-statistic: 77.36 on 8 and 1989 DF,  p-value: < 2.2e-16

## Check Linear Regression Assumptions

The following code chunk performs various checks to verify that the
model satisfies the assumptions of linear regression.

    ## [1] Perform Global Check of Linear Regression Assumptions

    ## 
    ## Call:
    ## lm(formula = CRECEIVE ~ GYEAR + CAT02 + CAT03 + CAT04 + CLAIMS + 
    ##     ORIGINAL + GENERAL + FWDAPLAG, data = Sample90to95C, na.action = na.omit)
    ## 
    ## Coefficients:
    ## (Intercept)        GYEAR        CAT02        CAT03        CAT04  
    ##   998.65051     -0.49997      3.05106      3.45773      1.37359  
    ##      CLAIMS     ORIGINAL      GENERAL     FWDAPLAG  
    ##     0.05989     -1.55882      9.57013     -0.21028  
    ## 
    ## 
    ## ASSESSMENT OF THE LINEAR MODEL ASSUMPTIONS
    ## USING THE GLOBAL TEST ON 4 DEGREES-OF-FREEDOM:
    ## Level of Significance =  0.05 
    ## 
    ## Call:
    ##  gvlma(x = CRECEIVEregression) 
    ## 
    ##                        Value   p-value                   Decision
    ## Global Stat        210438.23 0.000e+00 Assumptions NOT satisfied!
    ## Skewness             9785.54 0.000e+00 Assumptions NOT satisfied!
    ## Kurtosis           200585.30 0.000e+00 Assumptions NOT satisfied!
    ## Link Function          29.73 4.959e-08 Assumptions NOT satisfied!
    ## Heteroscedasticity     37.66 8.424e-10 Assumptions NOT satisfied!

    ## [1] Regression Residuals

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ## -10.5931  -2.9556  -0.8497   0.0000   1.0347  87.0293

    ## png 
    ##   2

    ## [1] Check for Autocorrelation of Residuals

    ##             Length Class  Mode     
    ## statistic   1      -none- numeric  
    ## method      1      -none- character
    ## alternative 1      -none- character
    ## p.value     1      -none- numeric  
    ## data.name   1      -none- character

    ## [1] Check for Correlation Among Independent Variables and Residuals

    ##             Length Class  Mode     
    ## statistic   1      -none- numeric  
    ## parameter   1      -none- numeric  
    ## p.value     1      -none- numeric  
    ## estimate    1      -none- numeric  
    ## null.value  1      -none- numeric  
    ## alternative 1      -none- character
    ## method      1      -none- character
    ## data.name   1      -none- character
    ## conf.int    2      -none- numeric

    ##             Length Class  Mode     
    ## statistic   1      -none- numeric  
    ## parameter   1      -none- numeric  
    ## p.value     1      -none- numeric  
    ## estimate    1      -none- numeric  
    ## null.value  1      -none- numeric  
    ## alternative 1      -none- character
    ## method      1      -none- character
    ## data.name   1      -none- character
    ## conf.int    2      -none- numeric

    ##             Length Class  Mode     
    ## statistic   1      -none- numeric  
    ## parameter   1      -none- numeric  
    ## p.value     1      -none- numeric  
    ## estimate    1      -none- numeric  
    ## null.value  1      -none- numeric  
    ## alternative 1      -none- character
    ## method      1      -none- character
    ## data.name   1      -none- character
    ## conf.int    2      -none- numeric

    ##             Length Class  Mode     
    ## statistic   1      -none- numeric  
    ## parameter   1      -none- numeric  
    ## p.value     1      -none- numeric  
    ## estimate    1      -none- numeric  
    ## null.value  1      -none- numeric  
    ## alternative 1      -none- character
    ## method      1      -none- character
    ## data.name   1      -none- character
    ## conf.int    2      -none- numeric

    ##             Length Class  Mode     
    ## statistic   1      -none- numeric  
    ## parameter   1      -none- numeric  
    ## p.value     1      -none- numeric  
    ## estimate    1      -none- numeric  
    ## null.value  1      -none- numeric  
    ## alternative 1      -none- character
    ## method      1      -none- character
    ## data.name   1      -none- character
    ## conf.int    2      -none- numeric

    ##             Length Class  Mode     
    ## statistic   1      -none- numeric  
    ## parameter   1      -none- numeric  
    ## p.value     1      -none- numeric  
    ## estimate    1      -none- numeric  
    ## null.value  1      -none- numeric  
    ## alternative 1      -none- character
    ## method      1      -none- character
    ## data.name   1      -none- character
    ## conf.int    2      -none- numeric

    ## [1] Check for Positive Variablity in Values of Independent Variables

    ##      PATENT               GYEAR              CRECEIVE         
    ##  Min.   :-1.966e+05   Min.   :    -1.84   Min.   :-196610.50  
    ##  1st Qu.:-9.461e+03   1st Qu.:    -0.08   1st Qu.:     -1.00  
    ##  Median :-1.562e+03   Median :    -0.01   Median :      0.05  
    ##  Mean   : 1.609e+09   Mean   : 15821.82   Mean   : -10918.84  
    ##  3rd Qu.: 3.750e+03   3rd Qu.:     0.04   3rd Qu.:      0.84  
    ##  Max.   : 2.896e+10   Max.   :284792.13   Max.   :     52.77  
    ##       CAT                 CLAIMS             CMADE          
    ##  Min.   :-10151.110   Min.   :   -9.74   Min.   :    -1.68  
    ##  1st Qu.:    -0.261   1st Qu.:   -0.04   1st Qu.:     0.00  
    ##  Median :    -0.042   Median :    0.10   Median :     0.40  
    ##  Mean   :  -563.623   Mean   : 3628.12   Mean   :  7805.24  
    ##  3rd Qu.:     0.226   3rd Qu.:    5.02   3rd Qu.:     2.98  
    ##  Max.   :     4.534   Max.   :65200.31   Max.   :140406.94  
    ##     GENERAL             ORIGINAL           FWDAPLAG        
    ##  Min.   :-6018.177   Min.   :  -0.032   Min.   :-53886.36  
    ##  1st Qu.:   -0.042   1st Qu.:  -0.002   1st Qu.:    -1.49  
    ##  Median :    0.002   Median :   0.007   Median :    -0.07  
    ##  Mean   : -334.267   Mean   : 223.730   Mean   : -2993.68  
    ##  3rd Qu.:    0.069   3rd Qu.:   0.075   3rd Qu.:     0.04  
    ##  Max.   :    0.849   Max.   :4025.316   Max.   :     8.10  
    ##     BCKGTLAG            CRECbinary            CAT01         
    ##  Min.   :-27783.717   Min.   :-7390.528   Min.   : -0.5186  
    ##  1st Qu.:    -0.715   1st Qu.:   -0.012   1st Qu.: -0.0496  
    ##  Median :    -0.184   Median :    0.001   Median : -0.0207  
    ##  Mean   : -1533.160   Mean   : -410.553   Mean   : 27.6406  
    ##  3rd Qu.:     1.101   3rd Qu.:    0.113   3rd Qu.:  0.0037  
    ##  Max.   :   209.960   Max.   :    0.806   Max.   :498.3723  
    ##      CAT02               CAT03                CAT04          
    ##  Min.   :  -0.7360   Min.   :-1121.1082   Min.   :  -0.6171  
    ##  1st Qu.:  -0.0219   1st Qu.:   -0.0206   1st Qu.:  -0.0367  
    ##  Median :  -0.0061   Median :   -0.0071   Median :  -0.0012  
    ##  Mean   :  99.7019   Mean   :  -62.2666   Mean   : 162.3663  
    ##  3rd Qu.:   0.0744   3rd Qu.:    0.0539   3rd Qu.:   0.0543  
    ##  Max.   :1795.0549   Max.   :    0.2779   Max.   :2923.0292  
    ##      CAT05                CAT06             CRECordinal        
    ##  Min.   :-2003.7053   Min.   :-2091.6430   Min.   :-154187.48  
    ##  1st Qu.:   -0.0674   1st Qu.:   -0.0372   1st Qu.:     -0.61  
    ##  Median :   -0.0226   Median :   -0.0111   Median :      0.03  
    ##  Mean   : -111.3210   Mean   : -116.1213   Mean   :  -8563.79  
    ##  3rd Qu.:   -0.0065   3rd Qu.:    0.0246   3rd Qu.:      0.69  
    ##  Max.   :    0.4576   Max.   :    1.1318   Max.   :     25.62

    ## [1] Check for Mulitcollinearity Among the Variables

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   1.022   1.058   1.074   1.090   1.092   1.219

## Clean Data 4

The following code chunk removes cases in which `CRECEIVE` is greater
than or equal to 10 as outliers and applies a transformation to the
`CRECEIVE` variable to better satisfy the assumptions of linear
regression.

## Q-Q Plots for Transformed Variables

The following code chunk displays Quantile-Quantile (Q-Q) plots for the
transformed variables to check for suitability to use in multiple
regression analysis.

    ## png 
    ##   2

## Multiple Regression Using Transformed Variables

    ## 
    ## Call:
    ## lm(formula = CRECEIVEsqrt ~ GYEAR + CAT02 + CAT03 + CAT04 + CLAIMS + 
    ##     ORIGINAL + GENERAL + FWDAPLAG, data = Sample90to95D, na.action = na.omit)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.50502 -0.37531 -0.09773  0.30909  2.13512 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 169.336058  15.585978  10.865  < 2e-16 ***
    ## GYEAR        -0.084001   0.007821 -10.740  < 2e-16 ***
    ## CAT02         0.135559   0.047162   2.874  0.00410 ** 
    ## CAT03         0.141919   0.045456   3.122  0.00182 ** 
    ## CAT04         0.072884   0.034381   2.120  0.03415 *  
    ## CLAIMS        0.004406   0.001465   3.008  0.00266 ** 
    ## ORIGINAL     -0.249616   0.045047  -5.541 3.46e-08 ***
    ## GENERAL       1.473686   0.052161  28.253  < 2e-16 ***
    ## FWDAPLAG     -0.158777   0.004641 -34.214  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.5442 on 1754 degrees of freedom
    ## Multiple R-squared:  0.6417, Adjusted R-squared:  0.6401 
    ## F-statistic: 392.7 on 8 and 1754 DF,  p-value: < 2.2e-16

## Check Linear Regression Assumptions for Transformed Variables

The following code chunk performs various checks to verify that the
model satisfies the assumptions of linear regression.

    ## [1] "Perform Global Check of Linear Regression Assumptions"

    ## 
    ## Call:
    ## lm(formula = CRECEIVEsqrt ~ GYEAR + CAT02 + CAT03 + CAT04 + CLAIMS + 
    ##     ORIGINAL + GENERAL + FWDAPLAG, data = Sample90to95D, na.action = na.omit)
    ## 
    ## Coefficients:
    ## (Intercept)        GYEAR        CAT02        CAT03        CAT04  
    ##  169.336058    -0.084001     0.135559     0.141919     0.072884  
    ##      CLAIMS     ORIGINAL      GENERAL     FWDAPLAG  
    ##    0.004406    -0.249616     1.473686    -0.158777  
    ## 
    ## 
    ## ASSESSMENT OF THE LINEAR MODEL ASSUMPTIONS
    ## USING THE GLOBAL TEST ON 4 DEGREES-OF-FREEDOM:
    ## Level of Significance =  0.05 
    ## 
    ## Call:
    ##  gvlma(x = CRECEIVEregressionTrfm) 
    ## 
    ##                        Value   p-value                   Decision
    ## Global Stat        362.77778 0.0000000 Assumptions NOT satisfied!
    ## Skewness           134.44666 0.0000000 Assumptions NOT satisfied!
    ## Kurtosis            13.00083 0.0003114 Assumptions NOT satisfied!
    ## Link Function      215.27328 0.0000000 Assumptions NOT satisfied!
    ## Heteroscedasticity   0.05701 0.8112811    Assumptions acceptable.

    ## [1] Regression Residuals

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ## -1.50502 -0.37531 -0.09773  0.00000  0.30909  2.13512

    ## png 
    ##   2

    ## [1] Check for Autocorrelation of Residuals

    ##             Length Class  Mode     
    ## statistic   1      -none- numeric  
    ## method      1      -none- character
    ## alternative 1      -none- character
    ## p.value     1      -none- numeric  
    ## data.name   1      -none- character

    ## [1] Check for Correlation between Independent Variables and Residuals

    ##             Length Class  Mode     
    ## statistic   1      -none- numeric  
    ## parameter   1      -none- numeric  
    ## p.value     1      -none- numeric  
    ## estimate    1      -none- numeric  
    ## null.value  1      -none- numeric  
    ## alternative 1      -none- character
    ## method      1      -none- character
    ## data.name   1      -none- character
    ## conf.int    2      -none- numeric

    ##             Length Class  Mode     
    ## statistic   1      -none- numeric  
    ## parameter   1      -none- numeric  
    ## p.value     1      -none- numeric  
    ## estimate    1      -none- numeric  
    ## null.value  1      -none- numeric  
    ## alternative 1      -none- character
    ## method      1      -none- character
    ## data.name   1      -none- character
    ## conf.int    2      -none- numeric

    ##             Length Class  Mode     
    ## statistic   1      -none- numeric  
    ## parameter   1      -none- numeric  
    ## p.value     1      -none- numeric  
    ## estimate    1      -none- numeric  
    ## null.value  1      -none- numeric  
    ## alternative 1      -none- character
    ## method      1      -none- character
    ## data.name   1      -none- character
    ## conf.int    2      -none- numeric

    ##             Length Class  Mode     
    ## statistic   1      -none- numeric  
    ## parameter   1      -none- numeric  
    ## p.value     1      -none- numeric  
    ## estimate    1      -none- numeric  
    ## null.value  1      -none- numeric  
    ## alternative 1      -none- character
    ## method      1      -none- character
    ## data.name   1      -none- character
    ## conf.int    2      -none- numeric

    ##             Length Class  Mode     
    ## statistic   1      -none- numeric  
    ## parameter   1      -none- numeric  
    ## p.value     1      -none- numeric  
    ## estimate    1      -none- numeric  
    ## null.value  1      -none- numeric  
    ## alternative 1      -none- character
    ## method      1      -none- character
    ## data.name   1      -none- character
    ## conf.int    2      -none- numeric

    ##             Length Class  Mode     
    ## statistic   1      -none- numeric  
    ## parameter   1      -none- numeric  
    ## p.value     1      -none- numeric  
    ## estimate    1      -none- numeric  
    ## null.value  1      -none- numeric  
    ## alternative 1      -none- character
    ## method      1      -none- character
    ## data.name   1      -none- character
    ## conf.int    2      -none- numeric

    ## [1] Check for Positive Variablity of Independent Variable Values

    ##      PATENT               GYEAR              CRECEIVE        
    ##  Min.   :-6.394e+04   Min.   :    -0.62   Min.   :-63945.38  
    ##  1st Qu.:-1.806e+04   1st Qu.:    -0.17   1st Qu.:    -0.12  
    ##  Median :-2.913e+03   Median :    -0.02   Median :     0.02  
    ##  Mean   : 1.525e+09   Mean   : 14970.64   Mean   : -3364.93  
    ##  3rd Qu.: 3.943e+03   3rd Qu.:     0.04   3rd Qu.:     1.17  
    ##  Max.   : 2.898e+10   Max.   :284439.91   Max.   :     7.04  
    ##       CAT                 CLAIMS             CMADE          
    ##  Min.   :-14093.401   Min.   :   -7.36   Min.   :    -1.67  
    ##  1st Qu.:    -0.136   1st Qu.:   -0.02   1st Qu.:    -0.01  
    ##  Median :    -0.033   Median :    0.10   Median :     0.58  
    ##  Mean   :  -741.325   Mean   : 3083.82   Mean   :  7565.81  
    ##  3rd Qu.:     0.166   3rd Qu.:    1.90   3rd Qu.:     1.78  
    ##  Max.   :     4.790   Max.   :58503.49   Max.   :143669.41  
    ##     GENERAL             ORIGINAL           FWDAPLAG        
    ##  Min.   :-3844.485   Min.   :  -0.030   Min.   :-53564.60  
    ##  1st Qu.:   -0.022   1st Qu.:  -0.005   1st Qu.:    -1.71  
    ##  Median :    0.006   Median :   0.000   Median :    -0.07  
    ##  Mean   : -202.300   Mean   : 235.537   Mean   : -2819.18  
    ##  3rd Qu.:    0.105   3rd Qu.:   0.049   3rd Qu.:     0.04  
    ##  Max.   :    0.412   Max.   :4473.449   Max.   :     8.92  
    ##     BCKGTLAG           CRECbinary            CAT01          
    ##  Min.   :-58505.74   Min.   :-6485.743   Min.   :-77.69777  
    ##  1st Qu.:    -1.38   1st Qu.:   -0.008   1st Qu.: -0.04458  
    ##  Median :    -0.33   Median :    0.001   Median : -0.02658  
    ##  Mean   : -3068.29   Mean   : -341.336   Mean   : -4.13195  
    ##  3rd Qu.:     1.10   3rd Qu.:    0.181   3rd Qu.: -0.00642  
    ##  Max.   :   217.17   Max.   :    0.559   Max.   :  0.15783  
    ##      CAT02               CAT03               CAT04         
    ##  Min.   :  -0.6646   Min.   :-497.1487   Min.   :  -0.601  
    ##  1st Qu.:  -0.0192   1st Qu.:  -0.0190   1st Qu.:  -0.027  
    ##  Median :  -0.0024   Median :  -0.0065   Median :   0.000  
    ##  Mean   : 159.1411   Mean   : -26.1797   Mean   : 179.571  
    ##  3rd Qu.:   0.0555   3rd Qu.:   0.0012   3rd Qu.:   0.033  
    ##  Max.   :3024.3896   Max.   :   0.0849   Max.   :3412.263  
    ##      CAT05                CAT06             CRECordinal       
    ##  Min.   :-2948.7487   Min.   :-2913.0576   Min.   :-63945.38  
    ##  1st Qu.:   -0.0461   1st Qu.:   -0.0225   1st Qu.:    -0.12  
    ##  Median :   -0.0249   Median :    0.0011   Median :     0.02  
    ##  Mean   : -155.1816   Mean   : -153.2184   Mean   : -3364.93  
    ##  3rd Qu.:   -0.0076   3rd Qu.:    0.0171   3rd Qu.:     1.17  
    ##  Max.   :    0.4690   Max.   :    1.1718   Max.   :     7.04  
    ##   CRECEIVEsqrt       
    ##  Min.   :-22018.211  
    ##  1st Qu.:    -0.034  
    ##  Median :     0.005  
    ##  Mean   : -1158.681  
    ##  3rd Qu.:     0.458  
    ##  Max.   :     2.268

    ## [1] Check for Multicollinearity Among Variables

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   1.013   1.045   1.061   1.077   1.083   1.188

## Save Data

The following code chunk saves the final cleaned data that was used in
the
analysis.

``` r
write.csv(Sample90to95C, here("DataClean","NBERpatents1963to1999","NBERPatCit90to95SampleC.csv"), append = FALSE)
```

    ## Warning in write.csv(Sample90to95C, here("DataClean",
    ## "NBERpatents1963to1999", : attempt to set 'append' ignored

``` r
write.csv(Sample90to95D, here("DataClean","NBERpatents1963to1999","NBERPatCit90to95SampleD.csv"), append = FALSE)
```

    ## Warning in write.csv(Sample90to95D, here("DataClean",
    ## "NBERpatents1963to1999", : attempt to set 'append' ignored
