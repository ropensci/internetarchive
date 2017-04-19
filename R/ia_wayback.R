
#' Search the wayback machine
#'
#' Provide and url and timestamp and get a url back to the closest snapshot the wayback machine crawled.
#'
#' @param wayback_url The url for which to get a snapshot.
#' @param timestamp timestamp in format YYYYMMDDhhmmss. YYYYMMDD will also work.
#'
#' @return List containing the closest snapshot.
#' @references See the documentation on the Internet Archive's
#' \href{https://archive.org/help/wayback_api.php}{wayback page}.
#' @examples
#' #  wayback <- ia_wayback_search("http://lincolnmullen.com/#software",'20160701005604')
#' @export
ia_wayback_search <- function(wayback_url, timestamp = NULL) {

  base <- "https://archive.org/"
  path  <- "wayback/available"
  query <- list("url" = wayback_url,
                "timestamp" = timestamp)

  url <-  modify_url(base, path = path, query = query)
  req <- GET(url)
  warn_for_status(req)
  # headers are not application/json so the use of jsonlite is required.
  response <- jsonlite::fromJSON(content(req,as = "text",encoding = "UTF-8"))

}