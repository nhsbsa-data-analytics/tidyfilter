#' @title Replace word prefixes that occur in given words.
#' @description Finds words starting with a word in a given list, and
#'   replaces each such word prefix with a given replacement.
#'
#' @param .data A data.frame or tibble.
#' @param .words A list of words.
#' @param .replacement A character string used as replacement.
#' @param ... Columns to act upon.
#'
#' @return The original data, filtered.
#' @export
#'
#' @examples
#' data <- data.frame(
#'   x = c("This is some text...", "...containing words."),
#'   y = c("This is more text...", "...containing something."),
#'   z = c("This is some more text...", "...containing  more words.")
#' )
#'
#' data <- data %>%
#'   filter_words(
#'     c("some", "words"),
#'     "####",
#'     x, y
#'   )
#'
#' #                      x                        y                         z
#' # 1 This is #### text... This is more text...     This is some more text...
#' # 2 ...containing ####.  ...containing ####thing. ...containing more words.
filter_words <- function(.data, .words, .replacement, ...) {
  .data %>% dplyr::mutate(
    dplyr::across(
      c(...),
      ~ gsub(
        paste0("\\b", .words, collapse = "|\\b"),
        .replacement, .,
        ignore.case = TRUE, perl = TRUE
      )
    )
  )
}
