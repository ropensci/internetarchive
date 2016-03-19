#' Client for the Internet Archive API
#'
#' This client permits you to search (\link{ia_search}), retrieve item metadata
#' (\link{ia_metadata}) and associated files (\link{ia_files}), and download
#' files (\link{ia_files}) in a pipeable interface.
#'
#' @import httr
#' @importFrom dplyr rbind_all data_frame %>% mutate rowwise do as_data_frame
#' @importFrom tools file_ext
#' @name internetarchive
NULL

# Hide variables from R CMD check
if (getRversion() >= "2.15.1") {
  utils::globalVariables(c(".", "id"))
}
