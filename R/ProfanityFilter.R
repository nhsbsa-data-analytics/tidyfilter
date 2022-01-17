#' @title R6 Class providing a profanity filter to censor text.
#' @description Uses a trie data structure of profane words to filter profanity
#' from text.
#'
#' @importFrom R6 R6Class
#' @importFrom rjson fromJSON
#'
#' @export
# Begin Exclude Linting
ProfanityFilter <- R6::R6Class(
  # End Exclude Linting
  "ProfanityFilter",
  private = list(
    .profane_trie = NULL,
    .censor_profane_words = function(text, censor_char) {
      text <- strsplit(text, split = " ")[[1]]
      clean_text <- ""

      for (word in text) {
        curr_word <- ""
        if (private$.profane_trie$has_prefix(tolower(word))) {
          curr_word <- strrep(censor_char, nchar(word))
        } else {
          curr_word <- word
        }
        clean_text <- paste(clean_text, curr_word)
      }

      substr(clean_text, 2, nchar(clean_text))
    }
  ),
  public = list(
    #' @description
    #' Create a new `ProfanityFilter` object.
    #'
    #' @param profane_words Unnamed list of words (by default it reads the included
    #' `profane_words.json` into a list).
    #' @return A new `ProfanityFilter` object.
    #'
    #' @examples
    #' \dontrun{
    #'   # use default profanity list
    #'   pf <- ProfanityFilter$new()
    #'
    #'   # use custom profanity list
    #'   bad_words <- list("feck", "sod", "damn")
    #'   pf <- ProfanityFilter$new(bad_words)
    #' }
    initialize = function(profane_words = rjson::fromJSON(file = system.file(
                            "extdata", "profane_words.json",
                            package = "profanityfilter"
                          ))) {
      private$.profane_trie <- Trie$new(profane_words)
    },

    #' @description
    #' Apply profanity filtering to a piece of text.
    #'
    #' @param text The text to filter.
    #' @param censor_char Character used to replace all characters in censored
    #' words (default '*').
    #' @return The original text, filtered of profanity.
    #'
    #' @examples
    #' \dontrun{
    #'   pf$censor("Don't say feck or bugger", '+')
    #'   # "Don't say ++++ or ++++++!"
    #' }
    censor = function(text, censor_char = "*") {
      stopifnot(is.character(text))
      stopifnot(is.character(censor_char))

      private$.censor_profane_words(text, censor_char)
    }
  ),
  cloneable = FALSE
)
