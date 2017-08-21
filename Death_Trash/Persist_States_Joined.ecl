IMPORT Death_Master, Header, ut;

EXPORT Persist_States_Joined(STRING	VersionDate) := FUNCTION

	suppSuperFileName		:=	'~thor_data400::Base::Death_Master_Supplemental_States';
	plusSuperFileName		:=	'~thor_data400::Base::Death_Master_Plus_States';

	dJoined
	 := Death_Master.Mapping_CA
	 +	Death_Master.Mapping_GA
	 +	Death_Master.Mapping_MI
	 +	Death_Master.Mapping_MT
	 +	Death_Master.Mapping_NV
	 +	Death_Master.Mapping_OH;

  oldRecords						:= DATASET(suppSuperFileName, Header.layout_death_master_supplemental, THOR);
	UNSIGNED vMaxRecordID := MAX(oldRecords,(UNSIGNED)state_death_id[3..]);
	
	cleanName 		:= Death_Master.fn_cleanName(dJoined);
	cleanAddress	:= Death_Master.fn_cleanAddress(cleanName(fname <> '' AND lname <> ''));
	newRecords		:= Death_Master.fn_fillSupplementalFields(cleanAddress, VersionDate, vMaxRecordID);

	// DEDUP and leave the latest record in supp file. 
	Combined       := DISTRIBUTE(newRecords + oldRecords,  HASH(source_state, fname, lname)); 
  CombinedSort   := SORT(Combined, 	SOURCE_STATE, DECEDENT_NAME, DECEDENT_RACE, DECEDENT_ORIGIN, DECEDENT_SEX, 
																		DECEDENT_AGE, EDUCATION, OCCUPATION, WHERE_WORKED, CAUSE, SSN, DOB, DOD, 
																		BIRTHPLACE, MARITAL_STATUS, FATHER, MOTHER, YEAR, COUNTY_RESIDENCE, COUNTY_DEATH, 
																		ADDRESS, AUTOPSY, AUTOPSY_FINDINGS, PRIMARY_CAUSE_OF_DEATH, 
																		UNDERLYING_CAUSE_OF_DEATH, MED_EXAM, EST_LIC_NO, DISPOSITION, DISPOSITION_DATE, 
																		WORK_INJURY, INJURY_DATE, INJURY_TYPE, INJURY_LOCATION, SURG_PERFORMED, 
																		SURGERY_DATE, HOSPITAL_STATUS, PREGNANCY, FACILITY_DEATH, EMBALMER_LIC_NO, 
																		DEATH_TYPE, TIME_DEATH, BIRTH_CERT, CERTIFIER, CERT_NUMBER, LOCAL_FILE_NO, VDI, 
																		CITE_ID, FILE_ID, AMENDMENT_CODE, AMENDMENT_YEAR, _ON_LEXIS, _FS_PROFILE, 
																		US_ARMED_FORCES, PLACE_OF_DEATH, STATE_DEATH_FLAG, -PROCESS_DATE, LOCAL); 
  CombinedDedup  := DEDUP(CombinedSort, SOURCE_STATE, DECEDENT_NAME, DECEDENT_RACE, DECEDENT_ORIGIN, DECEDENT_SEX, 
																		DECEDENT_AGE, EDUCATION, OCCUPATION, WHERE_WORKED, CAUSE, SSN, DOB, DOD, 
																		BIRTHPLACE, MARITAL_STATUS, FATHER, MOTHER, YEAR, COUNTY_RESIDENCE, COUNTY_DEATH, 
																		ADDRESS, AUTOPSY, AUTOPSY_FINDINGS, PRIMARY_CAUSE_OF_DEATH, 
																		UNDERLYING_CAUSE_OF_DEATH, MED_EXAM, EST_LIC_NO, DISPOSITION, DISPOSITION_DATE, 
																		WORK_INJURY, INJURY_DATE, INJURY_TYPE, INJURY_LOCATION, SURG_PERFORMED, 
																		SURGERY_DATE, HOSPITAL_STATUS, PREGNANCY, FACILITY_DEATH, EMBALMER_LIC_NO, 
																		DEATH_TYPE, TIME_DEATH, BIRTH_CERT, CERTIFIER, CERT_NUMBER, LOCAL_FILE_NO, VDI,
																		CITE_ID, FILE_ID, AMENDMENT_CODE, AMENDMENT_YEAR, _ON_LEXIS,_FS_PROFILE, 
																		US_ARMED_FORCES, PLACE_OF_DEATH, STATE_DEATH_FLAG, LOCAL):persist('death_states_deduped');

  // Process the Supplemental data into the Plus format
	PlusRecords		:= Death_Master.fn_supplemental_to_plus_layout(CombinedDedup);

	// Rollup Plus file. If update record comes in state_death_id will be changed.
  PlusDist  := DISTRIBUTE(PlusRecords,HASH(fname, lname)); 
	plusSort  := SORT(PlusDist,fname,lname,mname,dod8,dob8,ssn,zip_lastres,state_death_flag,-filedate,LOCAL); 
	
	RECORDOF(plusSort) tRollupRecords(plusSort L, plusSort R) := 
	TRANSFORM 	
		SELF.state			:=	IF(L.state <>'', L.state, R.state); 
		SELF.fipsCounty	:=	IF(L.fipsCounty <>'', L.fipsCounty, R.fipsCounty); 
		SELF 						:=	L; 
	END; 
	
	plusOut  := ROLLUP(plusSort,	LEFT.fname						=	RIGHT.fname				AND 
	                              LEFT.lname						=	RIGHT.lname				AND 
																LEFT.mname						=	RIGHT.mname				AND 
																LEFT.dod8							=	RIGHT.dod8				AND 
																LEFT.dob8							=	RIGHT.dob8				AND 
																LEFT.ssn							=	RIGHT.ssn 				AND 
																LEFT.zip_lastres			=	RIGHT.zip_lastres	AND 
																LEFT.state_death_flag	=	RIGHT.state_death_flag, // Won't be needed now but useful when we convert Ab Inito to ECL 
	                              tRollupRecords(LEFT, RIGHT), LOCAL):persist('death_states_rollup');

	// Keep Plus state_death_id's in Supp	
	suppOut := JOIN(	DISTRIBUTE(CombinedDedup,HASH(state_death_id)),
										DISTRIBUTE(plusOut,HASH(state_death_id)), 
	                  TRIM(LEFT.state_death_id,LEFT,RIGHT)	=	TRIM(RIGHT.state_Death_id,LEFT,RIGHT), 
										TRANSFORM({CombinedDedup}, SELF	:= LEFT), 
										LOCAL);
	

										
	ut.MAC_SF_BuildProcess(plusOut,plusSuperFileName,plusResult,2);
	ut.MAC_SF_BuildProcess(suppOut,suppSuperFileName,suppResult,2);

	RETURN SEQUENTIAL (
		plusResult,
		suppResult
	);

END;