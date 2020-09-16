# Guide to Directed Networks: Vessel Flow Between Fishery Alternatives

Directed networks summarise and visualize changes in fishery participation undertaken by a subset of vessels from one fishing season to the next. In Fisher et al. (in revision), we constructed directed networks for each California port group to observe changes in fishery participation undertaken by Dungeness crab vessels between the 2015 and 2016 crab years.

## Basic Network Structure

The ***nodes*** of the network are composed primarily of fisheries; we also included two non-fishery nodes in order to capture (1) exit from the fishing industry (No Fishing), and (2) switching to a different port group to land catch (Other Port), during the time period observed. 

The ***edges*** of the network indicate vessel 'movement' *out* of the fishery at the start of the directed edge, and *into* the fishery or alternative at the end of the directed edge. For example, if a vessel which only records Dungeness crab catch in 2015 then records landings of only sablefish in 2016, there would be a directed edge which starts at the Dungeness crab node and points toward the sablefish node. For easier visualization, fisheries that have outward flow are placed toward the left side of the network, and fisheries that have inward flow are placed toward the right side of the network. 

We also make use of a specific type of edge called a **self-loop** to represent continued participation in a given fishery from one year to the next. If the vessel from the previous example had fished both Dungeness crab and sablefish in 2015, and then only fished for sablefish in 2016, there would be a self-loop at the sablefish node. There would *not* be a directed edge out of the Dungeness crab node, because the vessel is not moving into a new fishery. 

This network structure does make it possible for a single vessel to be present in multiple nodes and edges. 


## Weighting and Color

Edges are weighted by the number of vessels undertaking the represented shift in participation. 

Nodes are sized according to the number of vessels which participated in the represented fishery (or "No Fishing", "Other Port" alternatives). These

The color of each node indicates the gear type used in the fishery (with "No Fishing", "Other Port" alternatives in gray). 

![node-color-legend](https://github.com/mfisher5/ParticipationNetworks/blob/master/doc/img/network_node_legend.png?raw=true)

<br>

## Splitting the Fishing Season

We refer to each commercial fishing season using “crab years,” which span from November through October of the following year. For example, the 2016 crab year corresponds to the 2015-16 fishing season (i.e. Nov. 2015 - Oct. 2016). To observe behavioral responses during and immediately after the 2016 closures, we further subset each crab year into an early and a late season delineated by the dates of the 2016 closures. Spatial variation was observed at a regional level. The dates used to split the fish ticket data for each region and crab year were as follows:

![table-season-dates](https://github.com/mfisher5/ParticipationNetworks/blob/master/doc/img/table_split_crab_year.png?raw=true)

<br>

### Early Season Networks

The position of the fisheries from left (2015) to right (2016) on the ‘x’ axis is according to the direction of vessel flow. In the early season, the only fishery which ‘lost’ vessels was the Dungeness crab fishery, and so the Dungeness crab fishery is the only one on the left (2015) side of the graph. 

In the example below, you can see that some vessels did not land any commercial fishery catch during the 2016 late season, represented by the directed edge which starts at the Dungeness crab fishery node and ends at the "No Fishing" node.

![early-network](https://github.com/mfisher5/ParticipationNetworks/blob/master/doc/img/early_directed_network_example.png?raw=true)

<br>

### Late Season Networks

The position of the fisheries from left (2015) to right (2016) on the ‘x’ axis is according to the direction of vessel flow. Whereas in the early season the only fishery which ‘lost’ vessel participation was the Dungeness crab fishery, in the late season some vessels switched out of a non-Dungeness fishery (positioned left) into the Dungeness crab fishery (positioned right).

Since Dungeness crab vessels have more diverse fishery participation in the late season, there will be a lot more self-loops in these graphs. 

In the first graph of the example below, vessels which only landed Chinook during the 2015 late season instead landed Dungeness crab in the 2016 late season. 

![late-network](https://github.com/mfisher5/ParticipationNetworks/blob/master/doc/img/late_directed_network_example.png?raw=true)







