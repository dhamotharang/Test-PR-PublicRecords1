export mac_daily_email(f_type, b_status, o_act, e_target='\' \'') := macro

#uniquename(wuid_lower)

%wuid_lower% := stringlib.StringToLowerCase(thorlib.wuid());

o_act := 
     case(f_type,
	'BK' =>
	      case(b_status,
		      'SUCC' =>
			        FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + ut.GetDate,
                       'keys: 1) thor_data400::key::bkrupt_did_qa(thor_data400::key::bkrupt_did' + %wuid_lower% + '),\n' + 
		             '      2) thor_data400::key::bkrupt_casenum_qa(thor_data400::key::bkrupt_casenum' + %wuid_lower% + '),\n' + 
		             '      3) thor_Data400::key::bankrupt_didslim_qa(thor_data400::key::bankrupt_didslim' + %wuid_lower% + '),\n' +
		             '      4) thor_data400::key::bkrupt_full_qa(thor_data400::key::bkrupt_full' + %wuid_lower% + '),\n' +
		             '      5) thor_data400::key::bankrupt_bdid_qa(thor_data400::key::bankrupt_bdid' + %wuid_lower% + ')\n' +
		             '      have been built and ready to be deployed to QA.'),
			 'FAIL' =>	   
				   FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + ut.GetDate,
                                              failmessage),
			        FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + ut.GetDate,
                                              'Invalid status parameter.')),  									 
	'FLCRASH' =>
	      case(b_status,
		      'SUCC' =>
			        FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + ut.GetDate,
                       'keys: 1) thor_data400::key::flcrash0_qa(thor_data400::key::flcrash0_' + %wuid_lower% + '),\n' + 
				   '      2) thor_data400::key::flcrash1_qa(thor_data400::key::flcrash1_' + %wuid_lower% + '),\n' + 
				   '      3) thor_data400::key::flcrash2v_qa(thor_data400::key::flcrash2v_' + %wuid_lower% + '),\n' + 
				   '      4) thor_data400::key::flcrash3v_qa(thor_data400::key::flcrash3v_' + %wuid_lower% + '),\n' + 
				   '      5) thor_data400::key::flcrash4_qa(thor_data400::key::flcrash4_' + %wuid_lower% + '),\n' + 
				   '      6) thor_data400::key::flcrash5_qa(thor_data400::key::flcrash5_' + %wuid_lower% + '),\n' + 
				   '      7) thor_data400::key::flcrash6_qa(thor_data400::key::flcrash6_' + %wuid_lower% + '),\n' + 
				   '      8) thor_data400::key::flcrash7_qa(thor_data400::key::flcrash7_' + %wuid_lower% + '),\n' + 
				   '      9) thor_data400::key::flcrash_did_qa(thor_data400::key::flcrash_did_' + %wuid_lower% + '),\n' + 
                   
				   // The following keys have been commented out because they are not in use by the package
				   // file or in any of the queries.
				   // '      10) thor_data400::key::flcrash_accnbr_qa(thor_data400::key::flcrash_accnbr_' + %wuid_lower% + '),\n' + 
				   // '      11) thor_data400::key::flcrash_bdid_qa(thor_data400::key::flcrash_bdid_' + %wuid_lower% + '),\n' + 
				   // '      12) thor_data400::key::flcrash_dlnbr_qa(thor_data400::key::flcrash_dlnbr_' + %wuid_lower% + '),\n' + 
				   // '      13) thor_data400::key::flcrash_tagnbr_qa(thor_data400::key::flcrash_tagnbr_' + %wuid_lower% + '),\n' + 
				   // '      14) thor_data400::key::flcrash_vin_qa(thor_data400::key::flcrash_vin_' + %wuid_lower% + '),\n' + 
		             '      have been built and ready to be deployed to QA.'),
			 'FAIL' =>	   
				   FileServices.sendemail(e_target,f_type + ' Build Failure - ' + ut.GetDate,
                                              failmessage),
			        FileServices.sendemail(e_target,f_type + ' Build Warning - ' + ut.GetDate,
                                              'Invalid status parameter.')),
								 
	'GONG' =>
	      case(b_status,
		      'SUCC' =>
			        FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + ut.GetDate,
                       'keys: 1) thor_data400::key::gong_did_add_qa(thor_data400::key::gong_did_add' + %wuid_lower% + '),\n' + 
		             '      2) thor_data400::key::gong_hhid_add_qa(thor_data400::key::gong_hhid_add' + %wuid_lower% + '),\n' + 
		             '      3) thor_data400::key::gong_address_add_qa(thor_data400::key::gong_address_add' + %wuid_lower% + '),\n' +
		             '      4) thor_data400::key::gong_phone_add_qa(thor_data400::key::gong_phone_add' + %wuid_lower% + '),\n' +
		             '      5) thor_data400::key::gong_czsslf_add_qa(thor_data400::key::gong_czsslf_add' + %wuid_lower% + '),\n' +
		             '      6) thor_data400::key::gong_lczf_add_qa(thor_data400::key::gong_lczf_add' + %wuid_lower% + '),\n' +
		             '      7) thor_data400::key::gong_remove_qa(thor_data400::key::gong_remove' + %wuid_lower% + ')\n' +
		             '      have been built and ready to be deployed to QA.'),
			 'FAIL' =>	   
				   FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + ut.GetDate,
                                              failmessage),
			        FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + ut.GetDate,
                                              'Invalid status parameter.')),
	'GONG WEEKLY' =>
	      case(b_status,
		      'SUCC' =>
			        FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + ut.GetDate,
                       'keys: 1) thor_data400::key::gong_did_qa(thor_data400::key::gong_did' + %wuid_lower% + '),\n' + 
	                  '      2) thor_data400::key::gong_hhid_qa(thor_data400::key::gong_hhid' + %wuid_lower% + '),\n' + 
				   '      3) thor_data400::key::gong_address_qa(thor_data400::key::gong_address' + %wuid_lower% + '),\n' + 
				   '      4) thor_data400::key::gong_phone_qa(thor_data400::key::gong_phone' + %wuid_lower% + '),\n' + 
				   '      5) thor_data400::key::gong_czsslf_qa(thor_data400::key::gong_czsslf' + %wuid_lower% + '),\n' + 
				   '      6) thor_data400::key::gong_lczf_qa(thor_data400::key::gong_lczf' + %wuid_lower% + '),\n' + 
				   '      7) thor_data400::key::gong_eda_npa_nxx_line_qa(thor_data400::key::gong_eda_npa_nxx_line' + %wuid_lower% + '),\n' + 
				   '      8) thor_data400::key::gong_eda_st_lname_city_qa(thor_data400::key::gong_eda_st_lname_city' + %wuid_lower% + '),\n' + 
				   '      9) thor_data400::key::gong_eda_st_lname_fname_city_qa(thor_data400::key::gong_eda_st_lname_fname_city' + %wuid_lower% + '),\n' + 
				   '      10) thor_data400::key::gong_eda_st_bizword_city_qa(thor_data400::key::gong_eda_st_bizword_city' + %wuid_lower% + '),\n' + 
				   '      11) thor_data400::key::gong_eda_st_city_prim_name_prim_range_qa(thor_data400::key::gong_eda_st_city_prim_name_prim_range' + %wuid_lower% + '),\n' + 
				   '      12) thor_data400::key::gong_history_address_qa(thor_data400::key::gong_history_address' + %wuid_lower% + '),\n' + 
				   '      13) thor_data400::key::gong_history_phone_qa(thor_data400::key::gong_history_phone' + %wuid_lower% + '),\n' + 
				   '      14) thor_data400::key::gong_history_did_qa(thor_data400::key::gong_history_did' + %wuid_lower% + '),\n' + 
				   '      15) thor_data400::key::gong_history_hhid_qa(thor_data400::key::gong_history_hhid' + %wuid_lower% + '),\n' + 
				   '      16) thor_data400::key::gong_hist_bdid_qa(thor_data400::key::gong_hist_bdid' + %wuid_lower% + '),\n' + 
				   '      17) thor_data400::key::gong_history_name_qa(thor_data400::key::gong_history_name' + %wuid_lower% + '),\n' + 
				   '      18) thor_data400::key::gong_history_zip_name_qa(thor_data400::key::gong_history_zip_name' + %wuid_lower% + '),\n' + 
				   '      19) thor_data400::key::cbrs.phone10_gong' + %wuid_lower% + '),\n' + 
				   '      20) thor_data400::key::gong_history_surname_qa(thor_data400::key::gong_history::'+filedate+'::surnames),\n' + 
				   '      have been built and ready to be deployed to QA.'),
			 'FAIL' =>	   
				   FileServices.sendemail(e_target,f_type + ' Build Failure - ' + ut.GetDate,
                                              failmessage),
			        FileServices.sendemail(e_target,f_type + ' Build Warning - ' + ut.GetDate,
                                              'Invalid status parameter.')),								 
	'LIENS' =>
	      case(b_status,
		      'SUCC' =>
			        FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + ut.GetDate,
                       'keys: 1) thor_data400::key::liens_did_qa(thor_data400::key::liens_did' + %wuid_lower% + '),\n' + 
		             '      2) thor_data400::key::liens_bdid_qa(thor_data400::key::liens_bdid' + %wuid_lower% + '),\n' + 
		             '      3) thor_data400::key::liens_rmsid_qa(thor_data400::key::liens_rmsid' + %wuid_lower% + '),\n' +
		             '      4) thor_data400::key::liens_st_case_qa(thor_data400::key::liens_st_case' + %wuid_lower% + ')\n' +
		             '      have been built and ready to be deployed to QA.'),
			 'FAIL' =>	   
				   FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + ut.GetDate,
                                              failmessage),
			        FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + ut.GetDate,
                                              'Invalid status parameter.')),
      'LSSI' => 
	      case(b_status,
	           'SUCC' =>
				   FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + ut.GetDate,
                       'keys: 1) thor_data400::key::lssi_did_add_qa(thor_data400::key::lssi_did_add' + %wuid_lower% + '),\n' + 
	                  '      2) thor_data400::key::lssi_hhid_add_qa(thor_data400::key::lssi_hhid_add' + %wuid_lower% + '),\n' + 
				   '      3) thor_data400::key::lssi_remove_qa(thor_data400::key::lssi_remove' + %wuid_lower% + ')\n' +
				   '      have been built and ready to be deployed to QA.'),
			 'FAIL' =>
	                  FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + ut.GetDate,
                                              failmessage),
		             FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + ut.GetDate,
                                              'Invalid status parameter.')),	
	'LSSI WEEKLY' => 
	      case(b_status,
	           'SUCC' =>
				   FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + ut.GetDate,
                       'keys: 1) thor_data400::key::lssi_did_key_qa(thor_data400::key::lssi_did' + %wuid_lower% + '),\n' + 
	                  '      2) thor_data400::key::lssi_hhid_key_qa(thor_data400::key::lssi_hhid' + %wuid_lower% + '),\n' + 
				   '      have been built and ready to be deployed to QA.'),
			 'FAIL' =>
	                  FileServices.sendemail(e_target,f_type + ' Build Failure - ' + ut.GetDate,
                                              failmessage),
		             FileServices.sendemail(e_target,f_type + ' Build Warning - ' + ut.GetDate,
                                              'Invalid status parameter.')),			
							
	'UTIL' =>
	      case(b_status,
		      'SUCC' =>
			        FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + ut.GetDate,
                       'key: 1) thor_data400::key::utility_address_qa(thor_data400::key::utility_address' + %wuid_lower% + '),\n' + 
		             '     has been built and ready to be deployed to QA.'),
			 'FAIL' =>	   
				   FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + ut.GetDate,
                                              failmessage),
			        FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + ut.GetDate,
                                              'Invalid status parameter.')),
	'DEATH MASTER' =>
	      case(b_status,
		      'SUCC' =>
			        FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + ut.GetDate,
                       'key: 1) thor_data400::key::did_death_master_qa(thor_data400::key::did_death_master' + %wuid_lower% + '),\n' + 
		             '     has been built and ready to be deployed to QA.'),
			 'FAIL' =>	   
				   FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + ut.GetDate,
                                              failmessage),
			        FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + ut.GetDate,
                                              'Invalid status parameter.')),  
	FileServices.sendemail(e_target,'Daily Build Macro Warning',
                            'Invalid file type parameter.')		 
     ); 	

endmacro;