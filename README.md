
<!-- README.md is generated from README.Rmd. Please edit that file -->

# internetarchive

[![Build
Status](https://travis-ci.org/ropensci/internetarchive.svg?branch=master)](https://travis-ci.org/ropensci/internetarchive)
[![codecov.io](https://codecov.io/github/ropensci/internetarchive/coverage.svg?branch=master)](https://codecov.io/github/ropensci/internetarchive?branch=master)

## Overview

This API client for the [Internet Archive](https://archive.org/) is
intended primarily for searching for items, retrieving metadata for
items, and downloading the files associated with items. The functions
can be used with the pipe operator (`%>%`) from
[magrittr](https://github.com/smbache/magrittr) and the data
manipulation verbs in [dplyr](https://github.com/hadley/dplyr) to create
pipelines from searching to downloading. For the full details of what is
possible with the Internet Archive API, see their [advanced search
help](https://archive.org/advancedsearch.php).

## Installation

Install this package from CRAN:

``` r
install.packages("internetarchive")
```

Or, install the [development
version](https://github.com/ropensci/internetarchive) from GitHub with
[devtools](http://cran.rstudio.org/web/packages/devtools/).

``` r
# install.packages("devtools")
devtools::install_github("ropensci/internetarchive", build_vignettes = TRUE)
```

Then load the package. We will also use
[dplyr](https://github.com/hadley/dplyr) for manipulating the retrieved
data.

``` r
library("internetarchive")
library("dplyr", warn.conflicts = FALSE)
```

## Basic search and browse

The simplest way to search the Internet Archive is to use a keyword
search. The following function searches for these keywords in the most
important metadata fields, and returns a list of item identifiers.

``` r
ia_keyword_search("isaac hecker")
#> 31 total items found. This query requested 5 results.
#> [1] "americanexperien00fari"    "fatherhecker00sedggoog"   
#> [3] "fatherhecker01sedg"        "abitunpublished00heckgoog"
#> [5] "TheLifeOfFatherHecker"
```

You can pass an item identifier to the `ia_browse()` function to open an
item in your browser. If you pass this function multiple identifiers, it
will open only the first one.

``` r
ia_browse("TheLifeOfFatherHecker")
```

## Advanced search

Usually it is more useful to perform an advanced search. You can
construct an advanced search as a named character vector, where the
names correspond to the fields. The following search, for instance,
looks for items published by the American Tract Society in 1864. Run the
function `ia_list_fields()` to see the list of accepted metadata fields.

``` r
ats_query <- c("publisher" = "american tract society", "year" = "1864")
ia_search(ats_query, num_results = 20)
#> 13 total items found. This query requested 20 results.
#>  [1] "huguenotsfrance00martgoog" "missionsmartyrsi00bost"   
#>  [3] "vitalgodlinessa00plumgoog" "liliantaleofthre00lili"   
#>  [5] "littlewillietrue00amer"    "ourvillageinwart00mart"   
#>  [7] "vitalgodlinesstrws00plum"  "vitalgodlinesstr00plum"   
#>  [9] "songsofzionenlar00amer"    "ilvertonrectoryo00mart"   
#> [11] "colorbearerfranc01amer"    "sketcheseloquen00wategoog"
#> [13] "sketchesofeloque00wate"
```

You can change the number of items returned by the search using the
`num_results =` argument, and you can request subsequent pages of
results with the `page =` argument.

Notice that `ia_search()` and `ia_keyword_search()` both return a
character vector of identifiers, so both can be used in the same way at
the beginning of a pipeline.

### Dates

To search by a date range, use the `date` field and the years (or
[ISO 8601 dates](http://en.wikipedia.org/wiki/ISO_8601)) separated by
`TO`. Here we search for publications by the American Tract Society in
the
1840s.

``` r
ia_search(c("publisher" = "american tract society", date = "1840 TO 1850"))
#> 104 total items found. This query requested 5 results.
#> [1] "historyreformat09aubgoog"  "scripturebiogra00hookgoog"
#> [3] "historyreformat22aubgoog"  "memoirmrssarahl00hookgoog"
#> [5] "circulationandc00socigoog"
```

## Getting item metadata and files

Once you have retrieved a list of items, you can retrieve their metadata
and the list of files associated with the items.

To get a single item’s metadata, you can pass its identifier to the
`ia_get_items()` function.

``` r
hecker <- ia_get_items("TheLifeOfFatherHecker")
```

The result is a list where the names of items in the list are the item
identifiers, and the rest of the list is the metadata. This nested list
can be difficult to work with, so the `ia_metadata()` returns a data
frame of the metadata, and `ia_files()` returns a data frame of the
files associated with the item.

``` r
ia_metadata(hecker)
ia_files(hecker)
```

These functions can also retrieve the information for multiple items
when used in a pipeline. Here we search for all the items about Hecker,
retrieve their metadata, and turn it into a data frame. We then filter
the data frame to get only the titles.

``` r
ia_keyword_search("isaac hecker", num_results = 20) %>% 
  ia_get_items() %>% 
  ia_metadata() %>% 
  filter(field == "title") %>% 
  select(value)
```

## Downloading files

The `ia_download()` function will download all the files in a data frame
returned from `ia_files()`. This function should be used with caution,
and you should first filter the data frame to download only the files
that you wish. In the following example, we retrieve a list of all the
files associated with items published by the American Tract Society in
1864. Then we filter the list so we get only text files, then we pick
only the first text file associated with each item. Finally we download
the files to a directory we specify (in this case, a temporary
directory).

``` r
dir <- tempdir()
ia_search(ats_query) %>% 
  ia_get_items() %>% 
  ia_files() %>% 
  filter(type == "txt") %>% 
  group_by(id) %>% 
  slice(1) %>% 
  ia_download(dir = dir, overwrite = FALSE) %>% 
  glimpse()
```

Notice that `ia_download()` returns a modified version of the data frame
that was passed to it, adding a column `local_file` with the path to the
download files.

If the `overwrite =` argument is `FALSE`, then you can pass the same
data frame of files to `ia_download()` and it will download only the
files that it has not already downloaded.

-----

[![rOpenSCi
logo](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
