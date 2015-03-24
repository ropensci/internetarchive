context("Files, metadata, and downloading")

library(dplyr, warn.conflicts = FALSE)
dir <- tempdir()
items <- ia_get_items("TheLifeOfFatherHecker", silence = TRUE)
meta  <- ia_metadata(items)
files <- ia_files(items) %>%
            filter(type == "txt")
downloads <- ia_download(files, dir, silence = TRUE)

test_that("ia_downloads() downloads a file", {
  expect_equal_to_reference(readLines(downloads$local_file[1]),
                            "hecker_txt.rds")
})

test_that("ia_files() returns a data frame", {
  expect_is(files, c("data.frame", "tbl_df"))
  expect_named(files, c("id", "file", "type"))
})

test_that("ia_downloads() returns a data frame", {
  expect_is(downloads, c("data.frame", "tbl_df"))
  expect_named(downloads, c("id", "file", "type", "url",
                            "local_file", "downloaded"))
})

test_that("ia_metadata() returns a data frame", {
  expect_is(meta, c("data.frame", "tbl_df"))
  expect_named(meta, c("id", "field", "value"))
  expect_equal_to_reference(meta, "hecker_meta.rds")
})

test_that("ia_get_item() returns a list", {
  expect_is(items, "list")
  expect_named(items, )
})

test_that("ia_item_id() returns item ids", {
  expect_equal(ia_item_id(items), "TheLifeOfFatherHecker")
})