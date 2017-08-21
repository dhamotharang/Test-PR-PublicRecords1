IMPORT HEADER, ADDRESS, UT, Std;

file_in := Death_Master.Files.Nevada((	StringLib.StringToUpperCase(TRIM(fname)) NOT IN ['','UNIDENTIFIED MALE','UNIDENTIFIED FEMALE','UNKNOWN INDIVIDUAL','UNKNOWN'] AND
																				StringLib.StringToUpperCase(TRIM(lname)) NOT IN ['','UNIDENTIFIED MALE','UNIDENTIFIED FEMALE','UNKNOWN INDIVIDUAL','UNKNOWN']));

Header.layout_death_master_supplemental tDeathMaster_Nevada_Data_Supplement(file_in pInput) := 
TRANSFORM

	// Convert the DOB and DOD to a common format and calculate AGE
	fmtsin := [
		'%m/%d/%Y',
		'%Y-%m-%d'
	];
	fmtout:='%Y%m%d';	
	STRING8 	clean_dob 		:= 	Std.date.ConvertDateFormatMultiple(pInput.dob,fmtsin,fmtout);
	STRING8 	clean_dod 		:=	Std.date.ConvertDateFormatMultiple(pInput.dod,fmtsin,fmtout);
	UNSIGNED1	clean_age 		:= 	ut.Age((INTEGER) clean_dob,(INTEGER) clean_dod);		

	SELF.source_state  			:=	'NV';
	SELF.decedent_age 			:=	(STRING)clean_age + ' YEARS OLD';
	SELF.dob 								:=	clean_dob[5..6]+clean_dob[7..8]+clean_dob[1..4];
	SELF.dod 								:=	clean_dod[5..6]+clean_dod[7..8]+clean_dod[1..4];
	SELF.fname							:=	TRIM(pInput.fname);
	SELF.mname							:= 	TRIM(pInput.mname);
	SELF.lname							:=	TRIM(pInput.lname);
	SELF.name_suffix				:=	TRIM(pInput.name_suffix);
	SELF 										:=	[];
	
END;

EXPORT Mapping_NV := PROJECT(file_in, tDeathMaster_Nevada_Data_Supplement(LEFT));
