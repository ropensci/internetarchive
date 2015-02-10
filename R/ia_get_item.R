#' Get the metadata for an Internet Archive item
#'
#' @param item_id A character vector containing the ID for an Internet Archive
#'   item.
#' @return A list containing the metadata returned by the API.
#' @export
ia_get_item <- function(item_id) {
  path <- paste("details", item_id, sep = "/")
  req <- GET("https://archive.org/", path = path, query = list(output = "json"))
  warn_for_status(req)
  result <- content(req, as = "text")
  if (identical(result, "")) stop("")
  fromJSON(result, simplifyVector = FALSE)
}