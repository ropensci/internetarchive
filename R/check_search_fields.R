# Check that the search fields are recognized by the Internet Archive API
check_search_fields <- function(terms) {
  diff <- setdiff(names(terms), ia_fields)
  if (length(diff) > 0) {
    diff <- paste(diff, collapse = ", ")
    stop(paste("The search field(s)", diff, "is/are not valid."))
  }
}