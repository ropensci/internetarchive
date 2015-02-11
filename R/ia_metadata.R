#' Access the item metadata from an Internet Archive item
#' @param items A list object describing an Internet Archive items returned from
#'   the API.
#' @return A data frame containing the metadata, with columns \code{id} for the
#'   item identifier, \code{field} for the name of the metadata field, and
#'   \code{value} for the metadata values.
#' @examples
#' ats_query <- c("publisher" = "american tract society")
#' ids       <- ia_search(ats_query, num_results = 3)
#' items     <- ia_get_items(ids)
#' metadata  <- ia_metadata(items)
#' metadata
#' @export
ia_metadata <- function(items) {
  metadata_to_data_frame <- function(i) {
    m <- unlist(i$metadata)
    data_frame(id = unlist(i$metadata$identifier),
               field = names(m), value = unname(m))
  }
  dfs <- lapply(items, metadata_to_data_frame)
  rbind_all(dfs)
}