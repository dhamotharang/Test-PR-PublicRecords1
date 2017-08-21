IMPORT HMS_SureScripts;
pVersion := '20150716';
EXPORT base_BWR_Scrubs_Report := dataset('~thor400_data::base::hms::surescripts::' + pversion,base_Layout_base, flat, __Compressed__);