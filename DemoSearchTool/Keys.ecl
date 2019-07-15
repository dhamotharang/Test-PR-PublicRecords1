import  doxie;

EXPORT Keys := Module
 

	Export People			:= Index(	Dataset([], KeyLayouts.People_Layout) , 
																							{IsFCRA,First_Degree_Relatives_cnt,Second_Degree_Relatives_cnt,Third_Degree_Relatives_cnt,Associates_cnt,
																							Neighbors_cnt,AKAs_cnt,Bankruptcy_cnt,Corporate_Affiliation_cnt,Criminal_cnt,Criminal_DOC_cnt,
																							in_Deceased,Directory_Assistance_Gong_cnt,DL_cnt,Email_cnt,FAA_Aircraft_cnt,
																							Foreclosure_cnt,GWL_cnt,in_GWL_OFAC_Only,in_Address_HRI,in_SSN_HRI,Liens_cnt,Judgements_cnt,
																							Evictions_cnt,Marriage_and_Divorce_cnt,MVR_cnt,Notice_of_Default_cnt,People_at_Work_cnt,
																							in_Person_Header,PhonesPlus_cnt,Professional_License_cnt,Property_cnt,Registered_Agent_cnt,
																							Sex_Offender_cnt,Watercraft_cnt,Addresses_cnt,SSN_Cnt,mari_license_cnt,public_sanctn_cnt,
																							nonpublic_sanctn_cnt,freddiemac_sanctn_cnt,Owned_Business_bdid_cnt,Owned_Business_linkid_cnt, did},
																							KeyLayouts.People_Layout - [IsFCRA,First_Degree_Relatives_cnt,Second_Degree_Relatives_cnt,Associates_cnt,
																							Neighbors_cnt,AKAs_cnt,Bankruptcy_cnt,Corporate_Affiliation_cnt,Criminal_cnt,Criminal_DOC_cnt,
																							in_Deceased,Directory_Assistance_Gong_cnt,DL_cnt,Email_cnt,FAA_Aircraft_cnt,
																							Foreclosure_cnt,GWL_cnt,in_GWL_OFAC_Only,in_Address_HRI,in_SSN_HRI,Liens_cnt,Judgements_cnt,
																							Evictions_cnt,Marriage_and_Divorce_cnt,MVR_cnt,Notice_of_Default_cnt,People_at_Work_cnt,
																							in_Person_Header,PhonesPlus_cnt,Professional_License_cnt,Property_cnt,Registered_Agent_cnt,
																							Sex_Offender_cnt,Watercraft_cnt,Addresses_cnt,SSN_Cnt,mari_license_cnt,public_sanctn_cnt,
																							nonpublic_sanctn_cnt,freddiemac_sanctn_cnt,Owned_Business_bdid_cnt,Owned_Business_linkid_cnt, 
																							did,Third_Degree_Relatives_cnt],
																							Constants.SearchTool_Prefix + doxie.Version_SuperKey + '::people');

	Export Businesses_bdid	:= Index(	Dataset([], KeyLayouts.Business_Bdid_Layout),
																						{ IsFCRA, addresses_cnt,bankruptcy_cnt,in_business_header,business_associates_cnt,business_industry_naics_cnt,business_name_variations_cnt,business_registrations_cnt,corporations_sos_cnt,directory_assistance_gong_cnt,executives_cnt,faa_aircraft_cnt,fictitious_businesses_cnt,foreclosure_cnt,gwl_cnt,in_gwl_ofac_only,internet_domain_cnt,liens_cnt,judgements_cnt,evictions_cnt,mvr_cnt,property_cnt,registered_agent_cnt,ucc_cnt,watercraft_cnt,
																						mari_license_cnt,public_sanctn_cnt,nonpublic_sanctn_cnt,freddiemac_sanctn_cnt}, 
																						{ bdid},
																							Constants.SearchTool_Prefix + doxie.Version_SuperKey + '::business_bdid');
																			
	Export Businesses_linkids						:= Index(	Dataset([], KeyLayouts.Business_Linkids_Layout), 
																						{ addresses_cnt,bankruptcy_cnt,in_business_header,business_associates_cnt,business_industry_naics_cnt,business_name_variations_cnt,business_registrations_cnt,corporations_sos_cnt,directory_assistance_gong_cnt,executives_cnt,faa_aircraft_cnt,fictitious_businesses_cnt,foreclosure_cnt,gwl_cnt,in_gwl_ofac_only,internet_domain_cnt,liens_cnt,judgements_cnt,evictions_cnt,mvr_cnt,property_cnt,registered_agent_cnt,ucc_cnt,watercraft_cnt,
																						  mari_license_cnt,public_sanctn_cnt,nonpublic_sanctn_cnt,freddiemac_sanctn_cnt}, 
																							{ultid,orgid,seleid}, 
																							Constants.SearchTool_Prefix + doxie.Version_SuperKey + '::business_linkids'	);
	Export Combined_biz_bdid	:= Index(		Dataset([], KeyLayouts.Business_Bdid_Layout),
																						{bdid , IsFCRA, addresses_cnt,bankruptcy_cnt,in_business_header,business_associates_cnt,business_industry_naics_cnt,business_name_variations_cnt,business_registrations_cnt,corporations_sos_cnt,directory_assistance_gong_cnt,executives_cnt,faa_aircraft_cnt,fictitious_businesses_cnt,foreclosure_cnt,gwl_cnt,in_gwl_ofac_only,internet_domain_cnt,liens_cnt,judgements_cnt,evictions_cnt,mvr_cnt,property_cnt,registered_agent_cnt,ucc_cnt,watercraft_cnt,
																						mari_license_cnt,public_sanctn_cnt,nonpublic_sanctn_cnt,freddiemac_sanctn_cnt}, 
																						{ fp},
																							Constants.SearchTool_Prefix + doxie.Version_SuperKey + '::combined_biz_bdid');
																			
	Export Combined_biz_linkids						:= Index(		Dataset([], KeyLayouts.Business_Linkids_Layout), 
																						{ultid, orgid,  seleid, addresses_cnt,bankruptcy_cnt,in_business_header,business_associates_cnt,business_industry_naics_cnt,business_name_variations_cnt,business_registrations_cnt,corporations_sos_cnt,directory_assistance_gong_cnt,executives_cnt,faa_aircraft_cnt,fictitious_businesses_cnt,foreclosure_cnt,gwl_cnt,in_gwl_ofac_only,internet_domain_cnt,liens_cnt,judgements_cnt,evictions_cnt,mvr_cnt,property_cnt,registered_agent_cnt,ucc_cnt,watercraft_cnt,
																						mari_license_cnt,public_sanctn_cnt,nonpublic_sanctn_cnt,freddiemac_sanctn_cnt}, 
																						{__internal_fpos__}, 
																							Constants.SearchTool_Prefix + doxie.Version_SuperKey + '::combined_biz_linkids'
																			);
	Export DTC					:= Index(		Dataset([], KeyLayouts.People_Layout), 
																							{First_Degree_Relatives_cnt,Second_Degree_Relatives_cnt,Third_Degree_Relatives_cnt,Associates_cnt,
																							Neighbors_cnt,AKAs_cnt,Bankruptcy_cnt,Corporate_Affiliation_cnt,Criminal_cnt,Criminal_DOC_cnt,
																							in_Deceased,Directory_Assistance_Gong_cnt,DL_cnt,Email_cnt,FAA_Aircraft_cnt,
																							Foreclosure_cnt,GWL_cnt,in_GWL_OFAC_Only,in_Address_HRI,in_SSN_HRI,Liens_cnt,Judgements_cnt,
																							Evictions_cnt,Marriage_and_Divorce_cnt,MVR_cnt,Notice_of_Default_cnt,People_at_Work_cnt,
																							in_Person_Header,PhonesPlus_cnt,Professional_License_cnt,Property_cnt,Registered_Agent_cnt,
																							Sex_Offender_cnt,Watercraft_cnt,Addresses_cnt,SSN_Cnt,mari_license_cnt,public_sanctn_cnt,
																							nonpublic_sanctn_cnt,freddiemac_sanctn_cnt,Owned_Business_bdid_cnt,Owned_Business_linkid_cnt, did},
																							KeyLayouts.People_Layout - [IsFCRA,First_Degree_Relatives_cnt,Second_Degree_Relatives_cnt,Associates_cnt,
																							Neighbors_cnt,AKAs_cnt,Bankruptcy_cnt,Corporate_Affiliation_cnt,Criminal_cnt,Criminal_DOC_cnt,
																							in_Deceased,Directory_Assistance_Gong_cnt,DL_cnt,Email_cnt,FAA_Aircraft_cnt,
																							Foreclosure_cnt,GWL_cnt,in_GWL_OFAC_Only,in_Address_HRI,in_SSN_HRI,Liens_cnt,Judgements_cnt,
																							Evictions_cnt,Marriage_and_Divorce_cnt,MVR_cnt,Notice_of_Default_cnt,People_at_Work_cnt,
																							in_Person_Header,PhonesPlus_cnt,Professional_License_cnt,Property_cnt,Registered_Agent_cnt,
																							Sex_Offender_cnt,Watercraft_cnt,Addresses_cnt,SSN_Cnt,mari_license_cnt,public_sanctn_cnt,
																							nonpublic_sanctn_cnt,freddiemac_sanctn_cnt,Owned_Business_bdid_cnt,Owned_Business_linkid_cnt, 
																							did,Third_Degree_Relatives_cnt],
																							Constants.SearchTool_Prefix + doxie.Version_SuperKey + '::dtc');
	
	Export Business_Address						:= Index( 	Dataset([], KeyLayouts.Business_Address_Layout),
																							{  BDID_cnt, seleid_cnt, prim_range, prim_name,sec_range, zip },
																							KeyLayouts.Business_Address_Layout - [ BDID_cnt, seleid_cnt, prim_range, prim_name,sec_range, zip],
																							Constants.SearchTool_Prefix + doxie.Version_SuperKey + '::business_address');
	
End;