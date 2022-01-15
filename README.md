# profanityfilter
_Filter Profanity From Text_

A simple profanity filter that uses a trie data structure for the profanity list. This has the potential to be faster than using the easier methods such as regular 
expressions or string methods. The idea came from this python [package](https://github.com/arhankundu99/profanity-filter); the code has been rewritten in R. Also I have used 
parts of the code from this R package, [`rtrie`](https://github.com/ezgraphs/rtrie/blob/develop/R/rtrie.R). The list of profane words is taken from this 
[repository](https://github.com/zacanger/profane-words).

The use case this was written for is filtering profanity in comments made in free text questions in customer satisfaction surveys, for display in Shiny dashboards.

The package uses continuous integration to ensure style, no syntax errors and maintain consistency. Documentation is automated via Roxygenise.

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

[![R-CMD-check](https://github.com/MarkMc1089/profanityfilter/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/MarkMc1089/profanityfilter/actions/workflows/check-standard.yaml)

## Usage

```
bad_words <- list("buck", "fugger")

pf <- ProfanityChecker$new(bad_words)
pf$censor("Remember, don't say buck or fugger!")

Output:
"Remember, don't say **** or ******!"
```
