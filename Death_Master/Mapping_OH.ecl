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
	clean_address1					:=	fnCleanAddressField(pInput.res_addr_1);
	clean_address2					:=	fnCleanAddressField(pInput.res_addr_2);
	clean_zip								:=	fnCleanAddressField(pInput.res_zip);

	STRING76 orig_address1	:= 	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(clean_address1));
	STRING76 orig_address2	:= 	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(
																IF(	clean_address1<>'' AND (clean_zip<>''),
																		clean_address2+', ',
																		clean_address2
																)+clean_zip
															));

	// Convert the DOB and DOD to a common format and calculate AGE
	fmtsin := [
		'%m/%d/%Y',
		'%Y-%m-%d'
	];
	fmtout:='%Y%m%d';
	STRING8 	clean_dob 		:=	Std.date.ConvertDateFormatMultiple(pInput.dob,fmtsin,fmtout);
	STRING8 	clean_dod 		:=	Std.date.ConvertDateFormatMultiple(pInput.dod,fmtsin,fmtout);
	UNSIGNED1	clean_age 		:=	ut.Age((INTEGER) clean_dob,(INTEGER) clean_dod);		

	SELF.source_state  			:=	'OH';
	SELF.decedent_sex  			:=	IF(pInput.decedent_sex = 'M', 'MALE', IF(pInput.decedent_sex = 'F', 'FEMALE', ''));
	SELF.decedent_age 			:=	(STRING)clean_age + ' YEARS OLD';
	SELF.ssn  							:=	pInput.ssn_last_4;
	SELF.birthplace 				:=	StringLib.StringToUpperCase(TRIM(pInput.birthplace));
	SELF.dob 								:=	clean_dob[5..6]+clean_dob[7..8]+clean_dob[1..4];
	SELF.dod 								:=	clean_dod[5..6]+clean_dod[7..8]+clean_dod[1..4];
	SELF.fname							:=	TRIM(pInput.fname);
	SELF.mname							:=	TRIM(pInput.mname);
	SELF.lname							:=	TRIM(pInput.lname);
	SELF.name_suffix  			:=	TRIM(pInput.name_suffix);
	SELF.county_residence 	:= 	IF(pInput.res_county IN ['*'],'',StringLib.StringToUpperCase(TRIM(pInput.res_county)));
	SELF.orig_address1			:=	TRIM(orig_address1);
	SELF.orig_address2			:=	TRIM(orig_address2);
	SELF 										:=	[];
END;

EXPORT Mapping_OH := PROJECT(file_in, tDeathMaster_Ohio_Data_Supplement(LEFT));
