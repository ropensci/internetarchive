#' Access the list of files associated with an Internet Archive item
#' @param items A list describing an Internet Archive items returned from
#'   the API.
#' @return A list containing the files as a list of character vectors.
#'
#' @export
ia_files <- function(items) {
  files_to_data_frame <- function(i) {
    f <- unlist(names(i$files))
    data_frame(id = unlist(i$metadata$identifier),
               file = f, type = file_ext(file))
  }
  dfs <- lapply(items, files_to_data_frame)
  rbind_all(dfs)
}