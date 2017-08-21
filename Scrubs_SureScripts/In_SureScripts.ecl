IMPORT HMS_SureScripts;
pVersion := '20151217';
EXPORT In_SureScripts := dataset('~thor400_data::in::hms::surescripts::' + pversion,SureScripts_Layout_SureScripts, THOR);
//EXPORT SureScripts_In_SureScripts := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name ;