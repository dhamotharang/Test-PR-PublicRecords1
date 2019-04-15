import doxie, Tools, BIPV2, dx_DataBridge, RoxieKeyBuild;

export Build_Keys(string pversion) :=
module

 		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_DataBridge.Key_LinkIds.Key
																							 ,DataBridge.Files().Base.Built
																							 ,dx_DataBridge.keynames().LinkIds.QA
																							 ,dx_DataBridge.keynames(pversion,false).LinkIds.New
																							 ,BuildLinkIdsKey);  
																							 
		 //DOPSGrowthCheck 
		 GetDops:=dops.GetDeployedDatasets('P','B','F');
	 	 OnlyDataBridge:=GetDops(datasetname='DataBridgeKeys');
			
		 father_pversion := OnlyDataBridge[1].buildversion;
		 filename        := '~thor_data400::key::databridge::'+pversion+'::linkids';
		 father_filename := '~thor_data400::key::databridge::'+father_pversion+'::linkids';
		 set of string key_DataBridge_InputSet:=['ultid', 'orgid', 'seleid', 'proxid', 'powid', 'empid', 'dotid', 'ultscore', 'orgscore', 'selescore', 'proxscore', 'powscore', 'empscore', 'dotscore', 'ultweight', 
																						 'orgweight', 'seleweight', 'proxweight', 'powweight', 'empweight', 'dotweight', 'source', 'global_sid', 'record_sid', 'bdid', 'bdid_score', 'did', 'did_score', 
																						 'dt_first_seen', 'dt_last_seen', 'dt_vendor_first_reported', 'dt_vendor_last_reported', 'process_date', 'record_type', 'clean_company_name', 'clean_area_code', 
																						 'clean_telephone_num', 'mail_score_desc', 'name_gender_desc', 'title_desc_1', 'title_desc_2', 'title_desc_3', 'title_desc_4', 'web_address1', 'web_address2', 
																						 'web_address3', 'sic8_desc_1', 'sic8_desc_2', 'sic8_desc_3', 'sic8_desc_4', 'sic6_desc_1', 'sic6_desc_2', 'sic6_desc_3', 'sic6_desc_4', 'sic6_desc_5,email1', 'email2',
																						 'email3', 'name', 'company', 'address', 'address2', 'city', 'state', 'scf', 'zip', 'zip4', 'mail_score', 'area_code', 'telephone_number', 'name_gender', 'name_prefix',
																						 'name_first', 'name_middle_initial', 'name_last', 'suffix', 'title_code_1', 'title_code_2', 'title_code_3', 'title_code_4', 'sic8_1', 'sic8_2', 'sic8_3', 'sic8_4',
																						 'sic6_1', 'sic6_2', 'sic6_3', 'sic6_4', 'sic6_5', 'transaction_date', 'database_site_id', 'database_individual_id', 'email_present_flag', 'site_source1', 'site_source2', 
																						 'site_source3','site_source4', 'site_source5', 'site_source6', 'site_source7', 'site_source8', 'site_source9', 'site_source10', 'individual_source1', 'individual_source2',
																						 'individual_source3', 'individual_source4', 'individual_source5', 'individual_source6', 'individual_source7', 'individual_source8', 'individual_source9', 'individual_source10',
																						 'email_status', 'title', 'fname', 'mname', 'lname', 'name_suffix', 'name_score', 'prim_range', 'predir', 'prim_name', 'addr_suffix', 'postdir', 'unit_desig', 'sec_range', 
																						 'p_city_name', 'v_city_name', 'st', 'cart', 'cr_sort_sz', 'lot', 'lot_order', 'dbpc', 'chk_digit', 'rec_type', 'fips_state', 'fips_county', 'geo_lat', 'geo_long', 'msa', 
																						 'geo_blk', 'geo_match,err_stat', 'raw_aid', 'ace_aid', 'prep_address_line1', 'prep_address_line_last'];
			DeltaCommands:=sequential(
			DOPSGrowthCheck.CalculateStats('DataBridgeKeys','dx_DataBridge.Key_LinkIds.Key','key_DataBridge',filename,'did','record_sid','','','','',pversion,father_pversion),
			DOPSGrowthCheck.DeltaCommand(filename,father_filename,'DataBridgeKeys','key_DataBridge','dx_DataBridge.Key_LinkIds.Key','record_sid',pversion,father_pversion,key_DataBridge_InputSet),
			DOPSGrowthCheck.ChangesByField(filename,father_filename,'DataBridgeKeys','key_DataBridge','dx_DataBridge.Key_LinkIds.Key','record_sid','',pversion,father_pversion),
			DopsGrowthCheck.PersistenceCheck(filename,father_filename,'DataBridgeKeys','key_DataBridge','dx_DataBridge.Key_LinkIds.Key','record_sid',key_DataBridge_InputSet,key_DataBridge_InputSet,pversion,father_pversion),
			);

	export full_build :=
	
	sequential(
	    BuildLinkIdsKey
		 ,Promote(pversion).BuildFiles.New2Built
  	 ,DeltaCommands
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping DataBridge.Build_Keys atribute')
	);

end;
  
	export full_build :=
	
	sequential(
	    BuildLinkIdsKey
		 ,Promote(pversion).BuildFiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping DataBridge.Build_Keys atribute')
	);

end;