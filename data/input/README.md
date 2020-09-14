## Input Data

All input data is derived from confidential landings and registration data obtained through [PacFIN](http://pacfin.psmfc.org/) with direct permission from the California Department of Fish and Wildlife. Input data includes non-aggregated, confidential information on individual vessels, and so is not provided here. Information on fishery landings data from the California Department of Fish and Wildlife, including data sharing request forms, can be found on their [website](https://wildlife.ca.gov/Conservation/Marine/MFSU#48329363-overview--background).

<br>

#### Vessel Length

*Description:* Vessel length is self-reported annually in California Department of Fish and Wildlife vessel registration data. This data must be pre-processed after sourcing from PacFIN, to account for human error in data entry, and crab seasons which span two registration years. For details on this process, refer to the Supplementary Material.

- drvid: vessel identification number (PacFIN registration data equivalent is DRVID. Fish ticket equivalent is VESSEL_NUM)
- agency_code: the state in which the vessel was registered (PacFIN registration data equivalent is AGENCY_CODE)
- year: the year of registration (PacFIN registration data equivalent is REGISTRATION_YEAR)
- FINAL_LENGTH: vessel length (in feet) calculated from the vessel registration data. 
- TYPE_CALC: String describing how the vessel length was calculated.
- UNIQUE_LENGTHS: The number of unique vessel lengths reported in the registration data for this vessel, within the 2/4 years preceding the registration year.
- N_YEARS_LENGTH_RECORDED: Number of years with a reported length for the vessel.
- HISTORIC_DATA: Whether there was insufficient information during the first 3 year search for reported vessel length. If so, 5 years of registration data was used for length calculation. 

*Source:* Raw PacFIN data

<br>
<br>


#### Pre-processed fish ticket data

*Description:* Fish ticket, or landing receipts, data are composed of fishery landings by vessel and date. Fish tickets are used for identifying fisheries through metier analysis, and for constructing networks. They must be pre-processed after sourcing from PacFIN to complete either analysis. The following lists the data included in each data frame, and the corresponding PacFIN name. For full descriptions of the data, refer to the PacFIN documentation for [COMPREHENSIVE_FT](http://pacfin.psmfc.org/wp-content/uploads/2016/06/PacFIN_Comprehensive_Fish_Tickets.pdf)

- trip id: FISH_TICKET_ID 
- year: LANDING_YEAR
- tdate: LANDING_DATE
- pcgroup: PACFIN_GROUP_PORT_CODE
- pcid: PACFIN_PORT_CODE
- spid: PACFIN_SPECIES_CODE
- spid_recode: Edited PacFIN species code, to replace [nominal species IDs](https://pacfin.psmfc.org/data/faqs/). (No PacFIN equivalent)
- council: COUNCIL_CODE
- grgroup: PACFIN_GROUP_GEAR_CODE
- grid: GEAR_CODE
- removal_type: REMOVAL_TYPE_NAME
- removal_type_code: REMOVAL_TYPE_CODE
- drvid: VESSEL_NUM
- drvid_year: String that combines the vessel identification number and the landing year (No PacFIN equivalent)
- proc: DEALER_NUM
- fleet: FLEET_CODE
- pounds: LANDED_WEIGHT_LBS
- ppp: PRICE_PER_POUND
- adj_ppp: Recalculated price per pound, for commercial fish tickets which record pounds landed for commercial / direct sales, but do not record revenue from the sale (No PacFIN equivalent)
- revenue: EXVESSEL_REVENUE
- adj_revenue: Recalculated exvessel revenue, for commercial fish tickets which record pounds landed for commercial / direct sales, but do not record revenue from the sale (No PacFIN equivalent)


*Source:* Raw PacFIN data run through `script 00` (`process_fish_tickets_for_networks`)

<br>
<br>

#### Fish tickets with assigned metiers

*Description:* Fish ticket, or landing receipts, data are composed of fishery landings by vessel and date. These tickets also have an assigned metier or fishery. They will be split into separate data frames by crab year and by port group, with the exception of the reference tickets that were used to run infomap - these data frames may be composed of multiple crab years. In addition to the columns listed in the previous section, the data frame includes:

- metier.num: The metier number assigned to the fish ticket by infomap or the k-nearest neighbor algorithm. Numbers will be specific to port groups, so may be repeated across port groups. 
- metier.name: The name for each metier; if assigned automatically, will be composed of a species ID and a gear group ID.

*Source:* Pre-processed PacFIN fish tickets run through `script 01` through `script 04`

<br>
<br>










