context("test news creation")

test_that("existing file is checked", {
  tmp_file <- file.path(paste0(tempdir(), "/tmp_NEWS.md"))
  writeLines(text = "test NEWS.md", con = tmp_file)
  this_warning <- paste0(
    "version check not yet implemented! ",
    "Consider given an initial version. ",
    "It is set to 0.0.0.9000 for now.")
  expect_warning(news$new(file = tmp_file), this_warning)
  unlink(tmp_file)

  expect_error(news$new(file = "this/does/not/exists.md"),
               "given file does not exists")

})
