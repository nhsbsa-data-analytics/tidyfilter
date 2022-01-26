#' @title Set character encoding in tibble or data.frame
#' @description Given an encoding, this sets all character columns to it.
#'
#' @param .data A data.frame or tibble.
#' @param .encoding A string specifying an encoding..
#'
#' @return The original data, with character columns set to given encoding.
#' @export
#'
#' @examples
#' \dontrun{
#' data <- data %>%
#'   encode_char_cols("latin1")
#' }
encode_char_cols <- function(.data, .encoding) {
  .data %>% dplyr::mutate_if(
    is.character,
    .funs = function(x) {
      return(iconv(x, "UTF-8", .encoding))
    }
  )
}
