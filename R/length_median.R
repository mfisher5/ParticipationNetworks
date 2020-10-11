#' Calculate Median Vessel Length
#'
#' Calculate median vessel length from three years of vessel
#' registration data (current year plus two previous years)
#'
#' @param x vector of vessel lengths
#' @param years vector of the years associated with the vessel lengths
#' @return median (numeric)
#' @examples
#' getmode(v=c(30,30,33,3))
#' @export
get2yrmed <- function(x, years){
  tmp_dat_frame <- data.frame("Year"=years, "Lengths" = x)
  tmp_dat_sub <- tmp_dat_frame[1:2,]
  med_length <- median(tmp_dat_sub$Lengths)
  return(med_length)
}