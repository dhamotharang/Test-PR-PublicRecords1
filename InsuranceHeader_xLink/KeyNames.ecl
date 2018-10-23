IMPORT ut;

EXPORT KeyNames(string buildType='', String aBuildDate='') := MODULE

	SHARED BOOLEAN isCustTestEnv           := FALSE:STORED('CustomerTestEnv');
	// Common key name components
	SHARED prefix    := KeyPrefix + 'key::InsuranceHeader_xLink';
	specPrefixBase := '~thor_data400::key::InsuranceHeader_xLink';
	SHARED spec_prefix := IF(isCustTestEnv, specPrefixBase + '_prte', specPrefixBase);
	// SHARED prefix    := KeyPrefix + 'key::CustomerTest_xLink_IKB';
	SHARED buildDate := IF(aBuildDate<>'', aBuildDate, keyInfix);
	EXPORT keyFather := TRIM(MAP(buildType=''=>'father',
													buildType='FULL' => 'full_father',  // used for build only
													buildType='INC' => 'inc_father', 
													buildType='INC_BOCA' => 'inc_boca_father', 'father'));// used for build only
	
	SHARED spFileInfix := TRIM(MAP(buildType='' => keySuperFile,  // default superfile for batch and online searches
														buildType='FULL' => 'full',  // used for build only
														buildType='INC' => 'inc', 
														buildType='INC_BOCA' => 'inc_boca', keySuperFile));// used for build only
	// SHARED spFileInfix := 'full';
	// Specific key names superfile
	EXPORT header_super		:= prefix + '::' + spFileInfix + '::' + 'header';
	EXPORT header0_super	:= prefix + '::' + spFileInfix + '::' + 'header0';
	EXPORT refs_super			:= prefix + '::' + spFileInfix + '::' + 'DID::Refs';
	EXPORT words_super		:= prefix + '::' + spFileInfix + '::' + 'DID::Words';	
	EXPORT name_super			:= prefix + '::' + spFileInfix + '::' + 'DID::Refs::NAME';
	EXPORT address_super	:= prefix + '::' + spFileInfix + '::' + 'DID::Refs::ADDRESS';
	EXPORT ssn_super			:= prefix + '::' + spFileInfix + '::' + 'DID::Refs::SSN';
	EXPORT ssn4_super			:= prefix + '::' + spFileInfix + '::' + 'DID::Refs::SSN4';
	EXPORT dob_super			:= prefix + '::' + spFileInfix + '::' + 'DID::Refs::DOB';
	EXPORT dobf_super			:= prefix + '::' + spFileInfix + '::' + 'DID::Refs::DOBF';	
	EXPORT zip_pr_super		:= prefix + '::' + spFileInfix + '::' + 'DID::Refs::ZIP_PR';
	EXPORT src_rid_super	:= prefix + '::' + spFileInfix + '::' + 'DID::Refs::SRC_RID';
	EXPORT dln_super			:= prefix + '::' + spFileInfix  + '::' + 'DID::Refs::DLN';
	EXPORT ph_super				:= prefix + '::' + spFileInfix + '::' + 'DID::Refs::PH';
	EXPORT lfz_super			:= prefix + '::' + spFileInfix + '::' + 'DID::Refs::LFZ';
	EXPORT relative_super := prefix + '::' + spFileInfix + '::' + 'DID::Refs::RELATIVE';
	EXPORT id_history_super := prefix + '::' + spFileInfix + '::' + 'DID::sup::RID';	
	
	// Specific key names father file
	EXPORT header_father  := prefix + '::' + keyFather + '::' + 'header';
	EXPORT header0_father := prefix + '::' + keyFather + '::' + 'header0';
	EXPORT refs_father		:= prefix + '::' + keyFather + '::' + 'DID::Refs';
	EXPORT words_father		:= prefix + '::' + keyFather + '::' + 'DID::Words';
	EXPORT name_father		:= prefix + '::' + keyFather + '::' + 'DID::Refs::NAME';
	EXPORT address_father	:= prefix + '::' + keyFather + '::' + 'DID::Refs::ADDRESS';
	EXPORT ssn_father			:= prefix + '::' + keyFather + '::' + 'DID::Refs::SSN';
	EXPORT ssn4_father		:= prefix + '::' + keyFather + '::' + 'DID::Refs::SSN4';
	EXPORT dob_father			:= prefix + '::' + keyFather + '::' + 'DID::Refs::DOB';
	EXPORT dobf_father			:= prefix + '::' + keyFather + '::' + 'DID::Refs::DOBF';
	EXPORT zip_pr_father	:= prefix + '::' + keyFather + '::' + 'DID::Refs::ZIP_PR';
	EXPORT src_rid_father	:= prefix + '::' + keyFather + '::' + 'DID::Refs::SRC_RID';
	EXPORT dln_father			:= prefix + '::' + keyFather + '::' + 'DID::Refs::DLN';
	EXPORT ph_father			:= prefix + '::' + keyFather + '::' + 'DID::Refs::PH';
	EXPORT lfz_father			:= prefix + '::' + keyFather + '::' + 'DID::Refs::LFZ';
	EXPORT relative_father:= prefix + '::' + Keyfather + '::' + 'DID::Refs::RELATIVE';
	EXPORT id_history_father := prefix + '::' + Keyfather + '::' + 'DID::sup::RID';	
	
	// Specific key names logical file
	EXPORT header_logical 	:= prefix + '::' + buildDate + '::' + 'IDL';
	EXPORT header0_logical 	:= prefix + '::' + buildDate + '::' + 'IDL0';
	EXPORT refs_logical			:= prefix + '::' + buildDate + '::' + 'DID::Refs';
	EXPORT words_logical		:= prefix + '::' + buildDate + '::' + 'DID::Words';
	EXPORT name_logical			:= prefix + '::' + buildDate + '::' + 'DID::Refs::NAME';
	EXPORT address_logical	:= prefix + '::' + buildDate + '::' + 'DID::Refs::ADDRESS';
	EXPORT ssn_logical			:= prefix + '::' + buildDate + '::' + 'DID::Refs::SSN';
	EXPORT ssn4_logical			:= prefix + '::' + buildDate + '::' + 'DID::Refs::SSN4';
	EXPORT dob_logical			:= prefix + '::' + buildDate + '::' + 'DID::Refs::DOB';
	EXPORT dobf_logical			:= prefix + '::' + buildDate + '::' + 'DID::Refs::DOBF';
	EXPORT zip_pr_logical		:= prefix + '::' + buildDate + '::' + 'DID::Refs::ZIP_PR';
	EXPORT src_rid_logical	:= prefix + '::' + buildDate + '::' + 'DID::Refs::SRC_RID';
	EXPORT dln_logical			:= prefix + '::' + buildDate + '::' + 'DID::Refs::DLN';
	EXPORT ph_logical				:= prefix + '::' + buildDate + '::' + 'DID::Refs::PH';
	EXPORT lfz_logical			:= prefix + '::' + buildDate + '::' + 'DID::Refs::LFZ';
	EXPORT relative_logical	:= prefix + '::' + buildDate + '::' + 'DID::Refs::RELATIVE';
	EXPORT id_history_logical := prefix + '::' + buildDate + '::' + 'DID::sup::RID';	
	
	// specificities keys super files
	EXPORT sname_spc_super						:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::SNAME';
	EXPORT fname_spc_super						:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::FNAME';
	EXPORT mname_spc_super						:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::MNAME';
	EXPORT lname_spc_super						:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::LNAME';
	EXPORT derived_gender_spc_super 	:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::DERIVED_GENDER';
	EXPORT prim_range_spc_super 			:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::PRIM_RANGE';
	EXPORT prim_name_spc_super 				:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::PRIM_NAME';
	EXPORT sec_range_spc_super 				:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::SEC_RANGE';
	EXPORT city_spc_super 						:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::CITY';
	EXPORT st_spc_super 							:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::ST';
	EXPORT zip_spc_super 							:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::ZIP';
	EXPORT ssn5_spc_super 						:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::SSN5';
	EXPORT ssn4_spc_super 						:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::SSN4';
	EXPORT dob_year_spc_super 				:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::DOB_year';
	EXPORT dob_month_spc_super 				:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::DOB_month';
	EXPORT dob_day_spc_super 					:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::DOB_day';
	EXPORT phone_spc_super 						:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::PHONE';
	EXPORT dl_state_spc_super 				:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::DL_STATE';
	EXPORT dl_nbr_spc_super 					:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::DL_NBR';
	EXPORT src_spc_super 							:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::SRC';
	EXPORT source_rid_spc_super 			:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::SOURCE_RID';
	EXPORT mainname_spc_super 				:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::MAINNAME';
	EXPORT fullname_spc_super 				:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::FULLNAME';
	EXPORT addr1_spc_super 						:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::ADDR1';
	EXPORT locale_spc_super 					:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::LOCALE';
	EXPORT address_spc_super 					:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::ADDRESS';
	EXPORT main_spc_super							:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::specificities';
	EXPORT res_spc_super							:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::RES';
	EXPORT dt_first_seen_spc_super		:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::DT_FIRST_SEEN';
	EXPORT dt_last_seen_spc_super			:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::DT_LAST_SEEN';
	EXPORT reporteddate_spc_super			:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::REPORTEDDATE';
	EXPORT dt_effective_first_spc_super			:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::DT_EFFECTIVE_FIRST';
	EXPORT dt_effective_last_spc_super				:= spec_prefix + '::' + KeySuperfile + '::' + 'DID::Word::DT_EFFECTIVE_LAST';
	
	// specificities keys father super files
	EXPORT sname_spc_father						:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::SNAME';
	EXPORT fname_spc_father						:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::FNAME';
	EXPORT mname_spc_father						:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::MNAME';
	EXPORT lname_spc_father						:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::LNAME';
	EXPORT derived_gender_spc_father 	:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::DERIVED_GENDER';
	EXPORT prim_range_spc_father 			:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::PRIM_RANGE';
	EXPORT prim_name_spc_father 			:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::PRIM_NAME';
	EXPORT sec_range_spc_father 			:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::SEC_RANGE';
	EXPORT city_spc_father 						:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::CITY';
	EXPORT st_spc_father 							:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::ST';
	EXPORT zip_spc_father 						:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::ZIP';
	EXPORT ssn5_spc_father 						:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::SSN5';
	EXPORT ssn4_spc_father 						:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::SSN4';
	EXPORT dob_year_spc_father 				:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::DOB_year';
	EXPORT dob_month_spc_father 			:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::DOB_month';
	EXPORT dob_day_spc_father 				:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::DOB_day';
	EXPORT phone_spc_father 					:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::PHONE';
	EXPORT dl_state_spc_father 				:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::DL_STATE';
	EXPORT dl_nbr_spc_father 					:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::DL_NBR';
	EXPORT src_spc_father 						:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::SRC';
	EXPORT source_rid_spc_father 			:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::SOURCE_RID';
	EXPORT mainname_spc_father 				:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::MAINNAME';
	EXPORT fullname_spc_father 				:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::FULLNAME';
	EXPORT addr1_spc_father 					:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::ADDR1';
	EXPORT locale_spc_father 					:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::LOCALE';
	EXPORT address_spc_father 				:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::ADDRESS';
	EXPORT main_spc_father						:= spec_prefix + '::' + keyFather + '::' + 'DID::specificities';
	EXPORT res_spc_father							:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::RES';
	EXPORT dt_first_seen_spc_father		:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::DT_FIRST_SEEN';
	EXPORT dt_last_seen_spc_father		:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::DT_LAST_SEEN';
	EXPORT reporteddate_spc_father		:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::REPORTEDDATE';
	EXPORT dt_effective_first_spc_father:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::DT_EFFECTIVE_FIRST';
	EXPORT dt_effective_last_spc_father:= spec_prefix + '::' + keyFather + '::' + 'DID::Word::DT_EFFECTIVE_LAST';
	
	// specificities keys logical files
	EXPORT sname_spc_logical						:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::SNAME';
	EXPORT fname_spc_logical						:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::FNAME';
	EXPORT mname_spc_logical						:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::MNAME';
	EXPORT lname_spc_logical						:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::LNAME';
	EXPORT derived_gender_spc_logical 	:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::DERIVED_GENDER';
	EXPORT prim_range_spc_logical 			:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::PRIM_RANGE';
	EXPORT prim_name_spc_logical 				:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::PRIM_NAME';
	EXPORT sec_range_spc_logical 				:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::SEC_RANGE';
	EXPORT city_spc_logical 						:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::CITY';
	EXPORT st_spc_logical 							:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::ST';
	EXPORT zip_spc_logical 							:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::ZIP';
	EXPORT ssn5_spc_logical 						:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::SSN5';
	EXPORT ssn4_spc_logical 						:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::SSN4';
	EXPORT dob_year_spc_logical 				:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::DOB_year';
	EXPORT dob_month_spc_logical 				:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::DOB_month';
	EXPORT dob_day_spc_logical 					:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::DOB_day';
	EXPORT phone_spc_logical 						:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::PHONE';
	EXPORT dl_state_spc_logical 				:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::DL_STATE';
	EXPORT dl_nbr_spc_logical 					:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::DL_NBR';
	EXPORT src_spc_logical 							:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::SRC';
	EXPORT source_rid_spc_logical 			:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::SOURCE_RID';
	EXPORT mainname_spc_logical 				:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::MAINNAME';
	EXPORT fullname_spc_logical 				:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::FULLNAME';
	EXPORT addr1_spc_logical 						:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::ADDR1';
	EXPORT locale_spc_logical 					:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::LOCALE';
	EXPORT address_spc_logical 					:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::ADDRESS';
	EXPORT main_spc_logical							:= spec_prefix + '::' + buildDate + '::' + 'DID::specificities';
	EXPORT res_spc_logical							:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::RES';
	EXPORT dt_first_seen_spc_logical		:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::DT_FIRST_SEEN';
	EXPORT dt_last_seen_spc_logical			:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::DT_LAST_SEEN';
	EXPORT reporteddate_spc_logical			:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::REPORTEDDATE';
	EXPORT dt_effective_first_spc_logical:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::DT_EFFECTIVE_FIRST';
	EXPORT dt_effective_last_spc_logical:= spec_prefix + '::' + buildDate + '::' + 'DID::Word::DT_EFFECTIVE_LAST';
END;