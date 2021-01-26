# Vessel Lengths from PacFIN Registration Data

We distinguish between small (<40 feet in length) and large (40+ feet in length) vessels in our analysis. 
Vessel length information was drawn from vessel registration data, obtained through [PacFIN](http://pacfin.psmfc.org/). To account for recording and other errors in the registration data set, the reported vessel length went through a few quality control steps to get to the processed vessel lengths that we used for our analysis. 

This doc will walk through the data processing, with specific reference to functions and scripts included in this repository.

<br>

## Vessel registration from PacFIN: Reported Vessel Lengths 

We used the following SQL code to download California Department of Fish and Wildlife vessel registration data from PacFIN:

```
select *
FROM pacfin_foundation.vessel_registrations vr
where vr.REGISTRATION_YEAR between 2008 AND 2018
and vr.agency_code = 'C' 
```

<br>

## Custom R functions: Processed Vessel Lengths

The function `calc_length` will provide a "processed" vessel length for each calendar year by drawing on 3-5 years of vessel registration data.  

This function calls two other custom R functions: `get_median_length` will calculate the median length from the two most recent years of registration data, and `get_historic_length` will expand the search area in the registration data from 2 years prior to 4 years prior of the given calendar year. 

The following flow chart depicts the major decision points in the `calc_length` function.

![length_fx_chart](https://github.com/mfisher5/ParticipationNetworks/blob/master/doc/img/length_flowchart.png?raw=true)


## Script 00 Workflow: Processed Vessel Lengths

The above functions are called in *Section 3* of the script [`00_process_fish_tickets_for_networks`](https://github.com/mfisher5/ParticipationNetworks/blob/master/scripts/00_process_fish_tickets_for_networks.Rmd), which also provides a description of the `calc_length` function. 

This script allows you to read in the raw vessel registration data pulled from PacFIN, filters for unlikely vessel lengths (the upper and lower cutoffs can be changed), and then applies the `calc_length` function to each calendar year of vessel registration data that has been read into R. The final data frame saves the following information into an output file:

- **drvid**: vessel identification number, which matches that in fish ticket data
- **agency_code**: abbreviation for the state agency that has provided the vessel registration information (C/O/W)
- **year**: calendar year for which the vessel length applies
- **FINAL_LENGTH**: the processed vessel length for the given calendar year
- **TYPE_CALC**: the type of calculation that produced the given length
- **UNIQUE_LENGTHS**: the number of unique vessel lengths that were reported for the vessel over the most recent 3-5 years of registration data
- **N_YEARS_LENGTH_RECORDED**: the number of years (out of a maximum of 3 or 5) that the given vessel had reported length available in the registration data
- **HISTORIC_DATA**: Did the function have to reach back into the most recent 5 years of registration data, because 3 years did not provide enough information?





