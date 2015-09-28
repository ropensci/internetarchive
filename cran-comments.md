This is patch release to the `internetarchive` package. The `knitr` package has
changed its dependencies, so `rmarkdown` must be listed as a suggested package 
when using `knitr` for a vignette.

## Test environments

* local OS X install, R 3.2.2
* Ubuntu 14.04, R 3.2.2 (via Travis CI)
* win-builder (R-devel and R-release)

## R CMD check results

There were no ERRORs, WARNINGs or NOTEs. Every effort has been made to keep the check time to a minimum while still exercising all of the features of the package.
