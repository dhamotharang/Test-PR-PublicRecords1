export mac_daily_email_local(f_type, b_status, filedate, o_act, e_target='\' \'') := macro

#uniquename(wuid_lower)

%wuid_lower% := stringlib.StringToLowerCase(thorlib.wuid());

o_act := 
     case(f_type,
	'BK' =>
	      case(b_status,
		      'SUCC' =>
			        FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + filedate,
                       'keys: 1) thor_data400::key::bkrupt_did_qa(thor_data400::key::bankrupt::'+filedate+'::did),\n' + 
		             '      2) thor_data400::key::bkrupt_casenum_qa(thor_data400::key::bankrupt::'+filedate+'::casenum),\n' + 
		             '      3) thor_Data400::key::bankrupt_didslim_qa(thor_data400::key::bankrupt::'+filedate+'::didslim),\n' +
		             '      4) thor_data400::key::bkrupt_full_qa(thor_data400::key::bankrupt::'+filedate+'::full),\n' +
		             '      5) thor_data400::key::bankrupt_bdid_qa(thor_data400::key::bankrupt::'+filedate+'::bdid)\n' +
		             '      have been built and ready to be deployed to QA.'),
			 'FAIL' =>	   
				   FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + filedate,
                                              failmessage),
			        FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + filedate,
                                              'Invalid status parameter.')),  									 
	'FLCRASH' =>
	      case(b_status,
		      'SUCC' =>
			        FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + filedate,
                       'keys: 1) thor_data400::key::flcrash0_qa(thor_data400::key::flcrash0_' + %wuid_lower% + '),\n' + 
				   '      2) thor_data400::key::flcrash1_qa(thor_data400::key::flcrash1_' + %wuid_lower% + '),\n' + 
				   '      3) thor_data400::key::flcrash2v_qa(thor_data400::key::flcrash2v_' + %wuid_lower% + '),\n' + 
				   '      4) thor_data400::key::flcrash3v_qa(thor_data400::key::flcrash3v_' + %wuid_lower% + '),\n' + 
				   '      5) thor_data400::key::flcrash4_qa(thor_data400::key::flcrash4_' + %wuid_lower% + '),\n' + 
				   '      6) thor_data400::key::flcrash5_qa(thor_data400::key::flcrash5_' + %wuid_lower% + '),\n' + 
				   '      7) thor_data400::key::flcrash6_qa(thor_data400::key::flcrash6_' + %wuid_lower% + '),\n' + 
				   '      8) thor_data400::key::flcrash7_qa(thor_data400::key::flcrash7_' + %wuid_lower% + '),\n' + 
				   '      9) thor_data400::key::flcrash_accnbr_qa(thor_data400::key::flcrash_accnbr_' + %wuid_lower% + '),\n' + 
				   '      10) thor_data400::key::flcrash_bdid_qa(thor_data400::key::flcrash_bdid_' + %wuid_lower% + '),\n' + 
				   '      11) thor_data400::key::flcrash_did_qa(thor_data400::key::flcrash_did_' + %wuid_lower% + '),\n' + 
				   '      12) thor_data400::key::flcrash_dlnbr_qa(thor_data400::key::flcrash_dlnbr_' + %wuid_lower% + '),\n' + 
				   '      13) thor_data400::key::flcrash_tagnbr_qa(thor_data400::key::flcrash_tagnbr_' + %wuid_lower% + '),\n' + 
				   '      14) thor_data400::key::flcrash_vin_qa(thor_data400::key::flcrash_vin_' + %wuid_lower% + '),\n' + 
		             '      have been built and ready to be deployed to QA.'),
			 'FAIL' =>	   
				   FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,
                                              failmessage),
			        FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,
                                              'Invalid status parameter.')),
								 
	'GONG' =>
	      case(b_status,
		      'SUCC' =>
			        FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + filedate,
                       'keys: 1) thor_data400::key::gong_did_add_qa(thor_data400::key::gong_daily::'+filedate+'::did_add),\n' + 
		             '      2) thor_data400::key::gong_hhid_add_qa(thor_data400::key::gong_daily::'+filedate+'::hhid_add),\n' + 
		             '      3) thor_data400::key::gong_address_add_qa(thor_data400::key::gong_daily::'+filedate+'::address_add),\n' +
		             '      4) thor_data400::key::gong_phone_add_qa(thor_data400::key::gong_daily::'+filedate+'::phone_add),\n' +
		             '      5) thor_data400::key::gong_czsslf_add_qa(thor_data400::key::gong_daily::'+filedate+'::czsslf_add),\n' +
		             '      6) thor_data400::key::gong_lczf_add_qa(thor_data400::key::gong_daily::'+filedate+'::lczf_add),\n' +
		             '      7) thor_data400::key::gong_remove_qa(thor_data400::key::gong_daily::'+filedate+'::remove)\n' +
					 '      8) thor_data400::key::gong_eda_npa_nxx_line_add_qa(thor_data400::key::gong_daily::'+filedate+'::eda_npa_nxx_line_add)\n' +
					 '      9) thor_data400::key::gong_eda_st_bizword_city_add_qa(thor_data400::key::gong_daily::'+filedate+'::eda_st_bizword_city_add)\n' +
					 '      10) thor_data400::key::gong_eda_st_city_prim_name_prim_range_add_qa(thor_data400::key::gong_daily::'+filedate+'::eda_st_city_prim_name_prim_range_add)\n' +
					 '      11) thor_data400::key::gong_gong_eda_st_lname_city_add_qa(thor_data400::key::gong_daily::'+filedate+'::eda_st_lname_city_add)\n' +
					 '      12) thor_data400::key::gong_eda_st_lname_fname_city_add_qa(thor_data400::key::gong_daily::'+filedate+'::eda_st_lname_fname_city_add)\n' +
		             '      have been built and ready to be deployed to QA.'),
			 'FAIL' =>	   
				   FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + filedate,
                                              failmessage),
			        FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + filedate,
                                              'Invalid status parameter.')),
	'GONG WEEKLY' =>
	      case(b_status,
		      'SUCC' =>
			        FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + filedate,
                       'keys: 1) thor_data400::key::gong_did_qa(thor_data400::key::gong_weekly::'+filedate+'::did),\n' + 
	                  '      2) thor_data400::key::gong_hhid_qa(thor_data400::key::gong_weekly::'+filedate+'::hhid),\n' + 
				   '      3) thor_data400::key::gong_address_qa(thor_data400::key::gong_weekly::'+filedate+'::address),\n' + 
				   '      4) thor_data400::key::gong_phone_qa(thor_data400::key::gong_weekly::'+filedate+'::phone),\n' + 
				   '      5) thor_data400::key::gong_czsslf_qa(thor_data400::key::gong_weekly::'+filedate+'::czsslf),\n' + 
				   '      6) thor_data400::key::gong_lczf_qa(thor_data400::key::gong_weekly::'+filedate+'::lczf),\n' + 
				   '      7) thor_data400::key::gong_eda_npa_nxx_line_qa(thor_data400::key::gong_weekly::'+filedate+'::eda_npa_nxx_line),\n' + 
				   '      8) thor_data400::key::gong_eda_st_lname_city_qa(thor_data400::key::gong_weekly::'+filedate+'::eda_st_lname_city),\n' + 
				   '      9) thor_data400::key::gong_eda_st_lname_fname_city_qa(thor_data400::key::gong_weekly::'+filedate+'::eda_st_lname_fname_city),\n' + 
				   '      10) thor_data400::key::gong_eda_st_bizword_city_qa(thor_data400::key::gong_weekly::'+filedate+'::eda_st_bizword_city),\n' + 
				   '      11) thor_data400::key::gong_eda_st_city_prim_name_prim_range_qa(thor_data400::key::gong_weekly::'+filedate+'::eda_st_city_prim_name_prim_range),\n' + 
				   '      12) thor_data400::key::cbrs.phone10_gong_qa(thor_data400::key::gong_weekly::'+filedate+'::cbrs.phone10_gong),\n' + 
				   '      13) thor_data400::key::gong_history_address_qa(thor_data400::key::gong_history::'+filedate+'::address),\n' + 
				   '      14) thor_data400::key::gong_history_phone_qa(thor_data400::key::gong_history::'+filedate+'::phone),\n' + 
				   '      15) thor_data400::key::gong_history_did_qa(thor_data400::key::gong_history::'+filedate+'::did),\n' + 
				   '      16) thor_data400::key::gong_history_hhid_qa(thor_data400::key::gong_history::'+filedate+'::hhid),\n' + 
				   '      17) thor_data400::key::gong_hist_bdid_qa(thor_data400::key::gong_history::'+filedate+'::bdid),\n' + 
				   '      18) thor_data400::key::gong_history_name_qa(thor_data400::key::gong_history::'+filedate+'::name),\n' + 
				   '      19) thor_data400::key::gong_history_zip_name_qa(thor_data400::key::gong_history::'+filedate+'::zip_name),\n' + 
				   '      20) thor_data400::key::gong_history_surname_qa(thor_data400::key::gong_history::'+filedate+'::surnames),\n' + 
				   '      have been built and ready to be deployed to QA.'),
			 'FAIL' =>	   
				   FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,
                                              failmessage),
			        FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,
                                              'Invalid status parameter.')),								 
	'LIENS' =>
	      case(b_status,
		      'SUCC' =>
			        FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + filedate,
                       'keys: 1) thor_data400::key::liens_did_qa(thor_data400::key::liens::'+filedate+'::did),\n' + 
		             '      2) thor_data400::key::liens_bdid_qa(thor_data400::key::liens::'+filedate+'::bdid),\n' + 
		             '      3) thor_data400::key::liens_rmsid_qa(thor_data400::key::liens::'+filedate+'::rmsid),\n' +
		             '      4) thor_data400::key::liens_st_case_qa(thor_data400::key::liens::'+filedate+'::st_case)\n' +
		             '      have been built and ready to be deployed to QA.'),
			 'FAIL' =>	   
				   FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + filedate,
                                              failmessage),
			        FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + filedate,
                                              'Invalid status parameter.')),
      'LSSI' => 
	      case(b_status,
	           'SUCC' =>
				   FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + filedate,
                       'keys: 1) thor_data400::key::lssi_did_add_qa(thor_data400::key::lssi::'+filedate+'::did_add),\n' + 
	                  '      2) thor_data400::key::lssi_hhid_add_qa(thor_data400::key::lssi::'+filedate+'::hhid_add),\n' + 
				   '      3) thor_data400::key::lssi_remove_qa(thor_data400::key::lssi::'+filedate+'::remove)\n' +
				   '      have been built and ready to be deployed to QA.'),
			 'FAIL' =>
	                  FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + filedate,
                                              failmessage),
		             FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + filedate,
                                              'Invalid status parameter.')),	
	'LSSI WEEKLY' => 
	      case(b_status,
	           'SUCC' =>
				   FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + filedate,
                       'keys: 1) thor_data400::key::lssi_did_key_qa(thor_data400::key::lssi_did' + %wuid_lower% + '),\n' + 
	                  '      2) thor_data400::key::lssi_hhid_key_qa(thor_data400::key::lssi_hhid' + %wuid_lower% + '),\n' + 
				   '      have been built and ready to be deployed to QA.'),
			 'FAIL' =>
	                  FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,
                                              failmessage),
		             FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,
                                              'Invalid status parameter.')),			
							
	'UTIL' =>
	      case(b_status,
		      'SUCC' =>
			        FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + filedate,
                       'key: 1) thor_data400::key::utility_address_qa(thor_data400::key::utility::'+filedate+'::address),\n' +
					   'key: 2) thor_data400::key::utility::daily.address_qa(thor_data400::key::utility::'+filedate+'::daily.address),\n' +
					   'key: 3) thor_data400::key::utility::daily.citystname_qa(thor_data400::key::utility::'+filedate+'::daily.citystname),\n' +
					   'key: 4) thor_data400::key::utility::daily.name_qa(thor_data400::key::utility::'+filedate+'::daily.name),\n' +
					   'key: 5) thor_data400::key::utility::daily.phone_qa(thor_data400::key::utility::'+filedate+'::daily.phone),\n' +
					   'key: 6) thor_data400::key::utility::daily.ssn_qa(thor_data400::key::utility::'+filedate+'::daily.ssn),\n' +
					   'key: 7) thor_data400::key::utility::daily.stname_qa(thor_data400::key::utility::'+filedate+'::daily.stname),\n' +
					   'key: 8) thor_data400::key::utility::daily.zip_qa(thor_data400::key::utility::'+filedate+'::daily.zip),\n' +
					   'key: 9) thor_data400::key::utility::daily.fdid_qa(thor_data400::key::utility::'+filedate+'::daily.fid),\n' +
					   'key: 10) thor_data400::key::utility::daily.did_qa(thor_data400::key::utility::'+filedate+'::daily.did),\n' +
					   'key: 11) thor_data400::key::utility::daily.id_qa(thor_data400::key::utility::'+filedate+'::daily.id),\n' +
		             '     has been built and ready to be deployed to QA.'),
			 'FAIL' =>	   
				   FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + filedate,
                                              failmessage),
			        FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + filedate,
                                              'Invalid status parameter.')),
	'DEATH MASTER' =>
	      case(b_status,
		      'SUCC' =>
			        FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + filedate,
                       'key: 1) thor_data400::key::did_death_master_qa(thor_data400::key::death_master' + filedate + '::did),\n' + 
		             '     has been built and ready to be deployed to QA.'),
			 'FAIL' =>	   
				   FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + filedate,
                                              failmessage),
			        FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + filedate,
                                              'Invalid status parameter.')),  
	FileServices.sendemail(e_target,'Daily Build Macro Warning',
                            'Invalid file type parameter.')		 
     ); 	

endmacro;