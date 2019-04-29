
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dynar

Import dynare output result file into R

<!-- badges: start -->

<!-- badges: end -->

## Usage

This is a basic example which shows you how to import a
"\*\_results.mat" file

``` r
library(dynar)


model <- mat2r("inst/main_basic_results.mat")


str(model, 1)
#> List of 9
#>  $ M.             :List of 59
#>   ..- attr(*, "dim")= int [1:3] 59 1 1
#>   ..- attr(*, "dimnames")=List of 3
#>  $ oo.            :List of 14
#>   ..- attr(*, "dim")= int [1:3] 14 1 1
#>   ..- attr(*, "dimnames")=List of 3
#>  $ options.       :List of 230
#>   ..- attr(*, "dim")= int [1:3] 230 1 1
#>   ..- attr(*, "dimnames")=List of 3
#>  $ estim.params.  : num[0 , 0 ] 
#>  $ bayestopt.     : num[0 , 0 ] 
#>  $ dataset.       : num[0 , 0 ] 
#>  $ estimation.info:List of 21
#>   ..- attr(*, "dim")= int [1:3] 21 1 1
#>   ..- attr(*, "dimnames")=List of 3
#>  $ dataset.info   : num[0 , 0 ] 
#>  $ oo.recursive.  : list()
#>  - attr(*, "header")=List of 3
```
