#' Get the metadata for Internet Archive items
#'
#' @param item_id A character vector containing the ID for an Internet Archive
#'   item. This argument is vectorized, so you can retrieve multiple items at
#'   once.
#' @param silence If false, print the item IDs as they are retrieved.
#' @return A list containing the metadata returned by the API. List names
#'   correspond to the item IDs.
#' @examples
#' \dontrun{
#' ia_get_items("thedamnationofth00133gut")
#'
#' ats_query <- c("publisher" = "american tract society")
#' ids       <- ia_search(ats_query, num_results = 2)
#' ia_get_items(ids)
#' }
#' @export
ia_get_items <- function(item_id, silence = FALSE) {
  path <- paste("details", item_id, sep = "/")
  if (!silence) message(paste("Getting", item_id))
  req <- GET("https://archive.org/", path = path, query = list(output = "json"))
  warn_for_status(req)
  result <- content(req, as = "parsed", encoding = "UTF-8")
  result
}
ia_get_items <- Vectorize(ia_get_items, SIMPLIFY = FALSE)