IMPORT HEADER, ADDRESS, UT, STD;

file_in := Death_Master.Files.Massachusetts((	StringLib.StringToUpperCase(TRIM(fname)) NOT IN ['','UNKNOWN','UNKNOWN INFANT 2','UNKNOWN INFANT 3','UNKNOWN INFANT','GNAME'] AND
																							StringLib.StringToUpperCase(TRIM(lname)) NOT IN ['','UNKNOWN','LNAME']));
						 
Header.layout_death_master_supplemental tDeathMaster_Massachusetts_Data_Supplement(file_in pInput) := 
TRANSFORM

	// Get Address and separate into address1 and address2
	STRING76 orig_address1 	:=	StringLib.StringToUpperCase(
															StringLib.StringCleanSpaces(
																pInput.POR_HouseNumber	+' '+
																pInput.POR_StreetPrefix	+' '+
																pInput.POR_StreetName		+' '+
																pInput.POR_StreetType		+' '+
																pInput.POR_StreetSuffix
															));
	STRING76 orig_address2 	:=	StringLib.StringToUpperCase(
															StringLib.StringCleanSpaces(
																pInput.residence_city	+
																IF(TRIM(pInput.residence_city)<>'' AND ut.st2abbrev(TRIM(pInput.residence_state))<>'',', ','')	+
																ut.st2abbrev(TRIM(pInput.residence_state))
															));

	// Convert the DOB and DOD to a common format
	// Convert the DOB and DOD to a common format and calculate AGE
	fmtsin	:=	'%m/%d/%Y';
	fmtout	:=	'%Y%m%d';
	STRING8 	clean_dob 		:=	IF(Std.Date.IsValidDate((INTEGER)Std.Date.ConvertDateFormat(pInput.dob,fmtsin,fmtout)),
																Std.Date.ConvertDateFormat(pInput.dob,fmtsin,fmtout),'');
	STRING8 	clean_dod 		:=	IF(Std.Date.IsValidDate((INTEGER)Std.Date.ConvertDateFormat(pInput.dod,fmtsin,fmtout)),
																Std.Date.ConvertDateFormat(pInput.dod,fmtsin,fmtout),'');
	INTEGER		clean_age 		:=	IF(clean_dob<>'' AND clean_dob<>'',ut.Age((UNSIGNED4) clean_dob,(UNSIGNED4) clean_dod),0);		

	SELF.source_state  			:= 	'MA';
	SELF.decedent_race			:= 	Lookup_States.lkp_ma_race(TRIM(pInput.decedent_race));
	SELF.decedent_origin		:= 	Lookup_States.lkp_ma_origin(TRIM(pInput.decedent_race));
	SELF.decedent_sex  			:= 	Lookup_States.lkp_ma_gender(pInput.sex);
	SELF.decedent_age 			:= 	IF(clean_dob<>'' AND clean_dob<>'',
																(STRING)clean_age+IF(clean_age=1,' YEAR OLD',' YEARS OLD'),
																''
															);
	SELF.dob 								:=	clean_dob[5..6]+clean_dob[7..8]+clean_dob[1..4];
	SELF.dod 								:=	clean_dod[5..6]+clean_dod[7..8]+clean_dod[1..4];
	SELF.county_residence		:= 	IF(ut.isNumeric(TRIM(pInput.residence_county)),'',TRIM(pInput.residence_county));
	SELF.fname							:= 	TRIM(pInput.fname);
	SELF.lname							:= 	TRIM(pInput.lname);
	SELF.orig_address1			:=	TRIM(orig_address1);
	SELF.orig_address2			:=	TRIM(orig_address2);
	SELF										:=	[];
	
END;

EXPORT Mapping_MA := PROJECT(file_in, tDeathMaster_Massachusetts_Data_Supplement(LEFT));
