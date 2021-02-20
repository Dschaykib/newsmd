#' @title Creating a NEWS.md file
#'
#' @description
#'  This is a convenience wrapper for \code{news$new()}. If you already have a
#'  \code{NEWS} file you can add it's path to \code{newsmd()}.
#'
#' @details
#'  This functions creates a \code{news} object, which can be saved as the
#'  NEWS.md file with the internal method \code{write()}. One can add versions,
#'  subtitles and bullet points to the \code{news}.
#'
#' @param file name of the \code{NEWS} file to load. If not given a new
#'  file \code{NEWS.md} is created.
#' @param text a character scalar containing the initial text.
#' @param version a character with the version in the format
#'  \code{major.minor.patch.dev}.
#'
#' @export
#' @examples
#' newsmd()

newsmd <- function(file = NULL,
                   text = c(paste0("## version ", version),
                            "", "---", "",
                            "### NEWS.md setup", "",
                            "- added NEWS.md creation with newsmd", ""),
                   version = "0.0.0.9000") {
  news$new(file = file, text = text, version = version)
}

#' @title Manipulate the NEWS.md file
#'
#' @description
#'  Manipulate the NEWS.md file.
#'
#' @seealso \link{newsmd}
#'
#' @export
#' @importFrom R6 R6Class
#' @docType class
#' @format An R6 class.
#'
#' @examples
#' ## Create a template
#' my_news <- news$new()
#' my_news$add_subtitle("improved things 1")
#' my_news$add_bullet("point 1")
#' my_news$add_bullet("point 2")
#'

news <- R6Class("news",
  public <- list(
    #' @description
    #' Create a new news object.
    #' @param text vector with context for the news.md file.
    #' @param version current version of the package.
    #' @param file a text file with the current news.md file.
    #'  Use NULL to create new file.
    #' @return A new `news` object.
    initialize = function(text = c(paste0("## version ", version),
                                   "", "---", "",
                                   "### NEWS.md setup", "",
                                   "- added NEWS.md creation with newsmd", ""),
                          version = "0.0.0.9000",
                          file = NULL) {

      if (is.null(file)) {
        private$text <- text
        private$version <- version

      } else {
        # check if file exists
        if (!file.exists(file)) {
          stop("given file does not exists")
        }
        # check if veriosn is given
        # this is done, since there is no functionality yet
        # to find the version of a given NEWS.md file
        if (version == "0.0.0.9000") {
          this_warning <- paste0(
            "version check not yet implemented! ",
            "Consider given an initial version. ",
            "It is set to 0.0.0.9000 for now.")
          warning(this_warning)
        }
        prev_text <- readLines(file)
        private$text <- c(text, prev_text)
        private$version <- version

      }
      private$ver_indx <- 8
      private$sub_indx <- 4
      private$bul_indx <- length(text)

      },
    #' @description
    #' Print a news object.
    print = function() {
      cat("NEWS.md: \n \n")
      cat(private$text[1:private$ver_indx], sep = "\n")
    },
    #' @description
    #' Get the news object as a text.
    #' @return The context of the news file.
    get_text = function() {
      return(private$text)
    },
    #' @description
    #' Write and save a news object.
    #' @param file A path and file to where the news file is saved.
    write = function(file = "NEWS.md") {
      writeLines(private$text, file)
    },
    #' @description
    #' Adds a version line to a news object.
    #' @param x A string with the version number.
    add_version = function(x) {
      private$text <- c(paste("## version", x), "", "---", "", "",
                       private$text)
      private$sub_indx <- 4
      private$bul_indx <- 4
      private$ver_indx <- 5
    },
    #' @description
    #' Adds a subtitle line to a news object.
    #' @param x A string with the subtitle.
    add_subtitle = function(x) {
      private$text <- c(
        private$text[1:private$sub_indx],
        "", paste("###", x), "", "",
        private$text[(private$sub_indx + 1):length(private$text)])
      private$bul_indx <- private$sub_indx + 3
      private$ver_indx <- private$ver_indx + 4
    },
    #' @description
    #' Adds a bullet points to the last subtitle.
    #' @param x A vector with the bullet points.
    add_bullet = function(x) {
      private$text <- c(
        private$text[1:private$bul_indx],
        paste("-", x),
        private$text[(private$bul_indx + 1):length(private$text)])
      private$ver_indx <- private$ver_indx + length(x)
    }),
  private = list(
    text = "",
    version = NA,
    sub_indx = NA,
    bul_indx = NA,
    ver_indx = NA
  )
)
