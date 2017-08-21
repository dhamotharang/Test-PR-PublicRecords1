Import Data_Services, risk_indicators,business_header,Data_Services,PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
hri_base_file := PRTE2_Business_Header.Files_Prte_Addr_HRI_Keys().HRI_Addr_Sic;
#ELSE
hri_base_file := files().HRIAddressSicCode.built((integer)zip<>0);
#END;

Export Key_HRI_Address_To_Sic := index(hri_base_file, 
																		   {z5 := zip, prim_name,
																			suffix := addr_suffix,predir,
																			postdir, prim_range, sec_range, dt_first_seen},
																		   {sic_code,  company_name, city, state, Source},
																		   Data_Services.Data_Location.Prefix('HRI')+
																		   'thor_data400::key::hri_address_to_sic_qa');