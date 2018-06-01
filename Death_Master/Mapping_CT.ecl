IMPORT HEADER, ADDRESS, UT, Std;

file_in := Death_Master.Files.Connecticut(TRIM(DOD_Yr,ALL)<>'' AND ut.isNumeric(TRIM(DOD_Yr,ALL)));


Header.layout_death_master_supplemental tDeathMaster_Connecticut_Data_Supplement(file_in pInput) := 
TRANSFORM

	// Get Address and separate into address1 and address2
	StateOrCountry					:=	Death_Master.Lookup_States.lkp_ct_state_country(pInput.POR_StateOrCountry);
	clean_state							:=	IF(Address.Map_State_Name_To_Abbrev(StateOrCountry)<>'',
																Address.Map_State_Name_To_Abbrev(StateOrCountry),
																StateOrCountry);

	fnCleanAddressField(STRING	addrField)	:=	FUNCTION
		RETURN(IF(StringLib.StringToUpperCase(TRIM(addrField,LEFT,RIGHT)) 
							NOT IN ['UNOBTAINABLE','UNAVAILABLE','UNKNOWN','NA','N/A'],TRIM(addrField,LEFT,RIGHT),''));
	END;
	clean_housenumber				:=	fnCleanAddressField(pInput.POR_HouseNumber);
	clean_streetname				:=	fnCleanAddressField(pInput.POR_StreetName);
	clean_streettype				:=	fnCleanAddressField(pInput.POR_StreetType);
	clean_apartmentnumber		:=	fnCleanAddressField(pInput.POR_ApartmentNumber);
	clean_town							:=	IF(clean_state='CT',
																Death_Master.Lookup_States.ct_county_town_codes(town_code=INTFORMAT(pInput.POR_Town_FIPS,5,1))[1].town_name,
																Address.City_names(state_alpha=clean_state AND city_code=INTFORMAT(pInput.POR_Town_FIPS,5,1))[1].city_name
															);
	clean_zip								:=	IF(pInput.POR_Zip=0,'',INTFORMAT(pInput.POR_Zip,5,1));

	STRING76 orig_address1 	:=	ut.CleanSpacesAndUpper(
																clean_housenumber+' '+
																clean_streetname+' '+
																clean_streettype+' '+
																clean_apartmentnumber
															);
	STRING76 orig_address2 	:=	ut.CleanSpacesAndUpper(
																IF(	clean_town<>'' AND (clean_state<>'' OR clean_zip<>''),
																		clean_town+', ',
																		clean_town
																)+clean_state+' '+clean_zip
															);

	// Convert the DOB and DOD to a common format
	fmtsin := [
		'%m%d%Y'
	];
	fmtout:='%Y%m%d';
	// Convert the DOB and DOD to a common format
	STRING8		clean_dob 		:= 	IF(TRIM(pInput.dob_yr,ALL) IN ['0000',''],'',
																	IF(TRIM(pInput.dob_mth,ALL) IN ['00',''], '', TRIM(pInput.dob_mth,ALL)) +
																	IF(TRIM(pInput.dob_day,ALL) IN ['00',''], '', TRIM(pInput.dob_day,ALL)) +
																	pInput.dob_yr);
	STRING8		clean_dod 		:= 	IF(TRIM(pInput.dod_yr,ALL) IN ['0000',''],'',
																	IF(TRIM(pInput.dod_mth,ALL) IN ['00',''], '', TRIM(pInput.dod_mth,ALL)) +
																	IF(TRIM(pInput.dod_day,ALL) IN ['00',''], '', TRIM(pInput.dod_day,ALL)) +
																	TRIM(pInput.dod_yr,ALL));
	STRING8		clean_filed_date	:=	Std.date.ConvertDateFormatMultiple(INTFORMAT(pInput.DateRecordedModified,8,1),fmtsin,fmtout);
	// STRING8		clean_injury_date	:=	Std.date.ConvertDateFormatMultiple(INTFORMAT(pInput.DateOfInjury,8,1),fmtsin,fmtout);
	
	SELF.source_state  			:= 	'CT';
	SELF.decedent_race			:=	Lookup_States.lkp_ct_race(pInput.race);
	SELF.decedent_sex				:= 	Lookup_States.lkp_ct_gender(pInput.sex);
	SELF.decedent_age 			:= 	Lookup_States.lkp_ct_age(TRIM(pInput.AgeUnit,ALL),TRIM(pInput.AgeUnit_NumberOfUnits[2..],ALL));
	SELF.dob 								:= 	clean_dob;
	SELF.dod 								:= 	clean_dod;
	SELF.birthplace					:=	ut.CleanSpacesAndUpper(	
																IF(pInput.POB_Town_FIPS IN [0,99999],
																	Death_Master.Lookup_States.lkp_ct_state_country(pInput.POB_StateOrCountry),
																	IF(pInput.POB_StateOrCountry=0,'',
																		Death_Master.Lookup_States.ct_county_town_codes(town_code=INTFORMAT(pInput.POB_Town_FIPS,5,1))[1].town_name+', '+
																		Death_Master.Lookup_States.lkp_ct_state_country(pInput.POB_StateOrCountry)
																	)
																)
															);
	SELF.marital_status 		:= 	Lookup_States.lkp_ct_marital_status(pInput.maritalstatus);
	SELF.father							:= 	IF(StringLib.StringToUpperCase(TRIM(pInput.lname_father,LEFT,RIGHT)) = 'NOT AVAILABLE','',StringLib.StringToUpperCase(TRIM(pInput.lname_father,LEFT,RIGHT)));
	SELF.filed_date					:=	clean_filed_date;
	SELF.county_residence		:=	Address.County_Names(state_alpha=clean_state AND county_code=INTFORMAT(pInput.POR_County_FIPS,3,1))[1].county_name;
	SELF.county_death				:=	Address.County_Names(state_alpha=pInput.POD_State_FIPS AND county_code=INTFORMAT(pInput.POD_County_FIPS,3,1))[1].county_name;
	SELF.orig_address1			:=	TRIM(orig_address1);
	SELF.orig_address2			:=	TRIM(orig_address2);
	SELF.autopsy						:= 	Lookup_States.lkp_ct_autopsy(pInput.autopsy);
	SELF.med_exam						:= 	Lookup_States.lkp_ct_med_exam(pInput.MedicalExaminerContacted);
	SELF.disposition				:=	Lookup_States.lkp_ct_disposition(TRIM(pInput.MethodOfDisposition,ALL));
	SELF.work_injury				:= 	Lookup_States.lkp_ct_work_injury(pInput.InjuryAtWork);
	// SELF.injury_date				:=	clean_injury_date;
	// SELF.injury_type				:=	ut.CleanSpacesAndUpper(pInput.PlaceOfInjury);
	SELF.hospital_status		:=	Lookup_States.lkp_ct_hospital_status(pInput.HospitalStatus);
	SELF.pregnancy					:=	Lookup_States.lkp_ct_Pregnancy(pInput.Pregnancy);
	SELF.death_type					:=	Lookup_States.lkp_ct_death_type(pInput.MannerOfDeath);

	
	
	SELF.place_of_death			:=	ut.CleanSpacesAndUpper(
																IF(pInput.Hospital IN [0,90,91,94,95,96,97,98,99],'',TRIM(Lookup_States.lkp_ct_hospital_name(pInput.Hospital))+', ')+
																IF(pInput.POD_State_FIPS='CT',
																	Death_Master.Lookup_States.ct_county_town_codes(town_code=INTFORMAT(pInput.POD_Town_FIPS,5,1))[1].town_name+
																	', '+pInput.POD_State_FIPS+
																	IF(pInput.POD_Zip=0,'',' '+INTFORMAT(pInput.POD_Zip,5,1)),
																	''
																)																
															);
	SELF.underlying_cause_of_death	:=	ut.CleanSpacesAndUpper(
																				TRIM(pInput.COD1)+
																				IF(TRIM(pInput.COD2)<>'',';'+TRIM(pInput.COD2),'')+
																				IF(TRIM(pInput.COD3)<>'',';'+TRIM(pInput.COD3),'')+
																				IF(TRIM(pInput.COD4)<>'',';'+TRIM(pInput.COD4),'')+
																				IF(TRIM(pInput.COD5)<>'',';'+TRIM(pInput.COD5),'')+
																				IF(TRIM(pInput.COD6)<>'',';'+TRIM(pInput.COD6),'')+
																				IF(TRIM(pInput.COD7)<>'',';'+TRIM(pInput.COD7),'')+
																				IF(TRIM(pInput.COD8)<>'',';'+TRIM(pInput.COD8),'')+
																				IF(TRIM(pInput.COD9)<>'',';'+TRIM(pInput.COD9),'')+
																				IF(TRIM(pInput.COD10)<>'',';'+TRIM(pInput.COD10),'')+
																				IF(TRIM(pInput.COD11)<>'',';'+TRIM(pInput.COD11),'')+
																				IF(TRIM(pInput.COD12)<>'',';'+TRIM(pInput.COD12),'')+
																				IF(TRIM(pInput.COD13)<>'',';'+TRIM(pInput.COD13),'')+
																				IF(TRIM(pInput.COD14)<>'',';'+TRIM(pInput.COD14),'')+
																				IF(TRIM(pInput.COD15)<>'',';'+TRIM(pInput.COD15),'')+
																				IF(TRIM(pInput.COD16)<>'',';'+TRIM(pInput.COD16),'')+
																				IF(TRIM(pInput.COD17)<>'',';'+TRIM(pInput.COD17),'')+
																				IF(TRIM(pInput.COD18)<>'',';'+TRIM(pInput.COD18),'')+
																				IF(TRIM(pInput.COD19)<>'',';'+TRIM(pInput.COD19),'')+
																				IF(TRIM(pInput.COD20)<>'',';'+TRIM(pInput.COD20),'')
																			);

	SELF.fname							:= 	TRIM(pInput.fname);
	SELF.mname							:= 	TRIM(pInput.mname);
	SELF.lname							:= 	TRIM(pInput.lname);
	SELF.statefn					:=		(STRING)pInput.StateFN;
	SELF										:=	[];
	
END;

EXPORT Mapping_CT :=	PROJECT(file_in, tDeathMaster_Connecticut_Data_Supplement(LEFT));