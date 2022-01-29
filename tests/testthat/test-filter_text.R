test_that("Text is correctly censored", {
  data <- data.frame(
    x = c("This is some text...", "...containing words."),
    y = c("This is more text...", "...containing something."),
    z = c("This is some more text...", "...containing more words.")
  )
  expect_equal(
    data %>%
      filter_text(
        c("some", "words"),
        "#",
        x, y
      ),
    data.frame(
      x = c("This is #### text...", "...containing #####."),
      y = c("This is more text...", "...containing ####thing."),
      z = c("This is some more text...", "...containing more words.")
    )
  )
})
