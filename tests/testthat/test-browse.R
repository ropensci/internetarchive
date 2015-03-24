context("Browsing")

test_that("returns the items passed to it", {
  options(browser = "false")
  ids <- c("questionssoul01heckgoog", "fatherhecker01sedg")
  expect_equal(ia_browse(ids), ids)
})