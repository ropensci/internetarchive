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