IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE2_Prof_LicenseV2,PRTE,_control,strata,PRTE2_Common;

 EXPORT proc_build_keys(string filedate) := FUNCTION

//bdid	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_proflic_bdid,
						    constants.KeyName_prolicv2 + '@version@::proflic_bdid',
						    constants.KeyName_prolicv2 + filedate +'::bdid',
							  build_bdid);	
												 
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2( constants.KeyName_prolicv2 + '@version@::proflic_bdid',
								constants.KeyName_prolicv2 + filedate +'::bdid',
						  	move_bdid);
	 
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_prolicv2 + '@version@::proflic_bdid', 'Q', move_bdid_qa);
	
	//did
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_proflic_did(),
						    constants.KeyName_prolicv2 + '@version@::prolicense_did',
							  constants.KeyName_prolicv2 + filedate +'::did',
							  build_did);

	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2( constants.KeyName_prolicv2 + '@version@::prolicense_did',
								constants.KeyName_prolicv2 + filedate +'::did',
								move_did);
	 
RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_prolicv2 + '@version@::prolicense_did', 'Q', move_did_qa);

 //did fcra	
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_proflic_did(true),
							 constants.KeyName_prolicv2 + 'fcra::' + '@version@::prolicense_did',
							 constants.KeyName_prolicv2 + 'fcra::' + filedate +'::did',
							 build_FCRA_did);

	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2( constants.KeyName_prolicv2 + 'fcra::' + '@version@::prolicense_did',
								constants.KeyName_prolicv2 + 'fcra::' + filedate +'::did',
								move_FCRA_did);
	 
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_prolicv2 + 'fcra::' + '@version@::prolicense_did', 'Q', move_FCRA_did_qa);
		
	
	//licensenum
		RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_proflic_licensenum,
						     constants.KeyName_prolicv2 + '@version@::proflic_licensenum',
							   constants.KeyName_prolicv2 + filedate + '::licensenum',
							   build_licensenum);
												 
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2( constants.KeyName_prolicv2 + '@version@::proflic_licensenum',
								constants.KeyName_prolicv2 + filedate +'::licensenum',
						  	move_licensenum);
	 
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_prolicv2 + '@version@::proflic_licensenum', 'Q', move_licensenum_qa);
	
	
	//lnpid
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_proflic_lnpid,
					  	  constants.KeyName_prolicv2 + '@version@::prolicense_lnpid',
						    constants.KeyName_prolicv2 + filedate +'::lnpid',
							  build_lnpid);

	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2( constants.KeyName_prolicv2 + '@version@::prolicense_lnpid',
								constants.KeyName_prolicv2 + filedate +'::lnpid',
								move_lnpid);
	 
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_prolicv2 + '@version@::prolicense_lnpid', 'Q', move_lnpid_qa);
	
	
	
 //addr
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_proflic_addr,
							 constants.KeyName_prolicv2 + '@version@::cbrs.addr_proflic',
							 constants.KeyName_prolicv2 + filedate +'::cbrs.addr',
							 build_addr);

	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2( constants.KeyName_prolicv2 + '@version@::cbrs.addr_proflic',
								constants.KeyName_prolicv2 + filedate +'::cbrs.addr',
								move_addr);
	 
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_prolicv2 + '@version@::cbrs.addr_proflic', 'Q', move_addr_qa);
	
	
	//Id
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_proflic_Id,
					 	    constants.KeyName_prolicv2 + '@version@::Prolic_Id',
					      constants.KeyName_prolicv2 + filedate +'::Prolic_Id',
								build_Id);

	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2( constants.KeyName_prolicv2 + '@version@::Prolic_Id',
								constants.KeyName_prolicv2 + filedate +'::Prolic_Id',
					  		move_Id);
	 
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_prolicv2 + '@version@::Prolic_Id', 'Q', move_Id_qa);
	
//linkid	
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.Key_Proflic_LinkIDs.Key,
						   constants.KeyName_prolicv2 + '@version@::linkIDs',
						   constants.KeyName_prolicv2 + filedate +'::linkids',
						   build_linkId);	
	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2( constants.KeyName_prolicv2 + '@version@::linkids',
								constants.KeyName_prolicv2 + filedate +'::linkids',
					   		move_linkId);
		
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_prolicv2 + '@version@::linkids', 'Q', move_linkId_qa);	
			 
	
	//lookup Non FCRA
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_LicenseType_lookup(),
							  constants.KeyName_prolicv2 + '@version@::professional_license_type_lookup',
							  constants.KeyName_prolicv2 + filedate +'::professional_license_type_lookup',
							  build_lookup);
												 
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2( constants.KeyName_prolicv2 + '@version@::professional_license_type_lookup',
							  constants.KeyName_prolicv2 + filedate +'::professional_license_type_lookup',
								move_lookup);
																				
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_prolicv2 + '@version@::professional_license_type_lookup', 'Q', move_lookup_qa);
												 
	
	//lookup FCRA
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_LicenseType_lookup(true),
								 constants.KeyName_prolicv2 + 'fcra::'  + '@version@::professional_license_type_lookup',
								 constants.KeyName_prolicv2 + 'fcra::' + filedate +'::professional_license_type_lookup',
								 build_fcra_lookup);
												 
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2( constants.KeyName_prolicv2 + 'fcra::' + '@version@::professional_license_type_lookup',
							  constants.KeyName_prolicv2 + 'fcra::' + filedate +'::professional_license_type_lookup',
								move_fcra_lookup);
																				
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_prolicv2 + 'fcra::' + '@version@::professional_license_type_lookup', 'Q', move_fcra_lookup_qa);
									 
	
	
	AutokeyB2.MAC_Build(files.File_ProfLic_Autokeys, name.fname, name.mname, name.lname,
						best_ssn,
						dob,
						zero,
						addr.prim_name, addr.prim_range, addr.st, addr.p_city_name, addr.zip5, addr.sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,				 
						did,
						//personal above.  business below
						cname,
						zero,
						Phone,
						addr.prim_name, addr.prim_range, addr.st, addr.p_city_name, addr.zip5, addr.sec_range,
						bdid,
						Constants.ak_keyname,
						constants.ak_logical(filedate), bld_auto_keys, false, constants.skip_set, true,,
						true,,,prolic_seq_id,true); 

	AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, mymove,, constants.skip_set)

	retval := 	sequential(bld_auto_keys,mymove);

//DF-22706: FCRA Consusmer Data Field Depreciation-- Blanking FCRA fields
cnt_proflic_did_fcra := OUTPUT(strata.macf_pops(prte2_prof_licensev2.keys.key_proflic_did(true),,,,,,FALSE,
																				['ace_fips_st','action_case_number','action_cds','action_complaint_violation_cds','action_complaint_violation_desc','action_complaint_violation_dt',
																				'action_desc','action_effective_dt','action_final_order_no','action_original_filename_or_url','action_posting_status_dt','action_record_type',
																				'action_status','additional_licensing_specifics','additional_name_addr_type','additional_orig_additional_1','additional_orig_additional_2',
																				'additional_orig_additional_3','additional_orig_additional_4','additional_orig_city','additional_orig_name,additional_orig_st','additional_orig_zip',
																				'additional_phone','business_flag,company_name','country_str,county_str','education_1_curriculum','education_2_curriculum,education_2_dates_attended',
																				'education_2_degree','education_2_school_attended','education_3_curriculum','education_3_dates_attended','education_3_degree','education_3_school_attended',
																				'education_continuing_education','former_name_order','license_obtained_by','misc_email,misc_fax','misc_occupation,misc_other_id','misc_other_id_type',
																				'misc_practice_hours','misc_practice_type','misc_web_site','orig_former_name','personal_pob_cd','personal_pob_desc','personal_race_cd','personal_race_desc',
																				'previous_license_number','previous_license_type','record_type','sex','status_other_agency','status_renewal_desc','status_status_cds','title']),
																				named('cnt_proflic_did_fcra')); 
	

//---------- making DOPS optional and only in PROD build -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because we are not in PROD'); 
  updatedops          := PRTE.UpdateVersion('ProfLicKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
  updatedops_fcra     := PRTE.UpdateVersion('FCRA_ProfLicKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');
	PerformUpdateOrNot	:= IF(is_running_in_prod,parallel(updatedops,updatedops_fcra),NoUpdate);

	RETURN 	sequential(build_bdid,
		                   move_bdid,
											 move_bdid_qa,
		                   build_did,
										   move_did,
											 move_did_qa,
											 build_FCRA_did,
											 move_FCRA_did,
											 move_FCRA_did_qa,
											 build_licensenum,
											 move_licensenum,
											 move_licensenum_qa,
											 build_lnpid,
											 move_lnpid,
											 move_lnpid_qa,
											 build_addr,
											 move_addr,
											 move_addr_qa,
											 build_Id,
											 move_Id,
											 move_id_qa,
											 build_linkId,
											 move_linkId,
											 move_linkid_qa,
											 build_lookup,
											 move_lookup,
											 move_lookup_qa,
											 build_fcra_lookup,
											 move_fcra_lookup,
											 move_fcra_lookup_qa,
											 bld_auto_keys,
											 mymove,
											 cnt_proflic_did_fcra, 
										//	 PerformUpdateOrNot
											 );
	 
END;