% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_network_stats.R
\name{net_stats}
\alias{net_stats}
\title{Calculate Network Statistics}
\usage{
net_stats(g, y, stats = "both")
}
\arguments{
\item{g}{network, as an igraph object}

\item{y}{the year or crab year represented by the network}

\item{stats}{Specify whether you want to calculate node-level stats ('node'), network-level stats ('network') or both}
}
\value{
data frame with statistics
}
\description{
Calculate all network-level and node-level statistics for a given graph.
}
\examples{
stats.net <- net_stats(open_g, y = y, stats="network")
stats.node <- net_stats(open_g, y = y, stats="node")
stats.all <- net_stats(open_g, y = y, stats="both")
}
