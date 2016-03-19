#' Perform an simple keyword search of the Internet Archive.
#'
#' @param keywords The keywords to search for.
#' @param num_results The number of results to return per page.
#' @param page When results are paged, which page of results to return.
#' @param print_total Should the total number of results for this query be
#'   printed as a message?
#' @return A character vector of Internet Archive item IDs.
#' @examples
#' ia_keyword_search("isaac hecker", num_results = 20)
#' @export
ia_keyword_search <- function(keywords, num_results = 5, page = 1,
                              print_total = TRUE) {

  keywords <- paste0("(", keywords, ")")
  base <- "https://archive.org/"
  path  <- "advancedsearch.php"
  query <- list("q" = keywords, "fl[]" = "identifier", "rows" = num_results,
                "page" = page, "output" = "json")
  url <-  modify_url(base, path = path, query = query)
  req <- GET(url)
  warn_for_status(req)
  response <- content(req, as = "parsed", encoding = "UTF-8")

  if (print_total)
    message(paste(response$response$numFound, "total items found.",
                  "This query requested", num_results, "results."))

  unlist(response$response$docs, use.names = FALSE)

}