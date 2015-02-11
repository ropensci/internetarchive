#' Access the item IDs from an Internet Archive items
#'
#' @param item A list describing an Internet Archive items returned from
#'   the API. This argument is vectorized.
#' @return A character vector containing the item IDs.
#' @examples
#' ats_query <- c("publisher" = "american tract society")
#' ids       <- ia_search(ats_query, num_results = 3)
#' items     <- ia_get_items(ids)
#' ia_item_id(items)
#' @export
ia_item_id <- function(item) {
  id <- item[["metadata"]][["identifier"]]
  unlist(id)
}
ia_item_id <- Vectorize(ia_item_id, SIMPLIFY = TRUE, USE.NAMES = FALSE)