## Data: Networks

Adjacency matrix data files and R objects which are used to build:
1. undirected fisheries participation networks (**participation**)
2. directed participation networks (**vessel_flow**)

Adjacency matrices, the data used to build network objects, should be saved as `.csv` files. The `igraph` network objects, which include network structure and additional information for nodes and edges (i.e. weights, colors) are saved as `.rds`.

In file names, fishing community names are abbreviated using the PacFIN port group codes (pacfin.psmfc.org) as follows:
* CCA: Crescent City
* ERA: Eureka
* BGA: Fort Bragg
* BDA: Bodega Bay
* SFA: San Francisco
* MNA: Monterey
* MRA: Morro Bay