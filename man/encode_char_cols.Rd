% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/encode_char_cols.R
\name{encode_char_cols}
\alias{encode_char_cols}
\title{Set character encoding in tibble or data.frame}
\usage{
encode_char_cols(.data, .encoding)
}
\arguments{
\item{.data}{A data.frame or tibble.}

\item{.encoding}{A string specifying an encoding..}
}
\value{
The original data, with character columns set to given encoding.
}
\description{
Given an encoding, this sets all character columns to it.
}
\examples{
\dontrun{
data <- data \%>\%
  encode_char_cols("latin1")
}
}
