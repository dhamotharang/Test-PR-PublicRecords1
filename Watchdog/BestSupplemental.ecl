/***************************************************************
	BestSupplemental
	Using DID, take Physical Attribute Data from various sources.
	Add this data to a common layout.
	Standardize the data.
	Normalize the Records by DID
****************************************************************/
IMPORT MDR, DriversV2, hygenics_crim, hygenics_soff, marriage_divorce_v2, 
FLAccidents, FLAccidents_Ecrash, VotersV2, eMerges, ut, _validate, Codes,Data_Services;

#STORED ('_Validate_Year_Range_Low', '1900'); 
#STORED ('_Validate_Year_Range_high', ut.GetDate[1..4]);

EXPORT BestSupplemental(STRING8 filedate) := FUNCTION

/**********************/
/* Lookup Tables      */
/**********************/
	VARSTRING dl_race(STRING race) := CASE
	(
		race,
		'W'	=>	'WHITE',  
		'B'	=>	'BLACK',  
		'H'	=>	'HISPANIC',  
		'U'	=>	'UNKNOWN',
		''
	);

	STRING2 emerges_src(QSTRING src, QSTRING1 hunt, QSTRING1 fish, QSTRING1 combosuper)	:= MAP 
	(
		 src='HUNT' AND (hunt=''  OR fish=''  OR combosuper= '') => MDR.sourceTools.src_EMerge_Master
		,src='HUNT' AND (hunt='Y'             OR combosuper='Y') => MDR.sourceTools.src_EMerge_Hunt
		,src='HUNT' AND (            fish='Y' OR combosuper='Y') => MDR.sourceTools.src_EMerge_Fish
		,src='FISH'                                              => MDR.sourceTools.src_EMerge_Fish
		,src='CCW'                                               => MDR.sourceTools.src_EMerge_CCW
		,src='CENS'                                              => MDR.sourceTools.src_EMerge_Cens
		,''
	);

	VARSTRING crim_src(STRING src) := CASE
	(
		src,
		'1'	=>	MDR.sourceTools.src_Accurint_DOC,
		'2'	=>	MDR.sourceTools.src_Accurint_Crim_Court,
		'4'	=>	MDR.sourceTools.src_Accurint_Sex_offender,
		'5'	=>	MDR.sourceTools.src_Accurint_Arrest_Log,
		'' 
	);
	
/****************************/
/* Standardization Routines */
/****************************/
	// Common Colors
	setAuburn	:= ['AUBURN','AU','XAU'];
	setBlack	:= ['BLACK','BK','BLK','XBK'];
	setBlond	:= ['BLOND','BLN','XBD','BLONDE','BD','BONDE','BLND','BEIGE'];
	setBlue		:= ['BLUE','BLU'];
	setBrown	:= ['BROWN','BRO','BR','XBR','BRWON'];
	setDichromatic	:= ['DICHROMATIC'];
	setGray		:= ['GRAY','GRY','GREY','SILVER','GY','XGY'];
	setGreen	:= ['GREEN','GN','GRN'];
	setHazel	:= ['HAZEL','HZ','XHZ','HAZ'];
	setPink		:= ['PINK','PNK'];
	setRed		:= ['RED','RD','XRD'];
	setUnk		:= ['UNKNOWN','UNKOWN','UNK','UNKNOW','*UNMATCHED','UNASSIGNED','?'];
	setWhite	:= ['WHITE','WHI','WHT','XWT','WH'];

	// Colors specific to Hair
	setHairBlack	:= ['BL','XBL'];
	setHairGray		:= ['GR','XGR'];
	
	// Standardize Hair Color
	VARSTRING standardizeHairColor(QSTRING color)	:= MAP
	(
		 TRIM(color) IN setAuburn	=>	'AUBURN'
		,TRIM(color) IN [setBlack,setHairBlack]	=>	'BLACK'
		,TRIM(color) IN setBlond	=>	'BLONDE'
		,TRIM(color) IN setBlue		=>	'BLUE'
		,TRIM(color) IN setBrown	=>	'BROWN'
		,TRIM(color) IN setDichromatic	=>	'DICHROMATIC'
		,TRIM(color) IN [setGray,setHairGray]	=>	'GRAY'
		,TRIM(color) IN setGreen	=>	'GREEN'
		,TRIM(color) IN setHazel	=>	'HAZEL'
		,TRIM(color) IN setPink		=>	'PINK'
		,TRIM(color) IN setRed		=>	'RED'
		,TRIM(color) IN [setUnk,'HAIR']		=>	'UNKNOWN'
		,TRIM(color) IN setWhite	=>	'WHITE'
		,color
	);
	
	// Colors specific to Eyes
	setEyeGreen	:= ['GR','XGR'];
	setEyeBlue	:= ['BL','XBL'];
	
	// Standardize Eye Color
	VARSTRING standardizeEyeColor(QSTRING color)	:= MAP
	(
		 TRIM(color) IN setAuburn	=>	'AUBURN'
		,TRIM(color) IN setBlack	=>	'BLACK'
		,TRIM(color) IN setBlond	=>	'BLONDE'
		,TRIM(color) IN [setBlue,setEyeBlue]		=>	'BLUE'
		,TRIM(color) IN setBrown	=>	'BROWN'
		,TRIM(color) IN setDichromatic	=>	'DICHROMATIC'
		,TRIM(color) IN [setGreen,setEyeGreen]	=>	'GREEN'
		,TRIM(color) IN setGray		=>	'GRAY'
		,TRIM(color) IN setHazel	=>	'HAZEL'
		,TRIM(color) IN setPink		=>	'PINK'
		,TRIM(color) IN setRed		=>	'RED'
		,TRIM(color) IN [setUnk,'HAIR']		=>	'UNKNOWN'
		,TRIM(color) IN setWhite	=>	'WHITE'
		,color
	);
	
	subString				:= 	' \'';	// Handles cases such as "5 8" and "5'8"
	filterString		:=	'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*()_+-={}[]|\\:";<>?,./';
	
	// Standardize Height
	STRING3 standardizeHeight(STRING3 height)	:= FUNCTION
		subbed_height			:=	StringLib.StringSubstituteOut(height,subString,'0');
		filtered_height		:=	StringLib.StringFilterOut(subbed_height,filterString);
		converted_height	:=	IF(LENGTH(filtered_height)=3,(UNSIGNED)filtered_height[1]*12+(UNSIGNED)filtered_height[2..3],
													IF(LENGTH(filtered_height)=1,(UNSIGNED)filtered_height[1]*12,(UNSIGNED)filtered_height));
		RETURN	INTFORMAT(converted_height,3,1);
	END;
	
	// Standardize Weight
	STRING3 standardizeWeight(STRING3 weight)	:= FUNCTION
		filtered_weight	:=	StringLib.StringFilterOut(weight,filterString);
		RETURN	INTFORMAT((UNSIGNED)filtered_weight,3,1);
	END;
	
	setSMTRemove	:=	[
		'INFORMATION TEMPORARILY UNAVAILABLE',
		'NONE'
	];
	// Standardize Scars, Marks & Tattoos (SMT)
	QSTRING250 standardizeSMT(QSTRING250 SMT)	:= FUNCTION
		filtered_SMT	:=	IF(TRIM(SMT) IN setSMTRemove,'',TRIM(SMT));
		RETURN	filtered_SMT;
	END;
	
	// Standardize all of the values
	Layout_Supplemental.Raw	tStandardize(RECORDOF(Layout_Supplemental.Raw) sInput)	:= TRANSFORM
		SELF.hair_color	:=	IF(TRIM(sInput.hair_color)<>'',standardizeHairColor(StringLib.StringToUpperCase(TRIM(sInput.hair_color))),'');
		SELF.eye_color	:=	IF(TRIM(sInput.eye_color)<>'',standardizeEyeColor(StringLib.StringToUpperCase(TRIM(sInput.eye_color))),'');
		SELF.height			:= 	IF((UNSIGNED)sInput.height<>0,standardizeHeight(TRIM(sInput.height)),'');
		SELF.weight			:=	IF((UNSIGNED)sInput.weight<>0,standardizeWeight(TRIM(sInput.weight)),'');
		SELF.SMT				:=	IF(TRIM(sInput.SMT)<>'',standardizeSMT(StringLib.StringToUpperCase(TRIM(sInput.SMT))),'');
		SELF						:=	sInput;
		SELF						:=	[];
	END;
	
/*****************/
/* Input files   */
/*****************/
	// Driver's License
	dl	:=	DriversV2.File_DL;

	// Criminal
	Crims		:=	hygenics_crim.File_Moxie_Crim_Offender2_Dev;
	SexOff	:=	DATASET(Data_Services.foreign_prod+'thor_data400::in::hd::sex_offender_crossmain::wd',hygenics_soff.layout_out_main_cross,FLAT);

	// Marriage&Divorce
	MarDiv	:=	marriage_divorce_v2.file_mar_div_search;

	// Accident	
	ECrash		:=	FLAccidents_Ecrash.BaseFile;
	ECrashCRU	:=	FLAccidents_Ecrash.File_CRU_inquiries;
	VehBase		:=	FLAccidents.BaseFile_FLCrash0;
	VehDriver	:=	FLAccidents.BaseFile_FLCrash4;
	VehOwner	:=	FLAccidents.BaseFile_FLCrash2v;

	// Voters
	Voters		:=	VotersV2.File_Voters_Base;

	// Emerges
	eMerges		:=	eMerges.file_hvccw_base;

/***********************************/
/* Process Drivers License records */
/***********************************/
	Layout_Supplemental.Raw	tDriversLicense(RECORDOF(dl) dlInput)	:= TRANSFORM
		source							:=	IF(MDR.sourceTools.fDLs(dlInput.source_code, dlInput.orig_state)<>'',
															MDR.sourceTools.fDLs(dlInput.source_code, dlInput.orig_state),
															MDR.sourceTools.src_Certegy);
		date_used						:=	(STRING)MAX(dlInput.dt_last_seen,dlInput.dt_vendor_last_reported);
		UNSIGNED4 dt_src		:=  (UNSIGNED)_validate.date.fCorrectedDateString(date_used);
		
		SELF.did						:=	dlInput.did;
		SELF.gender					:=	IF(dlInput.sex_flag='M','MALE',IF(dlInput.sex_flag='F','FEMALE',''));
		SELF.race						:=	dl_race(StringLib.StringToUpperCase(dlInput.race));
		SELF.hair_color			:=	StringLib.StringToUpperCase(
															Codes.DRIVERS_LICENSE.HAIR_COLOR(dlInput.orig_state,dlInput.hair_color));
		SELF.eye_color			:=	StringLib.StringToUpperCase(
															Codes.DRIVERS_LICENSE.EYE_COLOR(dlInput.orig_state,dlInput.eye_color));
		SELF.height					:=	dlInput.height;
		SELF.weight					:=	dlInput.weight;
		SELF.dt_gender			:=	IF(SELF.gender<>'',dt_src,0);
		SELF.src_gender			:=	IF(SELF.gender<>'',source,'');
		SELF.dt_race				:=	IF(SELF.race<>'',dt_src,0);
		SELF.src_race				:=	IF(SELF.race<>'',source,'');
		SELF.dt_hair_color	:=	IF(SELF.hair_color<>'',dt_src,0);
		SELF.src_hair_color	:=	IF(SELF.hair_color<>'',source,'');
		SELF.dt_eye_color		:=	IF(SELF.eye_color<>'',dt_src,0);
		SELF.src_eye_color	:=	IF(SELF.eye_color<>'',source,'');
		SELF.dt_height			:=	IF(SELF.height<>'',dt_src,0);
		SELF.src_height			:=	IF(SELF.height<>'',source,'');
		SELF.dt_weight			:=	IF(SELF.weight<>'',dt_src,0);
		SELF.src_weight			:=	IF(SELF.weight<>'',source,'');
		SELF								:=	[];
	END;

	dl_valid	:=	dl(did<>0 AND (sex_flag<>'' OR hair_color<>'' OR eye_color<>'' OR height<>'' OR weight<>'' OR race<>''));
	dl_sort		:=	SORT(DISTRIBUTE(dl_valid,HASH(did)),did,LOCAL);
	fillDL		:=	PROJECT(dl_sort,tDriversLicense(LEFT));

/***********************************/
/* Process Criminal Records        */
/***********************************/
	Layout_Supplemental.Raw	tCrims(RECORDOF(Crims) crimsInput)	:= TRANSFORM
		source							:=	crim_src(crimsInput.data_type);
		date_used						:=	IF(crimsInput.case_date<>'',crimsInput.case_date,crimsInput.src_upload_date);
		UNSIGNED4 dt_src		:=  (UNSIGNED)_validate.date.fCorrectedDateString(date_used);
		
		SELF.did						:=	(UNSIGNED6)crimsInput.did;
		SELF.gender					:=	StringLib.StringToUpperCase(Codes.CRIM_OFFENDER2.SEX(crimsInput.sex));
		SELF.race						:=	StringLib.StringToUpperCase(crimsInput.race_desc);
		SELF.hair_color			:=	StringLib.StringToUpperCase(crimsInput.hair_color_desc);
		SELF.eye_color			:=	StringLib.StringToUpperCase(crimsInput.eye_color_desc);
		SELF.height					:=	crimsInput.height;
		SELF.weight					:=	crimsInput.weight;
		SELF.SMT						:=	StringLib.StringToUpperCase(
																		crimsInput.scars_marks_tattoos_1+' '+
																		crimsInput.scars_marks_tattoos_2+' '+
																		crimsInput.scars_marks_tattoos_3+' '+
																		crimsInput.scars_marks_tattoos_4+' '+
																		crimsInput.scars_marks_tattoos_5
																	);
		SELF.dt_gender			:=	IF(SELF.gender<>'',dt_src,0);
		SELF.src_gender			:=	IF(SELF.gender<>'',source,'');
		SELF.dt_race				:=	IF(SELF.race<>'',dt_src,0);
		SELF.src_race				:=	IF(SELF.race<>'',source,'');
		SELF.dt_hair_color	:=	IF(SELF.hair_color<>'',dt_src,0);
		SELF.src_hair_color	:=	IF(SELF.hair_color<>'',source,'');
		SELF.dt_eye_color		:=	IF(SELF.eye_color<>'',dt_src,0);
		SELF.src_eye_color	:=	IF(SELF.eye_color<>'',source,'');
		SELF.dt_height			:=	IF(SELF.height<>'',dt_src,0);
		SELF.src_height			:=	IF(SELF.height<>'',source,'');
		SELF.dt_weight			:=	IF(SELF.weight<>'',dt_src,0);
		SELF.src_weight			:=	IF(SELF.weight<>'',source,'');
		SELF.dt_SMT					:=	IF(SELF.SMT<>'',dt_src,0);
		SELF.src_SMT				:=	IF(SELF.SMT<>'',source,'');
		SELF								:=	[];
	END;

	Crims_Valid	:=	Crims((UNSIGNED)did<>0 AND pty_typ='0' AND
												(sex<>'' OR hair_color_desc<>'' OR eye_color_desc<>'' OR height<>'' OR weight<>'' OR race_desc<>'' OR 
												 scars_marks_tattoos_1<>'' OR scars_marks_tattoos_2<>'' OR scars_marks_tattoos_3<>'' OR
												 scars_marks_tattoos_4<>'' OR scars_marks_tattoos_5<>''));
	Crims_Sort	:=	SORT(DISTRIBUTE(Crims_Valid,HASH(did)),did,LOCAL);
	fillCrims		:=	PROJECT(Crims_Sort,tCrims(LEFT));

/***********************************/
/* Process Sex Offender Records    */
/***********************************/
	Layout_Supplemental.Raw	tSexOff(RECORDOF(SexOff) sexoffInput)	:= TRANSFORM
		source							:=	MDR.sourceTools.src_Accurint_Sex_offender;
		date_used						:=	IF(sexoffInput.src_upload_date<>'',sexoffInput.src_upload_date,
																sexoffInput.dt_last_reported);
		UNSIGNED4 dt_src		:=  (UNSIGNED)_validate.date.fCorrectedDateString(date_used);
		
		SELF.did						:=	sexoffInput.did;
		SELF.gender					:=	StringLib.StringToUpperCase(sexoffInput.sex);
		SELF.race						:=	StringLib.StringToUpperCase(sexoffInput.race);
		SELF.hair_color			:=	StringLib.StringToUpperCase(sexoffInput.hair_color);
		SELF.eye_color			:=	StringLib.StringToUpperCase(sexoffInput.eye_color);
		SELF.height					:=	sexoffInput.height;
		SELF.weight					:=	sexoffInput.weight;
		SELF.SMT						:=	StringLib.StringToUpperCase(sexoffInput.scars_marks_tattoos);
		SELF.dt_gender			:=	IF(SELF.gender<>'',dt_src,0);
		SELF.src_gender			:=	IF(SELF.gender<>'',source,'');
		SELF.dt_race				:=	IF(SELF.race<>'',dt_src,0);
		SELF.src_race				:=	IF(SELF.race<>'',source,'');
		SELF.dt_hair_color	:=	IF(SELF.hair_color<>'',dt_src,0);
		SELF.src_hair_color	:=	IF(SELF.hair_color<>'',source,'');
		SELF.dt_eye_color		:=	IF(SELF.eye_color<>'',dt_src,0);
		SELF.src_eye_color	:=	IF(SELF.eye_color<>'',source,'');
		SELF.dt_height			:=	IF(SELF.height<>'',dt_src,0);
		SELF.src_height			:=	IF(SELF.height<>'',source,'');
		SELF.dt_weight			:=	IF(SELF.weight<>'',dt_src,0);
		SELF.src_weight			:=	IF(SELF.weight<>'',source,'');
		SELF.dt_SMT					:=	IF(SELF.SMT<>'',dt_src,0);
		SELF.src_SMT				:=	IF(SELF.SMT<>'',source,'');
		SELF								:=	[];
	END;

	SexOff_Valid	:=	SexOff(did<>0 AND name_type='0' AND
														(sex<>'' OR hair_color<>'' OR eye_color<>'' OR height<>'' OR 
														 weight<>'' OR race<>'' OR scars_marks_tattoos<>''));
	SexOff_Sort		:=	SORT(DISTRIBUTE(SexOff_Valid,HASH(did)),did,LOCAL);
	fillSexOff		:=	PROJECT(SexOff_sort,tSexOff(LEFT));

/***********************************/
/* Process Voter Records           */
/***********************************/
	Layout_Supplemental.Raw	tVoters(RECORDOF(Voters) votersInput)	:= TRANSFORM
		source							:=	MDR.sourceTools.src_Voters_v2;
		date_used						:=	IF(votersInput.file_acquired_date<>'',votersInput.file_acquired_date,
															votersInput.date_last_seen);
		UNSIGNED4 dt_src		:=  (UNSIGNED)_validate.date.fCorrectedDateString(date_used);

		SELF.did						:=	votersInput.did;
		SELF.gender					:=	IF(votersInput.gender='M','MALE',IF(votersInput.gender='F','FEMALE',''));
		SELF.race						:=	StringLib.StringToUpperCase(votersInput.race_exp);
		SELF.dt_gender			:=	IF(SELF.gender<>'',dt_src,0);
		SELF.src_gender			:=	IF(SELF.gender<>'',source,'');
		SELF.dt_race				:=	IF(SELF.race<>'',dt_src,0);
		SELF.src_race				:=	IF(SELF.race<>'',source,'');
		SELF								:=	[];
	END;

	Voters_Valid	:=	Voters(did<>0 AND (gender<>'' OR race<>''));
	Voters_sort		:=	SORT(DISTRIBUTE(Voters_Valid,HASH(did)),did,LOCAL);
	fillVoters		:=	PROJECT(Voters_sort,tVoters(LEFT));

/***************************************************/
/* Process eMerges Records (HUNT, FISH, CCW, CENS) */
/***************************************************/
	Layout_Supplemental.Raw	teMerges(RECORDOF(eMerges) emergesInput)	:= TRANSFORM
		source							:=	emerges_src(emergesInput.file_id,
																				StringLib.StringToUpperCase(emergesInput.hunt),
																				StringLib.StringToUpperCase(emergesInput.fish),
																				StringLib.StringToUpperCase(emergesInput.combosuper));
		date_used						:=	IF(emergesInput.file_acquired_date<>'',emergesInput.file_acquired_date,
																emergesInput.date_last_seen);
		UNSIGNED4 dt_src		:=  (UNSIGNED)_validate.date.fCorrectedDateString(date_used);

		SELF.did						:=	(UNSIGNED6)emergesInput.did_out;
		SELF.gender					:=	IF(emergesInput.gender='M','MALE',IF(emergesInput.gender='F','FEMALE',''));
		SELF.race						:=	VotersV2.Table_Race_Ethnicity(StringLib.StringToUpperCase(TRIM(emergesInput.race)));
		SELF.dt_gender			:=	IF(SELF.gender<>'',dt_src,0);
		SELF.src_gender			:=	IF(SELF.gender<>'',source,'');
		SELF.dt_race				:=	IF(SELF.race<>'',dt_src,0);
		SELF.src_race				:=	IF(SELF.race<>'',source,'');
		SELF								:=	[];
	END;

	eMerges_Valid	:=	eMerges((UNSIGNED)did_out<>0 AND file_id NOT IN ['VOTE'] AND (gender<>'' OR race<>''));
	eMerges_sort	:=	SORT(DISTRIBUTE(eMerges_Valid,HASH(did_out)),did_out,LOCAL);
	filleMerges		:=	PROJECT(eMerges_sort,teMerges(LEFT));

/***************************************************/
/* Process Marriage&Divorce Records                */
/***************************************************/
	Layout_Supplemental.Raw	tMarDiv(RECORDOF(MarDiv) mardivInput)	:= TRANSFORM
		source							:=	MDR.sourceTools.src_Marriage;
		date_used						:=	(STRING)MAX(mardivInput.dt_last_seen,mardivInput.dt_vendor_last_reported);
		UNSIGNED4 dt_src		:=  (UNSIGNED)_validate.date.fCorrectedDateString(date_used);

		SELF.did						:=	mardivInput.did;
		SELF.race						:=	mardivInput.race;
		SELF.dt_race				:=	IF(SELF.race<>'',dt_src,0);
		SELF.src_race				:=	IF(SELF.race<>'',source,'');
		SELF								:=	[];
	END;

	MarDiv_Valid	:=	MarDiv(did<>0 AND race<>'');
	MarDiv_sort		:=	SORT(DISTRIBUTE(MarDiv_Valid,HASH(did)),did,LOCAL);
	fillMarDiv		:=	PROJECT(MarDiv_sort,tMarDiv(LEFT));

/***********************************/
/* Process ECrash records          */
/***********************************/
	Layout_Supplemental.Raw	tECrash(RECORDOF(ECrash) eCrashInput)	:= TRANSFORM
		source							:=	MDR.sourceTools.src_Accidents_ECrash;
		date_used						:=	IF(eCrashInput.creation_date<>'',eCrashInput.creation_date,
															IF(eCrashInput.date_vendor_last_reported<>'',eCrashInput.date_vendor_last_reported,
																	eCrashInput.dt_last_seen));
		UNSIGNED4 dt_src		:=  (UNSIGNED)_validate.date.fCorrectedDateString(date_used);
		
		SELF.did						:=	eCrashInput.did;
		SELF.gender					:=	StringLib.StringToUpperCase(eCrashInput.sex);
		SELF.race						:=	StringLib.StringToUpperCase(eCrashInput.race);
		SELF.hair_color			:=	StringLib.StringToUpperCase(eCrashInput.hair_color);
		SELF.eye_color			:=	StringLib.StringToUpperCase(eCrashInput.eye_color);
		SELF.height					:=	eCrashInput.height;
		SELF.weight					:=	eCrashInput.weight;
		SELF.dt_gender			:=	IF(SELF.gender<>'',dt_src,0);
		SELF.src_gender			:=	IF(SELF.gender<>'',source,'');
		SELF.dt_race				:=	IF(SELF.race<>'',dt_src,0);
		SELF.src_race				:=	IF(SELF.race<>'',source,'');
		SELF.dt_hair_color	:=	IF(SELF.hair_color<>'',dt_src,0);
		SELF.src_hair_color	:=	IF(SELF.hair_color<>'',source,'');
		SELF.dt_eye_color		:=	IF(SELF.eye_color<>'',dt_src,0);
		SELF.src_eye_color	:=	IF(SELF.eye_color<>'',source,'');
		SELF.dt_height			:=	IF(SELF.height<>'',dt_src,0);
		SELF.src_height			:=	IF(SELF.height<>'',source,'');
		SELF.dt_weight			:=	IF(SELF.weight<>'',dt_src,0);
		SELF.src_weight			:=	IF(SELF.weight<>'',source,'');
		SELF								:=	[];
	END;

	ECrash_valid	:=	ECrash(did<>0 AND (sex<>'' OR hair_color<>'' OR eye_color<>'' OR height<>'' OR weight<>'' OR race<>''));
	ECrash_sort		:=	SORT(DISTRIBUTE(ECrash_valid,HASH(did)),did,LOCAL);
	fillECrash		:=	PROJECT(ECrash_sort,tECrash(LEFT));

/***********************************/
/* Process ECrash CRU records      */
/***********************************/
	Layout_Supplemental.Raw	tECrashCRU(RECORDOF(ECrashCRU) eCrashCRUInput)	:= TRANSFORM
		source							:=	MDR.sourceTools.src_Accidents_ECrash_CRU;
		date_used						:=	IF(ut.ConvertDate(eCrashCRUInput.creation_date)<>'',
																ut.ConvertDate(eCrashCRUInput.creation_date),eCrashCRUInput.dt_last_seen);
		UNSIGNED4 dt_src		:=  (UNSIGNED)_validate.date.fCorrectedDateString(date_used);
		
		SELF.did						:=	eCrashCRUInput.did;
		SELF.gender					:=	IF(eCrashCRUInput.gender_1='M','MALE',
															IF(eCrashCRUInput.gender_1='F','FEMALE',
																IF(eCrashCRUInput.gender_1='U','UNKNOWN',''))
														);
		SELF.dt_gender			:=	IF(SELF.gender<>'',dt_src,0);
		SELF.src_gender			:=	IF(SELF.gender<>'',source,'');
		SELF								:=	[];
	END;

	ECrashCRU_valid	:=	ECrashCRU(did<>0 AND gender_1<>'');
	ECrashCRU_sort	:=	SORT(DISTRIBUTE(ECrashCRU_valid,HASH(did)),did,LOCAL);
	fillECrashCRU		:=	PROJECT(ECrashCRU_sort,tECrashCRU(LEFT));

/***********************************/
/* Process Accident Driver Records */
/***********************************/
	Layout_Supplemental.Raw	tVehDriver(RECORDOF(VehDriver) vehdriverInput)	:= TRANSFORM
		source							:=	MDR.sourceTools.src_Accidents_FL;

		SELF.did						:=	(UNSIGNED6)vehdriverInput.did;
		SELF.accident_nbr		:=	vehdriverInput.accident_nbr;
		SELF.gender					:=	StringLib.StringToUpperCase(Codes.FLCRASH4_DRIVER.DRIVER_SEX(vehdriverInput.driver_sex));
		SELF.race						:=	StringLib.StringToUpperCase(Codes.FLCRASH4_DRIVER.DRIVER_RACE(vehdriverInput.driver_race));
		SELF.src_gender			:=	IF(SELF.gender<>'',source,'');
		SELF.src_race				:=	IF(SELF.race<>'',source,'');
		SELF								:=	[];
	END;

	VehDriver_Valid		:=	VehDriver((UNSIGNED)did<>0 AND (driver_sex<>'' OR driver_race<>''));
	VehDriver_sort		:=	SORT(DISTRIBUTE(VehDriver_Valid,HASH(did)),did,LOCAL);
	fillVehDriver			:=	PROJECT(VehDriver_sort,tVehDriver(LEFT));

/******************************************/
/* Process Accident Vehical Owner Records */
/******************************************/
	Layout_Supplemental.Raw	tVehOwner(RECORDOF(VehOwner) vehownerInput)	:= TRANSFORM
		source							:=	MDR.sourceTools.src_Accidents_FL;

		SELF.did						:=	(UNSIGNED6)vehownerInput.did;
		SELF.accident_nbr		:=	vehownerInput.accident_nbr;
		SELF.gender					:=	StringLib.StringToUpperCase(Codes.FLCRASH2_VEHICLE.VEHICLE_OWNER_SEX(vehownerInput.vehicle_owner_sex));
		SELF.race						:=	StringLib.StringToUpperCase(Codes.FLCRASH2_VEHICLE.VEHICLE_OWNER_RACE(vehownerInput.vehicle_owner_race));
		SELF.src_gender			:=	IF(SELF.gender<>'',source,'');
		SELF.src_race				:=	IF(SELF.race<>'',source,'');
		SELF								:=	[];
	END;

	VehOwner_Valid	:=	VehOwner((UNSIGNED)did<>0 AND (vehicle_owner_sex<>'' OR vehicle_owner_race<>''));
	VehOwner_sort		:=	SORT(DISTRIBUTE(VehOwner_Valid,HASH(did)),did,LOCAL);
	fillVehOwner		:=	PROJECT(VehOwner_sort,tVehOwner(LEFT));
	
/**********************************************************/
/* Fill dates for Vehicle/Accident data                   */
/**********************************************************/
	dst_VehBase			:=	DISTRIBUTE(VehBase,HASH(accident_nbr,accident_date));
	srt_VehBase			:=	SORT(dst_VehBase,accident_nbr,-(UNSIGNED4)accident_date,LOCAL);	
	dep_VehBase			:=	DEDUP(srt_VehBase,accident_nbr,LOCAL);							

	Layout_Supplemental.Raw tGetAccidentDate(Layout_Supplemental.Raw vehInput, dep_VehBase baseInput) := 
	TRANSFORM
		SELF.dt_gender	:=	IF(vehInput.gender<>'',(UNSIGNED)baseInput.accident_date,0);
		SELF.dt_race		:=	IF(vehInput.race<>'',(UNSIGNED)baseInput.accident_date,0);
		SELF						:=	vehInput;
	END;				 
					 
	fillAccidentDates	:=	JOIN(	fillVehDriver+fillVehOwner, 
															dep_VehBase, 
															 LEFT.accident_nbr = RIGHT.accident_nbr,
															tGetAccidentDate(LEFT,RIGHT),LEFT OUTER,HASH
														);
					 
/**********************************************************/
/* Combine all of the Physical Attribute Records together */
/**********************************************************/
	physicalAttributes	:= 
						fillDL
						+fillCrims
						+fillSexOff
						+fillVoters
						+filleMerges
						+fillMarDiv
						+fillECrash
						+fillECrashCRU
						+fillAccidentDates;

/**********************************************/
/* DEDUP, Standardize and Filter the raw data */
/**********************************************/
	paDedup					:=	DEDUP(SORT(physicalAttributes,RECORD),ALL);
	paStandardized	:=	PROJECT(paDedup,tStandardize(LEFT));
	filtered_paFlat	:=	paStandardized(	gender<>'' OR hair_color<>'' OR eye_color<>'' OR height<>'' OR 
																			weight<>'' OR race<>'' OR SMT<>''):PERSIST('BestSupplementalStandardized');

/*************************/
/* Create the Parent Set */
/*************************/
	Layout_Supplemental.Base	tParent(RECORDOF(Layout_Supplemental.Raw) sInput)	:= TRANSFORM
		SELF.did	:=	sInput.did;
		SELF			:=	[];
	END;
	parentSet	:=	PROJECT(DEDUP(SORT(filtered_paFlat,did),did),tParent(LEFT));

/***********************************/
/* Create the Denormalized Set     */
/***********************************/
	Layout_Supplemental.Base	tDeNorm(RECORDOF(Layout_Supplemental.Base) lParent, 
																RECORDOF(Layout_Supplemental.Raw) rChild)	:= TRANSFORM
		SELF.process_date		:=	filedate;
		// If gender and source match, we only keep the latest date.
		SELF.gender			:=	IF(rChild.gender='',lParent.gender,
													lParent.gender(source<>rChild.src_gender OR gender<>rChild.gender)+
													IF(lParent.gender(source=rChild.src_gender,gender=rChild.gender)[1].date<rChild.dt_gender,
														DATASET([{rChild.gender,rChild.dt_gender,rChild.src_gender}],Layout_Supplemental.gender_layout),
														lParent.gender(source=rChild.src_gender,gender=rChild.gender)));
		// If hair color and source match, we only keep the latest date.
		SELF.hair_color	:=	IF(rChild.hair_color='',lParent.hair_color,
													lParent.hair_color(source<>rChild.src_hair_color OR hair_color<>rChild.hair_color)+
													IF(lParent.hair_color(source=rChild.src_hair_color,hair_color=rChild.hair_color)[1].date<rChild.dt_hair_color,
														DATASET([{rChild.hair_color,rChild.dt_hair_color,rChild.src_hair_color}],Layout_Supplemental.hair_color_layout),
														lParent.hair_color(source=rChild.src_hair_color,hair_color=rChild.hair_color)));
		// If eye color and source match, we only keep the latest date.
		SELF.eye_color	:=	IF(rChild.eye_color='',lParent.eye_color,
													lParent.eye_color(source<>rChild.src_eye_color OR eye_color<>rChild.eye_color)+
													IF(lParent.eye_color(source=rChild.src_eye_color,eye_color=rChild.eye_color)[1].date<rChild.dt_eye_color,
														DATASET([{rChild.eye_color,rChild.dt_eye_color,rChild.src_eye_color}],Layout_Supplemental.eye_color_layout),
														lParent.eye_color(source=rChild.src_eye_color,eye_color=rChild.eye_color)));
		// If source matches, we only keep the greatest height.  We also store the latest date.
		SELF.height			:=	IF(rChild.height='',lParent.height,
													lParent.height(source<>rChild.src_height)+
													IF(lParent.height(source=rChild.src_height)[1].height<rChild.height OR
															(lParent.height(source=rChild.src_height)[1].height=rChild.height AND
															 lParent.height(source=rChild.src_height)[1].date<rChild.dt_height) ,
														DATASET([{rChild.height,rChild.dt_height,rChild.src_height}],Layout_Supplemental.height_layout),
														lParent.height(source=rChild.src_height)));
		// If source matches, we only keep the latest weight and date.
		SELF.weight			:=	IF(rChild.weight='',lParent.weight,
													lParent.weight(source<>rChild.src_weight)+
													IF(lParent.weight(source=rChild.src_weight)[1].date<rChild.dt_weight,
														DATASET([{rChild.weight,rChild.dt_weight,rChild.src_weight}],Layout_Supplemental.weight_layout),
														lParent.weight(source=rChild.src_weight)));
		// If race and source match, we increase the total counter.  We also keep the latest date.
		SELF.race				:=	IF(rChild.race='',lParent.race,
													lParent.race(source<>rChild.src_race OR race<>rChild.race)+
														DATASET([{
															rChild.race,
															MAX(lParent.race(source=rChild.src_race,race=rChild.race)[1].date,rChild.dt_race),
															rChild.src_race,
															lParent.race(source=rChild.src_race,race=rChild.race)[1].total+1
														}],Layout_Supplemental.race_layout));

		// This concatinates all of the scars, marks and tattoos which have a common source
		// 1) Check if there is anything to add
		// 2) If there is something to add, check if the source already exists.
		// 3) If the source exists, check if this text already exists for that source.
		// 4) If not, concatinate the new data with the already existing data for that source.
		// 5) Else, create new record for that source and add the new text.
		SELF.SMT				:=	IF(rChild.SMT<>'' AND ~EXISTS(lParent.SMT(source=rChild.src_SMT)),
													lParent.SMT+DATASET([{TRIM(rChild.SMT),rChild.dt_SMT,rChild.src_SMT}],Layout_Supplemental.SMT_layout),
													IF(StringLib.StringFindCount(lParent.SMT(source=rChild.src_SMT)[1].SMT,TRIM(rChild.SMT))<>0,
														lParent.SMT,
														lParent.SMT(source<>rChild.src_SMT)+DATASET([{TRIM(rChild.SMT)+' '+
														lParent.SMT(source=rChild.src_SMT)[1].SMT,MAX(rChild.dt_SMT,lParent.SMT(source=rChild.src_SMT)[1].date),rChild.src_SMT}],Layout_Supplemental.SMT_layout))
													);
		SELF						:=	lParent;
	END;
	
/************************************/
/* Build our best supplemental file */
/************************************/
	result			:=	DENORMALIZE(
										SORT(DISTRIBUTE(parentSet,HASH(did)),did,LOCAL), 
										SORT(DISTRIBUTE(filtered_paFlat,HASH(did)),did,LOCAL),
										LEFT.did = RIGHT.did,
										tDeNorm(LEFT,RIGHT),
										LOCAL);

	RETURN result;

END;