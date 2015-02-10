#' An API Client for the Internet Archive
#'
#' @import httr
#' @import jsonlite
#' @importFrom dplyr rbind_all data_frame %>% mutate rowwise do as_data_frame
#' @importFrom tools file_ext
#' @name internetarchive
NULL

# Hide variables from R CMD check
if(getRversion() >= "2.15.1") {
  utils::globalVariables(c(".", "id"))
}
