#' Combining dev-versions into the next version
#'
#' @param text a string vector with the content of the get_text method
#'
#' @return a string vector with the reduced NEWS.md text
#'
combine_dev <- function(text = "") {

  version_idx <- grep(pattern = "^## version", text)
  version_tags <- text[version_idx]

  is_dev <- grepl(
    pattern = "[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+",
    x = version_tags)

  change_dev <- is_dev & !as.logical(cummin(is_dev))

  remove_lines <- function(x) {
    out <- rep(x, each = 5) + c(-1, 0, 1, 2, 3)
    return(out)
  }

  rm_idx <- remove_lines(version_idx[change_dev])

  out <- text[-rm_idx]

  # add line before '### NEWS.md setup'
  news_setup_idx <- which(out == "### NEWS.md setup")
  if (length(news_setup_idx) > 0) {
    # only if the lines is not alrady empty, add an extra epmty line
    if (out[news_setup_idx - 1] != "") {
      out <- c(out[1:(news_setup_idx - 1)], "", out[news_setup_idx:length(out)])
    }
  }


  return(out)

}
