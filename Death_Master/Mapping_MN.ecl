IMPORT HEADER, ADDRESS, UT;

file_in := Death_Master.Files.Minnesota;
						 
Header.layout_death_master_supplemental tDeathMaster_Minnesota_Data_Supplement(file_in pInput) := 
TRANSFORM

	// Get Address and separate into address1 and address2
	clean_state							:=	IF(Address.Map_State_Name_To_Abbrev(TRIM(pInput.residence_state,LEFT,RIGHT))<>'',
																Address.Map_State_Name_To_Abbrev(TRIM(pInput.residence_state,LEFT,RIGHT)),
																TRIM(pInput.residence_state,LEFT,RIGHT));
																
	fnCleanAddressField(STRING	addrField)	:=	FUNCTION
		RETURN(IF(StringLib.StringToUpperCase(TRIM(addrField,LEFT,RIGHT)) 
							NOT IN ['UNKNOWN','UNKNOWNUNKNOWN'],TRIM(addrField,LEFT,RIGHT),''));
	END;
	clean_streetname				:=	fnCleanAddressField(pInput.residence_street);

	STRING76 orig_address1	:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(
																clean_streetname
															));
	STRING76 orig_address2 	:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(
																IF(	TRIM(pInput.residence_city)<>'' AND (clean_state<>'' OR TRIM(pInput.residence_zip,LEFT,RIGHT)<>''),
																		TRIM(pInput.residence_city)+', ',
																		TRIM(pInput.residence_city)
																)+clean_state+' '+TRIM(pInput.residence_zip,LEFT,RIGHT)
															));

	STRING8		clean_dob 		:= 	IF(pInput.dob[1..4] IN ['9999',''],'',
																	pInput.dob[1..4] +
																	IF(pInput.dob[5..6] IN ['99'], '00', pInput.dob[5..6]) +
																	IF(pInput.dob[7..8] IN ['99'], '00', pInput.dob[7..8]));																
	STRING8		clean_dod 		:= 	IF(pInput.dod[1..4] IN ['9999',''],'',
																	pInput.dod[1..4] +
																	IF(pInput.dod[5..6] IN ['99'], '00', pInput.dod[5..6]) +
																	IF(pInput.dod[7..8] IN ['99'], '00', pInput.dod[7..8]));																
	UNSIGNED1	clean_age 		:=	ut.Age((INTEGER) clean_dob,(INTEGER) clean_dod);		
		
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
								pInput.Race_Hmong	=	'Y'	OR
								pInput.Race_Cambodian	=	'Y'	OR
								pInput.Race_Laotian	=	'Y'	OR
								pInput.Race_Other_Asian	=	'Y',
								IF(race1<>'',
									'; ASIAN',
									'ASIAN'
								),'');
	race3	:=	race2+
						IF(	pInput.Race_African_American='Y'	OR
								pInput.Race_Somalian='Y'	OR
								pInput.Race_Ethiopian='Y'	OR
								pInput.Race_Liberian='Y'	OR
								pInput.Race_Kenyan='Y'	OR
								pInput.Race_Sudanese='Y'	OR
								pInput.Race_Nigerian='Y'	OR
								pInput.Race_Ghanian='Y'	OR
								pInput.Race_Other_African='Y',
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
						IF(	pInput.Race_White	=	'Y',
								IF(race4<>'',
									'; WHITE',
									'WHITE'
								),'');
	race6	:=	race5+
						IF(	pInput.Race_Other	=	'Y',
								IF(race5<>'',
									'; OTHER',
									'OTHER'
								),'');
	race7	:=	race6+
						IF(	pInput.Race_Unknown	=	'Y',
								IF(race6<>'',
									'; UNKNOWN RACE',
									'UNKNOWN RACE'
								),'');
	race8	:=	race7+
						IF(	pInput.Race_Refused	=	'Y',
								IF(race7<>'',
									'; REFUSED TO PROVIDE RACE',
									'REFUSED TO PROVIDE RACE'
								),'');
	race	:=	race8+
						IF(	pInput.Race_Not_Obtainable	=	'Y',
								IF(race8<>'',
									'; RACE NOT OBTAINABLE',
									'RACE NOT OBTAINABLE'
								),'');
	SELF.decedent_race			:=	race;
	
	// Fill Origin according to UNITED STATES CENSUS 2000 POPULATION WITH BRIDGED RACE CATEGORIES
	// Combine all the origins
	dOrigins		:=	DATASET([
								{IF(pInput.Hispanic_Origin_Mexican='Y','MEXICAN','')},
								{IF(pInput.Hispanic_Origin_PuertoRican	=	'Y','PUERTO RICAN','')},
								{IF(pInput.Hispanic_Origin_Cuban	=	'Y','CUBAN','')},
								{IF(TRIM(pInput.Hispanic_Origin_Other_Literal,LEFT,RIGHT) <>	''
										,TRIM(pInput.Hispanic_Origin_Other_Literal,LEFT,RIGHT),
										IF(	pInput.Hispanic_Origin_Other	=	'Y',
												'HISPANIC',''	))},
								{IF(pInput.Hispanic_Origin_Refused_To_State_Hispanic_Origin	=	'Y','REFUSED TO STATE HISPANIC ORIGIN','')},
								{IF(pInput.Hispanic_Origin_Unknown_Hispanic_Origin	=	'Y','UNKNOWN HISPANIC ORIGIN','')},
								{IF(pInput.Hispanic_Origin_Not_Obtainable	=	'Y','REFUSED TO STATE HISPANIC ORIGIN','')},
								{IF(pInput.Race_Chinese										=	'Y','CHINESE','')},
								{IF(pInput.Race_Filipino									=	'Y','FILIPINO','')},
								{IF(pInput.Race_Japanese									=	'Y','JAPANESE','')},
								{IF(pInput.Race_Korean										=	'Y','KOREAN','')},
								{IF(pInput.Race_Vietnamese								=	'Y','VIETNAMESE','')},
								{IF(pInput.Race_Hmong											=	'Y','HMONG','')},
								{IF(pInput.Race_Cambodian									=	'Y','CAMBODIAN','')},
								{IF(pInput.Race_Laotian										=	'Y','LAOTIAN','')},
								{IF(pInput.Race_Native_Hawaiian						=	'Y','HAWAIIAN','')},
								{IF(pInput.Race_Guamanian_or_Chamorro			=	'Y','GUAMANIAN OR CHAMORRO','')},
								{IF(pInput.Race_Samoan										=	'Y','SAMOAN','')},
								{IF(pInput.Race_Somalian									=	'Y','SOMALIAN','')},
								{IF(pInput.Race_Ethiopian									=	'Y','ETHIOPIAN','')},
								{IF(pInput.Race_Liberian									=	'Y','LIBERIAN','')},
								{IF(pInput.Race_Kenyan										=	'Y','KENYAN','')},
								{IF(pInput.Race_Sudanese									=	'Y','SUDANESE','')},
								{IF(pInput.Race_Nigerian									=	'Y','NIGERIAN','')},
								{IF(pInput.Race_Ghanian										=	'Y','GHANIAN','')},
								{IF(pInput.Race_Other_African	=	'Y'	AND
										TRIM(pInput.Race_First_Other_African_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_First_Other_African_Literal,LEFT,RIGHT),'' )},
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
	
	SELF.decedent_origin		:=	IF( combined_origins[COUNT(combined_origins)].origin	=	''	AND
																	pInput.Hispanic_Origin_Not_Hispanic	=	'Y',
																	'NOT HISPANIC OR LATINO',
																	combined_origins[COUNT(combined_origins)].origin);
	SELF.source_state  			:= 	'MN';
	SELF.ssn  							:= 	pInput.ssn;
	SELF.decedent_sex  			:= 	IF(pInput.sex='M','MALE',IF(pInput.sex='F','FEMALE',IF(pInput.sex='U','UNKNOWN','')));
	SELF.decedent_age 			:=	(STRING)clean_age + ' YEARS OLD';
	SELF.county_residence		:=	TRIM(pInput.residence_county);
	SELF.county_death				:=	TRIM(pInput.county_of_death);
	SELF.orig_address1			:=	TRIM(orig_address1);
	SELF.orig_address2			:=	TRIM(orig_address2);
	SELF.dob 								:=	clean_dob[5..6]+clean_dob[7..8]+clean_dob[1..4];
	SELF.dod 								:=	clean_dod[5..6]+clean_dod[7..8]+clean_dod[1..4];
	SELF.cert_number				:=	TRIM(pInput.certificate_number);
	SELF.place_of_death			:=	StringLib.StringToUpperCase(TRIM(pInput.city_of_death));
	SELF.fname							:= 	TRIM(pInput.fname);
	SELF.mname							:= 	TRIM(pInput.mname);
	SELF.lname							:= 	TRIM(pInput.lname);
	SELF										:=	[];
	
END;

EXPORT Mapping_MN := PROJECT(file_in, tDeathMaster_Minnesota_Data_Supplement(LEFT));
