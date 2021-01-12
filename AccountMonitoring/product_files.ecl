﻿﻿/*2011-07-06T18:43:20Z (Chris Albee_prod)
Add BK daily files.
*/
IMPORT AccountMonitoring,BankruptcyV2, Business_Header, CellPhone, CourtLink, Corrections, Did_Add, Doxie, 
			 Data_Services, Gong, Gong_Neustar, Header, Header_Quick, Header_Services, LiensV2, LN_PropertyV2, NID, PAW, 
			 PhonesFeedback, Phonesplus, POE, Property, Risk_Indicators, ut, UtilFile, Watchdog, 
			 hygenics_crim, business_header_ss, PhonesInfo, BIPV2_Best, 
			 Business_Credit, Business_Credit_Scoring, UCCV2, SAM, Inquiry_AccLogs, Corp2,
			 VehicleV2, FAA, Watercraft, Phonesplus_v2, dx_PhonesInfo;
			 
EXPORT product_files := MODULE

	EXPORT header_files := MODULE
	
		// |||||||||||||||||||||||||| COMMON LAYOUTS |||||||||||||||||||||||||

		EXPORT layout_base_header := RECORD
			Header.Layout_Header.fname;
			Header.Layout_Header.mname;
			Header.Layout_Header.lname;
			Header.Layout_Header.prim_range;
			Header.Layout_Header.prim_name;
			Header.Layout_Header.sec_range;
			Header.Layout_Header.city_name;
			Header.Layout_Header.st;
			Header.Layout_Header.zip;
			Header.Layout_Header.phone;
			Header.Layout_Header.dt_last_seen;
			Header.Layout_Header.dt_vendor_last_reported;
			Header.Layout_Header.did;
			Header.Layout_Header.src;
      Header.Layout_Header_v2.dob;
			Header.Layout_Header_v2.ssn;
		END;

		EXPORT layout_base_file_util_daily := RECORD
			utilfile.Layout_DID_Out.fname;
			utilfile.Layout_DID_Out.mname;
			utilfile.Layout_DID_Out.lname;
			utilfile.Layout_DID_Out.prim_range;
			utilfile.Layout_DID_Out.prim_name;
			utilfile.Layout_DID_Out.sec_range;
			utilfile.Layout_DID_Out.address_city;
			utilfile.Layout_DID_Out.st;
			utilfile.Layout_DID_Out.zip;
			utilfile.Layout_DID_Out.phone;
			utilfile.Layout_DID_Out.record_date;
			utilfile.Layout_DID_Out.did;
		END;
		
		EXPORT layout_base_quick_header := RECORD
			Header.Layout_Header.fname;
			Header.Layout_Header.mname;
			Header.Layout_Header.lname;
			Header.Layout_Header.prim_range;
			Header.Layout_Header.prim_name;
			Header.Layout_Header.sec_range;
			Header.Layout_Header.city_name;
			Header.Layout_Header.st;
			Header.Layout_Header.zip;
			Header.Layout_Header.phone;
			Header.Layout_Header.dt_last_seen;
			Header.Layout_Header.dt_vendor_last_reported;
			Header.Layout_Header.did;
			Header.Layout_Header.src;
		END;
	
		// ||||||||||||||||||||||||||||  KEY FILES  ||||||||||||||||||||||||||
		
		// In lieu of: doxie.key_header
		EXPORT r_doxie_key_header_superfile 		  := 'thor_data400::key::header_' + doxie.version_superkey;
		EXPORT r_doxieKeyHeader_for_monitor 			:= 'monitor::personheader';
		EXPORT r_doxie_key_header_superkeyname    :=  AccountMonitoring.constants.MONITOR_KEY_CLUSTER + r_doxieKeyHeader_for_monitor + '_qa'; 
				
		// Define a Duplicate Index; see the ECL Language Guide, p. 68
		SHARED r_doxie_key_header_undist := 
			pull(INDEX(
				doxie.key_header,  
				r_doxie_key_header_superkeyname
			))(did <> 0);
			
		SHARED r_doxie_key_header :=
			DISTRIBUTE(
				PROJECT(r_doxie_key_header_undist, layout_base_header), 
				HASH64(did)
			);
      
		EXPORT r_doxie_key_header_slim := DEDUP(SORT(r_doxie_key_header, 
																							 did, fname, lname, prim_range, prim_name, sec_range, st, zip, phone, -dt_last_seen, -dt_vendor_last_reported, LOCAL),
																				  did, fname, lname, prim_range, prim_name, sec_range, st, zip, phone, LOCAL) 
																		: INDEPENDENT; 

		// DIDUPDATE FILES
		EXPORT r_doxie_key_rid_did_superfile 			:= 'thor_data400::key::rid_did_' + doxie.version_superkey;
		EXPORT r_doxieKeyRid_did_for_monitor 			:= 'monitor::doxie_rid_did';
		EXPORT r_doxie_key_rid_did_superkeyname   :=  AccountMonitoring.constants.MONITOR_KEY_CLUSTER + r_doxieKeyRid_did_for_monitor + '_qa'; 

		SHARED r_doxie_key_rid_did_undist := 
			INDEX(
				doxie.Key_Did_Rid,  
				r_doxie_key_rid_did_superkeyname
			)(rid <> did);

		EXPORT r_doxie_key_rid_did := 
			DISTRIBUTE(
				r_doxie_key_rid_did_undist, 
				HASH64(rid)
			): INDEPENDENT; 

		EXPORT r_doxie_key_rid_did_split_superfile 			  := 'thor_data400::key::rid_did_split_' + doxie.version_superkey;
		EXPORT r_doxieKeyRid_did_split_for_monitor 				:= 'monitor::doxie_rid_did_split';
		EXPORT r_doxie_key_rid_did_split_superkeyname     :=  AccountMonitoring.constants.MONITOR_KEY_CLUSTER + r_doxieKeyRid_did_split_for_monitor + '_qa'; 

	  SHARED r_doxie_key_rid_did_split_undist := 
			INDEX(
				doxie.Key_Did_Rid_Split,  
				r_doxie_key_rid_did_split_superkeyname
			)(rid <> did);

		EXPORT r_doxie_key_rid_did_split := 
			DISTRIBUTE(
				r_doxie_key_rid_did_split_undist, 
				HASH64(rid)
			): INDEPENDENT; 
			
		// BDIDUPDATE FILES
		EXPORT r_business_header_rcid_superfile 		:= 'thor_data400::key::business_header.rcid_' + business_header_ss.key_version;
		EXPORT r_business_header_rcid_for_monitor  	:= 'monitor::business_header_rcid';
		EXPORT r_business_header_rcid_superkeyname  :=  AccountMonitoring.constants.MONITOR_KEY_CLUSTER + r_business_header_rcid_for_monitor + '_qa'; 

		SHARED r_business_header_key_rcid_undist := 
			INDEX(
				Business_Header.Key_Business_Header_RCID,  
				r_business_header_rcid_superkeyname
			)(rcid <> bdid);

		EXPORT r_business_header_key_rcid := 
			DISTRIBUTE(
				r_business_header_key_rcid_undist, 
				HASH64(rcid)
			): INDEPENDENT; //PERSIST('acctmon::header::business_header_key_rcid');
		
		
		// BIP Best Header FILES
	  EXPORT r_bipbest_header_superfile 		:= 'thor_data400::key::bipv2_best::' + doxie.Version_SuperKey + '::linkids';
		EXPORT r_bipbest_header_for_monitor  	:= 'monitor::bipbest_header';
		EXPORT r_bipbest_header_superkeyname  :=  AccountMonitoring.constants.MONITOR_KEY_CLUSTER + r_bipbest_header_for_monitor + '_qa'; 
																					
		SHARED r_bipbest_header_key_undist := 
			INDEX(
				BIPV2_Best.Key_LinkIds.key,  
				r_bipbest_header_superkeyname
			)(proxid = 0);  // Proxid of zero are deemed the Best record

		EXPORT r_bipbest_header_key :=
			DISTRIBUTE(
				r_bipbest_header_key_undist(seleid !=0),
				HASH64(seleid)
				): INDEPENDENT; //PERSIST('acctmon::bipbestheader::key_bipv2_best');
				
		// In lieu of: header_quick.key_DID
		EXPORT r_quick_header_superfile 			:= 'thor_data400::key::' + header_quick.str_SegmentName + 'DID_' + Doxie.Version_SuperKey;
		EXPORT r_quick_header_for_monitor 		:= 'monitor::quick_headerDID';
		EXPORT r_quick_header_superkeyname    :=  AccountMonitoring.constants.MONITOR_KEY_CLUSTER + r_quick_header_for_monitor + '_qa'; 

		SHARED r_quick_header_key_DID_undist := 
			INDEX(
				header_quick.key_DID, 
				r_quick_header_superkeyname
			)(did <> 0);
		
		SHARED r_quick_header_key_DID :=
			DISTRIBUTE(
				PROJECT(r_quick_header_key_DID_undist, layout_base_quick_header), 
				HASH64(did)
			);

		EXPORT r_quick_header_key_DID_slim := DEDUP(SORT(r_quick_header_key_DID, 
																								   did, fname, lname, prim_range, prim_name, sec_range, st, zip, phone, -dt_last_seen, -dt_vendor_last_reported, LOCAL),
																						  did, fname, lname, prim_range, prim_name, sec_range, st, zip, phone, LOCAL) 
																				: INDEPENDENT; //PERSIST('acctmon::header::quick_header_key_DID_slim');

		// In lieu of: utilfile.key_util_daily_did
		EXPORT r_daily_utility_superfile 					  := 'thor_data400::key::utility::daily.did_' + Doxie.Version_SuperKey;
		EXPORT r_daily_utility_for_monitor 					:= 'monitor::daily_utility';
		EXPORT r_daily_utility_superkeyname     		:=  AccountMonitoring.constants.MONITOR_KEY_CLUSTER + r_daily_utility_for_monitor + '_qa'; 
		
		SHARED r_daily_utility_key_DID_undist := 
			INDEX(
				utilfile.key_util_daily_did,
				r_daily_utility_superkeyname
			)(record_date >= utilfile.StartDate, did <> '');
		
		SHARED r_daily_utility_key_DID := 
			DISTRIBUTE(
				PROJECT(r_daily_utility_key_DID_undist, layout_base_file_util_daily),
				HASH64((UNSIGNED6)did)
			);
			
		EXPORT r_daily_utility_key_DID_slim := DEDUP(SORT(r_daily_utility_key_DID, 
																									  did, fname, lname, prim_range, prim_name, sec_range, st, zip, phone, -record_date, LOCAL),
																						   did, fname, lname, prim_range, prim_name, sec_range, st, zip, phone, LOCAL) 
																				 : INDEPENDENT; //PERSIST('acctmon::header::daily_utility_key_DID_slim');

	END;
	
	EXPORT address := MODULE
	
		// =========================== ORIGINALLY: ===========================
		// base_people_file   := Watchdog.File_Best;
		// ===================================================================
		
		// Use people best info from base watchdog_best file
		// (thor_data400::base::watchdog_best uses layout=Watchdog.Layout_Best)
		EXPORT person_best_filename_raw := 'thor_data400::BASE::Watchdog_Best';
		EXPORT person_best_filename := AccountMonitoring.constants.DATA_LOCATION + person_best_filename_raw;
		SHARED watchdog_file_best_raw := DATASET(person_best_filename, Watchdog.Layout_Best, THOR)(did <> 0);
		
		EXPORT layout_base_file_neighbor := RECORD
			Watchdog.Layout_Best.fname;
			Watchdog.Layout_Best.mname;
			Watchdog.Layout_Best.lname;
			Watchdog.Layout_Best.prim_name;
			Watchdog.Layout_Best.prim_range;
			Watchdog.Layout_Best.sec_range;
			Watchdog.Layout_Best.city_name;
			Watchdog.Layout_Best.st;
			Watchdog.Layout_Best.zip;
			Watchdog.Layout_Best.phone;
			Watchdog.Layout_Best.addr_dt_last_seen;
			Watchdog.Layout_Best.did;
		END;

		SHARED watchdog_file_best_dist := 
			DISTRIBUTE(
				PROJECT(watchdog_file_best_raw, layout_base_file_neighbor), 
				HASH64(did)
			);

		EXPORT watchdog_file_best := DEDUP(SORT(watchdog_file_best_dist, 
																						did, phone, -addr_dt_last_seen, LOCAL),
																			 did, phone, LOCAL) 
																 : INDEPENDENT; //PERSIST('acctmon::phone::base_file_neighbor');		
				
		// =========================== ORIGINALLY: ===========================
		// base_business_file := Business_Header.File_Business_Header_Best;
		// ===================================================================
		
		// Use business best info from base business_header best file
		// (thor_data400::base::business_header.best 
		//           uses layout=Business_Header.Layout_BH_Best)	
		EXPORT business_best_filename_raw := 'thor_data400::BASE::Business_Header.Best';
		EXPORT business_best_filename := AccountMonitoring.constants.DATA_LOCATION + business_best_filename_raw;
		EXPORT base_business_file := DATASET(business_best_filename, Business_Header.Layout_BH_Best, THOR)
		                                     : INDEPENDENT; //PERSIST('acctmon::address::business_file');
				
	END;
	
	EXPORT bankruptcy := MODULE
	
		// =========================== ORIGINALLY: ===========================
		// search_file := bankruptcyv2.file_bankruptcy_search_v3;
		// ===================================================================
		
		EXPORT layout_search_file_slim := RECORD
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.tmsid;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.did;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.bdid;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.lname;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.mname;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.fname;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.prim_name;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.predir;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.prim_range;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.addr_suffix;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.postdir;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.unit_desig;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.sec_range;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.p_city_name;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.st;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.zip;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.zip4;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.ssn;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.ssnMatch;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.cname;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.tax_id;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.dCode;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.statusDate;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.dateVacated;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.dispType;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.dispReason;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.DotID;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.EmpID;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.POWID;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.ProxID;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.SELEID;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.OrgID;
			BankruptcyV2.layout_bankruptcy_search_v3_supp_bip.UltID;
		END;

		EXPORT search_filename_raw := 'thor_data400::base::bankruptcy::search_v3';
		EXPORT search_filename := AccountMonitoring.constants.DATA_LOCATION + search_filename_raw;
		EXPORT search_file_raw := DATASET(search_filename,
		                              BankruptcyV2.layout_bankruptcy_search_v3_supp_bip, THOR)
		                              (court_code+case_number NOT IN bankruptcyv2.Suppress.court_code_caseno);
		EXPORT search_file := 
			PROJECT( search_file_raw, layout_search_file_slim ) : INDEPENDENT;


		EXPORT search_filename_daily_raw := 'thor_data400::base::bankruptcy::search_v3_daily';
		EXPORT search_filename_daily := AccountMonitoring.constants.DATA_LOCATION + search_filename_daily_raw;
		EXPORT search_file_raw_daily := DATASET(search_filename_daily,
		                              BankruptcyV2.layout_bankruptcy_search_v3_supp_bip, THOR)
		                              (court_code+case_number NOT IN bankruptcyv2.Suppress.court_code_caseno);
		EXPORT search_file_daily := 
			PROJECT( search_file_raw_daily, layout_search_file_slim ) : INDEPENDENT;
			
			
		// =========================== ORIGINALLY: ===========================
		// main_file   := bankruptcyv3.file_bankruptcy_main_v3;
		// ===================================================================
		EXPORT main_filename_raw := 'thor_data400::base::bankruptcy::main_v3';
		EXPORT main_filename := AccountMonitoring.constants.DATA_LOCATION + main_filename_raw;
		EXPORT main_file   := PROJECT(DATASET(main_filename,
		                              bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp, THOR)
		                              (court_code+case_number NOT IN bankruptcyv2.Suppress.court_code_caseno),bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing)
																	: INDEPENDENT;	

		EXPORT main_filename_daily_raw := 'thor_data400::base::bankruptcy::main_v3_daily';
		EXPORT main_filename_daily := AccountMonitoring.constants.DATA_LOCATION + main_filename_daily_raw;
		EXPORT main_file_daily   := PROJECT(DATASET(main_filename_daily,
		                              bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp, THOR)
		                              (court_code+case_number NOT IN bankruptcyv2.Suppress.court_code_caseno),bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing)
																	: INDEPENDENT;	
	END;
	
  EXPORT deceased := MODULE

    // =========================== ORIGINALLY: ===========================
    // base_file := Header.File_DID_Death_MasterV2;
    // ===================================================================

    // NOTE: Due to poor synchronization between Prod_Dali and RoxieBatch (i.e., Prod_Dali
    // will have an updated Deathmaster file for 2-3 days before the same file version is
    // written to RoxieBatch), read from Prod_Dali the most recent version that exists on
    // RoxieBatch.
    EXPORT deathmaster_build_version := TRIM( did_add.get_EnvVariable('Deathmaster_Build_Version') ) : INDEPENDENT;

    // UNRESTRICTED BASEFILE
    EXPORT base_filename_raw := 'thor_data400::base::did_death_masterV3_ssa_' + deathmaster_build_version;
    EXPORT base_filename     := AccountMonitoring.constants.DATA_LOCATION + base_filename_raw;
    EXPORT base_superfilename_raw := 'thor_data400::base::did_death_masterV3_ssa';
    EXPORT base_superfilename     := AccountMonitoring.constants.DATA_LOCATION + base_superfilename_raw;
    EXPORT base_file := DATASET(base_filename, Header.Layout_Did_Death_MasterV3, flat);// : PERSIST('acctmon::deceased::by_DID');

  END;
	
	EXPORT foreclosure := MODULE

		// =========================== ORIGINALLY: ===========================
		// export File_Foreclosure_Base := PROJECT(File_Foreclosure_Base_v2, Layout_Fares_Foreclosure);
		// ===================================================================	
		EXPORT base_filename_raw := 'thor_data400::base::foreclosure';
		EXPORT base_filename := AccountMonitoring.constants.DATA_LOCATION + base_filename_raw;
		EXPORT base_file_raw := DATASET(base_filename, Property.Layout_Fares_Foreclosure_v2, THOR);
		EXPORT base_file     := PROJECT(base_file_raw, Property.Layout_Fares_Foreclosure);
		
		EXPORT Layout_Base_Header_file_slim := RECORD
			Property.Layout_Fares_Foreclosure.foreclosure_id;
			Property.Layout_Fares_Foreclosure.situs1_prim_range;
			Property.Layout_Fares_Foreclosure.situs1_predir;
			Property.Layout_Fares_Foreclosure.situs1_prim_name;
			Property.Layout_Fares_Foreclosure.situs1_addr_suffix;
			Property.Layout_Fares_Foreclosure.situs1_postdir;
			Property.Layout_Fares_Foreclosure.situs1_sec_range;
			Property.Layout_Fares_Foreclosure.situs1_p_city_name;
			Property.Layout_Fares_Foreclosure.situs1_st;
			Property.Layout_Fares_Foreclosure.situs1_zip;
			Property.Layout_Fares_Foreclosure.recording_date;
			Property.Layout_Fares_Foreclosure.filing_date;
			Property.Layout_Fares_Foreclosure.deed_category;
			Property.Layout_Fares_Foreclosure.document_type;
			Property.Layout_Fares_Foreclosure.name1_did;
		END;

		EXPORT base_file_slim := 
			PROJECT(
				DISTRIBUTE(
					base_file, 
					HASH64(situs1_zip,situs1_prim_range,situs1_prim_name,situs1_addr_suffix,situs1_predir)
				),
				Layout_Base_Header_file_slim
			) : INDEPENDENT; //PERSIST('acctmon::foreclosure::base_file_slim');
		
	END;
	
	EXPORT people_at_work := MODULE
	
		// =========================== ORIGINALLY: ===========================
		// base_file_b := PAW.Files().Base.Built(did > 0 and company_name <> '' and score > '003');
		// ===================================================================
	
		EXPORT main_filename_raw := 'thor_data400::base::paw::qa::data';
		EXPORT main_filename := AccountMonitoring.constants.DATA_LOCATION + main_filename_raw;
		EXPORT layout_base_file_b := RECORD
			PAW.layout.Employment_Out.company_name;
			PAW.layout.Employment_Out.dt_last_seen;
			PAW.layout.Employment_Out.fname;
			PAW.layout.Employment_Out.mname;
			PAW.layout.Employment_Out.lname;
			PAW.layout.Employment_Out.prim_range;
			PAW.layout.Employment_Out.prim_name;
			PAW.layout.Employment_Out.sec_range;
			PAW.layout.Employment_Out.city;
			PAW.layout.Employment_Out.state;
			PAW.layout.Employment_Out.zip;
			PAW.layout.Employment_Out.phone;
			PAW.layout.Employment_Out.did;
			PAW.layout.Employment_Out.score;
		END;
		EXPORT base_file_b_raw := 
			PROJECT(DATASET(main_filename, PAW.layout.Employment_Out, THOR)(did > 0 and company_name <> '' and score > '003'),
							TRANSFORM(layout_base_file_b, SELF := LEFT));
		
		SHARED base_file_b_dist := DISTRIBUTE(base_file_b_raw, hash64(did));
		
		EXPORT base_file_b := DEDUP(SORT(base_file_b_dist, 
																		 did, company_name, phone, -dt_last_seen, -score, LOCAL),
																did, company_name, phone, LOCAL) 
													: INDEPENDENT; //PERSIST('acctmon::paw::base_file_b');
	END;
	
	
	EXPORT phone := MODULE

		EXPORT rec_gong_history_slim := RECORD
			Gong.Layout_history.listed_name;
			Gong.Layout_history.name_last;
			Gong.Layout_history.name_first;
			Gong.Layout_history.name_middle;
			Gong.Layout_history.prim_name;
			Gong.Layout_history.prim_range;
			Gong.Layout_history.sec_range;
			Gong.Layout_history.p_city_name;
			Gong.Layout_history.v_city_name;
			Gong.Layout_history.st;
			Gong.Layout_history.z5;
			Gong.Layout_history.did;
			Gong.Layout_history.phone10;
			string7 phone7    := '';
			string3 area_code := '';
			Gong.Layout_history.current_record_flag;
			Gong.Layout_history.dt_last_seen;		
		END;
		
		// ||||||||||||||||||||||||||||  KEY FILES  ||||||||||||||||||||||||||

		// In lieu of: Gong.Key_History_Address

		EXPORT gong_history_address_keyfilename_raw := 'thor_data400::key::gong_history_address_' + doxie.Version_SuperKey;
		EXPORT gong_history_address_keyfilename     := AccountMonitoring.constants.DATA_LOCATION + gong_history_address_keyfilename_raw;
		
		SHARED gong_history_key_address_undist := 
			INDEX(
				Gong.Key_History_Address,
				gong_history_address_keyfilename
			)(current_record_flag = 'Y');
		
		SHARED gong_history_key_address := 
			DISTRIBUTE(
				gong_history_key_address_undist,
				HASH64(prim_name, st, z5, prim_range, sec_range)
			);

		EXPORT gong_history_key_address_slim := 
			PROJECT(gong_history_key_address, rec_gong_history_slim)
			        : INDEPENDENT; //PERSIST('acctmon::gong::history_address_key_slim');		
		

		// ||||||||||||||||||||||||||||  BASE FILES  ||||||||||||||||||||||||||
		
		// Gong.File_History
		// EXPORT base_filename_raw := 'thor_data400::base::gong_history';
		// EXPORT base_filename := constants.DATA_LOCATION + base_filename_raw;
		EXPORT gong_filename_nocluster := 'base::gong_history';
		EXPORT gong_filename_raw := 'thor_data400::' + gong_filename_nocluster;
		EXPORT gong_filename := AccountMonitoring.constants.DATA_LOCATION + gong_filename_raw;	
		//CCPA-22 use new gong history layout defined in Gong_Neustar
		SHARED File_Gong_History_Full := DATASET(gong_filename, Gong_Neustar.Layout_History, THOR, __COMPRESSED__);
		//SHARED File_Gong_History_Current := File_Gong_History_Full(current_record_flag = 'Y');
		EXPORT File_Gong_History_Current := File_Gong_History_Full(current_record_flag = 'Y');

		// 1. Perform suppression
//		ut.mac_suppress_by_phonetype(File_Gong_History_Current, phone10, st, histGong_out, TRUE, did);

		// Slim, distribute, sort, dedup. Then swap city names for better results (Bug 42318)
		SHARED Gong_hist_slim_raw := PROJECT(File_Gong_History_Current, rec_gong_history_slim);
		SHARED Gong_hist_slim_dst := DISTRIBUTE(Gong_hist_slim_raw,HASH64(name_last,prim_range,prim_name,z5));								   
		SHARED Gong_hist_slim_srt := SORT(Gong_hist_slim_dst, record, local);
		SHARED Gong_hist_slim_ddp := DEDUP(Gong_hist_slim_srt, record, local);

		SHARED Gong_hist_slim_persisted := 
			PROJECT(Gong_hist_slim_ddp,
				TRANSFORM(rec_gong_history_slim,
					self.p_city_name := left.v_city_name;
					self.v_city_name := left.p_city_name;
					self := left
				)
			) : INDEPENDENT; //PERSIST('acctmon::phone::gong_history_slim');
		
		// SHARED Gong_hist_slim := Gong_hist_slim_persisted : INDEPENDENT;

	
		// =========================== ORIGINALLY: ===========================
		// gong.Key_history_Address
		// ===================================================================
		
		EXPORT file_history_address := Gong_hist_slim_persisted(TRIM(prim_name) <> '', TRIM(z5) <> '');
		
		
		// =========================== ORIGINALLY: ===========================
		// gong.key_history_city_st_name
		// ===================================================================
		
		SHARED rec_history_name_city_st := RECORD
				file_history_address;
				string25 city_name;
				unsigned4 city_code;
				string6 dph_name_last;
				string20 p_name_first;
		END;

		SHARED file_history_name_city_st_undist := 
			PROJECT(
				file_history_address, 
				TRANSFORM(rec_history_name_city_st, 
					self.city_name := left.p_city_name, // assign P_city_name
					self.city_code := HASH64((qstring25)left.p_city_name),
					self.dph_name_last := metaphonelib.DMetaPhone1(left.name_last),
					self.p_name_first := NID.PreferredFirstNew(left.name_first),
					self := left))  
			+																											
			PROJECT(
				file_history_address(p_city_name <> v_city_name), 
				TRANSFORM(rec_history_name_city_st, 
					self.city_name := left.v_city_name, // assign V_city_name
					self.city_code := HASH64((qstring25)left.v_city_name),
					self.dph_name_last := metaphonelib.DMetaPhone1(left.name_last),
					self.p_name_first := NID.PreferredFirstNew(left.name_first),
					self := left));
								
		EXPORT file_history_name_city_st := 
			DISTRIBUTE(
				file_history_name_city_st_undist,
				HASH64(city_code,st,dph_name_last,name_last,p_name_first,name_first)
			); 
						
						
		// =========================== ORIGINALLY: ===========================
		// gong.Key_History_phone
		// ===================================================================

		SHARED has_no_alpha_chars(STRING expr) := LENGTH(stringlib.stringfilterout(expr, '0123456789')) = 0;
		
		SHARED get_phone7(STRING10 phone10_untrimmed) := 
			FUNCTION
				/* extract phone 7 */
				phone10 := TRIM(phone10_untrimmed, LEFT, RIGHT);
				phone7 := IF( phone10[8..10] = '', phone10[1..7], phone10[4..10] );

				/* ascertain boolean: phone 7 is all numbers and not all 0's and not empty and nxx/phone are not all 0's */
				good_phone7 := (phone7[1..3] BETWEEN '200' AND '999') AND ((UNSIGNED)phone7[4..7] > 0) AND (LENGTH(phone7) = 7) AND has_no_alpha_chars(phone7);

				RETURN IF(good_phone7, phone7, '');				
			END;

		SHARED get_area_code(STRING10 phone10_untrimmed) := 
			FUNCTION
				/* extract area_code */
				phone10 := trim(phone10_untrimmed, LEFT, RIGHT);
				area_code := if( phone10[8..10] = '', '', phone10[1..3] );

				/* ascertain boolean: area_code is all numbers and not all 0's and not empty and first character not 0 */
				good_area_code := ((UNSIGNED)area_code[1..1] <> 0) AND ((UNSIGNED)area_code > 0) AND has_no_alpha_chars(area_code);

				RETURN IF(good_area_code, area_code, '');
			END;
		
		SHARED rec_gong_history_slim xfm_split_phoneno(rec_gong_history_slim l) := 
			TRANSFORM
				self.phone7    := get_phone7(l.phone10);
				self.area_code := get_area_code(l.phone10);
				self := l;			
			END;

		SHARED Gong_hist_valid_phones := Gong_hist_slim_persisted(TRIM(phone10,LEFT,RIGHT) != '' AND phone10 NOT IN ut.Set_BadPhones);
		SHARED Gong_hist_valid_split_phones := PROJECT(Gong_hist_valid_phones, xfm_split_phoneno(left))(phone7 <> '', did <> 0);
			
		EXPORT file_history_phone := 
			DISTRIBUTE(
				Gong_hist_valid_split_phones,
				HASH64(name_last, name_first, phone7, area_code)
				);
			
			
		// =========================== ORIGINALLY: ===========================
		// base_file_cell := Phonesplus_v2.file_phonesplus_base;
		// ===================================================================
		
		EXPORT plus_filename_subfile := 'out::phonesplus_did';
		EXPORT plus_filename_raw := 'thor_data400::base::phonesplusv2';
		EXPORT plus_filename := AccountMonitoring.constants.DATA_LOCATION + plus_filename_raw;
		EXPORT layout_base_file_cell := RECORD
			Phonesplus_v2.Layout_Phonesplus_Base.fname;
			Phonesplus_v2.Layout_Phonesplus_Base.mname;
			Phonesplus_v2.Layout_Phonesplus_Base.lname;
			Phonesplus_v2.Layout_Phonesplus_Base.prim_range;
			Phonesplus_v2.Layout_Phonesplus_Base.prim_name;
			Phonesplus_v2.Layout_Phonesplus_Base.sec_range;
			Phonesplus_v2.Layout_Phonesplus_Base.v_city_name;
			Phonesplus_v2.Layout_Phonesplus_Base.state;
			Phonesplus_v2.Layout_Phonesplus_Base.zip5;
			Phonesplus_v2.Layout_Phonesplus_Base.cellphone;
			Phonesplus_v2.Layout_Phonesplus_Base.DateLastSeen;
			Phonesplus_v2.Layout_Phonesplus_Base.did;
			Phonesplus_v2.Layout_Phonesplus_Base.confidencescore;
			Phonesplus_v2.Layout_Phonesplus_Base.vendor;
		END;
		
		SHARED base_file_cell_undist := 
			PROJECT(
				Phonesplus_v2.File_Phonesplus_Base(did <> 0, CellPhone <> '', confidencescore > 10, phonesplus.IsCellSource(vendor)),
				layout_base_file_cell
			);

		EXPORT base_file_cell := 
			DISTRIBUTE(
				base_file_cell_undist,
				hash64(did)
			) : INDEPENDENT; //PERSIST('acctmon::phone::base_file_cell');
	     
		// =========================== ORIGINALLY: ===========================
		// base_file_neighbor := watchdog.Key_watchdog_glb;
		// ===================================================================
		
		EXPORT person_best_filename_raw := address.person_best_filename_raw;
		EXPORT person_best_filename := address.person_best_filename;
		
		EXPORT base_file_neighbor := address.watchdog_file_best;		

		// =========================== ORIGINALLY: ===========================
		// base_file_paw_did := PAW.File_Base;
		// ===================================================================	
		
		EXPORT base_file_paw_did := people_at_work.base_file_b;
		
		// ===================================================================
		// For SwitchType
		// ===================================================================
	  EXPORT phones_type_superfile	:= 'thor_data400::key::Phones_type_'+doxie.Version_SuperKey;
    EXPORT phones_type_for_superkey_monitor := 'monitor::Phones_type';
	  EXPORT phones_type_superkeyname := AccountMonitoring.constants.MONITOR_KEY_CLUSTER + phones_type_for_superkey_monitor + '_qa';
	
		EXPORT key_phones_type := 
			PULL(INDEX(
				dx_PhonesInfo.Key_Phones_Type,  
				phones_type_superkeyname
			));
			
		EXPORT key_phones_type_dist :=
			DISTRIBUTE(
				key_phones_type, 
				HASH64(phone)
			): INDEPENDENT;

    EXPORT Phones_Lerg6_superfile := 'thor_data400::key::phones_lerg6_'+doxie.Version_SuperKey;
		EXPORT Phones_Lerg6_for_superkey_monitor := 'monitor::phones_lerg6';
		EXPORT phones_lerg6_superkeyname := AccountMonitoring.constants.MONITOR_KEY_CLUSTER + Phones_Lerg6_for_superkey_monitor+ '_qa';
		
		EXPORT key_Phones_Lerg6 := 
			PULL(INDEX(
				dx_PhonesInfo.Key_Phones_Lerg6,  
				phones_lerg6_superkeyname
			));
			
		EXPORT key_Phones_Lerg6_dist :=
			DISTRIBUTE(
				key_Phones_Lerg6, 
				HASH64(npa, nxx, block_id)
			): INDEPENDENT;

    EXPORT carrier_reference_superfile := 'thor_data400::key::phonesmetadata::carrier_reference_'+doxie.Version_SuperKey;
		EXPORT carrier_reference_for_superkey_monitor := 'monitor::phonesmetadata::carrier_reference';
		EXPORT carrier_reference_superkeyname := AccountMonitoring.constants.MONITOR_KEY_CLUSTER + carrier_reference_for_superkey_monitor + '_qa';

		EXPORT key_carrier_reference := 
			PULL(INDEX(
				dx_PhonesInfo.Key_Source_Reference.ocn_name,  
				carrier_reference_superkeyname
			));
			
		EXPORT key_carrier_reference_dist :=
			DISTRIBUTE(
				key_carrier_reference, 
				HASH64(ocn)
			): INDEPENDENT;															 
			
		// Settings - Switch Type / Phone Type
		EXPORT SET OF STRING3 Toll_Free_Area_Codes := ['800','811','822','833','844','855','866','877','888','899'];
		EXPORT STRING1 POTS                       := 'P'; // "Plain Old Telephone Service"
		EXPORT STRING1 PAGER                      := 'G';
		EXPORT STRING1 CELL_PHONE                 := 'C';
		EXPORT STRING1 PUERTO_RICO_VIRGIN_ISLANDS := 'I';
		EXPORT STRING1 TIME                       := 'T';
		EXPORT STRING1 VOIP                       := 'V';
		EXPORT STRING1 WEATHER                    := 'W';
		EXPORT STRING1 TOLL_FREE                  := '8';
		EXPORT STRING1 UNKNOWN_TYPE               := 'U';		
		EXPORT STRING1 CABLE                      := 'B';
		

	END; // Phone module
	
	EXPORT property := MODULE
	
		// =========================== ORIGINALLY: ===========================
		// clnd := LN_PropertyV2.File_Search_DID(~(LENGTH(TRIM(cname)) BETWEEN 1 AND 3 OR
		//																			(TRIM(prim_range) = '' AND TRIM(prim_name) = '' AND TRIM(v_city_name) = '' AND TRIM(st) = '' AND TRIM(zip) = '')) AND
		//																		(source_code[2] = 'P') AND
		//																		ln_fares_id NOT IN LN_PropertyV2.Suppress_LNFaresID);
		// ===================================================================
		
		// Search file.		
		EXPORT Property_search_Roxiesuperfile:= 'thor_data400::key::ln_propertyv2::qa::search.fid';
		EXPORT Property_search_keyname_monitor := 'monitor::LN_PropertyV2::Search_fid';
		EXPORT Property_search_superkey_monitor := AccountMonitoring.constants.MONITOR_KEY_CLUSTER + Property_search_keyname_monitor + '_qa';
		
    SHARED Property_search_key_undist := INDEX(
												LN_PropertyV2.key_search_fid(),  
												Property_search_superkey_monitor
												);
    
    SHARED Property_search_key_filtered := Property_search_key_undist( NOT ( LENGTH(TRIM(cname)) BETWEEN 1 AND 3 OR
							 ( TRIM(prim_range)  = '' AND 
								 TRIM(prim_name)   = '' AND 
								 TRIM(v_city_name) = '' AND 
								 TRIM(st)          = '' AND 
								 TRIM(zip)         = '' ) 
							) AND
				 (source_code[2] = 'P') AND
				 ln_fares_id NOT IN LN_PropertyV2.Suppress_LNFaresID );

		SHARED Property_search_key_dist := 
			DISTRIBUTE(Property_search_key_filtered,
			           HASH32(did, bdid, app_ssn, lname, fname, 
								prim_range, prim_name, suffix, p_city_name, st, zip)): INDEPENDENT;
	  
		EXPORT Property_search_key_sorted := DEDUP(SORT(Property_search_key_dist,
								 did, bdid, app_ssn, lname, fname, 
								 prim_range, prim_name, suffix, p_city_name, st, zip, -process_date, RECORD,
								 LOCAL),
						did, bdid, app_ssn, lname, fname, 
						prim_range, prim_name, suffix, p_city_name, st, zip, 
						LOCAL);

		// Deeds file.
	
		EXPORT Property_deed_Roxiesuperfile := 'thor_data400::key::ln_propertyv2::qa::addlfaresdeed.fid';
		EXPORT Property_deed_keyname_monitor := 'monitor::LN_PropertyV2::addlfaresdeed.fid';
		EXPORT Property_deed_superkey_monitor := AccountMonitoring.constants.MONITOR_KEY_CLUSTER + Property_deed_keyname_monitor + '_qa';

		SHARED Property_deed_key_undist := INDEX(
										LN_PropertyV2.key_addl_fares_deed_fid,  
										Property_deed_superkey_monitor
										);

		EXPORT Property_deed_key_dist := 
			DISTRIBUTE(Property_deed_key_undist, HASH64(ln_fares_id)) : INDEPENDENT;
	
		// Linkid key		
		EXPORT Property_SearchLinkid_Roxie_superfile := 'thor_data400::key::ln_propertyv2::qa::search.linkids';
		EXPORT Property_SearchLinkid_keyname_monitor     := 'monitor::LN_PropertyV2::search.linkids';
		EXPORT Property_SearchLinkid_superkey_monitor := AccountMonitoring.constants.MONITOR_KEY_CLUSTER + Property_SearchLinkid_keyname_monitor + '_qa';

		SHARED Property_SearchLinkid_superkey_undist := 
				INDEX(
					LN_PropertyV2.Key_LinkIds.key,  
					Property_SearchLinkid_superkey_monitor
				);

		EXPORT Property_SearchLinkid_superkey_dist :=
				DISTRIBUTE(
					Property_SearchLinkid_superkey_undist, 
					HASH64(seleid)
					): INDEPENDENT; //PERSIST('acctmon::property::search_linkid');
		
		
	END; // End Property Module
	
	EXPORT litigiousdebtor := MODULE
		
		EXPORT layout_search_file_b := RECORD
			CourtLink.Layouts.Base.debtor_lname;
			CourtLink.Layouts.Base.debtor_fname;
			CourtLink.Layouts.Base.CourtState;
			CourtLink.Layouts.Base.DocketNumber;
		END;
		
		EXPORT litigiousdebtor_filename_raw    := 'thor_data400::base::courtlink::qa::litdebt';
		EXPORT litigiousdebtor_filename        := AccountMonitoring.constants.DATA_LOCATION + litigiousdebtor_filename_raw;
		EXPORT litigiousdebtor_file            := DATASET(litigiousdebtor_filename, CourtLink.Layouts.Base, THOR);
		
		EXPORT litigiousdebtor_file_slim := DISTRIBUTE(litigiousdebtor_file, HASH32(debtor_lname, debtor_fname, CourtState, DocketNumber)) 
		                                    : INDEPENDENT; //PERSIST('acctmon::litigiousdebtor::search_file_slim');
	END;

	EXPORT liens := MODULE
		
		// For LiensV2.file_liens_main
		
		SHARED liens_main_layout := LiensV2.Layout_liens_main_module.layout_liens_main;
		
		EXPORT main_HOGAN_filename_raw  := 'thor_data400::base::liens::main::Hogan';
		EXPORT main_HOGAN_filename      := AccountMonitoring.constants.DATA_LOCATION + main_HOGAN_filename_raw;
		EXPORT main_HOGAN_file          := PROJECT( DATASET(main_HOGAN_filename,LiensV2.layout_liens_main_module_for_hogan.layout_liens_main,THOR), liens_main_layout)
		                                     : INDEPENDENT; //PERSIST('acctmon::liens::main::HOGAN');
																				 
		EXPORT main_ILFDLN_filename_raw := 'thor_data400::base::liens::main::ILFDLN';
		EXPORT main_ILFDLN_filename     := AccountMonitoring.constants.DATA_LOCATION + main_ILFDLN_filename_raw;
		EXPORT main_ILFDLN_file         := DATASET(main_ILFDLN_filename,liens_main_layout,THOR)
		                                     : INDEPENDENT; //PERSIST('acctmon::liens::main::ILFDLN');
		
		EXPORT main_NYC_filename_raw    := 'thor_data400::base::liens::main::NYC';
		EXPORT main_NYC_filename        := AccountMonitoring.constants.DATA_LOCATION + main_NYC_filename_raw;
		EXPORT main_NYC_file            := DATASET(main_NYC_filename,liens_main_layout,THOR)
		                                     : INDEPENDENT; //PERSIST('acctmon::liens::main::NYC');
		
		EXPORT main_NYFDLN_filename_raw := 'thor_data400::base::liens::main::NYFDLN';
		EXPORT main_NYFDLN_filename     := AccountMonitoring.constants.DATA_LOCATION + main_NYFDLN_filename_raw;
		EXPORT main_NYFDLN_file         := DATASET(main_NYFDLN_filename,liens_main_layout,THOR)
		                                     : INDEPENDENT; //PERSIST('acctmon::liens::main::NYFDLN');
		
		EXPORT main_SA_filename_raw     := 'thor_data400::base::liens::main::SA';
		EXPORT main_SA_filename         := AccountMonitoring.constants.DATA_LOCATION + main_SA_filename_raw;
		EXPORT main_SA_file             := DATASET(main_SA_filename,liens_main_layout,THOR)
		                                     : INDEPENDENT; //PERSIST('acctmon::liens::main::SA');
		
		EXPORT main_chicago_law_filename_raw := 'thor_data400::base::liens::main::chicago_law';
		EXPORT main_chicago_law_filename     := AccountMonitoring.constants.DATA_LOCATION + main_chicago_law_filename_raw;
		EXPORT main_chicago_law_file         := DATASET(main_chicago_law_filename,liens_main_layout,THOR)
		                                          : INDEPENDENT; //PERSIST('acctmon::liens::main::chicago_law');

		EXPORT main_CA_federal_filename_raw := 'thor_data400::base::liens::main::CA_federal';
		EXPORT main_CA_federal_filename     := AccountMonitoring.constants.DATA_LOCATION + main_CA_federal_filename_raw;
		EXPORT main_CA_federal_file         := DATASET(main_CA_federal_filename,liens_main_layout,THOR)
		                                         : INDEPENDENT; //PERSIST('acctmon::liens::main::CA_federal');
		
		EXPORT main_superior_filename_raw  := 'thor_data400::base::liens::main::superior';
		EXPORT main_superior_filename      := AccountMonitoring.constants.DATA_LOCATION + main_superior_filename_raw;
		EXPORT main_superior_file          := DATASET(main_superior_filename,liens_main_layout,THOR)
		                                        : INDEPENDENT; //PERSIST('acctmon::liens::main::superior');
		
		EXPORT main_MA_filename_raw  := 'thor_data400::base::liens::main::MA';
		EXPORT main_MA_filename      := AccountMonitoring.constants.DATA_LOCATION + main_MA_filename_raw;
		EXPORT main_MA_file          := DATASET(main_MA_filename,liens_main_layout,THOR)
		                                  : INDEPENDENT; //PERSIST('acctmon::liens::main::MA');

		SHARED liens_main_pre_file := 
				main_HOGAN_file(tmsid NOT IN Liensv2.Suppress_TMSID())
			+ main_ILFDLN_file(tmsid NOT IN Liensv2.Suppress_TMSID())
			+ main_NYC_file(tmsid NOT IN Liensv2.Suppress_TMSID())
			+ main_NYFDLN_file(tmsid NOT IN Liensv2.Suppress_TMSID())
			+ main_SA_file(tmsid NOT IN Liensv2.Suppress_TMSID())
			+ main_chicago_law_file(tmsid NOT IN Liensv2.Suppress_TMSID())
			+ main_CA_federal_file(tmsid NOT IN Liensv2.Suppress_TMSID())
			+ main_superior_file(tmsid NOT IN Liensv2.Suppress_TMSID())
			+ main_MA_file(tmsid NOT IN Liensv2.Suppress_TMSID());

		EXPORT main_file := 
			PROJECT(liens_main_pre_file, 
				TRANSFORM(liens_main_layout, 
					SELF.orig_filing_date := IF(LEFT.orig_filing_date <= stringlib.GetDateYYYYMMDD(),LEFT.orig_filing_date, ''),
					SELF := LEFT))(NOT REGEXFIND('CAALAC1',tmsid));		
		
		// For LiensV2.file_liens_party

		EXPORT liens_party_layout := LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags;
		
		EXPORT party_HOGAN_filename_raw  := 'thor_data400::base::liens::party::Hogan';
		EXPORT party_HOGAN_filename      := AccountMonitoring.constants.DATA_LOCATION + party_HOGAN_filename_raw;
		EXPORT party_HOGAN_file          := PROJECT( DATASET(party_HOGAN_filename,LiensV2.layout_liens_party_ssn_for_hogan_bipv2_with_LinkFlags,THOR), liens_party_layout)
		                                      : INDEPENDENT; //PERSIST('acctmon::liens::party::HOGAN');

		EXPORT party_ILFDLN_filename_raw := 'thor_data400::base::liens::party::ILFDLN';
		EXPORT party_ILFDLN_filename     := AccountMonitoring.constants.DATA_LOCATION + party_ILFDLN_filename_raw;
		EXPORT party_ILFDLN_file         := DATASET(party_ILFDLN_filename,liens_party_layout,THOR)
		                                      : INDEPENDENT; //PERSIST('acctmon::liens::party::ILFDLN');
		
		EXPORT party_NYC_filename_raw    := 'thor_data400::base::liens::party::NYC';
		EXPORT party_NYC_filename        := AccountMonitoring.constants.DATA_LOCATION + party_NYC_filename_raw;
		EXPORT party_NYC_file            := DATASET(party_NYC_filename,liens_party_layout,THOR)
		                                      : INDEPENDENT; //PERSIST('acctmon::liens::party::NYC');
		
		EXPORT party_NYFDLN_filename_raw := 'thor_data400::base::liens::party::NYFDLN';
		EXPORT party_NYFDLN_filename     := AccountMonitoring.constants.DATA_LOCATION + party_NYFDLN_filename_raw;
		EXPORT party_NYFDLN_file         := DATASET(party_NYFDLN_filename,liens_party_layout,THOR)
		                                      : INDEPENDENT; //PERSIST('acctmon::liens::party::NYFDLN');
		
		EXPORT party_SA_filename_raw     := 'thor_data400::base::liens::party::SA';
		EXPORT party_SA_filename         := AccountMonitoring.constants.DATA_LOCATION + party_SA_filename_raw;
		EXPORT party_SA_file             := DATASET(party_SA_filename,liens_party_layout,THOR)
		                                      : INDEPENDENT; //PERSIST('acctmon::liens::party::SA');
		
		EXPORT party_chicago_law_filename_raw := 'thor_data400::base::liens::party::chicago_law';
		EXPORT party_chicago_law_filename     := AccountMonitoring.constants.DATA_LOCATION + party_chicago_law_filename_raw;
		EXPORT party_chicago_law_file         := DATASET(party_chicago_law_filename,liens_party_layout,THOR)
		                                           : INDEPENDENT; //PERSIST('acctmon::liens::party::chicago_law');

		EXPORT party_CA_federal_filename_raw := 'thor_data400::base::liens::party::CA_federal';
		EXPORT party_CA_federal_filename     := AccountMonitoring.constants.DATA_LOCATION + party_CA_federal_filename_raw;
		EXPORT party_CA_federal_file         := DATASET(party_CA_federal_filename,liens_party_layout,THOR)
		                                          : INDEPENDENT; //PERSIST('acctmon::liens::party::CA_federal');
		
		EXPORT party_superior_filename_raw  := 'thor_data400::base::liens::party::superior';
		EXPORT party_superior_filename      := AccountMonitoring.constants.DATA_LOCATION + party_superior_filename_raw;
		EXPORT party_superior_file          := DATASET(party_superior_filename,liens_party_layout,THOR)
		                                         : INDEPENDENT; //PERSIST('acctmon::liens::party::superior');
		
		EXPORT party_MA_filename_raw  := 'thor_data400::base::liens::party::MA';
		EXPORT party_MA_filename      := AccountMonitoring.constants.DATA_LOCATION + party_MA_filename_raw;
		EXPORT party_MA_file          := DATASET(party_MA_filename,liens_party_layout,THOR)
		                                   : INDEPENDENT; //PERSIST('acctmon::liens::party::MA');

		EXPORT party_file := 
				party_HOGAN_file((cname <> ''or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
			+ party_ILFDLN_file((cname <> ''or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
			+ party_NYC_file((cname <> ''or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
			+ party_NYFDLN_file((cname <> ''or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
			+ party_SA_file((cname <> ''or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
			+ party_chicago_law_file((cname <> ''or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
			+ party_CA_federal_file((cname <> ''or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
			+ party_superior_file((cname <> ''or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
			+ party_MA_file((cname <> ''or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid));
	
	END; // Liens
	
	EXPORT criminal := MODULE
			
		// 1. Offender file
		SHARED NOT_ALIAS := '0';
		
		EXPORT layout_offenders_slim := RECORD
			corrections.layout_Offender.offender_key;
			corrections.layout_Offender.lname;		
			corrections.layout_Offender.fname;	
			corrections.layout_Offender.mname;
			corrections.layout_Offender.name_suffix;
			corrections.layout_Offender.dob;
			corrections.layout_Offender.did;
			corrections.layout_Offender.ssn_appended;
		END;
		
		EXPORT offender_filename_raw    := 'thor_data400::base::corrections_offenders_public_built';
		EXPORT offender_filename        := AccountMonitoring.constants.DATA_LOCATION + offender_filename_raw;
		EXPORT offender_file_unfiltered := DATASET(offender_filename, corrections.layout_Offender, THOR);
		EXPORT offender_file_filtered   := offender_file_unfiltered(pty_typ = NOT_ALIAS);		
		
		EXPORT offender_file_dist := 
			DISTRIBUTE(
				PROJECT(offender_file_filtered,layout_offenders_slim),
			  HASH64(
					offender_key,lname,NID.PreferredFirstNew(fname),mname,dob,did,ssn_appended
				)
			);
												
		EXPORT offenders_file_deduped := 
			DEDUP(
				SORT(
					offender_file_dist, offender_key,lname,NID.PreferredFirstNew(fname),mname,dob,did,ssn_appended, 
					LOCAL
				),
				offender_key,lname,NID.PreferredFirstNew(fname),mname,dob,did,ssn_appended, 
				LOCAL
			);
		
		EXPORT offenders_file_slim := 
			DISTRIBUTE(
				offenders_file_deduped, 
				HASH64(offender_key)
			) : INDEPENDENT; //PERSIST('acctmon::criminal::offenders_file_slim');
		
		// 2. Offenses file, sorted and deduped for record having most recent off_date and inc_adm_date.
		EXPORT layout_offenses_slim := RECORD
			corrections.layout_offense_common.offender_key;
			corrections.layout_offense_common.off_date;
			corrections.layout_offense_common.case_num;
			corrections.layout_offense_common.inc_adm_dt;
		END;
		
		EXPORT offenses_filename_raw  := 'thor_data400::base::corrections_offenses_public_built';
		EXPORT offenses_filename      := AccountMonitoring.constants.DATA_LOCATION + offenses_filename_raw;
		EXPORT offenses_file          := DATASET(offenses_filename, hygenics_crim.Layout_Base_Offenses_with_OffenseCategory, THOR);

		EXPORT offenses_file_dist := 
			DISTRIBUTE(
				PROJECT(offenses_file,layout_offenses_slim),
			  HASH32(
					offender_key
				)
			);
												
		EXPORT offenses_file_deduped := 
			DEDUP(
				SORT(
					offenses_file_dist,
					offender_key, -off_date, -inc_adm_dt,
					LOCAL
				),
				offender_key,
				LOCAL
			);
			
		EXPORT offenses_file_slim := 
			DISTRIBUTE(
				offenses_file_deduped, 
				HASH64(offender_key)
			) : INDEPENDENT; //PERSIST('acctmon::criminal::offenses_file_slim');
			
		// 3. Punishments file, sorted and deduped for most recent event_dt.
		EXPORT layout_punishments_slim := RECORD
			corrections.Layout_CrimPunishment.offender_key;
			corrections.Layout_CrimPunishment.event_dt;
			corrections.Layout_CrimPunishment.sent_date;
			corrections.Layout_CrimPunishment.sent_length;
			corrections.Layout_CrimPunishment.cur_stat_inm_desc;
			corrections.Layout_CrimPunishment.sch_rel_dt;
			corrections.Layout_CrimPunishment.act_rel_dt;
			// corrections.Layout_CrimPunishment.pro_status;
			// corrections.Layout_CrimPunishment.pro_st_dt;
			// corrections.Layout_CrimPunishment.pro_end_dt;
			hygenics_crim.Layout_CrimPunishment.pro_status;
			hygenics_crim.Layout_CrimPunishment.pro_st_dt;
			hygenics_crim.Layout_CrimPunishment.pro_end_dt;
		END;
		
		EXPORT punishments_filename_raw  := 'thor_data400::base::corrections_punishment_public_built';
		EXPORT punishments_filename      := AccountMonitoring.constants.DATA_LOCATION + punishments_filename_raw;
		EXPORT punishments_file          := DATASET(punishments_filename, hygenics_crim.Layout_CrimPunishment, THOR);

		EXPORT punishments_file_dist := 
			DISTRIBUTE(
				PROJECT(punishments_file,layout_punishments_slim),
			  HASH32(
					offender_key
				)
			);
												
		EXPORT punishments_file_deduped := 
			DEDUP(
				SORT(
					punishments_file_dist,
					offender_key, -event_dt,
					LOCAL
				),
				offender_key,
				LOCAL
			);

		EXPORT punishments_file_slim := 
			DISTRIBUTE(
				punishments_file_deduped, 
				HASH64(offender_key)
			) : INDEPENDENT; //PERSIST('acctmon::criminal::punishments_file_slim');
			
	END; // criminal
	
	EXPORT phonefeedback := MODULE
		
		EXPORT phonefeedback_phone_keyname := 'thor_data400::key::phonesFeedback::'+doxie.Version_SuperKey+'::phone';
		EXPORT PhonesFeedback_Phone_superkey_monitor := 'monitor::PhonesFeedback::Phone';
		EXPORT PhonesFeedback_superkey     := AccountMonitoring.constants.MONITOR_KEY_CLUSTER + PhonesFeedback_Phone_superkey_monitor + '_qa';

		SHARED PhonesFeedback_key_undist := INDEX(
											PhonesFeedback.Key_PhonesFeedback_phone(),  
											PhonesFeedback_superkey
											);

		EXPORT PhonesFeedback_key_monitor := DISTRIBUTE(PhonesFeedback_key_undist(did != 0), 
																						HASH64(did)
																					): INDEPENDENT;			
	END;

	EXPORT workplace := MODULE
	// NOTE: WorkPlace is also known as PlaceOfEmployment(POE) for internal purposes.
	//       The base files were originally created using "::poe::" in the name.

	  EXPORT base_filename_raw := 'thor_data400::base::poe::qa::data';
	  EXPORT base_filename     := AccountMonitoring.constants.DATA_LOCATION + base_filename_raw;

		EXPORT layout_base_file_slimmed := RECORD
		  // the POE base file fields that are needed in the cgm are:
      // Person related fields
			POE.layouts.base.did;
			string9 ssn; // don't use POE.layouts.subject_ssn because that is unsigned4 and we need string9
      POE.layouts.base.subject_name.fname;
      POE.layouts.base.subject_name.lname;
			POE.layouts.base.subject_address.prim_range;
      POE.layouts.base.subject_address.predir;
	    POE.layouts.base.subject_address.prim_name;
	    POE.layouts.base.subject_address.addr_suffix;
	    POE.layouts.base.subject_address.postdir;
	    POE.layouts.base.subject_address.sec_range;
	    POE.layouts.base.subject_address.city_name;
	    POE.layouts.base.subject_address.st;
	    POE.layouts.base.subject_address.zip;
	    POE.layouts.base.subject_address.zip4;
			// Company related fields
			unsigned6 poe_bdid;  //used diff name here because of conflict with bdid in the portfolio base file.
			POE.layouts.base.company_name;
      // defined company address fields with diff names because of conflict with subject_address field names
      string10 company_prim_range;
	    string2  company_predir;
	    string28 company_prim_name;
	    string4  company_addr_suffix;
	    string2  company_postdir;
	    string8  company_sec_range;
	    string25 company_city_name;
	    string2  company_st;
	    string5  company_zip;
	    string4  company_zip4;
			POE.layouts.base.company_phone;
		END;

    SSN_WIDTH         := 9;
	  LEADING_ZERO_FILL := 1;
	  EXPORT base_file_slim := 
		  PROJECT(DATASET(base_filename, POE.layouts.base, THOR)(did > 0), 
			        TRANSFORM(layout_base_file_slimmed,
							  SELF.ssn         := if(LEFT.subject_ssn=0,
																	     '', // store blank instead of zero
																			 // otherwise convert unsigned ssn to string9 ssn
																			 // using intformat in case leading digit of ssn is zero
																	     intformat(LEFT.subject_ssn,SSN_WIDTH,LEADING_ZERO_FILL)),
								// some fields have diff names from left
								SELF.fname       := LEFT.subject_name.fname,
								SELF.lname       := LEFT.subject_name.lname,
				        SELF.prim_range  := LEFT.subject_address.prim_range,
				        SELF.predir      := LEFT.subject_address.predir,
				        SELF.prim_name   := LEFT.subject_address.prim_name,
				        SELF.addr_suffix := LEFT.subject_address.addr_suffix,
				        SELF.postdir     := LEFT.subject_address.postdir,
	              SELF.sec_range   := LEFT.subject_address.sec_range,
	              SELF.city_name   := LEFT.subject_address.city_name,
	              SELF.st          := LEFT.subject_address.st,
	              SELF.zip         := LEFT.subject_address.zip,
	              SELF.zip4        := LEFT.subject_address.zip4,
								SELF.poe_bdid            := LEFT.bdid;
				        SELF.company_prim_range  := LEFT.company_address.prim_range,
				        SELF.company_predir      := LEFT.company_address.predir,
				        SELF.company_prim_name   := LEFT.company_address.prim_name,
				        SELF.company_addr_suffix := LEFT.company_address.addr_suffix,
				        SELF.company_postdir     := LEFT.company_address.postdir,
	              SELF.company_sec_range   := LEFT.company_address.sec_range,
	              SELF.company_city_name   := LEFT.company_address.city_name,
	              SELF.company_st          := LEFT.company_address.st,
	              SELF.company_zip         := LEFT.company_address.zip,
	              SELF.company_zip4        := LEFT.company_address.zip4,
								// all others have the same field name as left
								SELF             := LEFT)) 
							: INDEPENDENT; //PERSIST('acctmon::workplace::base_file_slim');

	END; // end workplace module

	EXPORT PhoneOwnership := MODULE

	  EXPORT phones_transaction_superfile	:= 'thor_data400::key::Phones_transaction_'+doxie.Version_SuperKey;
    EXPORT phones_transaction_for_superkey_monitor := 'monitor::Phones_transaction';
	  EXPORT phones_transaction_superkeyname := AccountMonitoring.constants.MONITOR_KEY_CLUSTER + phones_transaction_for_superkey_monitor + '_qa';
	
		EXPORT key_phones_transaction := 
			PULL(INDEX(
				dx_PhonesInfo.Key_Phones_Transaction,  
				phones_transaction_superkeyname
			));
			
		EXPORT key_phones_transaction_dist :=
			DISTRIBUTE(
				key_phones_transaction, 
				HASH64(phone)
			): INDEPENDENT;

	END; //end of phone ownership
	
	EXPORT sbfe := MODULE
	
		EXPORT sbfe_build_version := TRIM(did_add.get_EnvVariable('sbfecv_build_version')):INDEPENDENT;
  
// Linkid key
// Duplicate of Roxie Key 
	
		EXPORT r_sbfeLinkid_superkeyname_raw := 'batchr3::monitor::sbfe::linkids_' + doxie.Version_SuperKey;
		EXPORT r_sbfeLinkid_superkeyname     := AccountMonitoring.constants.DATA_LOCATION + r_sbfeLinkid_superkeyname_raw;

		SHARED r_sbfeLinkid_key_undist := 
			pull(INDEX(
				Business_Credit.Key_LinkIds().key,  
				r_sbfeLinkid_superkeyname
			));

		EXPORT r_sbfeLinkid_key :=
			DISTRIBUTE(
				r_sbfeLinkid_key_undist, 
				HASH64(seleid)
				): INDEPENDENT; //PERSIST('acctmon::sbfe::key_linkid');
   
   
// Tradeline Key	
// Duplicate of Roxie Key	
  
		EXPORT r_sbfeTrade_superkeyname_raw := 'batchr3::monitor::sbfe::tradeline_' + doxie.Version_SuperKey;
		EXPORT r_sbfeTrade_superkeyname     := AccountMonitoring.constants.DATA_LOCATION + r_sbfeTrade_superkeyname_raw;

		SHARED r_sbfeTrade_key_undist := 
			pull(INDEX(
				Business_Credit.key_tradeline(),  
				r_sbfeTrade_superkeyname
			));

		EXPORT r_sbfeTrade_key :=
			DISTRIBUTE(
				r_sbfeTrade_key_undist, 
				HASH64(sbfe_contributor_number,contract_account_number)
				): INDEPENDENT; //PERSIST('acctmon::sbfe::key_tradeline');

// Credit Score Key	
// Duplicate of Roxie Key	
		
		EXPORT r_sbfeScore_superkeyname_raw := 'batchr3::monitor::sbfescoring::scoringindex_' + doxie.Version_SuperKey ;
		EXPORT r_sbfeScore_superkeyname     := AccountMonitoring.constants.DATA_LOCATION + r_sbfeScore_superkeyname_raw;

		SHARED r_sbfeScore_key_undist := 
			pull(INDEX(
				Business_Credit_Scoring.Key_ScoringIndex().Key,  
				r_sbfeScore_superkeyname
			));

		EXPORT r_sbfeScore_key :=
			DISTRIBUTE(
				r_sbfeScore_key_undist,
				HASH64(seleid) 
				): INDEPENDENT; //PERSIST('acctmon::sbfe::key_scoring');
	END;
  

		
	EXPORT ucc := MODULE
	
		EXPORT ucc_build_version := TRIM(did_add.get_EnvVariable('ucc_build_version')):INDEPENDENT;

		// Linkid key
		EXPORT uccLinkid_keyname_raw := 'thor_data400::key::ucc::' + ucc_build_version + '::linkids';
		EXPORT uccLinkid_keyname     := AccountMonitoring.constants.DATA_LOCATION + uccLinkid_keyname_raw;
		
		EXPORT uccLinkid_superkeyname_raw  := 'thor_data400::key::ucc::linkids_' + doxie.Version_SuperKey;
		EXPORT uccLinkid_superkeyname     	:= AccountMonitoring.constants.DATA_LOCATION + uccLinkid_superkeyname_raw;

		SHARED uccLinkid_key_undist := 
			INDEX(
				UCCV2.Key_LinkIds.key,  
				uccLinkid_keyname
			);

		EXPORT uccLinkid_key :=
			DISTRIBUTE(
				uccLinkid_key_undist, 
				HASH64(seleid)
				): INDEPENDENT; //PERSIST('acctmon::ucc::key_linkid');
				
		// Main tmsid/rmsid Key	
			
		EXPORT uccMain_keyname_raw  := 'thor_data400::key::ucc::' + ucc_build_version + '::main_rmsid';
		EXPORT uccMain_keyname     	:= AccountMonitoring.constants.DATA_LOCATION + uccMain_keyname_raw;
		
		EXPORT uccMain_superkeyname_raw := 'thor_data400::key::ucc::main_rmsid_' + doxie.Version_SuperKey;
		EXPORT uccMain_superkeyname     := AccountMonitoring.constants.DATA_LOCATION + uccMain_superkeyname_raw;

		SHARED uccMain_key_undist := 
			INDEX(
				UCCV2.Key_Rmsid_Main(),  
				uccMain_keyname
			);

		EXPORT uccMain_key :=
			DISTRIBUTE(
				uccMain_key_undist,
				HASH64(tmsid) 
				): INDEPENDENT; //PERSIST('acctmon::ucc::key_main');
	
		END;
		
		EXPORT govtdebarred := MODULE
	
			EXPORT govt_build_version := TRIM(did_add.get_EnvVariable('sam_build_version')):INDEPENDENT;

			// Linkid key
			EXPORT govtLinkid_keyname_raw := 'thor_data400::key::sam::' + govt_build_version + '::linkids';
			EXPORT govtLinkid_keyname     := AccountMonitoring.constants.DATA_LOCATION + govtLinkid_keyname_raw;
			
			EXPORT govtLinkid_superkeyname_raw  := 'thor_data400::key::sam::linkids_' + doxie.Version_SuperKey;
			EXPORT govtLinkid_superkeyname     	:= AccountMonitoring.constants.DATA_LOCATION + govtLinkid_superkeyname_raw;

			SHARED govtLinkid_key_undist := 
				INDEX(
					SAM.key_linkID.key,  
					govtLinkid_keyname
				);

			EXPORT govtLinkid_key :=
				DISTRIBUTE(
					govtLinkid_key_undist, 
					HASH64(seleid)
					): INDEPENDENT; //PERSIST('acctmon::sam::key_linkid');
					
		END;
		
		EXPORT inquiry := MODULE
	
      EXPORT inquiryLinkid_Roxie_SuperFile := 'thor_data400::key::inquiry_table::LinkIds_' + doxie.Version_SuperKey;
      EXPORT inquiryLinkid_superkey_monitor := 'monitor::inquiry::linkids';
      EXPORT inquiryLinkid_superkey     := AccountMonitoring.constants.MONITOR_KEY_CLUSTER + inquiryLinkid_superkey_monitor + '_qa';

      SHARED inquiryLinkid_key_undist := INDEX(
																							Inquiry_AccLogs.Key_Inquiry_LinkIds.key,  
																							inquiryLinkid_superkey
																							);

      EXPORT inquiryLinkid_key_monitor := DISTRIBUTE(inquiryLinkid_key_undist, 
                                             HASH64(seleid)
                                            ): INDEPENDENT; //PERSIST('acctmon::inquiry::key_linkid');
      // Update Linkid key
      EXPORT inquiryUpdLinkid_Roxie_SuperFile := 'thor_data400::key::inquiry_table::' + doxie.version_superkey  + '::linkids_update';
      EXPORT inquiryUpdLinkid_superkey_monitor := 'monitor::inquiry_table::linkids_update' ;
      EXPORT inquiryUpdLinkid_superkey     := AccountMonitoring.constants.MONITOR_KEY_CLUSTER + inquiryUpdLinkid_superkey_monitor + '_qa';
			
      SHARED inquiryUpdLinkid_key_undist := INDEX(
																									Inquiry_AccLogs.Key_Inquiry_LinkIds_Update.key,  
																									inquiryUpdLinkid_superkey
																									);

      EXPORT inquiryUpdLinkid_key_monitor := DISTRIBUTE(inquiryUpdLinkid_key_undist, 
	                                              HASH64(seleid)
                                               ): INDEPENDENT; //PERSIST('acctmon::inquiry_table::key_linkid_update');					
		END;
		
		EXPORT corp := MODULE
	
			EXPORT corp_build_version := TRIM(did_add.get_EnvVariable('corp_build_version')):INDEPENDENT;
			
			// Linkid key
			EXPORT corpLinkid_keyname_raw := 'thor_data400::key::corp2::' + corp_build_version + '::corp::linkids';
			EXPORT corpLinkid_keyname     := AccountMonitoring.constants.DATA_LOCATION + corpLinkid_keyname_raw;
			
			EXPORT corpLinkid_superkeyname_raw  := 'thor_data400::key::corp2::' + doxie.Version_SuperKey + '::corp::linkids';
			EXPORT corpLinkid_superkeyname     	:= AccountMonitoring.constants.DATA_LOCATION + corpLinkid_superkeyname_raw;

			SHARED corpLinkid_key_undist := 
				INDEX(
					Corp2.Key_LinkIDs.corp.key,  
					corpLinkid_keyname
				);

			EXPORT corpLinkid_key :=
				DISTRIBUTE(
					corpLinkid_key_undist, 
					HASH64(seleid)
					): INDEPENDENT; //PERSIST('acctmon::corp::key_linkid');
							
			// corp key
				
			EXPORT corpKey_keyname_raw := 'thor_data400::key::corp2::' + corp_build_version + '::corp::corp_key.record_type';
			EXPORT corpKey_keyname     := AccountMonitoring.constants.DATA_LOCATION + corpKey_keyname_raw;
			
			EXPORT corpKey_superkeyname_raw  := 'thor_data400::key::corp2::' + doxie.Version_SuperKey + '::corp::corp_key.record_type';
			EXPORT corpKey_superkeyname     	:= AccountMonitoring.constants.DATA_LOCATION + corpKey_superkeyname_raw;

			SHARED corpKey_key_undist := 
				INDEX(
					Corp2.Key_Corp_Corpkey,  
					corpKey_keyname
				);

			EXPORT corpKey_key :=
				DISTRIBUTE(
					corpKey_key_undist, 
					HASH64(corp_key)
					): INDEPENDENT; //PERSIST('acctmon::corp2::corp_key.record_type');
					
		END;
		
		EXPORT mvr := MODULE
	
			EXPORT mvr_build_version := TRIM(did_add.get_EnvVariable('vehicle_build_version')):INDEPENDENT;
			
			// Linkid key
			EXPORT mvrLinkid_keyname_raw := 'thor_data400::key::vehiclev2::' + mvr_build_version + '::linkids';
			EXPORT mvrLinkid_keyname     := AccountMonitoring.constants.DATA_LOCATION + mvrLinkid_keyname_raw;
			
			EXPORT mvrLinkid_superkeyname_raw  	:= 'thor_data400::key::vehiclev2::linkids_' + doxie.Version_SuperKey;
			EXPORT mvrLinkid_superkeyname     	:= AccountMonitoring.constants.DATA_LOCATION + mvrLinkid_superkeyname_raw;

			SHARED mvrLinkid_key_undist := 
				INDEX(
					VehicleV2.Key_Vehicle_linkids.key,  
					mvrLinkid_keyname
				);

			EXPORT mvrLinkid_key :=
				DISTRIBUTE(
					mvrLinkid_key_undist, 
					HASH64(seleid)
					): INDEPENDENT; //PERSIST('acctmon::vehiclev2::key_linkid');
			
			// Main key
			EXPORT main_keyname_raw := 'thor_data400::key::vehiclev2::' + mvr_build_version + '::main_key';
			EXPORT main_keyname     := AccountMonitoring.constants.DATA_LOCATION + main_keyname_raw;
			
			EXPORT main_superkeyname_raw 	:= 'thor_data400::key::vehiclev2::main_key_' + doxie.Version_SuperKey;
			EXPORT main_superkeyname     	:= AccountMonitoring.constants.DATA_LOCATION + main_superkeyname_raw;

			SHARED main_key_undist := 
				INDEX(
					VehicleV2.Key_Vehicle_Main_Key,  
					main_keyname
				);

			EXPORT main_key :=
				DISTRIBUTE(
					main_key_undist, 
					HASH64(vehicle_key)
					): INDEPENDENT; //PERSIST('acctmon::vehiclev2::main_key');
					
		END;

		EXPORT aircraft := MODULE
	
			EXPORT air_build_version := TRIM(did_add.get_EnvVariable('Aircraft_build_version')):INDEPENDENT;
			
			// Linkid key
			EXPORT airLinkid_keyname_raw := 'thor_data400::key::faa::' + air_build_version + '::aircraft_linkids';
			EXPORT airLinkid_keyname     := AccountMonitoring.constants.DATA_LOCATION + airLinkid_keyname_raw;
			
			EXPORT airLinkid_superkeyname_raw  	:= 'thor_data400::key::aircraft_linkids_' + doxie.Version_SuperKey;
			EXPORT airLinkid_superkeyname     	:= AccountMonitoring.constants.DATA_LOCATION + airLinkid_superkeyname_raw;

			SHARED airLinkid_key_undist := 
				INDEX(
					faa.key_aircraft_linkids.key,  
					airLinkid_keyname
					);

			EXPORT airLinkid_key :=
				DISTRIBUTE(
					airLinkid_key_undist, 
					HASH64(seleid)
					): INDEPENDENT; //PERSIST('acctmon::aircraft::key_linkid');
		
		END;
		
		EXPORT watercraft := MODULE
	
			EXPORT water_build_version := TRIM(did_add.get_EnvVariable('watercraft_build_version')):INDEPENDENT;
			
			// Linkid key
			EXPORT waterLinkid_keyname_raw := 'thor_data400::key::watercraft::' + water_build_version + '::linkids';
			EXPORT waterLinkid_keyname     := AccountMonitoring.constants.DATA_LOCATION + waterLinkid_keyname_raw;
			
			EXPORT waterLinkid_superkeyname_raw  	:= 'thor_data400::key::watercraft_linkids_' + doxie.Version_SuperKey;
			EXPORT waterLinkid_superkeyname     	:= AccountMonitoring.constants.DATA_LOCATION + waterLinkid_superkeyname_raw;

			SHARED waterLinkid_key_undist := 
				INDEX(
					Watercraft.Key_LinkIds.key,  
					waterLinkid_keyname
				);

			EXPORT waterLinkid_key :=
				DISTRIBUTE(
					waterLinkid_key_undist, 
					HASH64(seleid)
					): INDEPENDENT; //PERSIST('acctmon::watercraft::key_linkid');
		END;

	EXPORT email := MODULE
	 IMPORT dx_Email;
   
		EXPORT emailLexid_superfile := 'thor_200::key::email_datav2::' + doxie.Version_SuperKey + '::did'; // - a superfile name referenced in dx_Email.Key_Did, to be used as RoxieSuperFile in fn_UpdateSuperFiles() process
		EXPORT emailLexid_for_superkey_monitor := 'monitor::email_datav2::did';
		EXPORT emailLexid_superkeyname := AccountMonitoring.constants.MONITOR_KEY_CLUSTER + emailLexid_for_superkey_monitor + '_qa'; // superfile used by monitoring process

		emaillexid_key_undist := 
			PULL(INDEX( 
          dx_Email.Key_Did()  
				, emailLexid_superkeyname)
        );
  
		EXPORT lexid_key :=
			DISTRIBUTE(
				emaillexid_key_undist, 
				HASH64(did)
				): INDEPENDENT; //PERSIST?
   
		EXPORT emailaddr_superfile := 'thor_200::key::email_datav2::' + doxie.Version_SuperKey + '::email_addresses'; // - a superfile name referenced in dx_Email.Key_Email_Address, to be used as RoxieSuperFile in fn_UpdateSuperFiles() process
		EXPORT emailaddr_for_superkey_monitor := 'monitor::email_datav2::email_addresses';
		EXPORT emailaddr_superkeyname := AccountMonitoring.constants.MONITOR_KEY_CLUSTER + emailaddr_for_superkey_monitor + '_qa'; // superfile used by monitoring process

		emailaddr_key_undist := 
			PULL(INDEX( 
          dx_Email.Key_Email_Address()  
				, emailaddr_superkeyname)
        );
  
		EXPORT emailaddr_key :=
			DISTRIBUTE(
				emailaddr_key_undist, 
				HASH64(clean_email)
				): INDEPENDENT; //PERSIST?
   
		EXPORT emailmain_superfile := 'thor_200::key::email_datav2::' + doxie.Version_SuperKey + '::payload'; // - a superfile name referenced in dx_Email.Key_email_payload, to be used as RoxieSuperFile in fn_UpdateSuperFiles() process
		EXPORT emailmain_for_superkey_monitor := 'monitor::email_datav2::payload';
		EXPORT emailmain_superkeyname := AccountMonitoring.constants.MONITOR_KEY_CLUSTER + emailmain_for_superkey_monitor + '_qa'; // superfile used by monitoring process

		payload_key_undist := 
			PULL(INDEX( 
          dx_Email.Key_email_payload()  
				, emailmain_superkeyname)
        );
  
		EXPORT main_key :=
			DISTRIBUTE(
				payload_key_undist, 
				HASH64(email_rec_key)
				): INDEPENDENT; //PERSIST?
   
  END;
END;
