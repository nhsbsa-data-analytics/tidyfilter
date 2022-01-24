# tidyfilter
_Filter Text Based On List of Words Or Regexes_


The use case this was written for is filtering profanity and personal identifiable data in comments made in free text questions in customer satisfaction surveys, for display in Shiny dashboards.

The package uses continuous integration to ensure style, no syntax errors and maintain consistency. Documentation is automated via Roxygenise.

<!-- badges: start -->
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

[![R-CMD-check](https://github.com/MarkMc1089/tidyfilter/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/MarkMc1089/tidyfilter/actions/workflows/check-standard.yaml)

[![Codecov test coverage](https://codecov.io/gh/MarkMc1089/tidyfilter/branch/master/graph/badge.svg)](https://codecov.io/gh/MarkMc1089/tidyfilter?branch=master)

[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## Installation

```
devtools::install_github("MarkMc1089/tidyfilter")
```

## Usage

### Regex based word filter

Use this in `dplyr` pipelines. It is fast and vectorised. Also, fully configurable, requiring both a word list and replacement string.

```
data <- data.frame(
    w = c("My phone number is 07421 345 678", "Call me on 01234567890")
    x = c("This is some text...", "...containing words."),
    y = c("This is more text...", "...containing something."),
    z = c("This is some more text...", "...containing more words.")
  )

data %>%
  filter_words(
    c("some", "words", "and", "regex", "[0-9]{3,}[\s0-9]*[0-9]"),
    "####",
    w, x, y
  )

#                         w                    x                        y                         z
# 1 My phone number is #### This is #### text... This is more text...     This is some more text...
# 2 Call me on ####         ...containing ####.  ...containing ####thing. ...containing more words.
```
### Wordlists
Included are 3 word lists for profanity and 1 list of regexes.

- profane_words_basic.txt: Contains just 4 of the most offensive words.
- profane_words.txt: Contains nearly 3000 potentially offensive expressions. Beware over-filtering, you will get many false positives!
- profane_words.json: Same list of nearly 3000 words, in JSON format.
- pid_regex: Contains regex to catch dates, phone numbers and emails.

```
readLines(system.file("extdata", "pid_regex.txt", package = "tidyfilter"))
profane_words = rjson::fromJSON(
  file = system.file("extdata", "profane_words.json", package = "tidyfilter")
)
```
