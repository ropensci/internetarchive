#' Open an Internet Archive item in the browser
#'
#' @param item_id The item identifier. If multiple item identifiers are passed
#'   in, only the first will be opened.
#' @param type Which page to open: \code{details} is the metadata page,
#'   \code{stream} is the viewing page for items which are associated with a
#'   PDF.
#' @return Returns the item ID(s) passed to the function.
#' @examples
#' # Distinguished Converts to Rome in America
#' ia_browse("distinguishedcon00scanuoft")
#' @export
ia_browse <- function(item_id, type = c("details", "stream")) {
  type <- match.arg(type)
  utils::browseURL(paste("https://archive.org", type, item_id[1], sep = "/"))
  return(item_id)
}