import  doxie;

EXPORT Keys := Module
 
	peoplef := 	Project(file_combined_people(true, false), {Boolean IsFCRA := true, file_combined_people(true, false)});
	peoplen :=  Project(file_combined_people(false, false), {Boolean IsFCRA := false, file_combined_people(false, false)});
	
	Export People			:= Index(	peoplef + peoplen , 
																								 	{IsFCRA,First_Degree_Relatives_cnt,Second_Degree_Relatives_cnt,Third_Degree_Relatives_cnt,Associates_cnt,
																										 Neighbors_cnt,AKAs_cnt,Bankruptcy_cnt,Corporate_Affiliation_cnt,Criminal_cnt,Criminal_DOC_cnt,
																										 in_Deceased,Directory_Assistance_Gong_cnt,DL_cnt,Email_cnt,FAA_Aircraft_cnt,
																										 Foreclosure_cnt,GWL_cnt,in_GWL_OFAC_Only,in_Address_HRI,in_SSN_HRI,Liens_cnt,Judgements_cnt,
																										 Evictions_cnt,Marriage_and_Divorce_cnt,MVR_cnt,Notice_of_Default_cnt,People_at_Work_cnt,
																										 in_Person_Header,PhonesPlus_cnt,Professional_License_cnt,Property_cnt,Registered_Agent_cnt,
																										 Sex_Offender_cnt,Watercraft_cnt,Addresses_cnt,SSN_Cnt,mari_license_cnt,public_sanctn_cnt,
																										 nonpublic_sanctn_cnt,freddiemac_sanctn_cnt, Owned_Business_bdid_cnt,Owned_Business_linkid_cnt, 
																										 did},
																									 {peoplef + peoplen},
																									Constants.SearchTool_Prefix + doxie.Version_SuperKey + '::people');
				
	shared Businesses_bdidf := Project(file_combined_business(true, true), {boolean IsFCRA := true, file_combined_business(true, true), integer fp := 0});
	shared Businesses_bdidn := Project(file_combined_business(false, true), {boolean IsFCRA := false, file_combined_business(false, true), integer fp := 0});

	Export Businesses_bdid	:= Index(	Businesses_bdidf +  Businesses_bdidn,
																																	{ IsFCRA, addresses_cnt,bankruptcy_cnt,in_business_header,business_associates_cnt,
																																			business_industry_naics_cnt,business_name_variations_cnt,business_registrations_cnt,
																																			corporations_sos_cnt,directory_assistance_gong_cnt,executives_cnt,faa_aircraft_cnt,
																																			fictitious_businesses_cnt,foreclosure_cnt,gwl_cnt,in_gwl_ofac_only,internet_domain_cnt,
																																			liens_cnt,judgements_cnt,evictions_cnt,mvr_cnt,property_cnt,registered_agent_cnt,ucc_cnt,
																																			watercraft_cnt,mari_license_cnt,public_sanctn_cnt,nonpublic_sanctn_cnt,freddiemac_sanctn_cnt}, 
																																	{unsigned6 bdid := id,}, 
																																	Constants.SearchTool_Prefix + doxie.Version_SuperKey + '::business_bdid');
																			
	Export Businesses_linkids						:= Index(	file_combined_business(false, false), 
																																								{ addresses_cnt,bankruptcy_cnt,in_business_header,business_associates_cnt,
																																								  business_industry_naics_cnt,business_name_variations_cnt,business_registrations_cnt,
																																									 corporations_sos_cnt,directory_assistance_gong_cnt,executives_cnt,faa_aircraft_cnt,
																																									 fictitious_businesses_cnt,foreclosure_cnt,gwl_cnt,in_gwl_ofac_only,internet_domain_cnt,
																																									 liens_cnt,judgements_cnt,evictions_cnt,mvr_cnt,property_cnt,registered_agent_cnt,ucc_cnt,
																																									 watercraft_cnt,mari_license_cnt,public_sanctn_cnt,nonpublic_sanctn_cnt,freddiemac_sanctn_cnt}, 
																																								{file_combined_business(false, false), unsigned6 seleid := id}- [id], 
																																								Constants.SearchTool_Prefix + doxie.Version_SuperKey + '::business_linkids');
																																								
	Export Combined_biz_bdid	:= Index(	Businesses_bdidf +  Businesses_bdidn,
																																			{unsigned6 bdid := id, IsFCRA, 
 																																			addresses_cnt,bankruptcy_cnt,in_business_header,business_associates_cnt,business_industry_naics_cnt,
																																			 business_name_variations_cnt,business_registrations_cnt,corporations_sos_cnt,directory_assistance_gong_cnt,
																																			 executives_cnt,faa_aircraft_cnt,fictitious_businesses_cnt,foreclosure_cnt,gwl_cnt,in_gwl_ofac_only,
																																			 internet_domain_cnt,liens_cnt,judgements_cnt,evictions_cnt,mvr_cnt,property_cnt,registered_agent_cnt,
																																			 ucc_cnt,watercraft_cnt,mari_license_cnt,public_sanctn_cnt,nonpublic_sanctn_cnt,freddiemac_sanctn_cnt}, 
																																			{fp}, 
																																		Constants.SearchTool_Prefix + doxie.Version_SuperKey + '::combined_biz_bdid');
																			
	Export Combined_biz_linkids						:= Index(	file_combined_business(false, false), 
																																											{ultid, orgid, unsigned6 seleid := id, addresses_cnt,bankruptcy_cnt,in_business_header,
																																											 business_associates_cnt,business_industry_naics_cnt,business_name_variations_cnt,
																																											 business_registrations_cnt,corporations_sos_cnt,directory_assistance_gong_cnt,
																																											 executives_cnt,faa_aircraft_cnt,fictitious_businesses_cnt,foreclosure_cnt,gwl_cnt,
																																											 in_gwl_ofac_only,internet_domain_cnt,liens_cnt,judgements_cnt,evictions_cnt,mvr_cnt,
																																											 property_cnt,registered_agent_cnt,ucc_cnt,watercraft_cnt,mari_license_cnt,
																																											 public_sanctn_cnt,nonpublic_sanctn_cnt,freddiemac_sanctn_cnt}, 
																																											{file_combined_business(false, false)}- [id], 
																																											Constants.SearchTool_Prefix + doxie.Version_SuperKey + '::combined_biz_linkids');
																																											
	Export DTC					:= Index(	file_combined_people(false, true), 
																									{First_Degree_Relatives_cnt,Second_Degree_Relatives_cnt,Third_Degree_Relatives_cnt,Associates_cnt,
																									Neighbors_cnt,AKAs_cnt,Bankruptcy_cnt,Corporate_Affiliation_cnt,Criminal_cnt,Criminal_DOC_cnt,
																									in_Deceased,Directory_Assistance_Gong_cnt,DL_cnt,Email_cnt,FAA_Aircraft_cnt,
																									Foreclosure_cnt,GWL_cnt,in_GWL_OFAC_Only,in_Address_HRI,in_SSN_HRI,Liens_cnt,Judgements_cnt,
																									Evictions_cnt,Marriage_and_Divorce_cnt,MVR_cnt,Notice_of_Default_cnt,People_at_Work_cnt,
																									in_Person_Header,PhonesPlus_cnt,Professional_License_cnt,Property_cnt,Registered_Agent_cnt,
																									Sex_Offender_cnt,Watercraft_cnt,Addresses_cnt,SSN_Cnt,mari_license_cnt,public_sanctn_cnt,
																									nonpublic_sanctn_cnt,freddiemac_sanctn_cnt,Owned_Business_bdid_cnt,Owned_Business_linkid_cnt, 
																									did},
																									{file_combined_people(false,true)},
																									Constants.SearchTool_Prefix + doxie.Version_SuperKey + '::dtc');
	
	Export Business_Address						:= Index( file_address_businesses,
																																							{  BDID_cnt, seleid_cnt, prim_range, prim_name,sec_range, zip },
																																							{file_address_businesses},
																																							Constants.SearchTool_Prefix + doxie.Version_SuperKey + '::business_address');
	
End;