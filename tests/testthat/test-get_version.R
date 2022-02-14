testthat::context("test get_Version")

testthat::test_that("version punctuation level", {


  testversions <- as.data.frame(matrix(ncol = 2, byrow = TRUE, data = c(
    # component cases
    "1", "1",
    "1.2", "1.2",
    "1.2.3", "1.2.3",
    "1.2.3.4", "1.2.3.4",
    "1.2.3.4.5", "1.2.3.4.5",
    # different seperators
    "1-2-3", "1.2.3",
    "1-2.3", "1.2.3",
    "1-2:3", "1.2.3",
    "1:2-3", "1.2.3",
    # with date
    "1.2.3.4.5 2021.12.31", "1.2.3.4.5"
    # not working cases
    #"2021.12.31 1.2.3.4.5 ", "1.2.3.4"
    #"1_2_3", "1.2.3",
    #"1/2/3", "1.2.3",
  )))
  names(testversions) <- c("version_check", "version_res")

  tmp_file <- file.path(paste0(tempdir(), "/tmp_version.md"))

  # looping over all test versions
  i_row <- 1
  for (i_row in seq_along(testversions$version_check)) {
    i_version <- testversions$version_check[i_row]
    writeLines(text = c("NEWS.md 10",
                        paste0("# version ", i_version),
                        "- some stuff"),
               con = tmp_file)

    this_version <- get_version(file = tmp_file, latest = TRUE)
    res <- as.character(testversions$version_res[i_row])
    testthat::expect_equal(this_version, res)
  }

})

testthat::test_that("version labeling level", {

  tmp_file <- file.path(paste0(tempdir(), "/tmp_version.md"))

  writeLines(text = c("NEWS.md 10",
                      "# version 1.0",
                      "version 1.1",
                      "1.2",
                      "# 1.3",
                      "## 1.4",
                      "## 1.5"),
             con = tmp_file)

  this_version <- get_version(file = tmp_file, latest = FALSE)
  res <- c("1.0", "1.1", "1.3", "1.4", "1.5")
  testthat::expect_equal(this_version, res)

})
