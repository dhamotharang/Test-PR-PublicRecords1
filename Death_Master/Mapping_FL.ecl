IMPORT HEADER, ADDRESS, UT;

file_in := Death_Master.Files.Florida((StringLib.StringToUpperCase(TRIM(lname)) NOT IN ['','UNKNOWN']));
						 
Header.layout_death_master_supplemental tDeathMaster_Florida_Data_Supplement(file_in pInput) := 
TRANSFORM


	// Get Address and separate into address1 and address2
	pre_clean_state					:=	IF(Address.Map_State_Name_To_Abbrev(TRIM(pInput.residence_state,LEFT,RIGHT))<>'',
																Address.Map_State_Name_To_Abbrev(TRIM(pInput.residence_state,LEFT,RIGHT)),
																TRIM(pInput.residence_state,LEFT,RIGHT));

	fnCleanAddressField(STRING	addrField)	:=	FUNCTION
		RETURN(IF(StringLib.StringToUpperCase(TRIM(addrField,LEFT,RIGHT)) 
							NOT IN ['','NONE','UNK','UNKNO','UNKNOWN','UNOBTAINABLE','UNAVAILABLE','UNOBT'],TRIM(addrField,LEFT,RIGHT),''));
	END;
	clean_address						:=	fnCleanAddressField(pInput.residence_address);
	clean_apartment					:=	fnCleanAddressField(pInput.residence_apartment);
	clean_city							:=	fnCleanAddressField(pInput.residence_city);
	clean_state							:=	fnCleanAddressField(pre_clean_state);
	clean_zip								:=	fnCleanAddressField(pInput.residence_zip);

	STRING76 orig_address1 	:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(
																	clean_address+' '+
																	clean_apartment
															));
	STRING76 orig_address2 	:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(
																IF(	clean_city<>'' AND (clean_state<>'' OR clean_zip<>''),
																		clean_city+', ',
																		clean_city
																)+clean_state+' '+IF(clean_zip='99999','',clean_zip)
															));

	// Convert the DOB and DOD to a common format
	STRING8		clean_dob 		:= 	IF(pInput.dob[5..8] IN ['9999',''],'',
																	IF(pInput.dob[1..2] IN ['99'], '00', pInput.dob[1..2]) +
																	IF(pInput.dob[3..4] IN ['99'], '00', pInput.dob[3..4]) +
																	pInput.dob[5..8]);																
	STRING8		clean_dod 		:= 	IF(pInput.dod[5..8] IN ['9999',''],'',
																	IF(pInput.dod[1..2] IN ['99'], '00', pInput.dod[1..2]) +
																	IF(pInput.dod[3..4] IN ['99'], '00', pInput.dod[3..4]) +
																	pInput.dod[5..8]);
																	
	SELF.source_state  			:= 	'FL';
	SELF.statefn						:=	TRIM(pInput.StateFN);
	SELF.decedent_race			:= 	StringLib.StringToUpperCase(TRIM(pInput.race));
	SELF.decedent_origin		:= 	StringLib.StringToUpperCase(TRIM(pInput.hispanic_origin));
	SELF.decedent_sex  			:= 	Lookup_States.lkp_fl_gender(pInput.gender);
	SELF.decedent_age 			:= 	StringLib.StringToUpperCase((INTEGER)pInput.age_death_value+' '+TRIM(pInput.age_death_units));
	SELF.education		 			:= 	StringLib.StringToUpperCase(pInput.education);
	SELF.ssn  							:= 	pInput.ssn;
	SELF.dob 								:= 	clean_dob;
	SELF.dod 								:= 	clean_dod;
	SELF.birthplace					:=	StringLib.StringToUpperCase(
																IF(TRIM(pInput.place_of_birth_state)<>'' AND TRIM(pInput.place_of_birth_country)<>'',
																	TRIM(pInput.place_of_birth_state)+', '+TRIM(pInput.place_of_birth_country),
																	IF(TRIM(pInput.place_of_birth_state)<>'',TRIM(pInput.place_of_birth_state),TRIM(pInput.place_of_birth_country))
																)
															);
	SELF.marital_status			:= 	StringLib.StringToUpperCase(pInput.marital_status);
	fname_father_clean 			:=	IF(TRIM(pInput.fname_father,ALL)[1..3] IN ['','UNK'],'',TRIM(pInput.fname_father,ALL));
	mname_father_clean 			:=	IF(TRIM(pInput.mname_father,ALL)[1..3] IN ['','UNK'],'',TRIM(pInput.mname_father,ALL));
	lname_father_clean			:=	IF(TRIM(pInput.lname_father,ALL)[1..3] IN ['','UNK'],'',TRIM(pInput.lname_father,ALL));
	suffix_father_clean			:=	IF(TRIM(pInput.name_suffix_father,ALL)[1..3] IN ['','UNK'],'',TRIM(pInput.name_suffix_father,ALL));
	SELF.father							:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(
																IF(	(TRIM(lname_father_clean)<>'' OR TRIM(suffix_father_clean)<>'') AND 
																		(TRIM(fname_father_clean)<>'' OR TRIM(mname_father_clean)<>''),
																			TRIM(lname_father_clean+' '+suffix_father_clean,LEFT,RIGHT)+', '+
																			TRIM(fname_father_clean+' '+mname_father_clean,LEFT,RIGHT),
																			IF(TRIM(lname_father_clean)<>'' OR TRIM(suffix_father_clean)<>'',
																				TRIM(lname_father_clean+' '+suffix_father_clean,LEFT,RIGHT),
																				TRIM(fname_father_clean+' '+mname_father_clean,LEFT,RIGHT)
																			)
																)
															));
	fname_mother_clean 			:=	IF(TRIM(pInput.fname_mother,ALL)[1..3] IN ['','UNK'],'',TRIM(pInput.fname_mother,ALL));
	mname_mother_clean 			:=	IF(TRIM(pInput.mname_mother,ALL)[1..3] IN ['','UNK'],'',TRIM(pInput.mname_mother,ALL));
	lname_mother_clean			:=	IF(TRIM(pInput.lname_mother,ALL)[1..3] IN ['','UNK'],'',TRIM(pInput.lname_mother,ALL));
	SELF.mother							:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(
																IF(	TRIM(lname_mother_clean)<>'' AND 
																	 (TRIM(fname_mother_clean)<>'' OR TRIM(mname_mother_clean)<>''),
																			TRIM(lname_mother_clean,LEFT,RIGHT)+', '+
																			TRIM(fname_mother_clean+' '+mname_mother_clean,LEFT,RIGHT),
																			IF(TRIM(lname_mother_clean)<>'',
																					TRIM(lname_mother_clean,LEFT,RIGHT),
																					TRIM(fname_mother_clean+' '+mname_mother_clean,LEFT,RIGHT)
																			)
																)
															));
	SELF.county_residence		:= 	IF(TRIM(pInput.residence_county) IN ['','*'],'OUT OF STATE',StringLib.StringToUpperCase(TRIM(pInput.residence_county)));
	SELF.county_death				:= 	StringLib.StringToUpperCase(TRIM(pInput.place_of_death_county));
	SELF.orig_address1			:=	TRIM(orig_address1);
	SELF.orig_address2			:=	TRIM(orig_address2);
	SELF.disposition				:=	StringLib.StringToUpperCase(TRIM(pInput.disposition_type));
	SELF.hospital_status		:= 	StringLib.StringToUpperCase(TRIM(pInput.place_of_death_type));
	SELF.certifier					:=	StringLib.StringToUpperCase(TRIM(pInput.certifier_type));
	SELF.us_armed_forces		:=	Lookup_States.lkp_fl_yes_no_unk(pInput.us_armed_forces);
	SELF.place_of_death			:=	StringLib.StringToUpperCase(
																IF(TRIM(pInput.place_of_death_city)<>'' AND TRIM(pInput.place_of_death_county)<>'',
																	TRIM(pInput.place_of_death_city)+', '+TRIM(pInput.place_of_death_county),
																	IF(TRIM(pInput.place_of_death_city)<>'', TRIM(pInput.place_of_death_city),
																		TRIM(pInput.place_of_death_county)
																	)
																)
															);
	SELF.fname							:= 	TRIM(pInput.fname);
	SELF.mname							:= 	TRIM(pInput.mname);
	SELF.lname							:= 	TRIM(pInput.lname);
	SELF.name_suffix				:= 	TRIM(pInput.name_suffix);
	SELF										:=	[];
	
END;

EXPORT Mapping_FL := PROJECT(file_in, tDeathMaster_Florida_Data_Supplement(LEFT));
