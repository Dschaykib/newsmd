testthat::context("test combine_dev")

testthat::test_that("example build", {
  my_news <- news$new()
  my_news$add_subtitle("improved things")
  my_news$add_bullet("point 0.1")
  my_news$add_bullet("point 0.2")
  my_news$add_version("0.0.1")
  my_news$add_bullet("point 1.1")
  my_news$add_bullet("point 1.2")
  my_news$add_subtitle("improved things")
  my_news$add_bullet("point 1.3")
  my_news$add_version("0.0.1.9000")
  my_news$add_bullet("point 1.4")
  my_news$add_bullet("point 1.5")
  my_news$add_subtitle("improved things")
  my_news$add_bullet("point 1.6")
  my_news$add_version("0.0.1.9001")
  my_news$add_bullet("point 1.7")
  my_news$add_bullet("point 1.8")
  my_news$add_subtitle("improved things")
  my_news$add_bullet("point 1.9")
  my_news$add_version("0.0.2")
  my_news$add_bullet("point 2.1")
  my_news$add_bullet("point 2.2")
  my_news$add_subtitle("improved things")
  my_news$add_bullet("point 2.3")
  my_news$add_version("0.0.3.9000")
  my_news$add_bullet("point 3.1")
  my_news$add_bullet("point 3.2")
  my_news$add_subtitle("improved things")
  my_news$add_bullet("point 3.3")

  res <- c(
    "## version 0.0.3.9000",
    "",
    "---",
    "",
    "",
    "### improved things",
    "",
    "- point 3.3",
    "",
    "- point 3.2",
    "- point 3.1",
    "",
    "## version 0.0.2",
    "",
    "---",
    "",
    "",
    "### improved things",
    "",
    "- point 2.3",
    "",
    "- point 2.2",
    "- point 2.1",
    "",
    "### improved things",
    "",
    "- point 1.9",
    "",
    "- point 1.8",
    "- point 1.7",
    "",
    "### improved things",
    "",
    "- point 1.6",
    "",
    "- point 1.5",
    "- point 1.4",
    "",
    "## version 0.0.1",
    "",
    "---",
    "",
    "",
    "### improved things",
    "",
    "- point 1.3",
    "",
    "- point 1.2",
    "- point 1.1",
    "",
    "### improved things",
    "",
    "- point 0.2",
    "- point 0.1",
    "",
    "### NEWS.md setup",
    "",
    "- added NEWS.md creation with [newsmd](https://github.com/Dschaykib/newsmd)",
    ""
    )

  # write and reload
  tmp_file <- file.path(paste0(tempdir(), "/test_build_dev_NEWS.md"))
  my_news$write(file = tmp_file, reduce_dev = TRUE)
  tmp_news <- readLines(tmp_file)

  testthat::expect_equal(tmp_news, res)

  unlink(tmp_file)
})
