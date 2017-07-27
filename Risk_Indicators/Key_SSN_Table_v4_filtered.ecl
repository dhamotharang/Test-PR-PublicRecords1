import doxie, Data_Services;

isFCRA := true;
r := risk_indicators.SSN_Table_v4(isFCRA);  

export Key_SSN_Table_v4_filtered := index (r, {ssn}, {r}, 
	// Data_Services.Data_Location.Prefix('DeathMaster')+'thor_data400::key::death_master::'+doxie.Version_SuperKey+'::ssn_table_v4_filtered');
	'~thor_data400::key::death_master::'+doxie.Version_SuperKey+'::ssn_table_v4_filtered');
