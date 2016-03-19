#' Search the Internet Archive
#'
#' Perform an advanced search of the Internet Archive, specifying which metadata
#' fields to search. Note that all searches are in the form of "contains," i.e.,
#' the title contains the search term.
#'
#' @param terms A set of metadata fields and corresponding values to search.
#'   These should take the form of a named character vector.
#' @param num_results The number of results to return per page.
#' @param page When results are paged, which page of results to return.
#' @param print_url Should the URL used for the query be printed as a message?
#' @param print_total Should the total number of results for this query be
#'   printed as a message?
#' @return A character vector of Internet Archive item IDs.
#'
#' @references See the documentation on the Internet Archive's
#'   \href{https://archive.org/advancedsearch.php}{advanced search page}.
#' @examples
#' query1 <- c("title" = "damnation of theron ware")
#' ia_search(query1)
#' query2 <- c("title" = "damnation of theron ware",
#'             "contributor" = "gutenberg")
#' ia_search(query2)
#' @export
ia_search <- function(terms, num_results = 5, page = 1, print_url = FALSE,
                      print_total = TRUE) {

  check_search_fields(terms)
  terms <- format_search(terms)
  base <- "https://archive.org/"
  path  <- "advancedsearch.php"
  query <- list("q" = terms, "fl[]" = "identifier", "rows" = num_results,
                "page" = page, "output" = "json")
  url <-  modify_url(base, path = path, query = query)

  if (print_url) message(url)
  req <- GET(url)
  warn_for_status(req)
  response <- content(req, as = "parsed", encoding = "UTF-8")

  if (print_total)
    message(paste(response$response$numFound, "total items found.",
                  "This query requested", num_results, "results."))

  unlist(response$response$docs, use.names = FALSE)

}