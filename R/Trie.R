#' @title R6 Class providing a trie data structure
#' @description Trie is implemented as nested unnamed lists, with a special
#' character string flag denoting end of a word.
#'
#' @importFrom R6 R6Class
#' @export
# Begin Exclude Linting
Trie <- R6::R6Class(
  # End Exclude Linting
  "Trie",
  private = list(
    .root = list(),
    .end = "",
    .insert = function(words) {
      first <- substr(words, 1, 1)
      rest <- substr(words, 2, nchar(words))
      zi <- nchar(words) == 0L
      c(
        list(" " = private$.end)[any(zi)],
        lapply(split(rest[!zi], first[!zi]), private$.insert)
      )
    }
  ),
  public = list(
    #' @description
    #' Create a new `Trie` object.
    #'
    #' @param words Unnamed list of words.
    #' @return A new `Trie` object.
    #'
    #' @examples
    #' words <- list("first", "fist", "fjord")
    #' t <- Trie$new(words)
    initialize = function(words) {
      stopifnot(all(as.logical(lapply(words, is.character))))

      private$.end <- "_end"
      private$.root <- private$.insert(words)
    },

    #' @description
    #' Check if a given word is present in the trie.
    #'
    #' @param word String to check for presence in trie.
    #' @return Either `TRUE` or `FALSE`.
    #'
    #' @examples
    #' t$has_prefix("firstly")
    #' # TRUE
    #' t$has_prefix("firs")
    #' # FALSE
    #'
    has_prefix = function(word) {
      current <- private$.root
      for (char in strsplit(word, "")[[1]]) {
        if (is.null(current[[char]])) {
          if (private$.end %in% current) {
            return(TRUE)
          }
          return(FALSE)
        }
        current <- current[[char]]
      }
      if (private$.end %in% current) {
        return(TRUE)
      }
      return(FALSE)
    }
  ),
  cloneable = FALSE
)
