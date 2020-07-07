Import Data_Services, risk_indicators,business_header,Data_Services, vault, _control;

hri_base_file := files().HRIAddressSicCode.built((integer)zip<>0);

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca

Export Key_HRI_Address_To_Sic := vault.Risk_Indicators.Key_HRI_Address_To_Sic;

#ELSE

Export Key_HRI_Address_To_Sic := index(hri_base_file, 
																		   {z5 := zip, prim_name,
																			suffix := addr_suffix,predir,
																			postdir, prim_range, sec_range, dt_first_seen},
																		   {sic_code,  company_name, city, state, Source},
																		   Data_Services.Data_Location.Prefix('HRI')+
																		   'thor_data400::key::hri_address_to_sic_qa');

#END;