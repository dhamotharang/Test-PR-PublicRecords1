IMPORT HMS_SureScripts;
pVersion := '20151217';
EXPORT base_in_base := dataset('~thor400_data::base::hms::surescripts::' + pversion,base_Layout_base, flat, __Compressed__);