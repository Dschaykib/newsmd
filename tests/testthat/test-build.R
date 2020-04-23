context("test news build")

test_that("get build", {

  news_1 <- newsmd()
  news_2 <- news$new()
  res <- c("## version 0.0.0.9000", "", "---",
           "", "### setup", "", "- added NEWS.md creation", "")

  expect_identical(class(news_1), c("news", "R6"))
  expect_identical(res, news_1$get_text())
  expect_identical(res, news_2$get_text())
})

test_that("example build", {
  my_news <- news$new()
  my_news$add_subtitle("improved things 1")
  my_news$add_bullet("point 1")
  my_news$add_bullet("point 2")
  my_news$add_version("0.0.1")
  my_news$add_bullet("point 3")
  my_news$add_bullet("point 3.1")
  my_news$add_subtitle("improved things 2")
  my_news$add_bullet("point 4")
  my_news$add_bullet("point 4.2")
  my_news$add_subtitle("improved things 3")
  my_news$add_bullet("point 5")
  my_news$add_version("1.0.0")

  res <- c(
    "## version 1.0.0", "", "---",
    "", "", "## version 0.0.1",
    "", "---", "",
    "", "### improved things 3", "",
    "- point 5", "", "",
    "### improved things 2", "", "- point 4.2",
    "- point 4", "", "- point 3.1",
    "- point 3", "", "## version 0.0.0.9000",
    "", "---", "",
    "", "### improved things 1", "",
    "- point 2", "- point 1", "",
    "### setup", "", "- added NEWS.md creation",
    "")

  expect_equal(my_news$get_text(), res)
})
