context("Search")

test_that("keyword search works", {
  expect_message(keyword <- ia_keyword_search("isaac hecker"),
                 "\\d+ total items found. This query requested 5 results.")
  expect_is(keyword, "character")
  expect_equal(length(keyword), 5)
})

test_that("advanced search works", {
  expect_message(advanced <- ia_search(c("creator" = "herman melville"),
                                       num_results = 10),
                 "\\d+ total items found. This query requested 10 results.")
  expect_is(advanced, "character")
  expect_equal(length(advanced), 10)
})