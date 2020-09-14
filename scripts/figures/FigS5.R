################ Fig. 3 Late Season Vessel Flow Networks ################ 
#
# 1/30/2020 - M. Fisher
#
#########################################################################



# Set up ------------------------------------------------------------------
# packages
library(tidyverse)
library(igraph)
library(ggraph)
library(grid)
library(gridExtra)
library(here)

# source plotting functions
source(here::here("R/vessel_flow_networks_fun.R"))

# set objects
myports <- c("CCA","ERA","BGA","BDA","SFA","MNA","MRA")
portnames <- c("Crescent City", "Eureka", "Fort Bragg", "Bodega Bay", "San Francisco", "Monterey Bay", "Morro Bay")
indir <- "data/networks/vessel_flow"



# Function to Plot --------------------------------------------------------
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
  new_names[which(new_names=="Sablefish (pot)")] <- "Sablefish"
  new_names[which(new_names=="Chinook (trl)")] <- "Chinook"
  new_names[which(new_names=="C. Halibut (pole)")] <- "C. Halibut"
  new_names[which(new_names=="Shrimp (pot)")] <- "Shrimp"
  V(mygraph)$common_name <- new_names
  return(mygraph)
}


plot_graph = function (mygraph, alt_dcrb=TRUE, dist_y=1.8) {
  ## prepare for plotting ##
  
  # color of vertices
  p=unique(V(mygraph)$port)
  V(mygraph)$color <- vertex_color_collapsed(mygraph)
  
  # early season: relative node size based on 2015 D. crab participation
  if(alt_dcrb){
    dcrb_node <- which(V(mygraph)$name=="DCRB_POT")
    vsizes=V(mygraph)$size
    vsizes[dcrb_node] = V(mygraph)$size14[dcrb_node]
  } else{vsizes=V(mygraph)$size}
  
  # for plotting self-loops
  self_g = delete.edges(mygraph,E(mygraph)[!(which_loop(mygraph))])
  self_loops <- as_edgelist(self_g)[,1]
  
  ## set location of nodes ##
  # initiate data frame & specify order of nodes (fishery --> d.crab --> no fishing / other port) 
  node.x <- c(); node.x.lab <- c()
  m=-1.5; d=-2; f=0
  node.x.df <- data.frame(node=as.character(),
                          xval=as.numeric())
  
  # Did vessels shift into D. crab fishery?
  el <- data.frame(as_edgelist(mygraph)) %>%
    mutate(X1=as.character(X1),
           X2=as.character(X2))
  crab_flow <- ifelse(dim(dplyr::filter(el,X1 != "DCRB_POT" & X2=="DCRB_POT"))[1] > 0,TRUE,FALSE)
  
  # loop through nodes and assign x position
  for(n in V(mygraph)$name){
    if(!(n %in% c("other_port","no_fishing"))){
      if(n=="DCRB_POT" & crab_flow){
        node.x <- c(node.x, d)
        node.x.lab <- c(node.x.lab, d-0.3)
        node.x.df <- rbind(node.x.df, data.frame(node=as.character(n),xval=d))
      } else{
        node.x <- c(node.x, m)
        node.x.lab <- c(node.x.lab,m)
        node.x.df <- rbind(node.x.df, data.frame(node=as.character(n),xval=m))
        m <- m + dist_y
      }
    } else{
      node.x <- c(node.x, f)
      node.x.lab <- c(node.x.lab, f)
      node.x.df <- rbind(node.x.df, data.frame(node=as.character(n),xval=f))
      f <- f + dist_y
    }
  }
  node.x.df$node <- as.character(node.x.df$node)
  el <- left_join(el,node.x.df,by=c("X1"="node"))
  el <- left_join(el,node.x.df,by=c("X2"="node")); colnames(el) <- c("X1","X2", "edge.x","edge.xend")
  # set y position; if crab_flow=TRUE, the d.crab node will be in the middle instead of the left side
  node.y <- unlist(lapply(V(mygraph)$name,FUN=function(i){ifelse(i == "DCRB_POT" & crab_flow, 0.5,ifelse(i %in% c("other_port","no_fishing"),0,0.9))}))
  node.y.lab <- ifelse(node.y==0.9, 1.2, ifelse(node.y==0,-0.4,0.5))
  edge.y <- unlist(lapply(el[,1],FUN=function(i){ifelse(i == "DCRB_POT" & crab_flow, 0.5,ifelse(i %in% c("other_port","no_fishing"),0,0.9))}))
  edge.yend <- unlist(lapply(el[,2],FUN=function(i){ifelse(i == "DCRB_POT" & crab_flow, 0.5,ifelse(i %in% c("other_port","no_fishing"),0,0.9))}))
  # a 0.3 offset for the labels isn't enough when there are 3 columns of nodes
  if(any(node.y==0)){node.y.lab[which(node.y.lab==1.2)] <- 1.4}
  # a 0.3 offset for the labels is too much when there is one column of nodes
  if(all(node.y==0.9)){node.y.lab[which(node.y.lab==1.2)] <- 1}
  
  
  # how many fisheries total?
  nmets <- length(V(mygraph)$name)
  
  # what vessel size is being plotted? capitalize size class
  s=unique(V(mygraph)$vsize)
  if(s=="large"){
    s="Large"; ylabel=p
  } else{
    s="Small"; ylabel=""
  }
  
  # set x upper limit based on number of nodes
  x_up <- max(node.x.df$xval) + 1.75
  
  ## graph of all vessels ##
  # if the graph does not include self-loops...
  if(ecount(self_g) < 1){
    ggraph(mygraph, 'igraph', algorithm = 'tree') + 
      geom_edge_diagonal(aes(y=edge.y,yend=edge.yend,x=el$edge.x, xend=el$edge.xend,width=((E(mygraph)$weight)^(1/3))), 
                         color="grey85",end_cap = circle(0.5),arrow=arrow(length=unit(0.3,'cm'))) +
      geom_node_point(aes(y=node.y, x = node.x),color=factor(V(mygraph)$color),
                      size=10*sqrt(vsizes)/sqrt(max(vsizes))) +
      geom_node_text(aes(y=node.y.lab,x=node.x.lab,label = common_name), size=5) +
      xlab(ylabel) +
      xlim(c(-2.5,6.5)) +
      # ylim(c(-0.05,1.1)) +
      theme_void() +
      theme(legend.position="none", 
            axis.title.y=element_text(size=18,hjust=0.5,angle=90),
            panel.border = element_rect(colour = "black", fill=NA, size=1)) +
      coord_flip() +
      scale_y_reverse(expand=expansion(mult=0.4))
  } 
  # if the graph does include self-loops
  else{
    ggraph(mygraph, 'igraph', algorithm = 'tree') + 
      geom_edge_diagonal(aes(y=edge.y,yend=edge.yend,x=el$edge.x, xend=el$edge.xend,width=((E(mygraph)$weight)^(1/3))), 
                         color="grey85",end_cap = circle(0.5),arrow=arrow(length=unit(0.3,'cm'))) +
      geom_edge_loop(aes(y=edge.y,x=el$edge.x,width=(E(mygraph)$weight)^(1/3), span=50,direction=0,strength=1.30), color="grey85") +
      geom_node_point(aes(y=node.y, x = node.x),color=factor(V(mygraph)$color),
                      size=10*sqrt(vsizes)/sqrt(max(vsizes))) +
      geom_node_text(aes(y=node.y.lab,x=node.x.lab,label = common_name), size=5) +
      xlab(ylabel) +
      xlim(c(-2.5,x_up)) +
      # ylim(c(-0.09,1.15)) +
      theme_void() +
      theme(legend.position="none", 
            axis.title.y=element_text(size=18,hjust=0.5,angle=90),
            panel.border = element_rect(colour = "black", fill=NA, size=1)) +
      coord_flip() +
      scale_y_reverse(expand=expansion(mult=0.4))
  }
}


# Graphs - by vessel size -------------------------------------------------

# Read in graph objects
size_graphs_list <- list()
list_names <- c()
i=1
for(p in myports){
  for(s in c("large","small")){
    tmpgraph <- readRDS(here::here(indir,paste0(p,"_open_",s,"_v8_newVL.rds")))
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
myplots_size <- lapply(size_graphs_list, plot_graph,alt_dcrb=FALSE)
grid.arrange(grobs=myplots_size, nrow=7,ncol=2)



col.titles=c("Large","Small")
ylabel="2015                                      2016"
png(here::here("results/plots","all_NtoS_LvS_newVL_netv7_coordfixed_open.png"), width=2000,height=3400,res=200)
grid.arrange(grobs=lapply(c(1,2), function(i) {
  arrangeGrob(grobs=myplots_size[seq(i,14,by=2)], top=textGrob(col.titles[i],gp=gpar(fontsize=22)), 
              bottom=textGrob(ylabel,gp=gpar(fontsize=18)),
              ncol=1)
}), ncol=2)
dev.off()


# Graph - by vessel size, by region ---------------------------------------


# Read in graph objects
size_graphs_list <- list()
list_names <- c()
i=1
for(p in myports[1:4]){
  for(s in c("large","small")){
    tmpgraph <- readRDS(here::here(indir,paste0(p,"_open_",s,"_v8_newVL.rds")))
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
myplots_size <- lapply(size_graphs_list, plot_graph,alt_dcrb=FALSE)
grid.arrange(grobs=myplots_size, nrow=4,ncol=2)



col.titles=c("Large","Small")
ylabel="2015                                      2016"
png(here::here("results/plots","North_LvS_newVL_netv7_coordfixed_open.png"), width=1900,height=2600,res=200)
grid.arrange(grobs=lapply(c(1,2), function(i) {
  arrangeGrob(grobs=myplots_size[seq(i,8,by=2)], top=textGrob(col.titles[i],gp=gpar(fontsize=22)), 
              bottom=textGrob(ylabel,gp=gpar(fontsize=18)),
              ncol=1)
}), ncol=2)
dev.off()



## Central ##


# Read in graph objects
size_graphs_list <- list()
list_names <- c()
i=1
for(p in myports[5:7]){
  for(s in c("large","small")){
    tmpgraph <- readRDS(here::here(indir,paste0(p,"_open_",s,"_v8_newVL.rds")))
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
myplots_size <- lapply(size_graphs_list, plot_graph,alt_dcrb=FALSE)
grid.arrange(grobs=myplots_size, nrow=3,ncol=2)



col.titles=c("Large","Small")
ylabel="2015                                      2016"
png(here::here("results/plots","Central_LvS_newVL_netv7_coordfixed_open.png"), width=1900,height=2400,res=200)
grid.arrange(grobs=lapply(c(1,2), function(i) {
  arrangeGrob(grobs=myplots_size[seq(i,6,by=2)], top=textGrob(col.titles[i],gp=gpar(fontsize=22)), 
              bottom=textGrob(ylabel,gp=gpar(fontsize=18)),
              ncol=1)
}), ncol=2)
dev.off()




