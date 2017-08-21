export mac_daily_email_local(f_type, b_status, filedate, o_act, e_target='\' \'') := macro
import bbb2, yellowpages, ebr;

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
						'      6) thor_data400::key::bkrupt_ssn_qa(thor_data400::key::bankrupt::'+filedate+'::ssn)\n' +
						'      7) thor_data400::key::bkrupt_address_qa(thor_data400::key::bankrupt::'+filedate+'::address)\n' +
						'      8) thor_data400::key::bankrupt::bocashell_did_qa(thor_data400::key::bankrupt::'+filedate+'::bocashell_did)\n' +
						'      9) thor_Data400::key::bankrupt::fcra::didslim_qa(thor_data400::key::bankrupt::fcra::'+filedate+'::didslim)\n' +
						'     10) thor_Data400::key::bankrupt::fcra::full_qa(thor_data400::key::bankrupt::fcra::'+filedate+'::full)\n' +
						'     11) thor_data400::key::bankrupt::fcra::bocashell_did_qa(thor_data400::key::bankrupt::fcra::'+filedate+'::bocashell_did)\n' +
						'     12) thor_Data400::key::bkrupt_did_fcra_qa(thor_data400::key::bankrupt::fcra::'+filedate+'::did)\n' +
						'      have been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + filedate,'Invalid status parameter.')
					),
		'FLCRASH' =>
			case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::flcrash0_qa(thor_data400::key::flcrash::'+filedate+'::flcrash0),\n' + 
						'      2) thor_data400::key::flcrash1_qa(thor_data400::key::flcrash::'+filedate+'::flcrash1),\n' + 
						'      3) thor_data400::key::flcrash2v_qa(thor_data400::key::flcrash::'+filedate+'::flcrash2v),\n' + 
						'      4) thor_data400::key::flcrash3v_qa(thor_data400::key::flcrash::'+filedate+'::flcrash3v),\n' + 
						'      5) thor_data400::key::flcrash4_qa(thor_data400::key::flcrash::'+filedate+'::flcrash4),\n' + 
						'      6) thor_data400::key::flcrash5_qa(thor_data400::key::flcrash::'+filedate+'::flcrash5),\n' + 
						'      7) thor_data400::key::flcrash6_qa(thor_data400::key::flcrash::'+filedate+'::flcrash6),\n' + 
						'      8) thor_data400::key::flcrash7_qa(thor_data400::key::flcrash::'+filedate+'::flcrash7),\n' + 
						'      9) thor_data400::key::flcrash_did_qa(thor_data400::key::flcrash::'+filedate+'::flcrash_did),\n' + 
						'      have been built and ready to be deployed to QA.'),
						// The following keys have been commented out because they are not in use by the package
						// file or in any of the queries.
						// '      10) thor_data400::key::flcrash_accnbr_qa(thor_data400::key::flcrash_accnbr_' + %wuid_lower% + '),\n' + 
						// '      11) thor_data400::key::flcrash_bdid_qa(thor_data400::key::flcrash_bdid_' + %wuid_lower% + '),\n' + 
						// '      12) thor_data400::key::flcrash_dlnbr_qa(thor_data400::key::flcrash_dlnbr_' + %wuid_lower% + '),\n' + 
						// '      13) thor_data400::key::flcrash_tagnbr_qa(thor_data400::key::flcrash_tagnbr_' + %wuid_lower% + '),\n' + 
						// '      14) thor_data400::key::flcrash_vin_qa(thor_data400::key::flcrash_vin_' + %wuid_lower% + '),\n' + 
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,'Invalid status parameter.')
					),
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
						'      11) thor_data400::key::gong_eda_st_lname_city_add_qa(thor_data400::key::gong_daily::'+filedate+'::eda_st_lname_city_add)\n' +
						'      12) thor_data400::key::gong_eda_st_lname_fname_city_add_qa(thor_data400::key::gong_daily::'+filedate+'::eda_st_lname_fname_city_add)\n' +
						'		13) thor_data400::key::gong_daily_address_qa(thor_data400::key::gong_daily::'+filedate+'::address)\n' +
						'		14) thor_data400::key::gong_daily_phone_qa(thor_data400::key::gong_daily::'+filedate+'::phone)\n' +
						'		15) thor_data400::key::gong_daily_name_qa(thor_data400::key::gong_daily::'+filedate+'::name)\n' +
						'		16) thor_data400::key::gong_daily_zip_name_qa(thor_data400::key::gong_daily::'+filedate+'::zip_name)\n' +
						'      have been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + filedate,'Invalid status parameter.')
					),
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
						FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,'Invalid status parameter.')
					),
		'GONG DAILY V2' =>
			case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::gongv2_did_qa(thor_data400::key::gongv2_weekly::'+filedate+'::did),\n' + 
						'      2) thor_data400::key::gongv2_hhid_qa(thor_data400::key::gongv2_weekly::'+filedate+'::hhid),\n' + 
						'      3) thor_data400::key::gongv2_address_qa(thor_data400::key::gongv2_weekly::'+filedate+'::address),\n' + 
						'      4) thor_data400::key::gongv2_phone_qa(thor_data400::key::gongv2_weekly::'+filedate+'::phone),\n' + 
						'      5) thor_data400::key::gongv2_czsslf_qa(thor_data400::key::gongv2_weekly::'+filedate+'::czsslf),\n' + 
						'      6) thor_data400::key::gongv2_lczf_qa(thor_data400::key::gongv2_weekly::'+filedate+'::lczf),\n' + 
						'      7) thor_data400::key::gongv2_eda_npa_nxx_line_qa(thor_data400::key::gongv2_weekly::'+filedate+'::eda_npa_nxx_line),\n' + 
						'      8) thor_data400::key::gongv2_eda_st_lname_city_qa(thor_data400::key::gongv2_weekly::'+filedate+'::eda_st_lname_city),\n' + 
						'      9) thor_data400::key::gongv2_eda_st_lname_fname_city_qa(thor_data400::key::gongv2_weekly::'+filedate+'::eda_st_lname_fname_city),\n' + 
						'      10) thor_data400::key::gongv2_eda_st_bizword_city_qa(thor_data400::key::gongv2_weekly::'+filedate+'::eda_st_bizword_city),\n' + 
						'      11) thor_data400::key::gongv2_eda_st_city_prim_name_prim_range_qa(thor_data400::key::gongv2_weekly::'+filedate+'::eda_st_city_prim_name_prim_range),\n' + 
						'      12) thor_data400::key::cbrs.phone10_gongv2_qa(thor_data400::key::gong_weekly::'+filedate+'::cbrs.phone10_gongv2),\n' + 
						'      13) thor_data400::key::gongv2_history_address_qa(thor_data400::key::gongv2_history::'+filedate+'::address),\n' + 
						'      14) thor_data400::key::gongv2_history_phone_qa(thor_data400::key::gongv2_history::'+filedate+'::phone),\n' + 
						'      15) thor_data400::key::gongv2_history_did_qa(thor_data400::key::gongv2_history::'+filedate+'::did),\n' + 
						'      16) thor_data400::key::gongv2_history_hhid_qa(thor_data400::key::gongv2_history::'+filedate+'::hhid),\n' + 
						'      17) thor_data400::key::gongv2_hist_bdid_qa(thor_data400::key::gongv2_history::'+filedate+'::bdid),\n' + 
						'      18) thor_data400::key::gongv2_history_name_qa(thor_data400::key::gongv2_history::'+filedate+'::name),\n' + 
						'      19) thor_data400::key::gongv2_history_zip_name_qa(thor_data400::key::gongv2_history::'+filedate+'::zip_name),\n' + 
						'      20) thor_data400::key::gongv2_history_surname_qa(thor_data400::key::gongv2_history::'+filedate+'::surnames),\n' + 
						'      have been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,'Invalid status parameter.')
					),
		'LIENS' =>
			case(b_status,
					'SUCC' =>
					FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::liens_did_qa(thor_data400::key::liens::'+filedate+'::did),\n' + 
						'      2) thor_data400::key::liens_bdid_qa(thor_data400::key::liens::'+filedate+'::bdid),\n' + 
						'      3) thor_data400::key::liens_rmsid_qa(thor_data400::key::liens::'+filedate+'::rmsid),\n' +
						'      4) thor_data400::key::liens_st_case_qa(thor_data400::key::liens::'+filedate+'::st_case)\n' +
						'      5) thor_data400::key::liens_plaintiffname_qa(thor_data400::key::liens::'+filedate+'::plaintiffname)\n' +
						'      6) thor_data400::key::liens_bdid_pl_qa(thor_data400::key::liens::'+filedate+'::bdid_pl)\n' +
						'      7) thor_data400::key::liens::bocashell_did_qa(thor_data400::key::liens::'+filedate+'::bocashell_did)\n' +
						'      8) thor_data400::key::liens::fcra::bocashell_did_qa(thor_data400::key::liens::fcra::'+filedate+'::bocashell_did)\n' +
						'      9) thor_data400::key::liens::fcra::did_qa(thor_data400::key::liens::fcra::'+filedate+'::did)\n' +
						'     10) thor_data400::key::liens::fcra::rmsid_qa(thor_data400::key::liens::fcra::'+filedate+'::rmsid)\n' +
						'      have been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + filedate,'Invalid status parameter.')
					),
		'LSSI' =>
			case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::lssi_did_add_qa(thor_data400::key::lssi::'+filedate+'::did_add),\n' + 
						'      2) thor_data400::key::lssi_hhid_add_qa(thor_data400::key::lssi::'+filedate+'::hhid_add),\n' + 
						'      3) thor_data400::key::lssi_remove_qa(thor_data400::key::lssi::'+filedate+'::remove)\n' +
						'      have been built and ready to be deployed to QA.'),
					'FAIL' =>
						FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + filedate,'Invalid status parameter.')
					),
		'LSSI WEEKLY' =>
			case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::lssi_did_key_qa(thor_data400::key::lssi_weekly::'+filedate+'::did),\n' + 
						'      2) thor_data400::key::lssi_hhid_key_qa(thor_data400::key::lssi_weekly::'+filedate+'::hhid),\n' + 
						'      have been built and ready to be deployed to QA.'),
					'FAIL' =>
						FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,'Invalid status parameter.')
					),
		'UTIL' =>
			case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Daily Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::utility_address_qa(thor_data400::key::utility::'+filedate+'::address),\n' +
						'      2) thor_data400::key::utility::daily.address_qa(thor_data400::key::utility::'+filedate+'::daily.address),\n' +
						'      3) thor_data400::key::utility::daily.citystname_qa(thor_data400::key::utility::'+filedate+'::daily.citystname),\n' +
						'      4) thor_data400::key::utility::daily.name_qa(thor_data400::key::utility::'+filedate+'::daily.name),\n' +
						'      5) thor_data400::key::utility::daily.phone_qa(thor_data400::key::utility::'+filedate+'::daily.phone),\n' +
						'      6) thor_data400::key::utility::daily.ssn_qa(thor_data400::key::utility::'+filedate+'::daily.ssn),\n' +
						'      7) thor_data400::key::utility::daily.stname_qa(thor_data400::key::utility::'+filedate+'::daily.stname),\n' +
						'      8) thor_data400::key::utility::daily.zip_qa(thor_data400::key::utility::'+filedate+'::daily.zip),\n' +
						'      9) thor_data400::key::utility::daily.fdid_qa(thor_data400::key::utility::'+filedate+'::daily.fid),\n' +
						'     10) thor_data400::key::utility::daily.did_qa(thor_data400::key::utility::'+filedate+'::daily.did),\n' +
						'     11) thor_data400::key::utility::daily.id_qa(thor_data400::key::utility::'+filedate+'::daily.id),\n' +
						'     has been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + filedate,'Invalid status parameter.')
					),
		'DEATH MASTER' =>
			case(b_status,
					'SUCC' =>
					FileServices.sendemail(e_target,f_type + ' Weekly Build Succeeded - ' + filedate,
					'keys: 1) thor_data400::key::did_death_master_qa(thor_data400::key::death_master::'+filedate+'::did),\n' + 
					' 	  2) thor_data400::key::ssn_table_qa(thor_data400::key::death_master::'+filedate+'::ssn_table),\n' + 
					'     has been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Weekly Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Weekly Build Warning - ' + filedate,'Invalid status parameter.')
				),
		'FAA' =>
			case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Monthly Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::airmen_did_qa(thor_data400::key::faa::'+filedate+'::airmen_did),\n' + 
						'      2) thor_data400::key::aircraft_reg_did_qa(thor_data400::key::faa::'+filedate+'::aircraft_reg_did),\n' + 
						'      3) thor_data400::key::aircraft_reg_bdid_qa(thor_data400::key::faa::'+filedate+'::aircraft_reg_bdid),\n' + 
						'      4) thor_data400::key::aircraft_reg_nnum_qa(thor_data400::key::faa::'+filedate+'::aircraft_reg_nnum),\n' + 
						'      5) thor_data400::key::faa_airmen_certs_qa(thor_data400::key::faa::'+filedate+'::airmen_certs),\n' + 
						'      6) thor_data400::key::faa_engine_info_qa(thor_data400::key::faa::'+filedate+'::engine_info),\n' + 
						'      7) thor_data400::key::faa_aircraft_info_qa(thor_data400::key::faa::'+filedate+'::aircraft_info),\n' + 
						'     has been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Monthly Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Monthly Build Warning - ' + filedate,'Invalid status parameter.')
					),
		'PULLSSN' =>
			case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + filedate,
						'key: 1) thor_data400::key::pullSSN_qa(thor_data400::key::pullssn::'+filedate+'::ssn),\n' + 
						'     has been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + filedate,'Invalid status parameter.')
					),
	     'SuppressionKeys' =>
			case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + filedate,
						'key: 1) thor_data400::key::new_suppression::qa::link_type_link_id(thor_data400::key::new_suppression::'+filedate+'::link_type_link_id),\n' + 
						'     has been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Daily Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Daily Build Warning - ' + filedate,'Invalid status parameter.')
					),
		'EMERGES' =>
			case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Monthly Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::hunters_doxie_did_qa(thor_data400::key::emerges::'+filedate+'::hunters_doxie_did),\n' + 
						'      2) thor_data400::key::voters_doxie_did_qa(thor_data400::key::emerges::'+filedate+'::voters_doxie_did),\n' + 
						'      3) thor_data400::key::ccw_doxie_did_qa(thor_data400::key::emerges::'+filedate+'::ccw_doxie_did),\n' + 
						'     has been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Monthly Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Monthly Build Warning - ' + filedate,'Invalid status parameter.')
					),
		'ATF' =>
			case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + filedate,
						'keys: 1) thor_Data400::key::atf_firearms_did_qa(thor_data400::key::atf::'+filedate+'::firearms_did),\n' + 
						'      2) thor_data400::key::atf_firearms_lnum_qa(thor_data400::key::atf::'+filedate+'::firearms_lnum),\n' + 
						'      3) thor_data400::key::atf_firearms_trad_qa(thor_data400::key::atf::'+filedate+'::firearms_trad),\n' + 
						'      4) thor_data400::key::atf_firearms_records_qa(thor_data400::key::atf::'+filedate+'::firearms_records),\n' + 
						'     has been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Monthly Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Monthly Build Warning - ' + filedate,'Invalid status parameter.')
					),
		'TELCORDIA_TPM' =>
			case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Monthly Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::telcordia_tpm_qa(thor_data400::key::telcordia::'+filedate+'::tpm)\n' + 
						'      2) thor_data400::key::telcordia_tpm_slim_qa(thor_data400::key::telcordia::'+filedate+'::tpm_slim),\n' + 
						'      3) thor_data400::key::telcordia_tpm_npa_st_qa(thor_data400::key::telcordia::'+filedate+'::npa_st),\n' + 
						'     have been built and are ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Monthly Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Monthly Build Warning - ' + filedate,'Invalid status parameter.')
					),
		'TELCORDIA_TDS' =>
			case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::telcordia_tds_qa(thor_data400::key::telcordia::'+filedate+'::tds)\n' + 
						'     have been built and are ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,'Invalid status parameter.')
					),
		'GLOBAL WATCH LISTS' =>
			case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Weekly Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::globalwatchlists::seq_qa(thor_data400::key::globalwatchlists::'+filedate+'::seq),\n' + 
						'      2) thor_data400::key::globalwatchlists::countries_qa(thor_data400::key::globalwatchlists::'+filedate+'::countries),\n' + 
						'      3) thor_data400::key::globalwatchlists::globalwatchlists_key_qa(thor_data400::key::globalwatchlists::'+filedate+'::globalwatchlists_key),\n' + 
						'have been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,'Invalid status parameter.')
					),
			'QUICK HEADER' =>
			case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Monthly Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::headerquick_autokeyaddress_qa(thor_data400::key::headerquick::'+filedate+'::autokey_address),\n' + 
						'      2) thor_data400::key::headerquick_autokeycitystname_qa(thor_data400::key::headerquick::'+filedate+'::autokey_citystname),\n' + 
						'      3) thor_data400::key::headerquick_autokeyname_qa(thor_data400::key::headerquick::'+filedate+'::autokey_name),\n' + 
						'      4) thor_data400::key::headerquick_autokeypayload_qa(thor_data400::key::headerquick::'+filedate+'::autokey_payload),\n' + 
						'      5) thor_data400::key::headerquick_autokeyphone_qa(thor_data400::key::headerquick::'+filedate+'::autokey_phone),\n' + 
						'      6) thor_data400::key::headerquick_autokeyssn_qa(thor_data400::key::headerquick::'+filedate+'::autokey_ssn),\n' + 
						'      7) thor_data400::key::headerquick_autokeystname_qa(thor_data400::key::headerquick::'+filedate+'::autokey_stname),\n' + 
						'      8) thor_data400::key::headerquick_autokeyzip_qa(thor_data400::key::headerquick::'+filedate+'::autokey_zip),\n' + 
						'      9) thor_data400::key::headerquickdid_qa(thor_data400::key::headerquick::'+filedate+'::did),\n' + 
						'have been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,'Invalid status parameter.')
					),
			'DO NOT CALL' =>
				case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Weekly Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::dnc::qa::phone(thor_data400::key::dnc::'+filedate+'::phone),\n' + 
						'had been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,'Invalid status parameter.')
					),
			'DO NOT MAIL' =>
				case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Monthly Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::dnm::qa::name.address(thor_data400::key::dnm::'+filedate+'::name.address),\n' + 
						'had been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,'Invalid status parameter.')
					),
			'EMERGES VOTE' =>
				case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::voters::QA::did(thor_data400::key::voters::'+filedate+'::did),\n' + 
						'	   	 2) thor_data400::key::voters::QA::VTID(thor_data400::key::voters::'+filedate+'::vtid),\n' + 
						'	   	 3) thor_data400::key::voters::QA::History_VTID(thor_data400::key::voters::'+filedate+'::history_vtid),\n' + 
						'	   	 4) thor_data400::key::voters::autokey::QA::Address(thor_data400::key::voters::'+filedate+'::autokey::address),\n' + 
						'	   	 5) thor_data400::key::voters::autokey::QA::CityStName(thor_data400::key::voters::'+filedate+'::autokey::citystname),\n' + 
						'	   	 6) thor_data400::key::voters::autokey::QA::Name(thor_data400::key::voters::'+filedate+'::autokey::name),\n' + 
						'	   	 7) thor_data400::key::voters::autokey::QA::Phone2(thor_data400::key::voters::'+filedate+'::autokey::phone2),\n' + 
						'	   	 8) thor_data400::key::voters::autokey::QA::SSN2(thor_data400::key::voters::'+filedate+'::autokey::ssn2),\n' + 
						'	   	 9) thor_data400::key::voters::autokey::QA::StName(thor_data400::key::voters::'+filedate+'::autokey::stname),\n' + 
						'	   	10) thor_data400::key::voters::autokey::QA::Zip(thor_data400::key::voters::'+filedate+'::autokey::zip),\n' + 
						'had been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,'Invalid status parameter.')
					),
			'EASI CENSUS' =>
				case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::easi::'+filedate+'::census,\n' + 
						'had been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,'Invalid status parameter.')
					),
			'BIRTHS' =>
				case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::births::'+filedate+'::ca_births,\n' + 
						'had been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,'Invalid status parameter.')
					),
			'FEDEX'	=>
				case(b_status,
					'SUCC' =>
						FileServices.sendemail(e_target,f_type + ' Build Succeeded - ' + filedate,
						'keys: 1) thor_data400::key::fedex::autokey::QA::Address(thor_data400::key::fedex::' + filedate + '::autokey::address),\n' + 
						'	   	 2) thor_data400::key::fedex::autokey::QA::CityStName(thor_data400::key::fedex::' + filedate + '::autokey::citystname),\n' + 
						'	   	 3) thor_data400::key::fedex::autokey::QA::Name(thor_data400::key::fedex::' + filedate + '::autokey::name),\n' + 
						'	   	 4) thor_data400::key::fedex::autokey::QA::Phone2(thor_data400::key::fedex::'+filedate+'::autokey::phone2),\n' + 
						'	   	 5) thor_data400::key::fedex::autokey::QA::StName(thor_data400::key::voters::'+filedate+'::autokey::stname),\n' + 
						'	   	 6) thor_data400::key::fedex::autokey::QA::Zip(thor_data400::key::voters::'+filedate+'::autokey::zip),\n' + 
						'	   	 7) thor_data400::key::fedex::autokey::QA::ZipprLname(thor_data400::key::voters::'+filedate+'::autokey::zipprlname),\n' + 
						'	   	 8) thor_data400::key::fedex::autokey::QA::Payload(thor_data400::key::voters::'+filedate+'::autokey::payload),\n' + 
						'had been built and ready to be deployed to QA.'),
					'FAIL' =>	   
						FileServices.sendemail(e_target,f_type + ' Build Failure - ' + filedate,failmessage),
					FileServices.sendemail(e_target,f_type + ' Build Warning - ' + filedate,'Invalid status parameter.')
					),
		FileServices.sendemail(e_target,'Build Macro Warning','Invalid file type parameter.')
	); 	

endmacro;