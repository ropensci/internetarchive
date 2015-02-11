# Check that the search fields are recognized by the Internet Archive API
#
# @param The named character vector of search fields and values.
# @references The list of valid search terms is drawn from the Internet Archive
# \href{https://archive.org/advancedsearch.php}{advanced search page}.
check_search_fields <- function(terms) {
  diff <- setdiff(names(terms), ia_fields)
  if (length(diff) > 0) {
    diff <- paste(diff, collapse = ", ")
    stop(paste("The search field(s)", diff, "is/are not valid."))
  }
}