IMPORT Death_Master,address,ut,HEADER, Std;

file_in := Death_Master.Files.Ohio(	StringLib.StringToUpperCase(TRIM(fname)) NOT IN ['','-','FNAME','UNIDENTIFIED MALE','UNKNOWN'] AND
																		StringLib.StringToUpperCase(TRIM(lname)) NOT IN ['','-','LNAME','UNIDENTIFIED MALE','UNIDENTIFIED FEMALE','UNKNOWN INDIVIDUAL','UNKNOWN']);

Header.layout_death_master_supplemental tDeathMaster_Ohio_Data_Supplement(file_in pInput) := 
TRANSFORM
																														
	// Get Address and separate into address1 and address2
	fnCleanAddressField(STRING	addrField)	:=	FUNCTION
		RETURN(IF(StringLib.StringToUpperCase(TRIM(addrField,LEFT,RIGHT)) 
							NOT IN ['NONE'],TRIM(addrField,LEFT,RIGHT),''));
	END;
	clean_address						:=	fnCleanAddressField(pInput.res_addr);
	clean_city							:=	fnCleanAddressField(pInput.res_city);
	clean_state             :=  fnCleanAddressField(pInput.res_state);
	clean_zip								:=	fnCleanAddressField(pInput.res_zip);

	STRING76 orig_address1	:= 	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(clean_address));
	STRING76 orig_address2	:= 	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(
																IF(	TRIM(clean_city)<>'' AND (clean_state<>'' OR TRIM(clean_zip,LEFT,RIGHT)<>''),
																		TRIM(clean_city)+', ',
																		TRIM(clean_city)
																)+clean_state+' '+TRIM(clean_zip,LEFT,RIGHT)
															));
	
	// Convert the DOB and DOD to a common format and calculate AGE
	fmtsin := [
		'%m/%d/%Y',
		'%Y-%m-%d',
		'%m%d%Y'
	];
	fmtout									:=	'%Y%m%d';
	STRING8 	clean_dob 		:=	Std.date.ConvertDateFormatMultiple(pInput.dob,fmtsin,fmtout);
	STRING8 	clean_dod 		:=	Std.date.ConvertDateFormatMultiple(pInput.dod,fmtsin,fmtout);
	STRING8 	clean_filed_date		:=	Std.date.ConvertDateFormatMultiple(INTFORMAT(pInput.filedate,8,1),fmtsin,fmtout);
	UNSIGNED1	clean_age 		:=	ut.Age((INTEGER) clean_dob,(INTEGER) clean_dod);		

	SELF.source_state  			:=	'OH';
	SELF.decedent_sex  			:=	IF(pInput.decedent_sex = 'M', 'MALE', IF(pInput.decedent_sex = 'F', 'FEMALE', ''));
	SELF.decedent_age 			:= 	IF(clean_dob<>'' AND clean_dod<>'',
																(STRING)clean_age+IF(clean_age=1,' YEAR OLD',' YEARS OLD'),
																''
															);
	SELF.ssn  							:=	pInput.ssn_last_4;
	SELF.birthplace 				:=	StringLib.StringToUpperCase(TRIM(pInput.birthplace));
	SELF.dob 								:=	clean_dob[5..6]+clean_dob[7..8]+clean_dob[1..4];
	SELF.dod 								:=	clean_dod[5..6]+clean_dod[7..8]+clean_dod[1..4];
	SELF.fname							:=	TRIM(pInput.fname);
	SELF.mname							:=	TRIM(pInput.mname);
	SELF.lname							:=	TRIM(pInput.lname);
	SELF.name_suffix  			:=	TRIM(pInput.name_suffix);
	SELF.filed_date					:=	clean_filed_date;
	SELF.county_residence 	:= 	IF(pInput.res_county IN ['*'],'',StringLib.StringToUpperCase(TRIM(pInput.res_county)));
	SELF.orig_address1			:=	TRIM(orig_address1);
	SELF.orig_address2			:=	TRIM(orig_address2);
	SELF 										:=	[];
END;

EXPORT Mapping_OH := PROJECT(file_in, tDeathMaster_Ohio_Data_Supplement(LEFT));
