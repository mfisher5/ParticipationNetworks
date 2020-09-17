## Input Data

Most input data is derived from confidential landings and registration data obtained through [PacFIN](http://pacfin.psmfc.org/) with direct permission from the California Department of Fish and Wildlife. Information on confidential fishery landings data collected and stored by the California Department of Fish and Wildlife, including data sharing request forms, can be found on their [website](https://wildlife.ca.gov/Conservation/Marine/MFSU#48329363-overview--background).

<br>

#### Ancillary Input Data

The following files contain fishing season and port group information that is used to conduct analysis and generate graphs:

1. *crab_open_dates.txt*: The date that the first port of landing in each California port group opened during the 2016 crab year.
	*`crab_year` (crab year)
	* `pcgroup` (3 letter port group code), 
	*`odate` (season start date, MM/DD/YYYY format)

2. *DCRB_Historic_Closures_CA_updated.csv*: Duration of port group closures in the California Dungeness crab fishery, from the 2007 through 2017 crab years. 
	a. `y` (crab year)
	b. `pcgroup` (3 letter port group code)
	c. `days.closed` (minimum number of days any port of landing within the given port group was delayed from the codified start date)

3. *pcgroup_mean_coordinates.csv*: Coordinates and Dungeness crab fishery betweenness centrality for California port groups. 
	a. `port_group`(3 letter port group code)
	b. `Lon` (longitude)
	c. `Lat` (latitude)
	d. `port_group_name` (full name of port group)
	e. `Lon_label` (longitude for label)
	f. `Lat_label` (latitude for label)
	g. `dcrb_between` (betweenness centrality of the Dungeness crab fishery)
	h. `region` (region to which the port group belongs, based on clustering analysis of undirected participation networks)

<br>

#### Vessel Length

*Description:* Vessel length is self-reported annually in California Department of Fish and Wildlife vessel registration data. This data must be pre-processed after sourcing from PacFIN, to account for human error in data entry, and crab seasons which span two registration years. For details on this process, refer to the Supplementary Material.

*Source:* Raw PacFIN data

<br>
<br>


#### Pre-processed fish ticket data

*Description:* Fish ticket, or landing receipts, data are composed of fishery landings by vessel and date. Fish tickets are used for identifying fisheries through metier analysis, and for constructing networks. They must be pre-processed after sourcing from PacFIN to complete either analysis. The following lists the data included in each data frame, and the corresponding PacFIN name. For full descriptions of the data, refer to the PacFIN documentation for [COMPREHENSIVE_FT](http://pacfin.psmfc.org/wp-content/uploads/2016/06/PacFIN_Comprehensive_Fish_Tickets.pdf)

*Source:* Raw PacFIN data run through `script 00` (`process_fish_tickets_for_networks`)

<br>
<br>

#### Fish tickets with assigned metiers

*Description:* Fish ticket, or landing receipts, data are composed of fishery landings by vessel and date. These tickets also have an assigned metier or fishery. They will be split into separate data frames by crab year and by port group, with the exception of the reference tickets that were used to run infomap - these data frames may be composed of multiple crab years. In addition to the columns listed in the previous section, the data frame includes:

*Source:* Pre-processed PacFIN fish tickets run through `script 01` through `script 04`

<br>
<br>










