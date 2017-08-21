IMPORT HEADER, ADDRESS, UT;

file_in := Death_Master.Files.NorthCarolina(TRIM(lname)<>'');
						 
Header.layout_death_master_supplemental tDeathMaster_NorthCarolina_Data_Supplement(file_in pInput) := 
TRANSFORM

	// Get Address and separate into address1 and address2
	fnCleanAddressField(STRING	addrField)	:=	FUNCTION
		RETURN(IF(StringLib.StringToUpperCase(TRIM(addrField,LEFT,RIGHT)) 
							NOT IN ['','-','UNK','PENDING','- PENDING','UNKNOWN','UNKNOWN UNKNOWN'],TRIM(addrField,LEFT,RIGHT),''));
	END;
	clean_state							:=	IF(TRIM(pInput.POR_State,LEFT,RIGHT) IN ['XX','ZZ'],'',
																IF(Address.Map_State_Name_To_Abbrev(TRIM(pInput.POR_State,LEFT,RIGHT))<>'',
																	Address.Map_State_Name_To_Abbrev(TRIM(pInput.POR_State,LEFT,RIGHT)),
																	TRIM(pInput.POR_State,LEFT,RIGHT))
															);
	clean_city							:=	fnCleanAddressField(pInput.POR_City_Literal);

	STRING76 orig_address1 	:=	ut.CleanSpacesAndUpper(
																TRIM(pInput.POR_StreetNumber)+' '+
																TRIM(pInput.POR_PreDirection)+' '+
																TRIM(pInput.POR_StreetName)+' '+
																TRIM(pInput.POR_StreetSuffix)+' '+
																TRIM(pInput.POR_PostDirection)+' '+
																TRIM(pInput.POR_ApartmentNumber)
															);
	STRING76 orig_address2	:= 	ut.CleanSpacesAndUpper(
																IF(	clean_city<>'' AND (clean_state<>'' OR pInput.POR_zip<>''),
																		clean_city+', ',
																		clean_city
																)+clean_state+' '+pInput.POR_zip+
																// Address may be outside of US or Canada
																IF(pInput.POR_Country NOT IN ['CA','US'],
																	' '+Death_Master.Lookup_States.lkp_nc_country_codes(country_code=pInput.POR_Country)[1].country_name,
																	''
																)
															);

	// Convert the DOB and DOD to a common format
	STRING8		clean_dob 				:= 	IF(TRIM(pInput.dob_yr,ALL) IN ['0000','9999',''],'',
																		IF(TRIM(pInput.dob_mth,ALL) IN ['0','00','99',''], '', INTFORMAT((UNSIGNED)pInput.dob_mth,2,1)) +
																		IF(TRIM(pInput.dob_day,ALL) IN ['0','00','99',''], '', INTFORMAT((UNSIGNED)pInput.dob_day,2,1)) +
																		pInput.dob_yr);
	STRING8		clean_dod 				:= 	IF(TRIM(pInput.dod_yr,ALL) IN ['0000','9999',''],'',
																		IF(TRIM(pInput.dod_mth,ALL) IN ['0','00','99',''], '', INTFORMAT((UNSIGNED)pInput.dod_mth,2,1)) +
																		IF(TRIM(pInput.dod_day,ALL) IN ['0','00','99',''], '', INTFORMAT((UNSIGNED)pInput.dod_day,2,1)) +
																		TRIM(pInput.dod_yr,ALL));
	// Convert Filed Date to YYYYMMDD and filter invalid dates.
	STRING8		clean_filed_date	:= 	IF(TRIM(pInput.local_registrar_filedate_year,ALL) IN ['0000','9999',''],'',
																		TRIM(pInput.local_registrar_filedate_year,ALL))	+
																		IF(TRIM(pInput.local_registrar_filedate_mth,ALL) IN ['0','00','99',''], '', INTFORMAT((UNSIGNED)pInput.local_registrar_filedate_mth,2,1)) +
																		IF(TRIM(pInput.local_registrar_filedate_day,ALL) IN ['0','00','99',''], '', INTFORMAT((UNSIGNED)pInput.local_registrar_filedate_day,2,1));
	STRING		POB_County		:=	Death_Master.Lookup_States.lkp_nc_county_codes(state_code=pInput.POB_State AND county_code=pInput.POB_County)[1].county_name;
	STRING		POR_County		:=	Death_Master.Lookup_States.lkp_nc_county_codes(state_code=pInput.POR_State AND county_code=pInput.POR_County)[1].county_name;
	STRING		POD_County		:=	Death_Master.Lookup_States.lkp_nc_county_codes(state_code=pInput.POR_State AND county_code=pInput.Facility_County)[1].county_name;

	// Fill Race according to UNITED STATES CENSUS 2000 POPULATION WITH BRIDGED RACE CATEGORIES
	race1	:=	IF(	pInput.Race_American_Indian_or_Alaska_Native='Y',
								'AMERICAN INDIAN OR ALASKA NATIVE','');
	race2	:=	race1+
						IF(	pInput.Race_Asian_Indian	=	'Y'	OR
								pInput.Race_Chinese	=	'Y'	OR
								pInput.Race_Filipino	=	'Y'	OR
								pInput.Race_Japanese	=	'Y'	OR
								pInput.Race_Korean	=	'Y'	OR
								pInput.Race_Vietnamese	=	'Y'	OR
								pInput.Race_Other_Asian	=	'Y',
								IF(race1<>'',
									'; ASIAN',
									'ASIAN'
								),'');
	race3	:=	race2+
						IF(	pInput.Race_African_American='Y',
								IF(race2<>'',
									'; BLACK OR AFRICAN AMERICAN',
									'BLACK OR AFRICAN AMERICAN'
								),'');
	race4	:=	race3+
						IF(	pInput.Race_Native_Hawaiian	=	'Y'	OR
								pInput.Race_Guamanian_or_Chamorro	=	'Y'	OR
								pInput.Race_Samoan	=	'Y'	OR
								pInput.Race_Other_Pacific_Islander	=	'Y',
								IF(race3<>'',
									'; NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER',
									'NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER'
								),'');
	race5	:=	race4+
						IF(	pInput.Race_White='Y',
								IF(race4<>'',
									'; WHITE',
									'WHITE'
								),'');
	race	:=	race5+
						IF(	pInput.Race_Other='Y',
								IF(race5<>'',
									'; OTHER',
									'OTHER'
								),'');
	SELF.decedent_race			:=	race;
	
	// Fill Origin according to UNITED STATES CENSUS 2000 POPULATION WITH BRIDGED RACE CATEGORIES
	// Combine all the origins
	dOrigins		:=	DATASET([
								{IF(pInput.Hispanic_Origin_Mexican='H','MEXICAN','')},
								{IF(pInput.Hispanic_Origin_PuertoRican	=	'H','PUERTO RICAN','')},
								{IF(pInput.Hispanic_Origin_Cuban	=	'H','CUBAN','')},
								{IF(TRIM(pInput.Hispanic_Origin_Other_Literal,LEFT,RIGHT) <>	''
										,TRIM(pInput.Hispanic_Origin_Other_Literal,LEFT,RIGHT),
										IF(	pInput.Hispanic_Origin_Other	=	'H',
												'HISPANIC',''	))},
								{IF(pInput.Race_Chinese								=	'Y','CHINESE','')},
								{IF(pInput.Race_Filipino							=	'Y','FILIPINO','')},
								{IF(pInput.Race_Japanese							=	'Y','JAPANESE','')},
								{IF(pInput.Race_Korean								=	'Y','KOREAN','')},
								{IF(pInput.Race_Vietnamese						=	'Y','VIETNAMESE','')},
								{IF(pInput.Race_Native_Hawaiian				=	'Y','HAWAIIAN','')},
								{IF(pInput.Race_Guamanian_or_Chamorro	=	'Y','GUAMANIAN OR CHAMORRO','')},
								{IF(pInput.Race_Samoan								=	'Y','SAMOAN','')},
								{IF(pInput.Race_American_Indian_or_Alaska_Native	=	'Y'	AND
										TRIM(pInput.Race_First_American_Indian_or_Alaska_Native_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_First_American_Indian_or_Alaska_Native_Literal,LEFT,RIGHT),'' )},
								{IF(pInput.Race_American_Indian_or_Alaska_Native	=	'Y'	AND
										TRIM(pInput.Race_Second_American_Indian_or_Alaska_Native_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_Second_American_Indian_or_Alaska_Native_Literal,LEFT,RIGHT),'' )},
								{IF(pInput.Race_Other_Asian	=	'Y'	AND
										TRIM(pInput.Race_First_Other_Asian_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_First_Other_Asian_Literal,LEFT,RIGHT),'' )},
								{IF(pInput.Race_Other_Asian	=	'Y'	AND
										TRIM(pInput.Race_Second_Other_Asian_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_Second_Other_Asian_Literal,LEFT,RIGHT),'' )},
								{IF(pInput.Race_Other_Pacific_Islander	=	'Y'	AND
										TRIM(pInput.Race_First_Other_Pacific_Islander_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_First_Other_Pacific_Islander_Literal,LEFT,RIGHT),'' )},
								{IF(pInput.Race_Other_Pacific_Islander	=	'Y'	AND
										TRIM(pInput.Race_Second_Other_Pacific_Islander_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_Second_Other_Pacific_Islander_Literal,LEFT,RIGHT),'' )},
								{IF(pInput.Race_Other	=	'Y'	AND
										TRIM(pInput.Race_First_Other_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_First_Other_Literal,LEFT,RIGHT),'' )},
								{IF(pInput.Race_Other	=	'Y'	AND
										TRIM(pInput.Race_Second_Other_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_Second_Other_Literal,LEFT,RIGHT),'' )}
								],{STRING	origin});
								
	dOrigins	tCombineOrigins(dOrigins	l, dOrigins	r)	:=	TRANSFORM
		SELF.origin	:=	IF(l.origin<>'',l.origin+'; '+r.origin,r.origin);
	END;
	// Remove blanks and duplicates and then concatinate
	combined_origins	:=	ITERATE(DEDUP(SORT(dOrigins(origin NOT IN ['','-','NA','N/A']),origin),ALL),tCombineOrigins(LEFT,RIGHT));
	
	SELF.decedent_origin		:=	combined_origins[COUNT(combined_origins)].origin;
	SELF.source_state  			:= 	'NC';
	SELF.decedent_sex				:= 	Lookup_States.lkp_nc_gender(pInput.gender);
	SELF.decedent_age 			:= 	Lookup_States.lkp_nc_age(pInput.age_code,pInput.age_units);
	SELF.education		 			:= 	Lookup_States.lkp_nc_education(pInput.education);
	SELF.cause							:=	Lookup_States.lkp_nc_manner_of_death(pInput.MannerOfDeath);
	SELF.ssn  							:= 	pInput.ssn;
	SELF.dob 								:= 	clean_dob;
	SELF.dod 								:= 	clean_dod;
	SELF.birthplace					:=	StringLib.StringCleanSpaces(
																IF(pInput.POB_Country<>'US',Death_Master.Lookup_States.lkp_nc_country_codes(country_code=pInput.POB_Country)[1].country_name,
																	IF(POB_County='','',TRIM(POB_County)+
																		IF(pInput.POB_State='','',', '+pInput.POB_State)))
															);
	SELF.marital_status			:= 	Lookup_States.lkp_nc_marital_status(pInput.MaritalStatus);
	SELF.father							:=	ut.CleanSpacesAndUpper(
																IF(	(TRIM(pInput.lname_father)<>'') AND 
																		(TRIM(pInput.fname_father)<>'' OR TRIM(pInput.mname_father)<>''),
																			TRIM(pInput.lname_father)+', '+
																			TRIM(pInput.fname_father+' '+pInput.mname_father,LEFT,RIGHT),
																			IF(TRIM(pInput.lname_father)<>'',
																				TRIM(pInput.lname_father)+' ',
																				TRIM(pInput.fname_father+' '+pInput.mname_father,LEFT,RIGHT)
																			)
																)
															);
	SELF.mother							:=	ut.CleanSpacesAndUpper(
																IF(	TRIM(pInput.lname_mother)<>'' AND 
																	 (TRIM(pInput.fname_mother)<>'' OR TRIM(pInput.mname_mother)<>''),
																			TRIM(pInput.lname_mother,LEFT,RIGHT)+', '+
																			TRIM(pInput.fname_mother+' '+pInput.mname_mother,LEFT,RIGHT),
																			IF(TRIM(pInput.lname_mother)<>'',
																				TRIM(pInput.lname_mother,LEFT,RIGHT),
																				TRIM(pInput.fname_mother+' '+pInput.mname_mother,LEFT,RIGHT)
																			)
																)
															);
	SELF.filed_date					:=	clean_filed_date;
	SELF.county_residence		:=	POR_County;
	SELF.county_death				:=	POD_County;
	SELF.orig_address1			:=	TRIM(orig_address1);
	SELF.orig_address2			:=	TRIM(orig_address2);
	SELF.autopsy						:=	Lookup_States.lkp_nc_yes_no_unk(pInput.autopsy);
	SELF.autopsy_findings		:=	Lookup_States.lkp_nc_yes_no_unk(pInput.AutopsyFindingsAvailable);
	SELF.disposition				:=	Lookup_States.lkp_nc_disposition(pInput.MethodOfDisposition);
	SELF.disposition_date		:=	SELF.filed_date;
	SELF.work_injury				:=	Lookup_States.lkp_nc_yes_no_unk(pInput.InjuryAtWork);
	SELF.injury_location		:=	Lookup_States.lkp_nc_injury_location(pInput.place_of_injury);
	SELF.hospital_status		:=	Lookup_States.lkp_nc_hospital_status(pInput.PlaceOfDeath);
	SELF.pregnancy					:=	Lookup_States.lkp_nc_pregnancy(TRIM(pInput.Pregnancy,ALL));
	SELF.facility_death			:=	pInput.Facility_Name;
	SELF.death_type					:=	SELF.cause;
	SELF.certifier					:=	Lookup_States.lkp_nc_certifier(pInput.cert_code);
	SELF.place_of_death			:=	ut.CleanSpacesAndUpper(
																IF(TRIM(Lookup_States.lkp_nc_place_codes(state_code=pInput.POD_State AND place_code=pInput.Facility_City)[1].place_name)<>'',
																Lookup_States.lkp_nc_place_codes(state_code=pInput.POD_State AND place_code=pInput.Facility_City)[1].place_name+
																', '+pInput.POD_State,pInput.POD_State)
															);
	SELF.us_armed_forces		:=	Lookup_States.lkp_nc_yes_no_unk(TRIM(pInput.Veteran_Flag,LEFT,RIGHT));
	SELF.primary_cause_of_death			:=	ut.CleanSpacesAndUpper(pInput.acme_underlying_cause_of_death);
	SELF.underlying_cause_of_death	:=	ut.CleanSpacesAndUpper(
																				IF(TRIM(pInput.icd10_manual_underlying_cause_of_death)<>'',TRIM(pInput.icd10_manual_underlying_cause_of_death),'')+
																				IF((TRIM(pInput.icd10_manual_underlying_cause_of_death)<>'' AND
																						TRIM(pInput.icd10_manual_underlying_cause_of_death)<>TRIM(pInput.first_mentioned_cause_of_death))
																							,';'+TRIM(pInput.first_mentioned_cause_of_death)
																							,IF(TRIM(pInput.icd10_manual_underlying_cause_of_death)='' AND
																									TRIM(pInput.first_mentioned_cause_of_death)<>''
																									,TRIM(pInput.first_mentioned_cause_of_death)
																									,''))+
																				IF(TRIM(pInput.second_mentioned_cause_of_death)<>'',			';'+TRIM(pInput.second_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.third_mentioned_cause_of_death)<>'',				';'+TRIM(pInput.third_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.fourth_mentioned_cause_of_death)<>'',			';'+TRIM(pInput.fourth_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.fifth_mentioned_cause_of_death)<>'',				';'+TRIM(pInput.fifth_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.sixth_mentioned_cause_of_death)<>'',				';'+TRIM(pInput.sixth_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.seventh_mentioned_cause_of_death)<>'',			';'+TRIM(pInput.seventh_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.eighth_mentioned_cause_of_death)<>'',			';'+TRIM(pInput.eighth_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.ninth_mentioned_cause_of_death)<>'',				';'+TRIM(pInput.ninth_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.tenth_mentioned_cause_of_death)<>'',				';'+TRIM(pInput.tenth_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.eleventh_mentioned_cause_of_death)<>'',		';'+TRIM(pInput.eleventh_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.twelfth_mentioned_cause_of_death)<>'',			';'+TRIM(pInput.twelfth_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.thirteenth_mentioned_cause_of_death)<>'',	';'+TRIM(pInput.thirteenth_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.fourteenth_mentioned_cause_of_death)<>'',	';'+TRIM(pInput.fourteenth_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.fifteenth_mentioned_cause_of_death)<>'',		';'+TRIM(pInput.fifteenth_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.sixteenth_mentioned_cause_of_death)<>'',		';'+TRIM(pInput.sixteenth_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.seventeenth_mentioned_cause_of_death)<>'',	';'+TRIM(pInput.seventeenth_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.eighteenth_mentioned_cause_of_death)<>'',	';'+TRIM(pInput.eighteenth_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.ninteenth_mentioned_cause_of_death)<>'',		';'+TRIM(pInput.ninteenth_mentioned_cause_of_death),'')+
																				IF(TRIM(pInput.twentieth_mentioned_cause_of_death)<>'',		';'+TRIM(pInput.twentieth_mentioned_cause_of_death),'')
																			);
	SELF.fname							:= 	TRIM(pInput.fname);
	SELF.mname							:= 	TRIM(pInput.mname);
	SELF.lname							:= 	TRIM(pInput.lname);
	SELF.name_suffix				:= 	TRIM(pInput.name_suffix);
	SELF										:=	[];
	
END;

EXPORT Mapping_NC := PROJECT(file_in, tDeathMaster_NorthCarolina_Data_Supplement(LEFT));
