#' Calculate Mode
#'
#' Simply calculates the mode from a vector of numbers.
#'
#' @param v vector of numbers or integers
#' @return mode (numeric)
#' @examples
#' getmode(v=c(30,30,3))
#' @export
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}