IMPORT HMS_Medicaid_IL;
pVersion := '20151005';
EXPORT base_in_base := dataset('~thor400_data::base::hms::Medicaid::IL::' + pversion,base_Layout_base, flat, __Compressed__);