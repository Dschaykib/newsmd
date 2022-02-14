#' Retrieve the version number of a NEWS.md file
#'
#' @description This function tries to extract the version number within a file.
#'   There are a few pitfalls:
#'
#'   * If the word "version" is within the text but denotes a dependency it is
#'   still detected. * If the files has a date before the version it will return
#'   the date instead of the version * It is assumed, that the NEWS.md files is
#'   updated from the top. Ergo the latest version is the first one.
#'
#' @param file a path to a file
#' @param latest a Boolean, if TRUE (default) only the latest version is
#'   returned
#'
#' @return either a single string or a vector with version numbers
#' @export
#'
get_version <- function(file, latest = TRUE) {

  # read file
  content <- readLines(file)
  content <- tolower(content)


  # get headlines and lines with versions
  idx <- startsWith(x = content, prefix = "#") |
    grepl("version [[:digit:]]", content)
  headlines_inital <- content[idx]

  # extract version
  # remove numbers which are between letters and no version,
  # but part of a word / name
  version_nonum <- gsub("(.*)([[:alpha:]])([[:digit:]]+)([[:alpha:]])(.*)",
                          replacement = "\\1\\2\\4\\5", x = headlines_inital)
  # remove all letter, since version are only number separated by a punctuation
  version_noletters <- gsub("[#[:alpha:]]", "", version_nonum)
  # replace punctuation . / - between numbers with "x" for the next step
  version_punct <- gsub("\\.|-|\\:", "x", version_noletters)
  version_punct <- gsub("([[:punct:]]x)|(x[[:punct:]])", "-", version_punct)
  version_punct <- gsub("[[:punct:]]", "", version_punct)

  # keep only the ones with numbers and change x back to .
  version_punct_clean <- grep(pattern = "[[:digit:]]",
                              version_punct, value = TRUE)
  version_punct_clean <- gsub("x", "\\.", version_punct_clean)
  version_punct_clean <- trimws(version_punct_clean)

  # split by space to remove possible dates
  version_final <- gsub("(.*)[[:blank:]](.*)", replacement = "\\1",
                        x = version_punct_clean)

  # it is assumed, that the latest version is the first one to be mentioned
  if (latest) {
    version_final <- version_final[1]
    if (is.na(version_final)) {
      version_final <- c()
    }
  }

  return(as.character(version_final))
}
