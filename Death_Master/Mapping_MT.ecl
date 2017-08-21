IMPORT HEADER, ADDRESS, UT;

file_in := Death_Master.Files.Montana((	StringLib.StringToUpperCase(TRIM(fname)) NOT IN ['','UNIDENTIFIED MALE','UNIDENTIFIED FEMALE','UNKNOWN INDIVIDUAL','UNKNOWN'] AND
																				StringLib.StringToUpperCase(TRIM(lname)) NOT IN ['','UNIDENTIFIED MALE','UNIDENTIFIED FEMALE','UNKNOWN INDIVIDUAL','UNKNOWN']));
						 
Header.layout_death_master_supplemental tDeathMaster_Montana_Data_Supplement(file_in pInput) := 
TRANSFORM

	// Get Address and separate into address1 and address2
	STRING76 orig_address1	:=	StringLib.StringToUpperCase(TRIM(IF(pInput.addr_1='.','',pInput.addr_1),LEFT,RIGHT)+' '+
																													TRIM(IF(pInput.addr_2='.','',pInput.addr_2),LEFT,RIGHT));
	STRING76 orig_address2	:=	StringLib.StringToUpperCase(TRIM(pInput.city,LEFT,RIGHT)+', '+
																ut.St2Abbrev(StringLib.StringToUpperCase(TRIM(pInput.state,LEFT,RIGHT)))+' '+TRIM(pInput.zip,LEFT,RIGHT));

	// Convert the DOB and DOD to a common format and calculate AGE
	STRING8		clean_dob 		:= 	IF(pInput.dob_yr IN ['9999','.',''], '0000', pInput.dob_yr)	+ 
															IF(pInput.dob_mth IN ['99','.',''], '00', pInput.dob_mth) +	
															IF(pInput.dob_day IN ['99','.',''], '00', pInput.dob_day);
	STRING8		clean_dod 		:= 	IF(pInput.dod_yr IN ['9999','.',''], '0000', pInput.dod_yr)	+ 
															IF(pInput.dod_mth IN ['99','.',''], '00', pInput.dod_mth) + 
															IF(pInput.dod_day IN ['99','.',''], '00', pInput.dod_day);
	UNSIGNED1 clean_age			:= 	ut.Age((INTEGER) clean_dob,(INTEGER) clean_dod);		

	SELF.source_state  			:= 	'MT';
	SELF.decedent_sex  			:= 	StringLib.StringToUpperCase(TRIM(pInput.gender));
	SELF.decedent_age 			:= 	(STRING)clean_age + ' YEARS OLD';
	SELF.ssn  							:= 	pInput.ssn;
	SELF.place_of_death			:= 	StringLib.StringToUpperCase(TRIM(pInput.state));
	SELF.dob 								:= 	clean_dob[5..6]+clean_dob[7..8]+clean_dob[1..4];
	SELF.dod 								:= 	clean_dod[5..6]+clean_dod[7..8]+clean_dod[1..4];
	SELF.fname							:= 	TRIM(pInput.fname);
	SELF.mname							:= 	TRIM(pInput.mname);
	SELF.lname							:= 	TRIM(pInput.lname);
	SELF.county_residence 	:= 	StringLib.StringToUpperCase(IF(pInput.county = 'NOT STATED','',TRIM(pInput.county)));
	SELF.orig_address1			:=	TRIM(orig_address1);
	SELF.orig_address2			:=	TRIM(orig_address2);
	SELF 										:=	[];
	
END;

EXPORT Mapping_MT := PROJECT(file_in, tDeathMaster_Montana_Data_Supplement(LEFT));

