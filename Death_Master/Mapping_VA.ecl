IMPORT HEADER, ADDRESS, UT, Std;

file_in := Death_Master.Files.Virginia(	StringLib.StringToUpperCase(TRIM(lname)) NOT IN ['','LNAME','CER_LNAME'] AND
																				StringLib.StringToUpperCase(TRIM(fname)) NOT IN ['','FNAME','CER_FNAME']);

Header.layout_death_master_supplemental tDeathMaster_Virginia_Data_Supplement(file_in pInput) := 
TRANSFORM
														
	fnCleanAddressField(STRING	addrField)	:=	FUNCTION
		RETURN(IF(StringLib.StringToUpperCase(TRIM(addrField,LEFT,RIGHT)) 
							NOT IN ['NONE','UNKNOWN','NA','N/A'],TRIM(addrField,LEFT,RIGHT),''));
	END;
	pre_clean_state					:=	fnCleanAddressField(ut.Word(pInput.address, 1,'*'));
	clean_city							:=	fnCleanAddressField(ut.Word(pInput.address, 2,'*'));
	clean_street						:=	fnCleanAddressField(ut.Word(pInput.address, 3,'*'));
	clean_zip								:=	fnCleanAddressField(pInput.zip);

	// Get Address and separate into address1 and address2
	clean_state							:=	IF(Address.Map_State_Name_To_Abbrev(TRIM(pre_clean_state,LEFT,RIGHT))<>'',
																Address.Map_State_Name_To_Abbrev(TRIM(pre_clean_state,LEFT,RIGHT)),
																TRIM(pre_clean_state,LEFT,RIGHT));
	
	STRING76 orig_address1 	:=	StringLib.StringToUpperCase(TRIM(clean_street,LEFT,RIGHT));
	STRING76 orig_address2 	:=	StringLib.StringToUpperCase(
															StringLib.StringCleanSpaces(
																IF(	clean_city<>'' AND (clean_state<>'' OR clean_zip<>''),
																		clean_city+', ',
																		clean_city
																)+clean_state+' '+clean_zip
															));
																					
	// Convert the DOB and DOD to a common format and calculate AGE
	fmtsin := [
		'%m/%d/%Y',
		'%Y-%m-%d'
	];
	fmtout:='%Y%m%d';	
	STRING8 	clean_dob 		:=	Std.date.ConvertDateFormatMultiple(pInput.dob,fmtsin,fmtout);
	STRING8 	clean_dod			:=	Std.date.ConvertDateFormatMultiple(pInput.dod,fmtsin,fmtout);
	UNSIGNED1 clean_age			:=	ut.GetAgeI_asOf((INTEGER) clean_dob,(INTEGER) clean_dod);		

	SELF.source_state  			:=	'VA';
	SELF.dob 								:=	clean_dob[5..6]+clean_dob[7..8]+clean_dob[1..4];
	SELF.dod 								:=	clean_dod[5..6]+clean_dod[7..8]+clean_dod[1..4];
	SELF.fname							:=	TRIM(pInput.fname);
	SELF.mname							:=	TRIM(pInput.mname);
	SELF.lname							:=	TRIM(pInput.lname);
	SELF.place_of_death			:=	Lookup_States.lkp_va_place_of_death(TRIM(pInput.place_of_death,ALL));
	SELF.orig_address1			:=	TRIM(orig_address1);
	SELF.orig_address2			:=	TRIM(orig_address2);
	SELF 										:=	[];
	
END;

EXPORT Mapping_VA := PROJECT(file_in, tDeathMaster_Virginia_Data_Supplement(LEFT));
