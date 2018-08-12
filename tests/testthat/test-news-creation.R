context("test news creation")

test_that("existing file is checked", {
  this_warning <- paste0(
    "version check not yet implemented! ",
    "Consider given an initial version. ",
    "It is set to 0.0.0.9000 for now.")
  expect_warning(news$new(file = "NEWS.md"),this_warning)
  
  expect_error(news$new(file = "this/does/not/exists.md"),
               "given file does not exists")
  
})
