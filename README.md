# Fisheries Participation Networks

These materials use fishery landings data to generate and analyze fisheries participation networks, as in Fisher et al. (in revision). This repository builds on R code originally produced for [Fuller et al. (2017)](https://doi.org/10.1093/icesjms/fsx128).


The directory structure follows Wilson et al. (2017) *Good enough practices in scientific computing*. 

- All Rmd scripts for the analysis are in **scripts**
- Custom functions sourced for the analysis are in **R**. Functions have been documented using `Roxygen2` syntax. 
- Documentation, including detailed descriptions of directed and undirected network structure, is in **doc**
- Raw, processed, and intermediate data files are saved in **data**
- Results (figures / tables, final network metrics) will be saved into  **results**

---

<br>

### Study Overview

> Climate shocks can reorganize the social-ecological linkages in food-producing communities, leading to a sudden loss of key products in food systems. The extent and persistence of this reorganization is difficult to observe and summarize, but is a critical aspect of predicting and rapidly assessing community vulnerability to extreme events. We apply network analysis to evaluate the impact of a climate shock – an unprecedented marine heatwave – with respect to patterns of resource use in California fishing communities, which were severely affected through closures of the Dungeness crab fishery. The climate shock significantly modified flows of users between fishery resources during the closures. These modifications were predicted by pre-shock patterns of resource use, and were associated with three strategies employed by community members, or vessels, to respond to the closures: temporary exit from the food system, spillover of effort from the Dungeness crab fishery into other fisheries, and spatial shifts in where fish were landed. Regional differences in resource use patterns and individual responses highlighted the Dungeness crab fishery as a seasonal “gilded trap” for northern California communities. We also detected disparities in individual response based on vessel size, with larger vessels more likely to display spatial mobility. Our study leverages network theory to demonstrate the importance of highly connected and decentralized networks of resource use in reducing the vulnerability of human communities to climate shocks. 


**Undirected fisheries participation networks** summarize patterns of resource use in commercial fishing communities by quantifying cross-fishery participation by commercial fishing vessels. The nodes of the network are fisheries, and the edges represent shared vessel participation. 

**Directed participation networks** provide a detailed description of spillover, or how a subset of vessels changed participation from one fishing season to the next. The nodes of the network are fisheries, and the edges show the flow of vessels out of fisheries from season 1 into fisheries from season 2.

Guides to each network type, including their construction and interpretation, are provided in the *doc* directory.

#### Some Definitions

Fisheries were defined with a data-driven approach. Individual PacFIN fish tickets, representing daily landings from individual vessels, were grouped based on gear type, species composition of catch, and ex-vessel revenue with a métier analysis modified from Fuller et al. (2017).  This analysis uses the `infomap` algorithm (Rosvall & Berstrom 2008) supplemented with the k-nearest neighbor algorithm.

Fishing seasons for Dungeness crab span two calendar years, and so this analysis uses "crab years;" each crab year spans from November of year 1 through October of year 2. For example, the 2016 crab year represents the 2015-16 fishing season, which begins in November of 2015. 

<br>

### Data

Raw landings and registration data are not included for confidentiality, and its use in Fisher et al. (in revision) is protected under a non-disclosure agreement. However, these data can be acquired by direct request from the California Department of Fish and Wildlife. We have provided the SQL code to download raw data from the PacFIN database in the [*data/raw*](https://github.com/mfisher5/ParticipationNetworks/tree/master/data/raw) folder.

We have provided the following aggregated, non-confidential data:
1. Adjacency matrices and `graph` objects for undirected fisheries participation networks (**data** directory)
2. Adjacency matrices and `graph` objects for directed participation networks (**data** directory)
3. Network metrics calculated for Fisher et al. (in revision), used to run generalized linear models (**results** directory)

<br>

We have also provided the following ancillary data in the **data** directory:

1. Duration of port group closures in the California Dungeness crab fishery, from the 2007 through 2017 crab years
2. The date that the first port of landing in each California port group opened during the 2016 crab year
3. Coordinates and Dungeness crab fishery betweenness centrality for California port groups

<br>
<br>

### Run the Analysis

To rerun the entire analysis, use the ordered .Rmd scripts in the **scripts** folder.

1. Fork and clone the repository.
2. Copy raw fish ticket and vessel registration data downloaded from PacFIN into the **data/raw** directory. This folder is already included in the `.gitignore` file. 
3. Run the scripts in order (details provided in the **scripts** directory README). We suggest that you check and update the `.gitignore` file after every script, to avoid accidentally publishing data containing confidential information.
4. Use the scripts in the **scripts/figures** folder to recreate the figures in Fisher et al. (in revision).

<br>

To replicate the output from the generalized linear models using the provided network data:
1. Run Section 3 of script *06_create_seasonal_networks.Rmd*.
2. Run scripts *07_explore_network_stats.Rmd* and *08_nested_GLMs*. You may have to update the name of the file containing the network metrics data.

You can also use the provided network metrics data file to run the generalized linear models, by skipping to script *08_nested_GLMs.Rmd*.

<br>

The scripts *Fig3.R* and *FigS5.R* will generate the directed participation networks using the provided `graph` objects in the **data/networks/vessel_flow** folder.
<br>
<br>
<br>
<br>


![ca-networks-img](https://github.com/mfisher5/ParticipationNetworks/blob/master/results/figures/fig1/example_network.png?raw=true)

---

References

E. C. Fuller et al., Characterizing fisheries connectivity in marine social–ecological systems. ICES Journal of Marine Science 74, 2087-2096 (2017).

M. Rosvall, C. T. Bergstrom, Maps of random walks on complex networks reveal community structure. Proceedings of the National Academy of Sciences 105, 1118 (2008).

