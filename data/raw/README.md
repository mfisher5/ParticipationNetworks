## Raw Data

Confidential landings and registration data obtained through [PacFIN](http://pacfin.psmfc.org/) with direct permission from the California Department of Fish and Wildlife. The raw data is composed of non-aggregated, confidential information on individual vessels, and so is not provided here. Information on fishery landings data from the California Department of Fish and Wildlife, including data sharing request forms, can be found on their [website](https://wildlife.ca.gov/Conservation/Marine/MFSU#48329363-overview--background).


### Pulling Fish Ticket Data

We used the following SQL code to download California Department of Fish and Wildlife data from the PacFIN comprehensive fish tickets database:

```
select *
FROM pacfin_marts.comprehensive_ft cft
where cft.pacfin_year between 2008 AND 2018
and cft.agency_code = 'C'
```



### Pulling Vessel Registration Data

We used the following SQL code to download California Department of Fish and Wildlife data from the PacFIN vessel registration database:

```
select *
FROM pacfin_foundation.vessel_registrations vr
where vr.REGISTRATION_YEAR between 2008 AND 2018
and vr.agency_code = 'C' 
```

