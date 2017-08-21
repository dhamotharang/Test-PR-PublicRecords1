import doxie, Data_Services, ut;

isfcra := false;
f := risk_indicators.Address_Table_v4(isfcra);

export Key_Address_Table_v4 := index(f,{zip,prim_name,prim_range,sec_range},{f},
				// Data_Services.Data_Location.Prefix('DeathMaster')+'thor_data400::key::death_master::'+doxie.Version_SuperKey+'::address_table_v4');
				'~thor_data400::key::death_master::'+doxie.Version_SuperKey+'::address_table_v4');
