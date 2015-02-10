#' Access the item ID from an Internet Archive item
#' @param item A list object describing an Internet Archive item returned from
#'   the API.
#' @return A character vector containing the item ID.
#' @export
ia_item_id <- function(item) {
  id <- item[["metadata"]][["identifier"]]
  unlist(id)
}