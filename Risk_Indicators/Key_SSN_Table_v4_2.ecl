import doxie, data_services, ut;

isFCRA := false;
r := risk_indicators.SSN_Table_v4_2(isFCRA);

export Key_SSN_Table_v4_2 := index(r,{ssn},{r},
	// Data_Services.Data_Location.Prefix('DeathMaster')+'thor_data400::key::death_master::'+doxie.Version_SuperKey+'::ssn_table_v4_2');
	'~thor_data400::key::death_master::'+doxie.Version_SuperKey+'::ssn_table_v4_2');
	// ut.foreign_dataland+'thor_data400::key::death_master::'+doxie.Version_SuperKey+'::ssn_table_v4_2');