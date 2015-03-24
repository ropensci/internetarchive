context("Errors and formatting")

test_that("search fields are valid", {
  expect_error(ia_search(c("my fake field" = 2)))
})

test_that("URLs are formatted correctly", {
  expect_equal(format_search(c("author" = "Herman Melville")),
               "author:\"Herman Melville\"")
  expect_equal(format_search(c("date" = 1844)), "date:[1844]")
  expect_equal(format_search(c("author" = "Herman Melville", "date" = 1844)),
               "author:\"Herman Melville\" AND date:[1844]")
})