# profanityfilter
_Filter Profanity From Text_

A simple profanity filter that uses a trie data structure for the profanity list. This has the potential to be faster than using the easier methods such as regular expressions or string methods. The idea came from this python [package](https://github.com/arhankundu99/profanity-filter); the code has been rewritten in R. Also I have used parts of the code from this R package, [`rtrie`](https://github.com/ezgraphs/rtrie/blob/develop/R/rtrie.R). The list of profane words is taken from this [repository](https://github.com/zacanger/profane-words).

The use case this was written for is filtering profanity in comments made in free text questions in customer satisfaction surveys, for display in Shiny dashboards.

The package uses continuous integration to ensure style, no syntax errors and maintain consistency. Documentation is automated via Roxygenise.

<!-- badges: start -->
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

[![R-CMD-check](https://github.com/MarkMc1089/profanityfilter/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/MarkMc1089/profanityfilter/actions/workflows/check-standard.yaml)

[![Codecov test coverage](https://codecov.io/gh/MarkMc1089/profanityfilter/branch/master/graph/badge.svg)](https://codecov.io/gh/MarkMc1089/profanityfilter?branch=master)

[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## Installation

```
devtools::install_github("MarkMc1089/profanityfilter")
```

## Usage

### Trie based profanity filter (experimental)

ProfanityFilter is an R6 class exposing only one function `censor`. This is not vectorised, so using on data.frames or tibbles is not recommended. It is also not configurable, so always uses the full profane_words JSON and replaces characters with "*".

```
bad_words <- list("buck", "fugger")

pf <- ProfanityChecker$new(bad_words)
pf$censor("Remember, don't say buck or fugger!")

Output:
"Remember, don't say **** or ******!"
```

### Regex based word filter

Use this in `dplyr` pipelines. It is fast and vectorised. Also, fully configurable, requiring both a word list and replacement string.

```
data <- data.frame(
    x = c("This is some text...", "...containing words."),
    y = c("This is more text...", "...containing something."),
    z = c("This is some more text...", "...containing more words.")
  )

data %>%
  filter_words(
    c("some", "words"),
    "####",
    x, y
  )

#                      x                        y                         z
# 1 This is #### text... This is more text...     This is some more text...
# 2 ...containing ####.  ...containing ####thing. ...containing more words.
```
### Wordlists
Included are 3 word lists.

- profane_words_basic.txt: Contains just 4 of the most offensive words.
- profane_words.txt: Contains nearly 3000 potentially offensive expressions. Beware over-filtering, you will get many false positives!
- profane_words.json: Same list of nearly 3000 words, in JSON format.

```
readLines(system.file("extdata", "profane_words_basic.txt", package = "profanityfilter"))
profane_words = rjson::fromJSON(
  file = system.file("extdata", "profane_words.json", package = "profanityfilter")
)
```
