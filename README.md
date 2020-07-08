# Fisheries Participation Networks

Use California fishery landings data to generate and analyze fisheries participation networks as in Fisher et al. (in prep). 

> Climate shocks can reorganize the social-ecological linkages in food-producing communities, leading to a sudden loss of key products in food systems. The extent and persistence of this reorganization is difficult to observe and summarize, but is a critical aspect of predicting and rapidly assessing community vulnerability to extreme events. We apply network analysis to evaluate the impact of a climate shock – an unprecedented marine heatwave – with respect to patterns of resource use in California fishing communities, which were severely affected through closures of the Dungeness crab fishery. The climate shock significantly modified flows of users between fishery resources during the closures. These modifications were predicted by pre-shock patterns of resource use, and were associated with three strategies employed by community members, or vessels, to respond to the closures: temporary exit from the food system, spillover of effort from the Dungeness crab fishery into other fisheries, and spatial shifts in where fish were landed. Regional differences in resource use patterns and individual responses highlighted the Dungeness crab fishery as a seasonal “gilded trap” for northern California communities. We also detected disparities in individual response based on vessel size, with larger vessels more likely to display spatial mobility. Our study leverages network theory to demonstrate the importance of highly connected and decentralized networks of resource use in reducing the vulnerability of human communities to climate shocks. 


The directory structure follows Wilson et al. (2017) *Good enough practices in scientific computing*. All Rmd scripts for the analysis are in **scripts**, custom functions sourced for the analysis are in **R**,  documentation is in **doc**, and all raw, processed, and intermediate data files are saved in the **data** directory. Results (figures / table, final network metrics) will be saved into the **results** folder. Functions have been documented using `Roxygen2` syntax. This repository builds on R code from [Fuller et al. (2017)](https://doi.org/10.1093/icesjms/fsx128).

Raw landings and registration data is not included for confidentiality, and its use in this research is protected under a non-disclosure agreement. However, these data can be acquired by direct request from the California Department of Fish and Wildlife. 
The non-confidential igraph objects and network statistics, used to produce tables / figures and run GLMs, are provided in the **data** folder.

To rerun the entire analysis, use the ordered .Rmd scripts in the **scripts** folder.

---

![ca-networks-img](https://github.com/mfisher5/ParticipationNetworks/blob/master/results/figures/fig1/example_network.png?raw=true)




