context("test news creation")

test_that("given file is checked", {
  tmp_file <- file.path(paste0(tempdir(), "/tmp_NEWS.md"))

  # no version
  writeLines(text = "test NEWS.md", con = tmp_file)
  this_warning <- paste0(
    "No version found in file - ",
    "consider given an initial version. ",
    "It is set to 0.0.0.9000 for now.")

  testthat::expect_warning(news$new(file = tmp_file), this_warning)

  # with version within file but no given new version
  writeLines(text = c("old NEWS.md", "# version 1.0", "- some stuff"),
             con = tmp_file)
  new_news <- news$new(file = tmp_file)

  res <- c("## version 1.0.0.9000",
           "",
           "---",
           "",
           "### NEWS.md setup",
           "",
           "- added NEWS.md creation with newsmd",
           "",
           "old NEWS.md",
           "# version 1.0",
           "- some stuff")

  testthat::expect_equal(new_news$get_text(), res)


  # with version within file and given new version
  writeLines(text = c("old NEWS.md", "# version 1.0", "- some stuff"),
             con = tmp_file)
  new_news <- news$new(file = tmp_file, version = "2.0")

  res <- c("## version 2.0",
           "",
           "---",
           "",
           "### NEWS.md setup",
           "",
           "- added NEWS.md creation with newsmd",
           "",
           "old NEWS.md",
           "# version 1.0",
           "- some stuff")

  testthat::expect_equal(new_news$get_text(), res)

  unlink(tmp_file)


  # with dev version within file but no given new version
  writeLines(text = c("old NEWS.md", "# version 1.0.0.9000", "- some stuff"),
             con = tmp_file)

  new_news <- news$new(file = tmp_file)

  res <- c("## version 1.0.0.9001",
           "",
           "---",
           "",
           "### NEWS.md setup",
           "",
           "- added NEWS.md creation with newsmd",
           "",
           "old NEWS.md",
           "# version 1.0.0.9000",
           "- some stuff")

  testthat::expect_equal(new_news$get_text(), res)

  unlink(tmp_file)


  # file does not exist
  testthat::expect_error(news$new(file = "this/does/not/exists.md"),
               "given file does not exists")

})
