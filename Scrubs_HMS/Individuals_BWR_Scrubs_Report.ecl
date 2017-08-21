IMPORT HMS, Scrubs_HMS;
filename := '~thor400_data::base::hms_pm::hms_individuals::' + Scrubs_HMS.pVersion;
EXPORT Individuals_BWR_Scrubs_Report := DATASET(filename, hms.layouts.individual_base, flat, __compressed__);