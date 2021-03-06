## Results: Statistics

Network metrics (node- and network-level) calculated from undirected fisheries participation networks.

We have provided the network metrics data used for Fisher et al. (2021) in `2008_2017_ParticipationNetworkMetrics.csv`. Not all metrics reported in the data frame were used for final analyses. The data included in this data frame are: 
1. `y` (year)
2. `period` (early or late season)
3. `pcgroup` (3 letter port group code)
4. `N` (number of nodes)
5. `E` (number of edges)
6. `avg_ew` (average edge weight)
7. `sd_ew` (standard deviation of edge weights
8. `med_ew` (median edge weight)
9. `avg_ew_scaled` (average edge weight, after scaling edge weights by maximum value)
10. `med_ew_scaled` (median edge weight, after scaling edge weights by maximum value)
11. `deg_max` (maximum degree of any node in the network)
12. `deg_min` (minimum degree of any node in the network)
13. `strength_mean` (mean node strength)
14. `assort` (assortativity)
15. `ed` (edge density)
16. `ld` (link density)
17. `mean_deg` (mean degree across network nodes)
18. `nc` (network centralization)
19. `nc_weighted` (weighted network centralization)
20. `m` (modularity)
21. `m_weighted` (weighted modularity)
22. `beta_eff` (beta efficiency)

<br>

### Metric Definitions

Equations for the network metrics used for final analyses in Fisher et al. (2021) are also available in the Supplementary Material. 

![ed](https://github.com/mfisher5/ParticipationNetworks/blob/master/doc/img/ED_equation.png?raw=true)

![md](https://github.com/mfisher5/ParticipationNetworks/blob/master/doc/img/MD_equation.png?raw=true)

![nc_weighted](https://github.com/mfisher5/ParticipationNetworks/blob/master/doc/img/NC_weighted_equation.png?raw=true)

![m_weighted](https://github.com/mfisher5/ParticipationNetworks/blob/master/doc/img/M_weighted_equation.png?raw=true)

<br>

Variables:
* m: number of edges
* n: number of nodes
* A_ij: element in row i, column j of adjacency matrix
* k: degree (unweighted) or sum of weights of adjacent edges (weighted) of nodes i, j
* c: component of i, j
* d^star: maximum degree centrality
* d_i: degree of node i
* s^star: maximum node strength
* s_i: strength of node i
* w: average edge weight 


