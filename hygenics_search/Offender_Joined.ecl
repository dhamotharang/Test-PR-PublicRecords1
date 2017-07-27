import crimsrch, crim_common, DID_Add, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville,lib_ziplib;

dCombined_Crim_SexPred			:=	Crim_Offender2_as_CrimSrch_Offender	 +	Sex_Pred_Search_DID_as_CrimSrch_Offender;

	rCombined_Crim_SexPred_ForADL := record
		Layout_Moxie_Offender_temp;
		unsigned6	temp_did;
	end;

	rCombined_Crim_SexPred_ForADL tBlankDIDandSSN(dCombined_Crim_SexPred pInput):= transform
		self.did		:=	'';
		self.ssn		:=	'';
		self.temp_did	:=	0;
		self			:=	pInput;
	end;

dCombined_Crim_SexPred_PreDID	:=	project(dCombined_Crim_SexPred,tBlankDIDandSSN(left));

//add origin state to XADL DOB matching

	add_orig_state_rec := record
		string2 temp_state;
		rCombined_Crim_SexPred_ForADL;
	end;

DID_add.mac_add_orig_state(dCombined_Crim_SexPred_PreDID, add_orig_state_rec, zip5, state,state_of_origin, add_orig_state) 

lMatchSet := ['S','A','D'];

did_Add.MAC_Match_Flex//_Sensitive  // NOTE <- removed sensitive macro 4/15/2008
	(add_orig_state, lMatchSet,						
	 orig_ssn, dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, temp_state, fake_phone_field, 
	 temp_did,
	 add_orig_state_rec,
	 false, fake_DID_Score_field,
	 75,						//dids with a score below here will be dropped
	 dCombined_Crim_SexPred_WithDID
	)

	rCombined_Crim_SexPred_ForADL tUseSourceSSN(dCombined_Crim_SexPred_WithDID pInput) := transform
		self.ssn 		:= pInput.orig_ssn;
		self.did 		:= if(pInput.off_name_type= '2' or pInput.temp_DID = 0,
							  '',
							  intformat(pInput.temp_did, 12, 1));
		self.temp_did 	:= if(pInput.off_name_type= '2' or pInput.temp_DID = 0,
							  0,
							  pInput.temp_did);
		self 		:= pInput;
	end;

dCrimOffender2_WithDID_OrigSSN := project(dCombined_Crim_SexPred_WithDID, tUseSourceSSN(left));

DID_Add.MAC_Add_SSN_By_DID(dCrimOffender2_WithDID_OrigSSN, temp_DID, SSN, dCrimOffender2_WithDID_PatchedSSN)

set_off := ['V','I','C','T'];

	Layout_Moxie_Offender_temp tCreateMoxie(dCrimOffender2_WithDID_PatchedSSN pInput) := transform
		self.fcra_traffic_flag 	:= if(pInput.offense_score in set_Off,
										'Y',
										pInput.fcra_traffic_flag );
		self 					:= pInput;
	end;

tCreateMoxie_pre_did_removal := project(dCrimOffender2_WithDID_PatchedSSN,tCreateMoxie(left));

offnd_hard_code_did_removals := fn_blank_the_did(tCreateMoxie_pre_did_removal);	
/*

dslayout := RECORD
  string8 date_first_reported;
  string8 date_last_reported;
  string60 offender_key;
  string2 vendor;
  string2 state_of_origin;
  string1 data_type;
  string20 source_file;
  string1 off_name_type;
  string50 off_name;
  string20 orig_lname;
  string20 orig_fname;
  string20 orig_mname;
  string10 orig_name_suffix;
  string2 place_of_birth;
  string8 dob;
  string8 dob_alias;
  string9 orig_ssn;
  string20 offender_id_num_1;
  string10 offender_id_num_type_1;
  string20 offender_id_num_2;
  string10 offender_id_num_type_2;
  string8 sor_date_1;
  string28 sor_date_type_1;
  string8 sor_date_2;
  string28 sor_date_type_2;
  string8 sor_date_3;
  string28 sor_date_type_3;
  string50 sor_status;
  string20 sor_offender_category;
  string10 sor_risk_level_code;
  string50 sor_risk_level_desc;
  string25 sor_registration_type;
  string60 offender_status;
  string125 offender_address_1;
  string35 offender_address_2;
  string35 offender_address_3;
  string35 offender_address_4;
  string35 offender_address_5;
  string35 case_number;
  string40 case_court;
  string50 case_name;
  string5 case_type;
  string25 case_type_desc;
  string8 case_filing_date;
  string30 race_desc;
  string10 sex;
  string40 hair_color_desc;
  string40 eye_color_desc;
  string20 skin_color_desc;
  string3 height;
  string3 weight;
  string30 ethnicity;
  string3 age;
  string30 build_type;
  string200 scars_marks_tattoos;
  string1 fcra_conviction_flag;
  string1 fcra_traffic_flag;
  string8 fcra_date;
  string1 fcra_date_type;
  string8 conviction_override_date;
  string1 conviction_override_date_type;
  string2 offense_score;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 state;
  string5 zip5;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  string3 ace_fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 cleaning_score;
  string9 ssn;
  string150 image_link;
  string12 did;
  string8 process_date;
  string8 file_date;
  string2 record_type;
  string25 orig_state;
  string15 id_num;
  string56 pty_nm;
  string1 pty_nm_fmt;
  string1 pty_typ;
  string1 nitro_flag;
  string35 case_num;
  string8 case_date;
  string30 county_of_origin;
  string10 dle_num;
  string9 fbi_num;
  string10 doc_num;
  string10 ins_num;
  string2 citizenship;
  string13 county_of_birth;
  string25 street_address_1;
  string25 street_address_2;
  string25 street_address_3;
  string10 street_address_4;
  string10 street_address_5;
  string13 current_residence_county;
  string13 legal_residence_county;
  string3 race;
  string3 hair_color;
  string3 eye_color;
  string3 skin_color;
  string10 scars_marks_tattoos_1;
  string10 scars_marks_tattoos_2;
  string10 scars_marks_tattoos_3;
  string10 scars_marks_tattoos_4;
  string10 scars_marks_tattoos_5;
  string5 party_status;
  string60 party_status_desc;
  string10 _3g_offender;
  string10 violent_offender;
  string10 sex_offender;
  string10 vop_offender;
  string26 record_setup_date;
  string45 datasource;
  string18 county_name;
  string3 score;
  string9 ssn_appended;
  string1 curr_incar_flag;
  string1 curr_parole_flag;
  string1 curr_probation_flag;
 END;

offnd_hard_code_did_removals := dataset(ut.foreign_prod+'~thor_data400::persist::crimsrch_offender_joined', dslayout, flat);
*/
export Offender_Joined := offnd_hard_code_did_removals
 //:	persist('~thor_data400::persist::CrimSrch_Offender_Joined' //,'Thor400_84')
 ;
 
//export Offender_Joined
// := project(dCrimOffender2_WithDID_PatchedSSN,tCreateMoxie(left))
// :	persist('~thor_data400::persist::CrimSrch_Offender_Joined' ,'Thor400_84')
// ;




