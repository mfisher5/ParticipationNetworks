################ Fig. 3 Early Season Vessel Flow Networks ################ 
#
# 1/30/2020 - M. Fisher
#
##########################################################################


# Set up ------------------------------------------------------------------
# packages
library(tidyverse)
library(igraph)
library(ggraph)
library(grid)
library(gridExtra)
library(here)

# source plotting functions
source("R/vessel_flow_networks_fun.R")

# set objects
myports <- c("CCA","ERA","BGA","BDA","SFA","MNA","MRA")
portnames <- c("Crescent City", "Eureka", "Fort Bragg", "Bodega Bay", "San Francisco", "Monterey Bay", "Morro Bay")
indir <- "output/networks/crab_vessel/graph_objects/"



# Functions for Plotting --------------------------------------------------

# function to change node names
rename_vertices <- function(mygraph){
  new_names <- V(mygraph)$common_name %>%
    str_replace("Misc. Pot/H&L", "Misc.(Pot,HL)") %>%
    str_replace("Misc. Fisheries", "Misc.") %>%
    str_replace("Rockfish/Lcod","RockLing") %>%
    str_replace("DTS Trawl","Groundfish") %>%
    str_replace("Dcrab","D.crab")
  new_names[which(new_names=="Hagfish (pot)")] <- "Hagfish"
  new_names[which(new_names=="Sablefish (Lgl)")] <- "Sablefish"
  new_names[which(new_names=="Sablefish (pot)")] <- "Sablefish"
  V(mygraph)$common_name <- new_names
  return(mygraph)
}

# function to plot
plot_graph = function (mygraph, alt_dcrb=TRUE) {
  ####### for all graphs ######
  p=unique(V(mygraph)$port) # port group
  V(mygraph)$color <- vertex_color_collapsed(mygraph) # node colors
  # remove any nodes with size of 0 in 2015
  mygraph <- delete.vertices(mygraph, V(mygraph)[which(V(mygraph)$size==0 & V(mygraph)$name != "DCRB_POT")])
  ## get node sizes, and reset 2015 d.crab node size to the 2014 participation
  if(alt_dcrb){
    dcrb_node <- which(V(mygraph)$name=="DCRB_POT")
    vsizes=V(mygraph)$size
    vsizes[dcrb_node] = V(mygraph)$size14[dcrb_node]
  } else{vsizes=V(mygraph)$size}
  
  # to plot vertices with only self loops on the left side of the graph
  # self_only <- names(degree(simplify(mygraph)))[which(degree(simplify(mygraph)) == 0)]
  self_only <- c()
  
  self_g = delete.edges(mygraph,E(mygraph)[!(which_loop(mygraph))])
  self_loops <- as_edgelist(self_g)[,1]
  
  node.y <- unlist(lapply(V(mygraph)$name,FUN=function(i){ifelse(i %in% c("DCRB_POT",self_only), 1,ifelse(i %in% self_loops, 0.1,0))}))
  edge.y <- unlist(lapply(as_edgelist(mygraph)[,1],FUN=function(i){ifelse(i %in% c("DCRB_POT",self_only), 1,ifelse(i %in% self_loops, 0.1,0))}))
  edge.yend <- unlist(lapply(as_edgelist(mygraph)[,2],FUN=function(i){ifelse(i %in% c("DCRB_POT",self_only), 1,ifelse(i %in% self_loops, 0.1,0))}))
  node.y.lab <- unlist(lapply(V(mygraph)$name,FUN=function(i){ifelse(i %in% c("DCRB_POT",self_only), 1.2,ifelse(i %in% self_loops, -0.5,-0.5))}))
  
  ## graph of all vessels
  if(is.null(V(mygraph)$vsize)){
    ylabel = p
    
    if(ecount(self_g) < 1){
      ggraph(mygraph, 'igraph', algorithm = 'tree') + 
        geom_edge_diagonal(aes(y=edge.y,yend=edge.yend,width=sqrt((E(mygraph)$weight))), 
                           color="grey85",end_cap = circle(0.5),arrow=arrow(length=unit(0.3,'cm'))) +
        geom_node_point(aes(y=node.y),color=factor(V(mygraph)$color),
                        size=10*sqrt(vsizes)/sqrt(max(vsizes))) +
        geom_node_text(aes(y=node.y.lab,label = common_name), size=5) +
        #annotate("text", x = 1.35, y = 0.5, label = paste0(s," Vessels"), size=4) +
        xlab(ylabel) +
        xlim(c(-3.1,3.1)) +
        theme_void() +
        theme(legend.position="none", 
              axis.title.y=element_text(angle=90,size=20,hjust=0.5),
              panel.border = element_rect(colour = "black", fill=NA, size=1)) +
        coord_flip() +
        scale_y_reverse(expand=expansion(add=c(0.5,1)))
    } else{
      ggraph(mygraph, 'igraph', algorithm = 'tree') + 
        geom_edge_diagonal(aes(y=edge.y,yend=edge.yend,width=sqrt((E(mygraph)$weight))), 
                           color="grey85",end_cap = circle(0.5),arrow=arrow(length=unit(0.3,'cm'))) +
        geom_edge_loop(aes(y=edge.y,width=sqrt((E(mygraph)$weight)), span=50,direction=0,strength=0.90), color="grey85") +
        geom_node_point(aes(y=node.y),color=factor(V(mygraph)$color),
                        size=10*sqrt(vsizes)/sqrt(max(vsizes))) +
        geom_node_text(aes(y=node.y.lab,label = common_name), size=5) +
        #annotate("text", x = 1.35, y = 0.5, label = paste0(s," Vessels"), size=4) +
        xlab(ylabel) +
        xlim(c(-3.1,3.1)) +
        theme_void() +
        theme(legend.position="none", 
              axis.title.y=element_text(angle=90,size=20,hjust=0.5),
              panel.border = element_rect(colour = "black", fill=NA, size=1)) +
        coord_flip() +
        scale_y_reverse(expand=expansion(add=c(0.5,1)))
    }
    
    ## graphs of large & small vessels
  } else{
    s=unique(V(mygraph)$vsize)
    s=ifelse(s=="large","Large","Small")
    if(s=="Large"){ylabel=p} else{ylabel=""}
    if(ecount(self_g) < 1){
      ggraph(mygraph, 'igraph', algorithm = 'tree') + 
        geom_edge_diagonal(aes(y=edge.y,yend=edge.yend,width=sqrt((E(mygraph)$weight))), 
                           color="grey85",end_cap = circle(0.5),arrow=arrow(length=unit(0.3,'cm'))) +
        geom_node_point(aes(y=node.y),color=factor(V(mygraph)$color),
                        size=10*sqrt(vsizes)/sqrt(max(vsizes))) +
        geom_node_text(aes(y=node.y.lab,label = common_name), size=5) +
        #annotate("text", x = 1.35, y = 0.5, label = paste0(s," Vessels"), size=4) +
        xlab(ylabel) +
        xlim(c(-2.7,2.7)) +
        # ylim(c(-0.05,1.1)) +
        theme_void() +
        theme(legend.position="none", 
              axis.title.y=element_text(angle=90,size=20,hjust=0.5),
              panel.border = element_rect(colour = "black", fill=NA, size=1)) +
        coord_flip() +
        scale_y_reverse(expand=expansion(add=c(0.5,1)))
    } else{
      ggraph(mygraph, 'igraph', algorithm = 'tree') + 
        geom_edge_diagonal(aes(y=edge.y,yend=edge.yend,width=sqrt((E(mygraph)$weight))), 
                           color="grey85",end_cap = circle(0.5),arrow=arrow(length=unit(0.3,'cm'))) +
        geom_edge_loop(aes(y=edge.y,width=sqrt((E(mygraph)$weight)), span=50,direction=0,strength=0.90), color="grey85") +
        geom_node_point(aes(y=node.y),color=factor(V(mygraph)$color),
                        size=10*sqrt(vsizes)/sqrt(max(vsizes))) +
        geom_node_text(aes(y=node.y.lab,label = common_name), size=5) +
        xlab(ylabel) +
        xlim(c(-2.7,2.7)) +
        # ylim(c(-0.09,1.15)) +
        theme_void() +
        theme(legend.position="none", 
              axis.title.y=element_text(angle=90,size=20,hjust=0.5),
              panel.border = element_rect(colour = "black", fill=NA, size=1)) +
        coord_flip() +
        scale_y_reverse(expand=expansion(add=c(0.5,1)))
    }
  }
}

# Graphs - by vessel size -------------------------------------------------------------

# Read in graph objects
size_graphs_list <- list()
list_names <- c()
i=1
for(p in myports){
  for(s in c("large","small")){
    tmpgraph <- readRDS(paste0(indir,p,"_closure_",s,"_v7_newVL.rds"))
    V(tmpgraph)$port = portnames[which(myports == p)]
    V(tmpgraph)$vsize = s
    tmpgraph <- rename_vertices(tmpgraph)
    size_graphs_list[[i]] <- tmpgraph
    list_names[i] <- paste0(p,"_",s)
    i = i + 1
  }
}
names(size_graphs_list) <- list_names

# run plotting function
myplots_size <- lapply(size_graphs_list, plot_graph)
# grid.arrange(grobs=myplots_size, nrow=7,ncol=2)

col.titles=c("Large","Small")
ylabel="2015                                      2016"
png("results/plots/all_NtoS_LvS_newVL_netv7_coordfixed_closure.png", width=1800,height=3000,res=200)
grid.arrange(grobs=lapply(c(1,2), function(i) {
  arrangeGrob(grobs=myplots_size[seq(i,14,by=2)], top=textGrob(col.titles[i],gp=gpar(fontsize=22)), 
              bottom=textGrob(ylabel,gp=gpar(fontsize=18)),
              ncol=1)
}), ncol=2)
dev.off()

