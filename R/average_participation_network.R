#' Average Participation Network Graphs
#'
#' Extract vertices attributes from the listed graph objects, and
#' average numeric attributes together to be incorporated into
#' a new participation network.
#'
#' @param tickets fish tickets data frame
#' @param pcid_choose specify a port group
#' @param years_choose a vector of the crab years to build a network for
#' @param filter use the `min_vessels` and `min_contribution` objects to filter the data
#' @param filter_subgraph a filtering option from the original function that was turned off for Fisher et al.
#' @param min_vessels the minimum number of vessels participating in a fishery for that fishery to be retained in the network
#' @param min_contribution the minimum contribution (as a proportion) to total exvessel revenue for a fishery to be retained for a given vessel
#' @return non-confidential fisheries partition network as an igraph object
#' @examples
#' pre_shock <- participation_network_multiyr(close_dat, filter = TRUE, filter_subgraph = FALSE)
#' @export
average_participation_networks <- function(multiyr_graph,annual_graphs,period,years){
  #### Average vertex attributes from annual graphs ####
  # empty data frame for vertex attributes
  vertex_df <- data.frame(metier=as.character(),
                          crab_year=as.character(),
                          size=as.numeric(),
                          percent_size=as.numeric(),
                          importance=as.numeric())
  
  for(i in seq(1,length(annual_graphs))){
    tmpg <- annual_graphs[[i]]
    # get vertex size, percent size, importance
    vnames=V(tmpg)$name
    vertex_size = V(tmpg)$size #total revenue in all fisheries
    percent_size = V(tmpg)$percent_size
    importance = V(tmpg)$importance
    tmpdf <- data.frame(metier=vnames,crab_year=rep(years[i], length(vnames)),
                        size=vertex_size,percent_size=percent_size,importance=importance)
    vertex_df <- rbind(vertex_df,tmpdf)
  }
  
  # average vertex attributes, by total revenue from all fisheries in that season ('size')
  vertex_info <- vertex_df %>%
    dplyr::select(metier,crab_year,percent_size,size) %>%
    group_by(metier) %>%
    summarise(avg_percent_size=mean(percent_size), total_size=sum(size)) %>%
    mutate(importance=avg_percent_size*total_size)
  
  
  #### Change vertices & attributes of multi-year graph ####
  
  # subset to include fisheries present in one or more annual graphs
  retain_fisheries <- unique(vertex_info$metier)
  multiyr_graph <- induced_subgraph(multiyr_graph, which(V(multiyr_graph)$name %in% retain_fisheries))
  # add averaged vertices info
  vertex_info <- vertex_info %>% filter(metier %in% V(multiyr_graph)$name)
  vertex_info <- vertex_info[match(V(multiyr_graph)$name, vertex_info$metier),]
  V(multiyr_graph)$size <- vertex_info$total_size
  V(multiyr_graph)$percent_size <- vertex_info$avg_percent_size
  V(multiyr_graph)$importance <- vertex_info$importance
  
  return(list(multiyr_graph, vertex_info))
  
  
}