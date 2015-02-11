# Turn a set of search terms into the correct format for the Internet Archive
# API.
# @param terms A named character vector where the names are the metadata fields.
# @return A string encoded as a URL.
format_search <- function(terms) {
  terms <- paste0(names(terms), ":\"", unname(terms), "\"")
  terms <- paste(terms, collapse = " AND ")
  gsub("date:\"(.+)\"", "date:[\\1]", terms)
}
