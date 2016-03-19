#' Download files for Internet Archive items.
#' @param files A data frame of files returned by \link{ia_files}. You should
#'   filter this data frame to download only the files that you actually want.
#' @param dir The directory in which to save the downloaded files.
#' @param extended_name If this argument is \code{FALSE}, then the downloaded
#'   file will have a filename in the following format:
#'   \code{itemidentifier.extension}, e.g., \code{thedamnationofth00133gut.txt}.
#'   If there are multiple files of the same file type for an item, then the
#'   file names will not be unique. If this argument is \code{TRUE}, them the
#'   downloaded file will have a filename in the following format:
#'   \code{itemidentifier-original-filename.extension}, e.g.,
#'   \code{thedamnationofth00133gut-133.txt}.
#' @param overwrite If \code{TRUE}, this function will download all files and
#'   overwrite them on disk if they have already been downloaded. If
#'   \code{FALSE}, then if a file already exists on disk it will not be
#'   downloaded again but other downloads will proceed normally.
#' @param silence If false, print the item IDs as they are downloaded.
#' @return A data frame including the file names of the downloaded files.
#' @examples
#' \dontrun{
#' if (require(dplyr)) {
#'   dir <- tempdir()
#'   ia_get_items("thedamnationofth00133gut") %>%
#'     ia_files() %>%
#'     filter(type == "txt") %>% # download only the files we want
#'     ia_download(dir = dir, extended_name = FALSE)
#' }
#' }
#' @export
ia_download <- function(files, dir = ".", extended_name = TRUE,
                        overwrite = FALSE, silence = FALSE) {
  url <- "https://archive.org/download/"
  files %>%
    mutate(url = paste0(url, id, file)) %>%
    rowwise() %>%
    do(download_row(., dir = dir, extended_name = extended_name,
                    overwrite = overwrite, silence = silence))
}

download_row <- function(row, dir, extended_name, overwrite, silence) {
  if (extended_name) {
    row$local_file <- paste0(dir, "/", row$id, gsub("/", "-", row$file))
  } else {
    row$local_file <- paste0(dir, "/", row$id, ".", row$type)
  }

  if (overwrite | !file.exists(row$local_file)) {
    if (!silence) message(paste("Downloading", row$local_file))
    GET(row$url, write_disk(row$local_file, overwrite = overwrite))
    row$downloaded <- TRUE
  }

  as_data_frame(row)
}