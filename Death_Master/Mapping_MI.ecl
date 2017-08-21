IMPORT HEADER, ADDRESS, UT;

file_in := Death_Master.Files.Michigan(( StringLib.StringToUpperCase(TRIM(fname)) NOT IN ['','UNKNOWN'] AND
																				 StringLib.StringToUpperCase(TRIM(lname)) NOT IN ['','UNKNOWN']));

Header.layout_death_master_supplemental tDeathMaster_Michigan_Data_Supplement(file_in pInput) := 
TRANSFORM

	// Get Address and separate into address1 and address2
	clean_state							:=	IF(Address.Map_State_Name_To_Abbrev(TRIM(pInput.state,LEFT,RIGHT))<>'',
																Address.Map_State_Name_To_Abbrev(TRIM(pInput.state,LEFT,RIGHT)),
																TRIM(pInput.state,LEFT,RIGHT));
	STRING76 orig_address1	:= 	StringLib.StringToUpperCase(TRIM(pInput.addr,LEFT,RIGHT));
	STRING76 orig_address2	:= 	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(
																IF(	TRIM(pInput.city,LEFT,RIGHT)<>'' AND clean_state<>'',
																		TRIM(pInput.city,LEFT,RIGHT)+', ',
																		TRIM(pInput.city,LEFT,RIGHT)
																)+clean_state
															));
																	

	// Convert the DOB and DOD to a common format and calculate AGE
	STRING8 clean_dob				:= 	IF(pInput.dob_yr IN ['9999','.',''], '0000', pInput.dob_yr)	+ 
															IF(pInput.dob_mth IN ['99','.',''], '00', pInput.dob_mth) +	
															IF(pInput.dob_day IN ['99','.',''], '00', pInput.dob_day);
	STRING8 clean_dod				:= 	IF(pInput.dod_yr IN ['9999','.',''], '0000', pInput.dod_yr)	+ 
															IF(pInput.dod_mth IN ['99','.',''], '00', pInput.dod_mth) + 
															IF(pInput.dod_day IN ['99','.',''], '00', pInput.dod_day);
	UNSIGNED1 clean_age			:= 	ut.Age((INTEGER) clean_dob,(INTEGER) clean_dod);		
	
	SELF.source_state  			:= 	'MI';
	SELF.decedent_sex  			:= 	IF(pInput.decedent_sex='1','MALE',IF(pInput.decedent_sex='2','FEMALE',''));
	SELF.decedent_age 			:= 	(STRING)clean_age + ' YEARS OLD';
	SELF.ssn  							:= 	pInput.ssn;
	place_of_death					:=	IF(
																LENGTH(TRIM(pInput.occurrence_state))=3,
																Death_Master.Lookup_States.lkp_mi_mdch_codes(new_mdch_code=pInput.occurrence_state)[1].country_state,
																Death_Master.Lookup_States.lkp_mi_mdch_codes(old_mdch_code=pInput.occurrence_state)[1].country_state															
															);
	SELF.place_of_death			:= 	ut.CleanSpacesAndUpper(place_of_death);
	SELF.dob 								:= 	clean_dob[5..6]+clean_dob[7..8]+clean_dob[1..4];
	SELF.dod 								:= 	clean_dod[5..6]+clean_dod[7..8]+clean_dod[1..4];
	SELF.fname							:= 	TRIM(pInput.fname);
	SELF.mname							:= 	TRIM(pInput.mname);
	SELF.lname							:= 	TRIM(pInput.lname);
	SELF.county_residence		:= 	IF(pInput.residence_county='','',StringLib.StringToUpperCase(Death_Master.Lookup_States.lkp_mi_county_codes2(cty=pInput.residence_county)[1].countyname));
	SELF.county_death				:= 	IF(pInput.occurrence_county='','',StringLib.StringToUpperCase(Death_Master.Lookup_States.lkp_mi_county_codes2(cty=pInput.occurrence_county)[1].countyname));
	SELF.orig_address1			:=	TRIM(orig_address1);
	SELF.orig_address2			:=	TRIM(orig_address2);
	SELF.father							:= 	StringLib.StringToUpperCase(TRIM(pInput.father_surname));
	SELF										:=	[];
	
END;

EXPORT Mapping_MI := PROJECT(file_in, tDeathMaster_Michigan_Data_Supplement(LEFT));
