test_that("Encoding is applied to character columns", {
  data <- data.frame(
    x = c("Can\u0092t see?", "\u00a3333.33"), # Can't see? | £333.33
    y = c(1, 2)
  )
  reencoded_data <- data %>%
    encode_char_cols("latin1")

  if (Sys.info()["sysname"] == "windows") {
    expect_equal(
      reencoded_data,
      data <- data.frame(
        x = c(
          rawToChar(
            as.raw(c(0x43, 0x61, 0x6e, 0x92, 0x74, 0x20, 0x73, 0x65, 0x65, 0x3f))
          ),
          rawToChar(as.raw(c(0xa3, 0x33, 0x33, 0x33, 0x2e, 0x33, 0x33)))
        ),
        y = c(1, 2)
      )
    )
  } else {
    expect_equal(
      reencoded_data,
      data <- data.frame(
        x = c(
          "Can't see?",
          "£333.33"
        ),
        y = c(1, 2)
      )
    )
  }
})
