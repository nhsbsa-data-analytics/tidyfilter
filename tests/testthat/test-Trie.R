TestTrie <- R6::R6Class( # Exclude Linting
  inherit = profanityfilter::Trie,
  public = list(
    get = function() {
      private$.root
    }
  )
)


test_that("Trie is initialised correctly", {
  t <- TestTrie$new(c("brow", "brown", "sat"))
  expect_equal(
    t$get(),
    list(
      "b" = list(
        "r" = list(
          "o" = list(
            "w" = list(
              " " = "_end",
              "n" = list(
                " " = "_end"
              )
            )
          )
        )
      ),
      "s" = list(
        "a" = list(
          "t" = list(
            " " = "_end"
          )
        )
      )
    )
  )
})

test_that("prefix word is found", {
  expect_equal(
    Trie$new(c("brow", "brown", "sat"))
    $has_prefix("satchel"),
    TRUE
  )
})

test_that("non-prefix word is not found", {
  expect_equal(
    Trie$new(c("brow", "brown", "sat"))
    $has_prefix("dog"),
    FALSE
  )
})

test_that("error is correctly thrown or not thrown", {
  expect_error(
    Trie$new(list("one", 2, "three"))
  )
  expect_error(
    Trie$new(list("one", NA_character_, "three"), NA)
  )
})
