import AID, SexOffender, lib_date, address, hygenics_soff, lib_stringlib, nid;

ds := hygenics_soff.Mapping_Offender;

	tempLayout := record
		Hygenics_SOff.Layout_OKC_Fixed_Altered;
		string name_format;
	end;
	
	tempLayout transOKC(ds l):= transform
		self.source_file 		:= l.source;
		self.scrape_date 		:= l.date_updated;
		self.orig_state 		:= l.state_of_origin;
		self.orig_firstname		:= l.firstname;
		self.orig_middlename	:= l.middlename;
		self.orig_lastname		:= l.lastname;
		self.orig_suffix		:= l.suffix;
		self.addl_comments_1 	:= l.addl_comments_1[1..140];
		self.addl_comments_2 	:= l.addl_comments_2[1..140];
		self.name_format		  := l.nametype;
		self 					:= l;
	end;
	
	in_file := project(ds, transOKC(left));
		
	In_Base_file := in_file;

	Addr_cleanup_Values 		:= ['0000 ADDRES NOT CURRENT AV'	,'0000 ADDRESS CURRENT RD'
								   ,'0000 ADDRESS NOT CURRENT AV'   ,'0000 ADDRESS NOT CURRENT BD'
								   ,'0000 ADDRESS NOT CURRENT CR'	,'0000 ADDRESS NOT CURRENT CT'
								   ,'0000 ADDRESS NOT CURRENT DR'	,'0000 ADDRESS NOT CURRENT RD'
								   ,'0000 ADDRESS NOT CURRENT LA'	,'0000 ADDRESS NOT CURRENT LN'
								   ,'0000 ADDRESS NOT CURRENT PL'	,'0000 ADDRESS NOT CURRENT PV'
								   ,'0000 ADDRESS NOT CURRENT ST'	,'0000 ADDRESS NOT CURRENT TR'
								   ,'0000 ADDRESS NOT CURRENT WY'	,'0000 NO CURRENT ADDRESS AV'
								   ,'0000 NO CURRENT ADDRESS RD'	,'0000 NO CURRENT ADDRESS ST'
								   ,'0000 ADDRESS UNKNOWN NOT CURRENT ST','0000 DOMICARY BD'
								   ,'0000 HOMELESS AV'				,'0000 HOMELESS DT'
								   ,'0000 HOMELESS HW'				,'0000 HOMELESS RD'
								   ,'0000 HOMELESS ST'				,'0000 N ADDRESS NOT CURRENT AV'
								   ,'0000 N ADDRESS NOT CURRENT ST'	,'0000 NO CURRENT ADDDRESS RD'
								   ,'0000 NO CURRENT ADDRESS RD'	,'0000 NO CURRENT ADDRESS ST'
								   ,'0000 NOT CURRENT AV'			,'0000 W ADDRESS NOT CURRENT RD'	
								   ,'00000 NO CURRENT ADDRESS CR'	,'00000 NO CURRENT ADDRESS RD'
								   ,'ABSCONDED'						,'ABSCONDED FROM PROBATION'
								   ,'ABSCONDED FROM REGISTRATION'	,'ACTIVE'
								   ,'ACTIVE COMMUNITY SUPERVISION'	,'ADDRESS UNKNOWN'
								   ,'ADMINISTRATIVE PROBATION'		,'APPEAL'
								   ,'COMMUNITY CONTROL'				,'COMPLIANT'
								   ,'COUNTY INCARCERATION'			,'CSC'
								   ,'CSCD/DIS'						,'DEAD'
								   ,'DECEASED'						,'DEPORTED'
								   ,'DISCHARGED'					,'ESCAPED'
								   ,'FAIL TO VERIFY ADDRESS'		,'FAILED TO VERIFY ADDRESS'		
								   ,'FAILURE TO REGISTER'
								   ,'FEDERAL INCARCERATION'			,'FEDERAL SUPERVISION'
								   ,'FUGITIVE'						,'HOMELESS'
								   ,'IN COMPLIANCE'					,'IN CUSTODY'
								   ,'IN VIOLATION'					,'INCARCERATED'
								   ,'INS CUSTODY'					,'JIMMY RYCE'
								   ,'JPO'							,'JPO/DIS'
								   ,'MOVED'							,'MOVED OUT OF STATE'
								   ,'NO CURRENT ADDRESS ST'			,'NO CURRENT ADDRESS BD'
								   ,'NO CURRENT ADDRESS RD'			,'NO CURRENT ADDRESS AV'
								   ,'NON COMPLIANT'					,'NON REGISTRATION COMPLIANCE'
								   ,'NON-COMPLIANT'					,'NON-COMPLIANT/INCARCERATED'
								   ,'NOT CURRENT'					,'OUT OF STATE'
								   ,'OUT OF STATE WORK IN CT'		,'PAR/DIS'
								   ,'PAROLE'						,'PAROLED'
								   ,'PENDING'						,'PENDING FROM OUT-OF-STATE'
								   ,'PREDATOR'						,'PREDITOR'
								   ,'PROBATION'						,'REGISTERED'
								   ,'REGISTERED IN AN OUTLYING OFFICE','REGISTRATION PERIOD HAS ENDED'
								   ,'RELEASED'						,'REPORTED DECEASED'
								   ,'REVOKED'						,'SEX OFFENDER'
								   ,'STATE INCARCERATION'			,'SUPERVISION'
								   ,'TDC'							,'TERMINATED'
								   ,'TEXAS YOUTH COMMISSION'		,'TRANSIENT'
								   ,'TYC/DIS'						,'UNAVAILABLE'
								   ,'UNDER DHFS SUPERVISION'		,'UNDER INVESTIGATION'
								   ,'UNDER SUPERVISION'				,'UNKNOWN'
								   ,'UNKNOWN ADDRESS'				,'UNVERIFIED ADDRESS'
								   ,'WANTED'						,'WHEREABOUTS UNCONFIRMED'];

	Invalid_City_List 			:= ['WARRANT ISSUED', 'NONE', 'UNK', 'UNKNOWN'];

	// This function formats the given date in MM/DD/YYYY to YYYYMMDD format.
	DateFinder := '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';
	formatDate(string intext) 	:= if(regexfind(DateFinder,intext)
									, intformat((integer)regexfind(DateFinder,intext,3),4,1) 
									+ intformat((integer)regexfind(DateFinder,intext,1),2,1) 
									+ intformat((integer)regexfind(DateFinder,intext,2),2,1)
									,intext);
							   
Hygenics_SOff.Layout_OKC_Sex_Offender_Common.prep Clean_OKC_Sex_Off_Address(In_Base_file InputRecord) := transform
  	string8 tempDate		 	:= formatDate(trim(InputRecord.scrape_date,left,right));
	string2 process_cc       	:= if(tempDate <> '', tempDate[1..2], '');
	string2 process_yy       	:= if(tempDate <> '', tempDate[3..4], '');
	string2 process_mm       	:= if(tempDate <> '', tempDate[5..6], '');
	string2 process_dd       	:= if(tempDate <> '', tempDate[7..8], ''); 
	self.dt_first_reported   	:= tempDate;
	self.dt_last_reported    	:= tempDate;
	self.vendor_code         	:= 'C2';
	self.orig_state          	:= stringlib.StringToUpperCase(trim(InputRecord.orig_state,left,right));
    
	self.seisint_primary_key 	:= if(trim(InputRecord.offender_id,left,right) != '' and InputRecord.orig_state='NC'
																	, self.vendor_code + trim(regexreplace('-', regexreplace('WEB', trim(InputRecord.offender_id, left, right), 'W'), ''), left, right),									
																if(trim(InputRecord.offender_id,left,right) != ''
																	, self.vendor_code + trim(InputRecord.offender_id,left,right)
																	, self.vendor_code + process_yy + (string)lib_date.DayOfYear((integer)(process_cc + process_yy),(integer)process_mm,(integer)process_dd) + (string)InputRecord.sor_number));
	
	self.key                 	:= 0;
	//self.source_file       	:= self.orig_state + ' STATE WIDE';
	self.name_format          := InputRecord.name_format;

	//////////ADDRESS CLEANER///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Restrict the zips to length 5 for the addressid cache
	string filterRegAddress2	:= if(regexfind('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]', InputRecord.registration_address_2[length(trim(InputRecord.registration_address_2,left,right))-9..length(trim(InputRecord.registration_address_2,left,right))], 0)<>'',
										InputRecord.registration_address_2[1..length(trim(InputRecord.registration_address_2,left,right))-4],
										if(regexfind('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]', InputRecord.registration_address_2[length(trim(InputRecord.registration_address_2,left,right))-9..length(trim(InputRecord.registration_address_2,left,right))], 0)<>'',
										InputRecord.registration_address_2[1..length(trim(InputRecord.registration_address_2,left,right))-3],
										if(regexfind('[0-9][0-9][0-9][0-9][0-9][0-9][0-9]', InputRecord.registration_address_2[length(trim(InputRecord.registration_address_2,left,right))-9..length(trim(InputRecord.registration_address_2,left,right))], 0)<>'',
										InputRecord.registration_address_2[1..length(trim(InputRecord.registration_address_2,left,right))-2],
										if(regexfind('[0-9][0-9][0-9][0-9][0-9][0-9]', InputRecord.registration_address_2[length(trim(InputRecord.registration_address_2,left,right))-9..length(trim(InputRecord.registration_address_2,left,right))], 0)<>'',
										InputRecord.registration_address_2[1..length(trim(InputRecord.registration_address_2,left,right))-1],
										if(regexfind('[0-9][0-9][0-9][0-9][0-9]', InputRecord.registration_address_2[length(trim(InputRecord.registration_address_2,left,right))-9..length(trim(InputRecord.registration_address_2,left,right))], 0)<>'',
										trim(InputRecord.registration_address_2,left,right),
										trim(InputRecord.registration_address_2,left,right))))));
										
	// Remove address as of dates for the addressid cache
	string filterRegAddress3 	:= if(regexfind('ADDRESS AS OF', StringLib.StringToUpperCase(InputRecord.registration_address_3), 0)<>'',
									'',
									InputRecord.registration_address_3);
	
	// Fix Virginia's address abbreviations
	string tempRegistrationAddress1 := lib_stringlib.StringLib.StringFindReplace(
										 lib_stringlib.StringLib.StringFindReplace(
										 lib_stringlib.StringLib.StringFindReplace(
										 lib_stringlib.StringLib.StringFindReplace(InputRecord.registration_address_1,
												'NRADC','Northwestern Regional Adult Detention Center')
												,'SWVRJA','SOUTHWEST VIRGINIA REGIONAL JAIL AUTHORITY')
												,'SWVRJ','SOUTHWEST VIRGINIA REGIONAL JAIL')	
												,'VCBR','VIRGINIA CENTER FOR BEHAVIORAL REHABILITATION');
												
	string tempRegistrationAddress2 := lib_stringlib.StringLib.StringFindReplace(
										 lib_stringlib.StringLib.StringFindReplace(
										 lib_stringlib.StringLib.StringFindReplace(
										 lib_stringlib.StringLib.StringFindReplace(filterRegAddress2,
												'NRADC','Northwestern Regional Adult Detention Center')
												,'SWVRJA','SOUTHWEST VIRGINIA REGIONAL JAIL AUTHORITY')
												,'SWVRJ','SOUTHWEST VIRGINIA REGIONAL JAIL')
												,'VCBR','VIRGINIA CENTER FOR BEHAVIORAL REHABILITATION');
	
	string tempRegAddress1 := tempRegistrationAddress1;
							
	string tempRegAddress2 := tempRegistrationAddress2;

	string prep_Address1 := stringlib.StringToUpperCase(if(tempRegAddress1 <> '' 
								OR tempRegAddress2 <> '' 
								OR InputRecord.registration_address_3 <> '' 
								OR InputRecord.registration_address_4 <> '' 
								OR InputRecord.registration_address_5 <> '', 					
										//tempRegAddress1
										if(trim(tempRegAddress1,left,right) in Addr_cleanup_Values
											,''
										// Added checks for those incarcerated with the New York DOC addresses 
										// that don't parse, and filter out the first address line for them
										// and use the second address line in its place.
										,if(tempRegAddress1[1..7] = 'NYSDOCS' AND InputRecord.orig_state = 'NY'
											OR tempRegAddress1[1..7] = 'NYCDOCS' AND InputRecord.orig_state = 'NY'
											,trim(tempRegAddress2,left,right)
											,trim(tempRegAddress1,left,right)))
										,''));
							             
	string prep_Address2 := stringlib.StringToUpperCase(if(tempRegAddress1 <> '' 
								OR tempRegAddress2 <> '' 
								OR InputRecord.registration_address_3 <> '' 
								OR InputRecord.registration_address_4 <> '' 
								OR InputRecord.registration_address_5 <> '',
										//tempRegAddress2
										 trim(if(trim(tempRegAddress2,left,right) in ['UNKNOWN']
										,''
										,if(tempRegAddress1[1..7] = 'NYSDOCS' AND InputRecord.orig_state = 'NY'
											OR tempRegAddress1[1..7] = 'NYCDOCS' AND InputRecord.orig_state = 'NY'
											,''
											, trim(tempRegAddress2,left,right) + ' '))
											+ trim(InputRecord.registration_address_3,left,right) + ' ' 
											+ trim(InputRecord.registration_address_4,left,right) 
											+ trim(InputRecord.registration_address_5,left,right),left,right)
										,''));

	self.append_Prep_Address1 		:= prep_Address1;
	self.append_Prep_Address2 		:= prep_Address2;
	self.append_Rawaid 				:= 0;
	self.registration_address_1     := stringlib.StringToUpperCase(trim(tempRegAddress1, left, right));
	self.registration_address_2     := stringlib.StringToUpperCase(trim(tempRegAddress2, left, right));
	self 							:= inputRecord;
	end;

	prepAddress := project(In_Base_file, Clean_OKC_Sex_Off_Address(left));

//Address ID/////////////////////////////////

	unsigned4 lAIDAppendFlags		:= AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
			
	AID.MacAppendFromRaw_2Line(prepAddress, Append_Prep_Address1, Append_Prep_Address2, Append_RawAID, addressCleaned, lAIDAppendFlags);

Hygenics_SOff.Layout_OKC_Sex_Offender_Common.interim addressAppended(addressCleaned pInput) := transform
	self.Append_RawAID				:= pInput.AIDWork_RawAID;
	self.prim_range 					:= pInput.AIDWork_ACECache.prim_range;
	self.predir 							:= pInput.AIDWork_ACECache.predir;
	self.prim_name 						:= pInput.AIDWork_ACECache.prim_name;
	self.addr_suffix 					:= pInput.AIDWork_ACECache.addr_suffix;
	self.postdir 							:= pInput.AIDWork_ACECache.postdir;
	self.unit_desig 					:= pInput.AIDWork_ACECache.unit_desig;
	self.sec_range 						:= pInput.AIDWork_ACECache.sec_range;
	self.p_city_name 					:= pInput.AIDWork_ACECache.p_city_name;
	self.v_city_name 					:= pInput.AIDWork_ACECache.v_city_name;
	self.st 									:= pInput.AIDWork_ACECache.st;
	self.zip 									:= pInput.AIDWork_ACECache.zip5;
	self.zip4 								:= pInput.AIDWork_ACECache.zip4;
	self.cart 								:= pInput.AIDWork_ACECache.cart;
	self.cr_sort_sz 					:= pInput.AIDWork_ACECache.cr_sort_sz;
	self.lot 									:= pInput.AIDWork_ACECache.lot;
	self.lot_order 						:= pInput.AIDWork_ACECache.lot_order;
	self.dbpc 								:= pInput.AIDWork_ACECache.dbpc;
	self.chk_digit 						:= pInput.AIDWork_ACECache.chk_digit;
	self.rec_type 						:= pInput.AIDWork_ACECache.rec_type;
	self.county 							:= pInput.AIDWork_ACECache.county;
	self.geo_lat 							:= pInput.AIDWork_ACECache.geo_lat;
	self.geo_long 						:= pInput.AIDWork_ACECache.geo_long;
	self.msa 									:= pInput.AIDWork_ACECache.msa;
	self.geo_blk 							:= pInput.AIDWork_ACECache.geo_blk;
	self.geo_match 						:= pInput.AIDWork_ACECache.geo_match;
	self.err_stat 						:= pInput.AIDWork_ACECache.err_stat;
	self											:= pInput;
	end;
		
cleanAddress 		:= project(addressCleaned,addressAppended(left)):persist('~thor_200::persist::soff_offender_aid');

/*
dslayout := RECORD
  string8 dt_first_reported;
  string8 dt_last_reported;
  string60 seisint_primary_key;
  unsigned8 key;
  string2 vendor_code;
  string1 name_format;
  string30 source_file;
  string10 date_added;
  string10 scrape_date;
  string10 src_upload_date;
  string2 orig_state;
  string name_orig;
  string orig_firstname;
  string orig_middlename;
  string orig_lastname;
  string orig_suffix;
  string firstname;
  string middlename;
  string lastname;
  string suffix;
  string name_aka;
  string320 intnet_email_address_1;
  string320 intnet_email_address_2;
  string320 intnet_email_address_3;
  string320 intnet_email_address_4;
  string320 intnet_email_address_5;
  string320 intnet_instant_message_addr_1;
  string320 intnet_instant_message_addr_2;
  string320 intnet_instant_message_addr_3;
  string320 intnet_instant_message_addr_4;
  string320 intnet_instant_message_addr_5;
  string320 intnet_user_name_1;
  string255 intnet_user_name_1_url;
  string320 intnet_user_name_2;
  string255 intnet_user_name_2_url;
  string320 intnet_user_name_3;
  string255 intnet_user_name_3_url;
  string320 intnet_user_name_4;
  string255 intnet_user_name_4_url;
  string320 intnet_user_name_5;
  string255 intnet_user_name_5_url;
  string50 offender_status;
  string40 offender_category;
  string10 risk_level_code;
  string50 risk_description;
  string50 police_agency;
  string50 police_agency_contact_name;
  string55 police_agency_address_1;
  string35 police_agency_address_2;
  string10 police_agency_phone;
  string35 registration_type;
  string8 reg_date_1;
  string28 reg_date_1_type;
  string8 reg_date_2;
  string28 reg_date_2_type;
  string8 reg_date_3;
  string28 reg_date_3_type;
  string125 registration_address_1;
  string45 registration_address_2;
  string35 registration_address_3;
  string35 registration_address_4;
  string35 registration_address_5;
  string35 registration_county;
  string10 registration_home_phone;
  string10 registration_cell_phone;
  string125 other_registration_address_1;
  string45 other_registration_address_2;
  string35 other_registration_address_3;
  string35 other_registration_address_4;
  string35 other_registration_address_5;
  string35 other_registration_county;
  string10 other_registration_phone;
  string125 temp_lodge_address_1;
  string45 temp_lodge_address_2;
  string35 temp_lodge_address_3;
  string35 temp_lodge_address_4;
  string35 temp_lodge_address_5;
  string35 temp_lodge_county;
  string10 temp_lodge_phone;
  string55 employer;
  string55 employer_address_1;
  string35 employer_address_2;
  string35 employer_address_3;
  string35 employer_address_4;
  string35 employer_address_5;
  string35 employer_county;
  string10 employer_phone;
  string140 employer_comments;
  string75 professional_licenses_1;
  string75 professional_licenses_2;
  string75 professional_licenses_3;
  string75 professional_licenses_4;
  string75 professional_licenses_5;
  string55 school;
  string55 school_address_1;
  string35 school_address_2;
  string35 school_address_3;
  string35 school_address_4;
  string35 school_address_5;
  string35 school_county;
  string10 school_phone;
  string140 school_comments;
  string30 offender_id;
  string30 doc_number;
  string30 sor_number;
  string30 st_id_number;
  string30 fbi_number;
  string30 ncic_number;
  string9 orig_ssn;
  string8 date_of_birth;
  string date_of_birth_aka;
  string3 age;
  string250 dna;
  string30 race;
  string30 ethnicity;
  string10 sex;
  string40 hair_color;
  string40 eye_color;
  string6 height;
  string3 weight;
  string20 skin_tone;
  string30 build_type;
  string200 scars_marks_tattoos;
  string6 shoe_size;
  string1 corrective_lense_flag;
  string8 arrest_date_1;
  string250 arrest_warrant_1;
  string40 offense_location_1;
  string80 conviction_jurisdiction_1;
  string8 conviction_date_1;
  string30 court_1;
  string25 court_case_number_1;
  string8 offense_date_1;
  string20 offense_code_or_statute_1;
  string320 offense_description_1;
  string180 offense_description_1_2;
  string10 offense_level_1;
  string1 victim_minor_1;
  string3 victim_age_1;
  string10 victim_gender_1;
  string30 victim_relationship_1;
  string8 disposition_dt_1;
  string180 sentence_description_1;
  string180 sentence_description_1_2;
  string8 arrest_date_2;
  string250 arrest_warrant_2;
  string40 offense_location_2;
  string80 conviction_jurisdiction_2;
  string8 conviction_date_2;
  string30 court_2;
  string25 court_case_number_2;
  string8 offense_date_2;
  string20 offense_code_or_statute_2;
  string320 offense_description_2;
  string180 offense_description_2_2;
  string10 offense_level_2;
  string1 victim_minor_2;
  string3 victim_age_2;
  string10 victim_gender_2;
  string30 victim_relationship_2;
  string8 disposition_dt_2;
  string180 sentence_description_2;
  string180 sentence_description_2_2;
  string8 arrest_date_3;
  string250 arrest_warrant_3;
  string40 offense_location_3;
  string80 conviction_jurisdiction_3;
  string8 conviction_date_3;
  string30 court_3;
  string25 court_case_number_3;
  string8 offense_date_3;
  string20 offense_code_or_statute_3;
  string320 offense_description_3;
  string180 offense_description_3_2;
  string10 offense_level_3;
  string1 victim_minor_3;
  string3 victim_age_3;
  string10 victim_gender_3;
  string30 victim_relationship_3;
  string8 disposition_dt_3;
  string180 sentence_description_3;
  string180 sentence_description_3_2;
  string8 arrest_date_4;
  string250 arrest_warrant_4;
  string40 offense_location_4;
  string80 conviction_jurisdiction_4;
  string8 conviction_date_4;
  string30 court_4;
  string25 court_case_number_4;
  string8 offense_date_4;
  string20 offense_code_or_statute_4;
  string320 offense_description_4;
  string180 offense_description_4_2;
  string10 offense_level_4;
  string1 victim_minor_4;
  string3 victim_age_4;
  string10 victim_gender_4;
  string3 victim_relationship_4;
  string8 disposition_dt_4;
  string180 sentence_description_4;
  string180 sentence_description_4_2;
  string8 arrest_date_5;
  string250 arrest_warrant_5;
  string40 offense_location_5;
  string80 conviction_jurisdiction_5;
  string8 conviction_date_5;
  string30 court_5;
  string25 court_case_number_5;
  string8 offense_date_5;
  string20 offense_code_or_statute_5;
  string320 offense_description_5;
  string180 offense_description_5_2;
  string10 offense_level_5;
  string1 victim_minor_5;
  string3 victim_age_5;
  string10 victim_gender_5;
  string30 victim_relationship_5;
  string8 disposition_dt_5;
  string180 sentence_description_5;
  string180 sentence_description_5_2;
  string140 addl_comments_1;
  string140 addl_comments_2;
  string30 orig_dl_number;
  string2 orig_dl_state;
  string150 orig_dl_link;
  string8 orig_dl_date;
  string1 passport_type;
  string10 passport_code;
  string25 passport_number;
  string50 passport_first_name;
  string100 passport_given_name;
  string30 passport_nationality;
  string8 passport_dob;
  string55 passport_place_of_birth;
  string10 passport_sex;
  string8 passport_issue_date;
  string55 passport_authority;
  string8 passport_expiration_date;
  string50 passport_endorsement;
  string150 passport_link;
  string8 passport_date;
  string4 orig_veh_year_1;
  string40 orig_veh_color_1;
  string40 orig_veh_make_model_1;
  string40 orig_veh_plate_1;
  string17 orig_registration_number_1;
  string2 orig_veh_state_1;
  string50 orig_veh_location_1;
  string4 orig_veh_year_2;
  string40 orig_veh_color_2;
  string40 orig_veh_make_model_2;
  string40 orig_veh_plate_2;
  string17 orig_registration_number_2;
  string2 orig_veh_state_2;
  string50 orig_veh_location_2;
  string4 orig_veh_year_3;
  string40 orig_veh_color_3;
  string40 orig_veh_make_model_3;
  string40 orig_veh_plate_3;
  string17 orig_registration_number_3;
  string2 orig_veh_state_3;
  string50 orig_veh_location_3;
  string4 orig_veh_year_4;
  string40 orig_veh_color_4;
  string40 orig_veh_make_model_4;
  string40 orig_veh_plate_4;
  string17 orig_registration_number_4;
  string2 orig_veh_state_4;
  string50 orig_veh_location_4;
  string4 orig_veh_year_5;
  string40 orig_veh_color_5;
  string40 orig_veh_make_model_5;
  string40 orig_veh_plate_5;
  string17 orig_registration_number_5;
  string2 orig_veh_state_5;
  string50 orig_veh_location_5;
  string150 fingerprint_link;
  string8 fingerprint_date;
  string150 palmprint_link;
  string8 palmprint_date;
  string150 image_link;
  string8 image_date;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned8 append_rawaid;
 END;

cleanAddress := dataset('~thor_200::persist::soff_offender_aid2', dslayout, flat);
*/

//Name ID/////////////////////////////////

	//nid.mac_cleanfullnames(cleanAddress, cleanfullnames, name_orig);
	nid.mac_cleanfullnames(cleanAddress, cleanfullnames, name_orig,,,,,,,,,,,,,,,,,,, true);
	
	cleanfullnames projFile(cleanfullnames l):= transform
		self := l;
	end;
	
	fullname_project 	:= project(cleanfullnames, projFile(left)):persist('~thor_200::persist::soff_offender_nid');
	
	name_fix					:= fullname_project;

/////////////////////////////////////////////////////////////////////////////
Hygenics_SOff.Layout_OKC_Sex_Offender_Common.final restAppended(name_fix InputRecord) := transform
	
	// function to explode race/ethnicity value
	expRaceEthnicity(string strValue):= map(stringlib.StringToUpperCase(trim(strValue,left,right)) = 'A' => 'ASIAN'
	                                    ,stringlib.StringToUpperCase(trim(strValue,left,right)) = 'B' => 'BLACK'
										,stringlib.StringToUpperCase(trim(strValue,left,right)) = 'H' => 'HISPANIC'
										,stringlib.StringToUpperCase(trim(strValue,left,right)) = 'I' => 'INDIAN'
										,stringlib.StringToUpperCase(trim(strValue,left,right)) = 'U' => 'UNKNOWN'
										,stringlib.StringToUpperCase(trim(strValue,left,right)) = 'W' => 'WHITE'
										,stringlib.StringToUpperCase(trim(strValue,left,right)) = 'O' => 'OTHER'
										,stringlib.StringToUpperCase(trim(strValue,left,right)));
	
	/*string73 tempName 				:= if(InputRecord.test_first_name <> '' and InputRecord.test_middle_name <> '' and InputRecord.test_middle_name <> 'NMN' and InputRecord.test_last_name <> '' and InputRecord.test_suffix_name <> '' ,
										address.CleanPersonFML73(InputRecord.test_first_name + ' ' + InputRecord.test_middle_name + ' ' + InputRecord.test_last_name + ' ' + InputRecord.test_suffix_name),
										if(InputRecord.test_first_name <> '' and InputRecord.test_middle_name <> '' and InputRecord.test_middle_name <> 'NMN' and InputRecord.test_last_name <> '' and InputRecord.test_suffix_name = '' ,
										address.CleanPersonFML73(InputRecord.test_first_name + ' ' + InputRecord.test_middle_name + ' ' + InputRecord.test_last_name),
										if(InputRecord.test_first_name <> '' and InputRecord.test_middle_name = '' and InputRecord.test_last_name <> '' and InputRecord.test_suffix_name <> '' ,
										address.CleanPersonLFM73(InputRecord.test_last_name + ' ' + InputRecord.test_first_name + ' ' + InputRecord.test_suffix_name),
										if(InputRecord.test_first_name <> '' and InputRecord.test_middle_name = '' and InputRecord.test_last_name <> '' and InputRecord.test_suffix_name = '' ,
										address.CleanPersonLFM73(InputRecord.test_last_name + ' ' + InputRecord.test_first_name ),
										if(InputRecord.test_first_name = '' and InputRecord.test_middle_name = '' and InputRecord.test_last_name <> '' and InputRecord.test_suffix_name <> '' ,
										address.CleanPersonLFM73(InputRecord.test_last_name + ' ' + InputRecord.test_suffix_name ),
										if(InputRecord.test_first_name ='' and InputRecord.test_middle_name = '' and InputRecord.test_last_name <> '' and InputRecord.test_suffix_name = '' ,
										address.CleanPersonLFM73(InputRecord.test_last_name),
										if(InputRecord.test_first_name <>'' and InputRecord.test_middle_name = '' and InputRecord.test_last_name = '' and InputRecord.test_suffix_name = '' ,
										address.CleanPersonFML73(InputRecord.test_first_name),
										if(InputRecord.test_first_name ='' and InputRecord.test_middle_name <> '' and InputRecord.test_middle_name <> 'NMN' and InputRecord.test_last_name = '' and InputRecord.test_suffix_name = '' ,
										address.CleanPersonFML73(InputRecord.test_middle_name),
										''))))))));*/
							
	self.title               		:= InputRecord.cln_title;//tempName[1..5];
	self.fname			     				:= InputRecord.cln_fname;//tempName[6..25];
	self.mname			     				:= InputRecord.cln_mname;//tempName[26..45];
	self.lname									:= InputRecord.cln_lname;/*if(tempName[46..48] in ['JR ','SR '],
																	tempName[49..65],
																	tempName[46..65]);*/
	self.name_suffix        		:= InputRecord.cln_suffix;/*if(tempName[46..48] in ['JR ','SR '],
																	tempName[46..48],
																	tempName[66..70]);*/
  self.name_type							:= InputRecord.name_format;	
	self.nid										:= InputRecord.nid;	
	self.ntype									:= InputRecord.nametype;
	self.nindicator							:= InputRecord.name_ind;
	//self.name_score	         		:= '';//tempName[71..73];
	self.name_orig           		:= stringlib.StringToUpperCase(trim(InputRecord.name_orig,left,right));
	self.name_aka            		:= stringlib.StringToUpperCase(trim(InputRecord.name_aka,left,right));
	// If the state is Indiana and the registration date value is 19000101, then set it to null.
	self.reg_date_1          		:= if(InputRecord.orig_state = 'IN' 
										AND InputRecord.reg_date_1 = '19000101', '',
										if(regexfind('LIFE',StringLib.StringToUpperCase(InputRecord.reg_date_1),0)<>'', '99991231'
										,lib_stringlib.stringlib.stringfilter(InputRecord.reg_date_1,'0123456789')));
	self.reg_date_2          		:= if(InputRecord.orig_state = 'IN' 
										AND InputRecord.reg_date_2 = '19000101', '',
										if(regexfind('LIFE',StringLib.StringToUpperCase(InputRecord.reg_date_2),0)<>'', '99991231'
										,lib_stringlib.stringlib.stringfilter(InputRecord.reg_date_2,'0123456789')));
	self.reg_date_3          		:= if(InputRecord.orig_state = 'IN' 
										AND InputRecord.reg_date_3 = '19000101', '',
										if(regexfind('LIFE',StringLib.StringToUpperCase(InputRecord.reg_date_3),0)<>'', '99991231'
										,lib_stringlib.stringlib.stringfilter(InputRecord.reg_date_3,'0123456789')));
	self.date_of_birth       		:= lib_stringlib.stringlib.stringfilter(InputRecord.date_of_birth,'0123456789');
	self.date_of_birth_aka   		:= lib_stringlib.stringlib.stringfilter(InputRecord.date_of_birth_aka,'0123456789');
	self.conviction_date_1   		:= lib_stringlib.stringlib.stringfilter(InputRecord.conviction_date_1,'0123456789');
	self.conviction_date_2   		:= lib_stringlib.stringlib.stringfilter(InputRecord.conviction_date_2,'0123456789');
	self.conviction_date_3   		:= lib_stringlib.stringlib.stringfilter(InputRecord.conviction_date_3,'0123456789');
	self.conviction_date_4   		:= lib_stringlib.stringlib.stringfilter(InputRecord.conviction_date_4,'0123456789');
	self.conviction_date_5   		:= lib_stringlib.stringlib.stringfilter(InputRecord.conviction_date_5,'0123456789');
	self.offense_date_1      		:= lib_stringlib.stringlib.stringfilter(InputRecord.offense_date_1,'0123456789');
	self.offense_date_2      		:= lib_stringlib.stringlib.stringfilter(InputRecord.offense_date_2,'0123456789');
	self.offense_date_3      		:= lib_stringlib.stringlib.stringfilter(InputRecord.offense_date_3,'0123456789');
	self.offense_date_4      		:= lib_stringlib.stringlib.stringfilter(InputRecord.offense_date_4,'0123456789');
	self.offense_date_5      		:= lib_stringlib.stringlib.stringfilter(InputRecord.offense_date_5,'0123456789');
	self.image_date          		:= lib_stringlib.stringlib.stringfilter(InputRecord.image_date,'0123456789');
	
		convert_height 	:= (string)if(regexfind('\'', InputRecord.height, 0)<>'' and regexfind('"', InputRecord.height, 0)<>'',
								((integer)InputRecord.height[1..stringlib.stringfind(InputRecord.height, '\'', 1)-1]*12)+
								((integer)(InputRecord.height[stringlib.stringfind(InputRecord.height, '\'', 1)+1..stringlib.stringfind(InputRecord.height, '"', 1)-1])),
							if(regexfind('\'', InputRecord.height, 0)<>'',
								((integer)InputRecord.height[1..stringlib.stringfind(InputRecord.height, '\'', 1)-1]*12),
								(integer)InputRecord.height));
	
		height_filter	:= if(convert_height between '48' and '84',
								intformat((integer)convert_height,3,1),
								'');
	
	self.height         			:=  height_filter;
	self.sex            			:= 	map(stringlib.StringToUpperCase(trim(InputRecord.sex,left,right)[1]) = 'M' => 'MALE'
										   ,stringlib.StringToUpperCase(trim(InputRecord.sex,left,right)[1]) = 'F' => 'FEMALE'
										   ,stringlib.StringToUpperCase(trim(InputRecord.sex,left,right)[1]) = 'U' => ''
										   ,'');
	// Trim the prefixed data from the front of the Kentucky records
	self.race           			:= 	if(trim(InputRecord.race,left,right) = ''
										   ,expRaceEthnicity(InputRecord.ethnicity)
										,if(trim(InputRecord.orig_state,left,right) = 'KY' 
											AND InputRecord.race[2..4]             = ' - '
										   ,trim(InputRecord.race[5..],left,right)
										   ,expRaceEthnicity(InputRecord.race)));
	self.ethnicity      			:=  if(trim(InputRecord.ethnicity,left,right) <> ''
										   ,expRaceEthnicity(InputRecord.ethnicity)
										   ,'');
	self.hair_color     			:= 	map(stringlib.StringToUpperCase(trim(InputRecord.hair_color,left,right)) = 'BRO' => 'BROWN'
										   ,stringlib.StringToUpperCase(trim(InputRecord.hair_color,left,right)) = 'BLK' => 'BLACK'
										   ,stringlib.StringToUpperCase(trim(InputRecord.hair_color,left,right)) = 'BLN' => 'BLOND'
										   ,stringlib.StringToUpperCase(trim(InputRecord.hair_color,left,right)) = 'GRY' => 'GRAY'
										   ,stringlib.StringToUpperCase(trim(InputRecord.hair_color,left,right)) = 'GRN' => 'GREEN'
										   ,stringlib.StringToUpperCase(trim(InputRecord.hair_color,left,right)) = 'WHI' => 'WHITE'
										   ,stringlib.StringToUpperCase(trim(InputRecord.hair_color,left,right)));
	self.eye_color    				:= 	map(stringlib.StringToUpperCase(trim(InputRecord.eye_color,left,right)) = 'BRO' => 'BROWN'
										   ,stringlib.StringToUpperCase(trim(InputRecord.eye_color,left,right)) = 'BLK' => 'BLACK'
										   ,stringlib.StringToUpperCase(trim(InputRecord.eye_color,left,right)) = 'BLU' => 'BLUE'
										   ,stringlib.StringToUpperCase(trim(InputRecord.eye_color,left,right)) = 'GRY' => 'GRAY'
										   ,stringlib.StringToUpperCase(trim(InputRecord.eye_color,left,right)) = 'GRN' => 'GREEN'
										   ,stringlib.StringToUpperCase(trim(InputRecord.eye_color,left,right)) = 'HAZ' => 'HAZEL'
										   ,stringlib.StringToUpperCase(trim(InputRecord.eye_color,left,right)));
	//self.image_link     			:= if (trim(InputRecord.image_link,left,right) <> '', 'OKC_'+ InputRecord.image_link, '');
	self.image_link       			:= InputRecord.image_link;
	self.source_file                := stringlib.StringToUpperCase(trim(InputRecord.source_file, left, right));
	self.offender_status            := stringlib.StringToUpperCase(trim(InputRecord.offender_status,left,right));
	self.offender_category          := stringlib.StringToUpperCase(trim(InputRecord.offender_category, left, right));
	self.risk_level_code            := stringlib.StringToUpperCase(trim(InputRecord.risk_level_code, left, right));
	self.risk_description           := stringlib.StringToUpperCase(trim(InputRecord.risk_description, left, right));
	self.police_agency              := stringlib.StringToUpperCase(trim(InputRecord.police_agency, left, right));
	self.police_agency_contact_name := stringlib.StringToUpperCase(trim(InputRecord.police_agency_contact_name, left, right));
	self.police_agency_address_1    := stringlib.StringToUpperCase(trim(InputRecord.police_agency_address_1, left, right));
	self.police_agency_address_2    := stringlib.StringToUpperCase(trim(InputRecord.police_agency_address_2, left, right));
	//self.police_agency_phone      := stringlib.StringToUpperCase(InputRecord.police_agency_phone);
	self.registration_type          := stringlib.StringToUpperCase(trim(InputRecord.registration_type, left, right));
	self.reg_date_1_type            := stringlib.StringToUpperCase(trim(InputRecord.reg_date_1_type, left, right));
	self.reg_date_2_type            := stringlib.StringToUpperCase(trim(InputRecord.reg_date_2_type, left, right));
	self.reg_date_3_type            := stringlib.StringToUpperCase(trim(InputRecord.reg_date_3_type, left, right));
	self.registration_address_3     := stringlib.StringToUpperCase(trim(InputRecord.registration_address_3, left, right));
	self.registration_address_4     := stringlib.StringToUpperCase(trim(InputRecord.registration_address_4, left, right));
	self.registration_address_5     := stringlib.StringToUpperCase(trim(InputRecord.registration_address_5, left, right));
	self.registration_county        := stringlib.StringToUpperCase(trim(InputRecord.registration_county, left, right));
	self.employer                   := stringlib.StringToUpperCase(trim(InputRecord.employer, left, right));
	self.employer_address_1         := stringlib.StringToUpperCase(trim(InputRecord.employer_address_1, left, right));
	self.employer_address_2         := stringlib.StringToUpperCase(trim(InputRecord.employer_address_2, left, right));
	self.employer_address_3         := stringlib.StringToUpperCase(trim(InputRecord.employer_address_3, left, right));
	self.employer_address_4         := stringlib.StringToUpperCase(trim(InputRecord.employer_address_4, left, right));
	self.employer_address_5         := stringlib.StringToUpperCase(trim(InputRecord.employer_address_5, left, right));
	self.employer_county            := stringlib.StringToUpperCase(trim(InputRecord.employer_county, left, right));
	self.school                     := stringlib.StringToUpperCase(trim(InputRecord.school, left, right));
	self.school_address_1           := stringlib.StringToUpperCase(trim(InputRecord.school_address_1, left, right));
	self.school_address_2           := stringlib.StringToUpperCase(trim(InputRecord.school_address_2, left, right));
	self.school_address_3           := stringlib.StringToUpperCase(trim(InputRecord.school_address_3, left, right));
	self.school_address_4           := stringlib.StringToUpperCase(trim(InputRecord.school_address_4, left, right));
	self.school_address_5           := stringlib.StringToUpperCase(trim(InputRecord.school_address_5, left, right));
	self.school_county              := stringlib.StringToUpperCase(trim(InputRecord.school_county, left, right));
	self.offender_id                := stringlib.StringToUpperCase(trim(InputRecord.offender_id, left, right));
	self.doc_number                 := stringlib.StringToUpperCase(trim(InputRecord.doc_number, left, right));
	self.sor_number                 := stringlib.StringToUpperCase(trim(InputRecord.sor_number, left, right));
	self.st_id_number               := stringlib.StringToUpperCase(trim(InputRecord.st_id_number, left, right));
	self.fbi_number                 := stringlib.StringToUpperCase(trim(InputRecord.fbi_number, left, right));
	self.ncic_number                := stringlib.StringToUpperCase(trim(InputRecord.ncic_number, left, right));
	//self.orig_ssn                 := lib_stringlib.stringlib.stringfilter(InputRecord.orig_ssn,'0123456789');
	//self.age                      := lib_stringlib.stringlib.stringfilter(InputRecord.age,'0123456789');
	self.weight                     := lib_stringlib.stringlib.stringfilter(InputRecord.weight,'0123456789');
	self.skin_tone                  := stringlib.StringToUpperCase(trim(InputRecord.skin_tone, left, right));
	self.build_type                 := stringlib.StringToUpperCase(trim(InputRecord.build_type, left, right));
	self.scars_marks_tattoos        := stringlib.StringToUpperCase(trim(InputRecord.scars_marks_tattoos, left, right));
	//self.shoe_size                := stringlib.StringToUpperCase(InputRecord.shoe_size);
	self.corrective_lense_flag      := stringlib.StringToUpperCase(trim(InputRecord.corrective_lense_flag, left, right));
	self.conviction_jurisdiction_1  := if(regexfind('AK AK|AL AL|AR AR|AZ AZ|CA CA|CO CO|CT CT|DC DC|DE DE|FL FL|'+
											'GA GA|HI HI|IA IA|ID ID|IL IL|IN IN|KS KS|KY KY|LA LA|MA MA|MD MD|ME ME|MI MI|MN MN|MO MO|'+
											'MS MS|MT MT|NC NC|ND ND|NE NE|NH NH|NJ NJ|NM NM|NV NV|NY NY|OH OH|OK OK|OR OR|PA PA|RI RI|'+
											'SC SC|SD SD|TN TN|TX TX|UT UT|VA VA|VT VT|WA WA|WI WI|WV WV|WY WY',
											stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_1, left, right)), 0)<>'' and InputRecord.orig_state = 'NV',
											stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_1, left, right))[1..length(stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_1, left, right)))-2],
											stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_1, left, right)));
	self.court_1                    := stringlib.StringToUpperCase(trim(InputRecord.court_1, left, right));
	self.court_case_number_1        := stringlib.StringToUpperCase(trim(InputRecord.court_case_number_1, left, right));
	self.offense_code_or_statute_1  := stringlib.StringToUpperCase(trim(InputRecord.offense_code_or_statute_1, left, right));
	self.offense_description_1      := stringlib.StringToUpperCase(trim(InputRecord.offense_description_1, left, right));
	self.offense_description_1_2    := stringlib.StringToUpperCase(trim(InputRecord.offense_description_1_2, left, right));
	self.victim_minor_1             := stringlib.StringToUpperCase(trim(InputRecord.victim_minor_1, left, right));
	//self.victim_age_1             := stringlib.StringToUpperCase(InputRecord.;
	self.victim_gender_1            := stringlib.StringToUpperCase(trim(InputRecord.victim_gender_1, left, right));
	self.victim_relationship_1      := stringlib.StringToUpperCase(trim(InputRecord.victim_relationship_1, left, right));
	self.sentence_description_1     := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_1, left, right));
	self.sentence_description_1_2   := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_1_2, left, right));
	self.conviction_jurisdiction_2  := stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_2, left, right));
	self.court_2                    := stringlib.StringToUpperCase(trim(InputRecord.court_2, left, right));
	self.court_case_number_2        := stringlib.StringToUpperCase(trim(InputRecord.court_case_number_2, left, right));
	self.offense_code_or_statute_2  := stringlib.StringToUpperCase(trim(InputRecord.offense_code_or_statute_2, left, right));
	self.offense_description_2      := stringlib.StringToUpperCase(trim(InputRecord.offense_description_2, left, right));
	self.offense_description_2_2    := stringlib.StringToUpperCase(trim(InputRecord.offense_description_2_2, left, right));
	self.victim_minor_2             := stringlib.StringToUpperCase(trim(InputRecord.victim_minor_2, left, right));
	//self.victim_age_2             := stringlib.StringToUpperCase(InputRecord.;
	self.victim_gender_2            := stringlib.StringToUpperCase(trim(InputRecord.victim_gender_2, left, right));
	self.victim_relationship_2      := stringlib.StringToUpperCase(trim(InputRecord.victim_relationship_2, left, right));
	self.sentence_description_2     := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_2, left, right));
	self.sentence_description_2_2   := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_2_2, left, right));
	self.conviction_jurisdiction_3  := stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_3, left, right));
	self.court_3                    := stringlib.StringToUpperCase(trim(InputRecord.court_3, left, right));
	self.court_case_number_3        := stringlib.StringToUpperCase(trim(InputRecord.court_case_number_3, left, right));
	self.offense_code_or_statute_3  := stringlib.StringToUpperCase(trim(InputRecord.offense_code_or_statute_3, left, right));
	self.offense_description_3      := stringlib.StringToUpperCase(trim(InputRecord.offense_description_3, left, right));
	self.offense_description_3_2    := stringlib.StringToUpperCase(trim(InputRecord.offense_description_3_2, left, right));
	self.victim_minor_3             := stringlib.StringToUpperCase(trim(InputRecord.victim_minor_3, left, right));
	//self.victim_age_3             := stringlib.StringToUpperCase(InputRecord.;
	self.victim_gender_3            := stringlib.StringToUpperCase(trim(InputRecord.victim_gender_3, left, right));
	self.victim_relationship_3      := stringlib.StringToUpperCase(trim(InputRecord.victim_relationship_3, left, right));
	self.sentence_description_3     := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_3, left, right));
	self.sentence_description_3_2   := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_3_2, left, right));
	self.conviction_jurisdiction_4  := stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_4, left, right));
	self.court_4                    := stringlib.StringToUpperCase(trim(InputRecord.court_4, left, right));
	self.court_case_number_4        := stringlib.StringToUpperCase(trim(InputRecord.court_case_number_4, left, right));
	self.offense_code_or_statute_4  := stringlib.StringToUpperCase(trim(InputRecord.offense_code_or_statute_4, left, right));
	self.offense_description_4      := stringlib.StringToUpperCase(trim(InputRecord.offense_description_4, left, right));
	self.offense_description_4_2    := stringlib.StringToUpperCase(trim(InputRecord.offense_description_4_2, left, right));
	self.victim_minor_4             := stringlib.StringToUpperCase(trim(InputRecord.victim_minor_4, left, right));
	//self.victim_age_4             := stringlib.StringToUpperCase(InputRecord.;
	self.victim_gender_4            := stringlib.StringToUpperCase(trim(InputRecord.victim_gender_4, left, right));
	self.victim_relationship_4      := stringlib.StringToUpperCase(trim(InputRecord.victim_relationship_4, left, right));
	self.sentence_description_4     := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_4, left, right));
	self.sentence_description_4_2   := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_4_2, left, right));
	self.conviction_jurisdiction_5  := stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_5, left, right));
	self.court_5                    := stringlib.StringToUpperCase(trim(InputRecord.court_5, left, right));
	self.court_case_number_5        := stringlib.StringToUpperCase(trim(InputRecord.court_case_number_5, left, right));
	self.offense_code_or_statute_5  := stringlib.StringToUpperCase(trim(InputRecord.offense_code_or_statute_5, left, right));
	self.offense_description_5      := stringlib.StringToUpperCase(trim(InputRecord.offense_description_5, left, right));
	self.offense_description_5_2    := stringlib.StringToUpperCase(trim(InputRecord.offense_description_5_2, left, right));
	self.victim_minor_5             := stringlib.StringToUpperCase(trim(InputRecord.victim_minor_5, left, right));
	//self.victim_age_5             := stringlib.StringToUpperCase(InputRecord.;
	self.victim_gender_5            := stringlib.StringToUpperCase(trim(InputRecord.victim_gender_5, left, right));
	self.victim_relationship_5      := stringlib.StringToUpperCase(trim(InputRecord.victim_relationship_5, left, right));
	self.sentence_description_5     := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_5, left, right));
	self.sentence_description_5_2   := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_5_2, left, right));
	self.addl_comments_1            := stringlib.StringToUpperCase(trim(InputRecord.addl_comments_1[1..140], left, right));
	self.addl_comments_2            := stringlib.StringToUpperCase(trim(InputRecord.addl_comments_2[1..140], left, right));
	self.orig_dl_number             := stringlib.StringToUpperCase(trim(InputRecord.orig_dl_number, left, right));
	self.orig_dl_state              := stringlib.StringToUpperCase(trim(InputRecord.orig_dl_state, left, right));
	//self.orig_veh_year_1          := stringlib.StringToUpperCase(InputRecord.orig_veh_year_1);
	self.orig_veh_color_1           := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_color_1, left, right));
	self.orig_veh_make_model_1      := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_make_model_1, left, right));
	self.orig_veh_plate_1           := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_plate_1, left, right));
	self.orig_veh_state_1           := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_state_1, left, right));
	//self.orig_veh_year_2          := stringlib.StringToUpperCase(InputRecord.;
	self.orig_veh_color_2           := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_color_2, left, right));
	self.orig_veh_make_model_2      := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_make_model_2, left, right));
	self.orig_veh_plate_2           := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_plate_2, left, right));
	self.orig_veh_state_2           := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_state_2, left, right));
	self.rawaid											:= InputRecord.append_rawaid;
	self.st													:= if(InputRecord.st = '',
																				InputRecord.orig_state,
																				InputRecord.st);
	self := InputRecord;
	self.offender_persistent_id			:= 0;
	self.offense_persistent_id			:= 0;
end;


ds_restAppended := project(name_fix, restAppended(left))
                        : persist('~thor_data400::Persist::restAppended');

//**** Persist seisint primary key assignment logic starts here ****//

// Get primary names and assign persist seisint primary key to primary names
primarynameRecs := ds_restAppended(name_type = '0');

	Layout_add_persist_primary_key := RECORD
		string persist_seisint_primary_key;  
		Hygenics_SOff.Layout_OKC_Sex_Offender_Common.final;
	end;

	Layout_add_persist_primary_key tr_assign_persistent_seisint_primary_key(primarynameRecs InputRecord) := transform
 
		concat_source_name							:= 		trim(trim(InputRecord.source_file, all) + trim(StringLib.StringFilter(StringLib.StringToUpperCase(InputRecord.name_orig),'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), all), all);	 
	 
		persist_seisint_primary_key 		:=    'C2'+ 
																					trim(InputRecord.orig_state, all)+ 
																					'SOR'+                   
																					(String)hash64(if(trim(InputRecord.sor_number, left, right)<>'' and trim(InputRecord.orig_state, all) in ['LA', 'SC', 'WA','IN','CT'],
																					                  trim(trim(InputRecord.source_file, all) + trim(InputRecord.sor_number, all) + trim(InputRecord.name_orig, all), all),
																					               if(trim(InputRecord.sor_number, left, right)<>'' and trim(InputRecord.orig_state, all) not in ['GA','LA', 'SC', 'WA'],
																														trim(trim(InputRecord.source_file, all) + trim(InputRecord.sor_number, all), all),
																												if(trim(InputRecord.date_of_birth, left, right)<>'' and trim(InputRecord.height, left, right)<>'',
																														trim(concat_source_name + trim(trim(StringLib.StringFilter(InputRecord.date_of_birth,'0123456789'), all) + trim(StringLib.StringFilter(InputRecord.height,'0123456789'), all), all), all),
																												if(trim(InputRecord.date_of_birth, left, right)<>'',
																														trim(concat_source_name + trim(StringLib.StringFilter(InputRecord.date_of_birth,'0123456789'), all), all),			
																														concat_source_name)))));																						
								
		self.persist_seisint_primary_key 	:= persist_seisint_primary_key;
		self := InputRecord;
	end;	
	
ds_assign_persistent_seisint_primary_key 			:= project(primarynameRecs, tr_assign_persistent_seisint_primary_key(left)) : persist('~thor_data400::Persist::Assigned_Persistent_Seisint_Primary_key_Primary_Name');
dist_assign_persistent_seisint_primary_key   	:= distribute(ds_assign_persistent_seisint_primary_key, hash(seisint_primary_key));

// Get alias names and assign persist seisint primary key to alias names
dist_aliasnameRecs := distribute(ds_restAppended(name_type <> '0'), hash(seisint_primary_key));

	Layout_add_persist_primary_key tr_persistent_seisint_primary_key_to_alias(dist_aliasnameRecs L, dist_assign_persistent_seisint_primary_key R) := transform
	 self.persist_seisint_primary_key := r.persist_seisint_primary_key;
	 self := L;
	end; 		

ds_assign_persistent_seisint_primary_key_alias := join(dist_aliasnameRecs,dist_assign_persistent_seisint_primary_key, 
																											 left.seisint_primary_key = right.seisint_primary_key,  
																											 tr_persistent_seisint_primary_key_to_alias(left,right), 
																											 local);

dist_ds_assign_persistent_seisint_primary_key_alias   := distribute(ds_assign_persistent_seisint_primary_key_alias, hash(seisint_primary_key));

// Concat primary names and alias names and assign persist seisint primary key to seisint primary key
concat_primary_and_alias := dist_assign_persistent_seisint_primary_key + dist_ds_assign_persistent_seisint_primary_key_alias
                                   : persist('~thor_data400::Persist::Assigned_Persistent_Seisint_Primary_key_test');

	Hygenics_SOff.Layout_OKC_Sex_Offender_Common.final tr_transfer_persistent_seisint_primary_key(concat_primary_and_alias InputRecord) := transform 
	 self.seisint_primary_key := InputRecord.persist_seisint_primary_key; 								
   self := InputRecord;
	end;	
	
ds_transfer_persistent_seisint_primary_key := project(concat_primary_and_alias, tr_transfer_persistent_seisint_primary_key(left));

// Add offender_persistent_id

	ds_transfer_persistent_seisint_primary_key addNPID(ds_transfer_persistent_seisint_primary_key l):= transform
		// self.offender_persistent_id := hash64(trim(l.seisint_primary_key, left, right)+trim((string)l.nid, left, right)+trim(l.date_of_birth, left, right)+trim(l.date_of_birth_aka, left, right));
		
			filterField(String s) := FUNCTION
			return StringLib.StringFilter(StringLib.StringToUpperCase(s),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		END;
		
		Vlname          		:= filterField(l.lname);
		Vfname          		:= filterField(l.fname);
		Vmname          		:= filterField(l.mname);
		Vname_suffix		    := filterField(l.name_suffix);
		Vrace 							:= filterField(l.race);
		Vheight							:= filterField(l.height);
		Vsex 								:= filterField(l.sex);
		Vweight							:= filterField(l.weight);
		Veye_color					:= filterField(l.eye_color);	
		Vhair_color					:= filterField(l.hair_color);	
		VOffender_status   	:= filterField(l.Offender_status);
	  Vscars_marks_tattoos:= filterField(l.scars_marks_tattoos);
		Vimage_link         := filterField(l.image_link);
		VregistrationAddr   := filterField(l.registration_address_1 +l.registration_address_2);
		Voffender_id        := filterField(l.offender_id);
		
		self.offender_persistent_id := hash64(trim(l.seisint_primary_key, left, right)+
		                                      trim((string)l.nid, left, right)+
																					trim(l.date_of_birth, left, right)+
																					trim(l.date_of_birth_aka, left, right)+
																					// Vlname               +           	
																					// Vfname          	   +
																					// Vmname          	   +
																					// Vname_suffix		     +
																					Vrace 						   +
																					Vheight						   +
																					Vsex 							   +
																					Vweight						   +
																					Veye_color				   +
																					Vhair_color				   +
																					// VOffender_status     +
																					Vscars_marks_tattoos +
																					// Vimage_link          +
																					VregistrationAddr    +
																					Voffender_id
																					);
		self := l;
	end;

nPId_Added := project(ds_transfer_persistent_seisint_primary_key, addNPID(left));

/*
dslayout := RECORD
  string8 dt_first_reported;
  string8 dt_last_reported;
  string60 seisint_primary_key;
  unsigned8 key;
  string2 vendor_code;
  string1 name_type;
  string30 source_file;
  string10 date_added;
  string10 scrape_date;
  string10 src_upload_date;
  string2 orig_state;
  string50 name_orig;
  string30 orig_firstname;
  string30 orig_middlename;
  string30 orig_lastname;
  string10 orig_suffix;
  string30 firstname;
  string30 middlename;
  string30 lastname;
  string10 suffix;
  string255 name_aka;
  string320 intnet_email_address_1;
  string320 intnet_email_address_2;
  string320 intnet_email_address_3;
  string320 intnet_email_address_4;
  string320 intnet_email_address_5;
  string320 intnet_instant_message_addr_1;
  string320 intnet_instant_message_addr_2;
  string320 intnet_instant_message_addr_3;
  string320 intnet_instant_message_addr_4;
  string320 intnet_instant_message_addr_5;
  string320 intnet_user_name_1;
  string255 intnet_user_name_1_url;
  string320 intnet_user_name_2;
  string255 intnet_user_name_2_url;
  string320 intnet_user_name_3;
  string255 intnet_user_name_3_url;
  string320 intnet_user_name_4;
  string255 intnet_user_name_4_url;
  string320 intnet_user_name_5;
  string255 intnet_user_name_5_url;
  string50 offender_status;
  string40 offender_category;
  string10 risk_level_code;
  string50 risk_description;
  string50 police_agency;
  string50 police_agency_contact_name;
  string55 police_agency_address_1;
  string35 police_agency_address_2;
  string10 police_agency_phone;
  string35 registration_type;
  string8 reg_date_1;
  string28 reg_date_1_type;
  string8 reg_date_2;
  string28 reg_date_2_type;
  string8 reg_date_3;
  string28 reg_date_3_type;
  string125 registration_address_1;
  string45 registration_address_2;
  string35 registration_address_3;
  string35 registration_address_4;
  string35 registration_address_5;
  string35 registration_county;
  string10 registration_home_phone;
  string10 registration_cell_phone;
  string125 other_registration_address_1;
  string45 other_registration_address_2;
  string35 other_registration_address_3;
  string35 other_registration_address_4;
  string35 other_registration_address_5;
  string35 other_registration_county;
  string10 other_registration_phone;
  string125 temp_lodge_address_1;
  string45 temp_lodge_address_2;
  string35 temp_lodge_address_3;
  string35 temp_lodge_address_4;
  string35 temp_lodge_address_5;
  string35 temp_lodge_county;
  string10 temp_lodge_phone;
  string55 employer;
  string55 employer_address_1;
  string35 employer_address_2;
  string35 employer_address_3;
  string35 employer_address_4;
  string35 employer_address_5;
  string35 employer_county;
  string10 employer_phone;
  string140 employer_comments;
  string75 professional_licenses_1;
  string75 professional_licenses_2;
  string75 professional_licenses_3;
  string75 professional_licenses_4;
  string75 professional_licenses_5;
  string55 school;
  string55 school_address_1;
  string35 school_address_2;
  string35 school_address_3;
  string35 school_address_4;
  string35 school_address_5;
  string35 school_county;
  string10 school_phone;
  string140 school_comments;
  string30 offender_id;
  string30 doc_number;
  string40 sor_number;
  string30 st_id_number;
  string30 fbi_number;
  string30 ncic_number;
  string9 orig_ssn;
  string8 date_of_birth;
  string8 date_of_birth_aka;
  string3 age;
  string250 dna;
  string30 race;
  string30 ethnicity;
  string10 sex;
  string40 hair_color;
  string40 eye_color;
  string3 height;
  string3 weight;
  string20 skin_tone;
  string30 build_type;
  string200 scars_marks_tattoos;
  string6 shoe_size;
  string1 corrective_lense_flag;
  string8 arrest_date_1;
  string250 arrest_warrant_1;
  string40 offense_location_1;
  string80 conviction_jurisdiction_1;
  string8 conviction_date_1;
  string30 court_1;
  string25 court_case_number_1;
  string8 offense_date_1;
  string20 offense_code_or_statute_1;
  string320 offense_description_1;
  string180 offense_description_1_2;
  string10 offense_level_1;
  string1 victim_minor_1;
  string3 victim_age_1;
  string10 victim_gender_1;
  string30 victim_relationship_1;
  string8 disposition_dt_1;
  string180 sentence_description_1;
  string180 sentence_description_1_2;
  string8 arrest_date_2;
  string250 arrest_warrant_2;
  string40 offense_location_2;
  string80 conviction_jurisdiction_2;
  string8 conviction_date_2;
  string30 court_2;
  string25 court_case_number_2;
  string8 offense_date_2;
  string20 offense_code_or_statute_2;
  string320 offense_description_2;
  string180 offense_description_2_2;
  string10 offense_level_2;
  string1 victim_minor_2;
  string3 victim_age_2;
  string10 victim_gender_2;
  string30 victim_relationship_2;
  string8 disposition_dt_2;
  string180 sentence_description_2;
  string180 sentence_description_2_2;
  string8 arrest_date_3;
  string250 arrest_warrant_3;
  string40 offense_location_3;
  string80 conviction_jurisdiction_3;
  string8 conviction_date_3;
  string30 court_3;
  string25 court_case_number_3;
  string8 offense_date_3;
  string20 offense_code_or_statute_3;
  string320 offense_description_3;
  string180 offense_description_3_2;
  string10 offense_level_3;
  string1 victim_minor_3;
  string3 victim_age_3;
  string10 victim_gender_3;
  string30 victim_relationship_3;
  string8 disposition_dt_3;
  string180 sentence_description_3;
  string180 sentence_description_3_2;
  string8 arrest_date_4;
  string250 arrest_warrant_4;
  string40 offense_location_4;
  string80 conviction_jurisdiction_4;
  string8 conviction_date_4;
  string30 court_4;
  string25 court_case_number_4;
  string8 offense_date_4;
  string20 offense_code_or_statute_4;
  string320 offense_description_4;
  string180 offense_description_4_2;
  string10 offense_level_4;
  string1 victim_minor_4;
  string3 victim_age_4;
  string10 victim_gender_4;
  string3 victim_relationship_4;
  string8 disposition_dt_4;
  string180 sentence_description_4;
  string180 sentence_description_4_2;
  string8 arrest_date_5;
  string250 arrest_warrant_5;
  string40 offense_location_5;
  string80 conviction_jurisdiction_5;
  string8 conviction_date_5;
  string30 court_5;
  string25 court_case_number_5;
  string8 offense_date_5;
  string20 offense_code_or_statute_5;
  string320 offense_description_5;
  string180 offense_description_5_2;
  string10 offense_level_5;
  string1 victim_minor_5;
  string3 victim_age_5;
  string10 victim_gender_5;
  string30 victim_relationship_5;
  string8 disposition_dt_5;
  string180 sentence_description_5;
  string180 sentence_description_5_2;
  string140 addl_comments_1;
  string140 addl_comments_2;
  string30 orig_dl_number;
  string2 orig_dl_state;
  string150 orig_dl_link;
  string8 orig_dl_date;
  string1 passport_type;
  string10 passport_code;
  string25 passport_number;
  string50 passport_first_name;
  string100 passport_given_name;
  string30 passport_nationality;
  string8 passport_dob;
  string55 passport_place_of_birth;
  string10 passport_sex;
  string8 passport_issue_date;
  string55 passport_authority;
  string8 passport_expiration_date;
  string50 passport_endorsement;
  string150 passport_link;
  string8 passport_date;
  string4 orig_veh_year_1;
  string40 orig_veh_color_1;
  string40 orig_veh_make_model_1;
  string40 orig_veh_plate_1;
  string17 orig_registration_number_1;
  string2 orig_veh_state_1;
  string50 orig_veh_location_1;
  string4 orig_veh_year_2;
  string40 orig_veh_color_2;
  string40 orig_veh_make_model_2;
  string40 orig_veh_plate_2;
  string17 orig_registration_number_2;
  string2 orig_veh_state_2;
  string50 orig_veh_location_2;
  string4 orig_veh_year_3;
  string40 orig_veh_color_3;
  string40 orig_veh_make_model_3;
  string40 orig_veh_plate_3;
  string17 orig_registration_number_3;
  string2 orig_veh_state_3;
  string50 orig_veh_location_3;
  string4 orig_veh_year_4;
  string40 orig_veh_color_4;
  string40 orig_veh_make_model_4;
  string40 orig_veh_plate_4;
  string17 orig_registration_number_4;
  string2 orig_veh_state_4;
  string50 orig_veh_location_4;
  string4 orig_veh_year_5;
  string40 orig_veh_color_5;
  string40 orig_veh_make_model_5;
  string40 orig_veh_plate_5;
  string17 orig_registration_number_5;
  string2 orig_veh_state_5;
  string50 orig_veh_location_5;
  string150 fingerprint_link;
  string8 fingerprint_date;
  string150 palmprint_link;
  string8 palmprint_date;
  string150 image_link;
  string8 image_date;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned8 rawaid;
 END;

ds := dataset('~thor_data400::Persist::Cleaned_HD_Sex_Offender_test', dslayout, flat);
*/
output(nPId_Added(seisint_primary_key ='C2CTSOR4298271687694912252'));
export Cleaned_OKC_Sex_Offender := nPId_Added : persist('~thor_data400::Persist::Cleaned_HD_Sex_Offender');