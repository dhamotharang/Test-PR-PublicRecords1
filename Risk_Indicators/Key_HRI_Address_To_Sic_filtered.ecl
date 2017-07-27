Import Data_Services, Doxie, business_header, Data_Services;

hri_base_file := files().HRIAddressSicCodeFCRA.built((integer)zip<>0);

Export Key_HRI_Address_To_Sic_filtered := index (hri_base_file, 
																		   {z5 := zip,prim_name, suffix := addr_suffix,predir, postdir,prim_range,sec_range,dt_first_seen},
																		   {sic_code, company_name, city, state, source},
																		   Data_Services.Data_Location.Prefix('HRI')+
																		   'thor_data400::key::hri_address_to_sic_filtered_' + doxie.Version_SuperKey);			 
