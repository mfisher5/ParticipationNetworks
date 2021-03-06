% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/graph_directed_network_early_supportfx_image.R
\name{directed_early_image}
\alias{directed_early_image}
\title{Crab Icon Graph, Early Season Directed Network}
\usage{
directed_early_image(
  g,
  image_object = img_file,
  image_size = 0.15,
  image_aspect = 1.2,
  image_offset = 0.15,
  image_transparent = FALSE
)
}
\arguments{
\item{g}{igraph object}

\item{image_object}{a character string that provides the file name for the dungeness crab node icon, for when crab_image is TRUE}

\item{image_size}{the size of the dungeness crab node icon, for when crab_image is TRUE}

\item{image_aspect}{the aspect ratio (width:height) of the dungeness crab node icon, for when crab_image is TRUE}

\item{image_offset}{the distance to the left of the node to place the dungeness crab node icon, for when crab_image is TRUE}

\item{image_transparent}{the alpha value for the dungeness crab node icon, for when crab_image is TRUE}
}
\value{
a ggraph object
}
\description{
Plotting function to graph a directed network with crab icon.
Called from within \code{graph_directed_early.R}
}
\examples{
plot_directed_early(g=mygraph)
}
