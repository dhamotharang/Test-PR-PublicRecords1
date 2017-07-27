import ut,doxie_cbrs;
#workunit ('name', 'Build Business_Contacts_Doxie_Keys');


//AND I GOTTA DO THE INITIAL BS ON ALL THESE BUT THE FIRST
//SET UP INITIAL STUFF FOR RUN ON PROD

ut.MAC_SK_BuildProcess_v2(business_header.Key_Business_Contacts_BDID, 
											 '~thor_data400::key::business_contacts.bdid', build_bdid_key)
											 
ut.MAC_SK_BuildProcess_v2(business_header.Key_Company_Title,
											 '~thor_data400::key::company_title', build_title_key, true)


ut.MAC_SK_BuildProcess(Business_Header.Key_Prep_Business_Contacts_State_LFName, 
											 'key::business_contacts.state.lfname', 'key::business_contacts.state.lfname', build_stlfname_key)
											 

ut.MAC_SK_BuildProcess(business_header.Key_Prep_Business_Contacts_State_City_Name,
											 'key::business_contacts.state.city.name', 'key::business_contacts.state.city.name', build_stcyname_key)


ut.MAC_SK_BuildProcess_v2(business_header.Key_Business_Contacts_DID,
											 'key::business_contacts.did', build_did_key)


ut.MAC_SK_BuildProcess(business_header.Key_Prep_Business_Contacts_Stats,
											 'key::business_contacts_stat', 'key::business_contacts_stat', build_stat_key)


ut.MAC_SK_BuildProcess_v2(Business_Header.Key_Business_Contacts_SSN,
											 'key::business_contacts.ssn', build_ssn_key)
											 
ut.MAC_SK_BuildProcess_v2(doxie_cbrs.key_BDID_relsByContact,
	'~thor_data400::key::cbrs.bdid_relsByContact', build_rbc_key)
											 
contact_keys := sequential(
	ut.SF_MaintBuilding('BASE::Business_Contacts'),
	build_bdid_key,
	build_title_key,
	build_stlfname_key,
	build_stcyname_key,
	build_did_key,
	build_ssn_key,
	ut.SF_MaintBuilt('BASE::Business_Contacts')
);

stat_key := sequential(
	ut.SF_MaintBuilding('BASE::People_At_Work_Stats'),
	build_stat_key,
	ut.SF_MaintBuilt('BASE::People_At_Work_Stats')
);

build_rbc_key;
sequential(
	contact_keys,
	stat_key)