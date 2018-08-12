context("test news creation")

test_that("existing file is checked", {
  writeLines("test NEWS.md", "tmp_NEWS.md")
  this_warning <- paste0(
    "version check not yet implemented! ",
    "Consider given an initial version. ",
    "It is set to 0.0.0.9000 for now.")
  expect_warning(news$new(file = "tmp_NEWS.md"), this_warning)
  unlink("tmp_NEWS.md")
  
  expect_error(news$new(file = "this/does/not/exists.md"),
               "given file does not exists")
  
})
