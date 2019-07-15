IMPORT HEADER, ADDRESS, NID,	STD,	ut;

// We only want records with First and Last names
file_in := Death_Master.Files.California((	StringLib.StringToUpperCase(TRIM(fname)) NOT IN ['','-','UNIDENTIFIED MALE','UNIDENTIFIED FEMALE','UNKNOWN INDIVIDUAL','UNKNOWN','FIRSTNAME','FIRST_NAME'] AND
																						StringLib.StringToUpperCase(TRIM(lname)) NOT IN ['','-','ZZ','UNIDENTIFIED MALE','UNIDENTIFIED FEMALE','UNKNOWN INDIVIDUAL','UNKNOWN','LASTNAME','LAST_NAME']));

// Transform the state layout to the common supplemental death master layout
Header.layout_death_master_supplemental tDeathMaster_California_Data_Supplement(file_in pInput) := 
TRANSFORM
																																																					
	// Clean Address Field.
	fnCleanAddressField(STRING	addrField)	:=	FUNCTION
		RETURN(IF(StringLib.StringToUpperCase(TRIM(addrField,LEFT,RIGHT)) 
							NOT IN ['','-','--','---','----','-----','UNK','PENDING','- PENDING','UNKNOWN','UNKNOWN UNKNOWN'],TRIM(addrField,LEFT,RIGHT),''));
	END;

	pre_clean_POB_StateOrCountry	:=	fnCleanAddressField(STD.Str.FilterOut(pInput.POB_StateOrCountry,'0123456789\'./`'));
	clean_POB_StateOrCountry			:=	IF(Address.Map_State_Name_To_Abbrev(TRIM(pre_clean_POB_StateOrCountry,LEFT,RIGHT))<>'',
																				Address.Map_State_Name_To_Abbrev(TRIM(pre_clean_POB_StateOrCountry,LEFT,RIGHT)),
																				TRIM(pre_clean_POB_StateOrCountry,LEFT,RIGHT));
	clean_POD_StreetNumber				:=	fnCleanAddressField(pInput.POD_StreetNumber);
	clean_POD_StreetAddress				:=	fnCleanAddressField(pInput.POD_StreetAddress);
	clean_POD_City								:=	fnCleanAddressField(pInput.POD_City);
	clean_POD_address_1						:=	Address.fn_addr_clean_prep(clean_POD_StreetNumber+' '+clean_POD_StreetAddress,'first');
	clean_POD_address_2						:=	Address.fn_addr_clean_prep(IF(TRIM(clean_POD_City,ALL)<>'',clean_POD_City+', CA','CA'),'last');

	// Convert the DOB and DOD to a common format and calculate AGE
	fmtsin_dob := '%m/%d/%Y'; // Ex. 6/7/2018
	fmtsin_dod := '%m/%d/%y'; // Ex. 6/7/18
	fmtout					:=	'%Y%m%d';
	STRING8 	clean_dob 		:=	Std.date.ConvertDateFormat(pInput.dob,fmtsin_dob,fmtout);
	//	California may send in two digit year (1/1/15) so we add 20 to the beginning
	STRING8 	clean_dod 		:= 	IF((UNSIGNED)Std.date.ConvertDateFormat(pInput.dod,fmtsin_dod,fmtout)<999999,
															'20'+Std.date.ConvertDateFormat(pInput.dod,fmtsin_dod,fmtout),
															Std.date.ConvertDateFormat(pInput.dod,fmtsin_dod,fmtout));
	UNSIGNED1	clean_age 		:=	ut.Age((INTEGER) clean_dob,(INTEGER) clean_dod);		
	
	SELF.source_state  			:=	'CA';
	SELF.decedent_sex				:= 	Lookup_States.lkp_ca_gender(StringLib.StringToUpperCase(pInput.gender));
	SELF.decedent_age 			:= 	IF(clean_dob<>'' AND clean_dod<>'',
																(STRING)clean_age+IF(clean_age=1,' YEAR OLD',' YEARS OLD'),
																''
															);
	SELF.birthplace					:=	clean_POB_StateOrCountry;
	SELF.dob 								:=	clean_dob[5..6]+clean_dob[7..8]+clean_dob[1..4];
	SELF.dod 								:=	clean_dod[5..6]+clean_dod[7..8]+clean_dod[1..4];
	SELF.fname							:=	TRIM(pInput.fname);
	SELF.mname							:=	TRIM(pInput.mname);
	SELF.lname							:=	TRIM(pInput.lname);
	lname_father_clean			:=	IF(TRIM(pInput.lname_father,ALL)[1..3] IN ['','-','--','---','UNK'],'',TRIM(pInput.lname_father,LEFT,RIGHT));
	SELF.father							:=	ut.CleanSpacesAndUpper(NID.CleanPerson73(lname_father_clean));
	county_death_clean			:=	IF(TRIM(pInput.POD_County,ALL)[1..3] IN ['','-','--','---','UNK'],'',TRIM(pInput.POD_County,LEFT,RIGHT));
	SELF.county_death				:=	ut.CleanSpacesAndUpper(county_death_clean+' COUNTY');
	SELF.facility_death			:=	ut.CleanSpacesAndUpper(pInput.POD_Facility_Name_Location);
	SELF.place_of_death			:=	ut.CleanSpacesAndUpper(
																STD.Str.FilterOut(
																	IF(TRIM(clean_POD_address_1,ALL)<>'',clean_POD_address_1+', ','')+
																	clean_POD_address_2
																,'"`')	// Remove unwanted characters
															);
	SELF										:=	[];
	
END;

EXPORT Mapping_CA := PROJECT(file_in, tDeathMaster_California_Data_Supplement(LEFT));
