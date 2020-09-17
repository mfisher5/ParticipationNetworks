## Input Data, Vessel Length Keys

Vessel lengths for registered commercial fishing vessels, by crab year. Information provided in the data frame:
- drvid: vessel identification number (PacFIN registration data equivalent is DRVID. Fish ticket equivalent is VESSEL_NUM)
- agency_code: the state in which the vessel was registered (PacFIN registration data equivalent is AGENCY_CODE)
- year: the year of registration (PacFIN registration data equivalent is REGISTRATION_YEAR)
- FINAL_LENGTH: vessel length (in feet) calculated from the vessel registration data. 
- TYPE_CALC: String describing how the vessel length was calculated.
- UNIQUE_LENGTHS: The number of unique vessel lengths reported in the registration data for this vessel, within the 2/4 years preceding the registration year.
- N_YEARS_LENGTH_RECORDED: Number of years with a reported length for the vessel.
- HISTORIC_DATA: Whether there was insufficient information during the first 3 year search for reported vessel length. If so, 5 years of registration data was used for length calculation. 