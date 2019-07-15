import SexOffender, lib_stringlib;

In_Base_file := Hygenics_SOff.File_OKC_Sex_Offender_DID(name_type = '0');

	Layout_Mainfile := record
		Hygenics_SOff.Layout_Accurint_Mainfile;
		string2 newline := '\r\n';
	end;

	Layout_Mainfile Clean_OKC_Sex_Off_Name(In_Base_file InputRecord) := transform
		self.ssn         := InputRecord.orig_ssn;
		self.dob         := InputRecord.date_of_birth;
		self.dob_aka     := InputRecord.date_of_birth_aka;
		self             := InputRecord;
	end;

dsAccurint_In := project(In_Base_file,Clean_OKC_Sex_Off_Name(left));

ds_blank_image_recs 	:= sort(dsAccurint_In(trim(image_link,left,right) = ''), orig_state, image_link);
ds_Sorted_AccurintFile 	:= sort(dsAccurint_In(trim(image_link,left,right)<> ''), orig_state, image_link);

Lookup_file 			:= sort(Hygenics_SOff.File_OKC_Pics_Lookup(trim(image_file_name,left,right) <> ''), state_of_origin, image_file_name);

	Layout_Mainfile Clean_Image_Link_trf(Layout_Mainfile l, Lookup_file r) := transform
		self.image_link := if (trim(r.image_file_name,left,right) <> '', l.image_link, r.image_file_name);
		self 			:= l;	
	end;

//Checking with the Image link lookup file to blank the main.image_link value if not found in the lookup file. 
Clean_ds 				:= join(ds_Sorted_AccurintFile, Lookup_file, 
								trim(left.orig_state,left,right) = stringlib.StringToUpperCase(trim(right.state_of_origin,left,right)) and																										trim(left.image_link,left,right) = trim(right.image_file_name,left,right), 
								Clean_Image_Link_trf(left,right), left outer, keep(1));
								
sort_clean_ds 			:= sort(Clean_ds + ds_blank_image_recs, seisint_primary_key, orig_state, name_orig);

//sort_clean_ds 			:= sort(dsAccurint_In, seisint_primary_key, orig_state, name_orig); 

//Moxie Layout///////////////////////////////////////////////////////////////////////////////////////
	oldMoxieLayout := RECORD
		string8 dt_first_reported;
		string8 dt_last_reported;
		string2 orig_state;
		string60 seisint_primary_key;
		string2 vendor_code;
		string20 source_file;
		string50 name_orig;
		string30 lname;
		string30 fname;
		string20 mname;
		string20 name_suffix;
		string1 name_type;
		string50 offender_status;
		string40 offender_category;
		string10 risk_level_code;
		string50 risk_description;
		string50 police_agency;
		string35 police_agency_contact_name;
		string55 police_agency_address_1;
		string35 police_agency_address_2;
		string10 police_agency_phone;
		string25 registration_type;
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
		string55 employer;
		string55 employer_address_1;
		string35 employer_address_2;
		string35 employer_address_3;
		string35 employer_address_4;
		string35 employer_address_5;
		string35 employer_county;
		string55 school;
		string55 school_address_1;
		string35 school_address_2;
		string35 school_address_3;
		string35 school_address_4;
		string35 school_address_5;
		string35 school_county;
		string30 offender_id;
		string30 doc_number;
		string40 sor_number;
		string30 st_id_number;
		string30 fbi_number;
		string30 ncic_number;
		string9 ssn;
		string8 dob;
		string8 dob_aka;
		string3 age;
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
		string80 conviction_jurisdiction_1;
		string8 conviction_date_1;
		string30 court_1;
		string25 court_case_number_1;
		string8 offense_date_1;
		string20 offense_code_or_statute_1;
		string320 offense_description_1;
		string180 offense_description_1_2;
		string1 victim_minor_1;
		string3 victim_age_1;
		string10 victim_gender_1;
		string30 victim_relationship_1;
		string180 sentence_description_1;
		string180 sentence_description_1_2;
		string80 conviction_jurisdiction_2;
		string8 conviction_date_2;
		string30 court_2;
		string25 court_case_number_2;
		string8 offense_date_2;
		string20 offense_code_or_statute_2;
		string180 offense_description_2;
		string180 offense_description_2_2;
		string1 victim_minor_2;
		string3 victim_age_2;
		string10 victim_gender_2;
		string30 victim_relationship_2;
		string180 sentence_description_2;
		string180 sentence_description_2_2;
		string80 conviction_jurisdiction_3;
		string8 conviction_date_3;
		string30 court_3;
		string25 court_case_number_3;
		string8 offense_date_3;
		string20 offense_code_or_statute_3;
		string180 offense_description_3;
		string180 offense_description_3_2;
		string1 victim_minor_3;
		string3 victim_age_3;
		string10 victim_gender_3;
		string30 victim_relationship_3;
		string180 sentence_description_3;
		string180 sentence_description_3_2;
		string80 conviction_jurisdiction_4;
		string8 conviction_date_4;
		string30 court_4;
		string25 court_case_number_4;
		string8 offense_date_4;
		string20 offense_code_or_statute_4;
		string180 offense_description_4;
		string180 offense_description_4_2;
		string1 victim_minor_4;
		string3 victim_age_4;
		string10 victim_gender_4;
		string30 victim_relationship_4;
		string180 sentence_description_4;
		string180 sentence_description_4_2;
		string80 conviction_jurisdiction_5;
		string8 conviction_date_5;
		string30 court_5;
		string25 court_case_number_5;
		string8 offense_date_5;
		string20 offense_code_or_statute_5;
		string180 offense_description_5;
		string180 offense_description_5_2;
		string1 victim_minor_5;
		string3 victim_age_5;
		string10 victim_gender_5;
		string30 victim_relationship_5;
		string180 sentence_description_5;
		string180 sentence_description_5_2;
		string140 addl_comments_1;
		string140 addl_comments_2;
		string30 orig_dl_number;
		string2 orig_dl_state;
		string4 orig_veh_year_1;
		string40 orig_veh_color_1;
		string40 orig_veh_make_model_1;
		string40 orig_veh_plate_1;
		string2 orig_veh_state_1;
		string4 orig_veh_year_2;
		string40 orig_veh_color_2;
		string40 orig_veh_make_model_2;
		string40 orig_veh_plate_2;
		string2 orig_veh_state_2;
		string150 image_link;
		string8 image_date;
		string2 newline;
	END;
 
	oldMoxieLayout  oldMoxieTran(sort_clean_ds l) := transform
		self := l;
	end;

ds_AccurintMoxieFile := project(sort_clean_ds, oldMoxieTran(left));

output(ds_AccurintMoxieFile,,'~thor_200::base::hd::OKC_Sex_Offender_File_Accurint_In_Moxie',overwrite);

/////////////////////////////////////////////////////////////////////////////////////////////

export Mapping_OKC_Cleaned_As_Accurint_In := output(sort_clean_ds,,'~thor_200::base::hd::OKC_Sex_Offender_File_Accurint_In',overwrite,__compressed__);