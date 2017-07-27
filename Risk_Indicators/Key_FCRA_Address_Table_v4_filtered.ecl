import doxie, Data_Services;

isfcra := true;
f := risk_indicators.Address_Table_v4(isfcra);

export Key_FCRA_Address_Table_v4_filtered := index(f,{zip,prim_name,prim_range,sec_range},{f},
		// Data_Services.Data_Location.Prefix('DeathMaster')+'thor_data400::key::death_master::'+doxie.Version_SuperKey+'::address_table_v4_filtered');
		'~thor_data400::key::death_master::fcra::'+doxie.Version_SuperKey+'::address_table_v4_filtered');