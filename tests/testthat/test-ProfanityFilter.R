test_that("Text is correctly censored", {
  t <- ProfanityFilter$new(c("brow", "brown", "sat"))
  expect_equal(
    t$censor("The quick brown fox jumped over the lazy dog."),
    "The quick ***** fox jumped over the lazy dog."
  )
  expect_equal(
    t$censor("The cat and his bro sat on the brown mat, with a heavy brow."),
    "The cat and his bro *** on the ***** mat, with a heavy *****"
  )
})

test_that("Non-text arguments result in error", {
  t <- ProfanityFilter$new(c("brow", "brown", "sat"))
  expect_error(
    t$censor(12345)
  )
  expect_error(
    t$censor("12345", 0)
  )
})
