IMPORT HEADER, ADDRESS, UT, Std;

file_in := Death_Master.Files.Georgia((	StringLib.StringToUpperCase(TRIM(fname)) NOT IN ['','-','-1','UNIDENTIFIED MALE','UNIDENTIFIED FEMALE','UNKNOWN INDIVIDUAL','UNKNOWN','FIRST_NAME','FIRST NAME'] AND
																				StringLib.StringToUpperCase(TRIM(lname)) NOT IN ['','-','-1','UNIDENTIFIED MALE','UNIDENTIFIED FEMALE','UNKNOWN INDIVIDUAL','UNKNOWN','LAST_NAME','LAST NAME']));

Header.layout_death_master_supplemental tDeathMaster_Georgia_Data_Supplement(file_in pInput) := 
TRANSFORM
																										
	// Get Address and separate into address1 and address2
	clean_state							:=	IF(Address.Map_State_Name_To_Abbrev(TRIM(pInput.resident_state,LEFT,RIGHT))<>'',
																Address.Map_State_Name_To_Abbrev(TRIM(pInput.resident_state,LEFT,RIGHT)),
																TRIM(pInput.resident_state,LEFT,RIGHT));

	STRING76 orig_address1 	:=	StringLib.StringToUpperCase(TRIM(pInput.residence_street_address,LEFT,RIGHT));
	STRING76 orig_address2	:= 	ut.CleanSpacesAndUpper(
																IF(	TRIM(pInput.resident_city,LEFT,RIGHT)<>'' AND clean_state<>'',
																		TRIM(pInput.resident_city,LEFT,RIGHT)+', ',
																		TRIM(pInput.resident_city,LEFT,RIGHT)
																)+clean_state
															);
																					
	// Convert the DOB and DOD to a common format
	fmtsin := [
		'%Y/%m/%d',
		'%m/%d/%Y',
		'%Y-%m-%d'
	];
	fmtout:='%Y%m%d';	
	STRING8 	clean_dob 		:=	Std.date.ConvertDateFormatMultiple(pInput.dob,fmtsin,fmtout);
	STRING8 	clean_dod			:=	Std.date.ConvertDateFormatMultiple(pInput.dod,fmtsin,fmtout);
	UNSIGNED1 clean_age			:=	(UNSIGNED)pInput.age;		

	// Fill Race according to UNITED STATES CENSUS 2000 POPULATION WITH BRIDGED RACE CATEGORIES
	race1	:=	IF(	pInput.Race_American_Indian_or_Alaska_Native	>	0,
								'AMERICAN INDIAN OR ALASKA NATIVE','');
	race2	:=	race1+
						IF(	pInput.Race_Asian_Indian	>	0	OR
								pInput.Race_Chinese	>	0	OR
								pInput.Race_Filipino	>	0	OR
								pInput.Race_Japanese	>	0	OR
								pInput.Race_Korean	>	0	OR
								pInput.Race_Vietnamese	>	0	OR
								pInput.Race_Other_Asian	>	0,
								IF(race1<>'',
									'; ASIAN',
									'ASIAN'
								),'');
	race3	:=	race2+
						IF(	pInput.Race_African_American	>	0,
								IF(race2<>'',
									'; BLACK OR AFRICAN AMERICAN',
									'BLACK OR AFRICAN AMERICAN'
								),'');
	race4	:=	race3+
						IF(	pInput.Race_Native_Hawaiian	>	0	OR
								pInput.Race_Guamanian_or_Chamorro	>	0	OR
								pInput.Race_Samoan	>	0	OR
								pInput.Race_Other_Pacific_Islander	>	0,
								IF(race3<>'',
									'; NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER',
									'NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER'
								),'');
	race5	:=	race4+
						IF(	pInput.Race_White	>	0,
								IF(race4<>'',
									'; WHITE',
									'WHITE'
								),'');
	race6	:=	race5+
						IF(	pInput.Race_Other	>	0,
								IF(race5<>'',
									'; OTHER',
									'OTHER'
								),'');
	race7	:=	race6+
						IF(	pInput.Race_Unknown	>	0,
								IF(race6<>'',
									'; UNKNOWN RACE',
									'UNKNOWN RACE'
								),'');
	race8	:=	race7+
						IF(	pInput.Race_Refused	>	0,
								IF(race7<>'',
									'; REFUSED TO PROVIDE RACE',
									'REFUSED TO PROVIDE RACE'
								),'');
	race	:=	race8+
						IF(	pInput.Race_Not_Obtainable	>	0,
								IF(race8<>'',
									'; RACE NOT OBTAINABLE',
									'RACE NOT OBTAINABLE'
								),'');
	SELF.decedent_race			:=	race;
	
	// Fill Origin according to UNITED STATES CENSUS 2000 POPULATION WITH BRIDGED RACE CATEGORIES
	// Combine all the origins
	dOrigins		:=	DATASET([
								{IF(pInput.Race_Chinese								>	0,'CHINESE','')},
								{IF(pInput.Race_Filipino							>	0,'FILIPINO','')},
								{IF(pInput.Race_Japanese							>	0,'JAPANESE','')},
								{IF(pInput.Race_Korean								>	0,'KOREAN','')},
								{IF(pInput.Race_Vietnamese						>	0,'VIETNAMESE','')},
								{IF(pInput.Race_Native_Hawaiian				>	0,'HAWAIIAN','')},
								{IF(pInput.Race_Guamanian_or_Chamorro	>	0,'GUAMANIAN OR CHAMORRO','')},
								{IF(pInput.Race_Samoan								>	0,'SAMOAN','')},
								{IF(pInput.Race_American_Indian_or_Alaska_Native	>	0	AND
										TRIM(pInput.Race_First_American_Indian_or_Alaska_Native_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_First_American_Indian_or_Alaska_Native_Literal,LEFT,RIGHT),'' )},
								{IF(pInput.Race_American_Indian_or_Alaska_Native	>	0	AND
										TRIM(pInput.Race_Second_American_Indian_or_Alaska_Native_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_Second_American_Indian_or_Alaska_Native_Literal,LEFT,RIGHT),'' )},
								{IF(pInput.Race_Other_Asian	>	0	AND
										TRIM(pInput.Race_First_Other_Asian_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_First_Other_Asian_Literal,LEFT,RIGHT),'' )},
								{IF(pInput.Race_Other_Asian	>	0	AND
										TRIM(pInput.Race_Second_Other_Asian_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_Second_Other_Asian_Literal,LEFT,RIGHT),'' )},
								{IF(pInput.Race_Other_Pacific_Islander	>	0	AND
										TRIM(pInput.Race_First_Other_Pacific_Islander_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_First_Other_Pacific_Islander_Literal,LEFT,RIGHT),'' )},
								{IF(pInput.Race_Other_Pacific_Islander	>	0	AND
										TRIM(pInput.Race_Second_Other_Pacific_Islander_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_Second_Other_Pacific_Islander_Literal,LEFT,RIGHT),'' )},
								{IF(pInput.Race_Other	>	0	AND
										TRIM(pInput.Race_First_Other_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_First_Other_Literal,LEFT,RIGHT),'' )},
								{IF(pInput.Race_Other	>	0	AND
										TRIM(pInput.Race_Second_Other_Literal,LEFT,RIGHT)	<>	'',
										TRIM(pInput.Race_Second_Other_Literal,LEFT,RIGHT),'' )}
								],{STRING	origin});
								
	dOrigins	tCombineOrigins(dOrigins	l, dOrigins	r)	:=	TRANSFORM
		SELF.origin	:=	IF(l.origin<>'',l.origin+'; '+r.origin,r.origin);
	END;
	// Remove blanks and duplicates and then concatinate
	combined_origins	:=	ITERATE(DEDUP(SORT(dOrigins(origin NOT IN ['','-','NA','N/A']),origin),ALL),tCombineOrigins(LEFT,RIGHT));
	
	SELF.decedent_origin		:=	combined_origins[COUNT(combined_origins)].origin;

	SELF.source_state  			:=	'GA';
	SELF.decedent_sex  			:=	StringLib.StringToUpperCase(TRIM(pInput.gender));
	SELF.decedent_age 			:=	(STRING)clean_age + ' YEARS OLD';
	SELF.ssn  							:=	pInput.ssn_last_4;
	SELF.dob 								:=	clean_dob[5..6]+clean_dob[7..8]+clean_dob[1..4];
	SELF.dod 								:=	clean_dod[5..6]+clean_dod[7..8]+clean_dod[1..4];
	SELF.fname							:=	TRIM(pInput.fname);
	SELF.mname							:=	TRIM(pInput.mname);
	SELF.lname							:=	TRIM(pInput.lname);
	SELF.county_residence 	:=	StringLib.StringToUpperCase(IF(pInput.resident_county = 'NOT STATED','',TRIM(pInput.resident_county)));
	SELF.orig_address1			:=	TRIM(orig_address1);
	SELF.orig_address2			:=	TRIM(orig_address2);
	SELF.father							:=	IF(TRIM(pInput.lname_father) IN ['-','-1','UNKNOWN'],'',StringLib.StringToUpperCase(TRIM(pInput.lname_father)));
	SELF 										:=	[];
	
END;

EXPORT Mapping_GA := PROJECT(file_in, tDeathMaster_Georgia_Data_Supplement(LEFT));
