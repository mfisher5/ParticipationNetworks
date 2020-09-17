## Input Data, Fish Tickets with Metiers

Fish tickets with metiers assigned; for reference years, the output of script 3, for all other years, the output of scripts 4 and 5. 

Information included in the data frame:
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
- metier.num: The metier number assigned to the fish ticket by infomap or the k-nearest neighbor algorithm. Numbers will be specific to port groups, so may be repeated across port groups. 
- metier.name: The name for each metier; if assigned automatically, will be composed of a species ID and a gear group ID.
