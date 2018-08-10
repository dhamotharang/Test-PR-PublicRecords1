IMPORT Death_Master, Header, ut, Scrubs, Scrubs_Death_Master_Supplemental, _Control,tools, STD, codes, PromoteSupers;

EXPORT fStates_Prep(STRING	VersionDate, string emailList='') := FUNCTION

	spray_states					:=	Death_Master.fSprayStateFiles;
	
	dNewStateRecords
	 := 
			Death_Master.Mapping_CA
		+	Death_Master.Mapping_CT
		+	Death_Master.Mapping_GA
		+	Death_Master.Mapping_FL
		+	Death_Master.Mapping_KY
		+	Death_Master.Mapping_MA
		+	Death_Master.Mapping_MI
		+	Death_Master.Mapping_MN
		+	Death_Master.Mapping_MT
		+	Death_Master.Mapping_NC
		+	Death_Master.Mapping_NV
		+	Death_Master.Mapping_OH
		+	Death_Master.Mapping_VA;

	dOldSuppRecords				:= Death_Master.Files.States_File;
	UNSIGNED vMaxRecordID := MAX(dOldSuppRecords(codes.St2Name(state_death_id[1..2])<>''),(UNSIGNED)state_death_id[3..]);
	// UNSIGNED vMaxRecordID := 0;//Test Only
	
	dCleanName 			:= Death_Master.fn_cleanName(dNewStateRecords);
	dCleanAddress		:= Death_Master.fn_cleanAddress(dCleanName);
	dNewSuppRecords	:= Death_Master.fn_fillSupplementalFields(dCleanAddress, VersionDate, vMaxRecordID):persist('~persist::death_master_states_cleaned_records');
	
//********************************Apply Scrubs before building the base file***************************
	recordsToScrub				:=	PROJECT(dNewSuppRecords,
															TRANSFORM(Scrubs_Death_Master_Supplemental.Layout_Death_Master_Supplemental,
																SELF:=LEFT));													//	Remove Scrub Bits
	deployScrubs					:=	Scrubs.ScrubsPlus_PassFile(recordsToScrub,'Scrubs_Death_Master_Supplemental','Scrubs_Death_Master_Supplemental','Scrubs_Death_Master_Supplemental','',VersionDate,emailList);
//****************************************************************************************************
	
	//dScrubbedSuppRecords	:=	PROJECT(dSuppScrubbedRecords.BitmapInfile,TRANSFORM(RECORDOF(dOldSuppRecords),SELF:=LEFT)):persist('~persist::death_master_states_scrubbed_records');
	dNoStateFN						:=	(dNewSuppRecords + dOldSuppRecords)(StateFN='');

	dStateRecords					:=	DISTRIBUTE((dNewSuppRecords + dOldSuppRecords)(StateFN<>''), HASH(source_state, StateFN));
	dSortStateRecords			:=	SORT(dStateRecords, source_state, StateFN, -PROCESS_DATE, LOCAL);
	dRollupStateRecords		:=	ROLLUP(	dSortStateRecords,	
																			LEFT.source_state	=	RIGHT.source_state	AND 
																			LEFT.StateFN			=	RIGHT.StateFN,
																		TRANSFORM(RECORDOF(LEFT),SELF:=LEFT),LOCAL);

	// DEDUP and leave the latest record in supp file. 
	dCombined      := DISTRIBUTE(dRollupStateRecords+dNoStateFN,  HASH(source_state, fname, lname)); 
  dCombinedSort  := SORT(dCombined,	SOURCE_STATE, DECEDENT_NAME, DECEDENT_RACE, DECEDENT_ORIGIN, DECEDENT_SEX, 
																		DECEDENT_AGE, EDUCATION, OCCUPATION, WHERE_WORKED, CAUSE, SSN, DOB, DOD, 
																		BIRTHPLACE, MARITAL_STATUS, FATHER, MOTHER, YEAR, COUNTY_RESIDENCE, COUNTY_DEATH, 
																		ADDRESS, AUTOPSY, AUTOPSY_FINDINGS, PRIMARY_CAUSE_OF_DEATH, 
																		UNDERLYING_CAUSE_OF_DEATH, MED_EXAM, EST_LIC_NO, DISPOSITION, DISPOSITION_DATE, 
																		WORK_INJURY, INJURY_DATE, INJURY_TYPE, INJURY_LOCATION, SURG_PERFORMED, 
																		SURGERY_DATE, HOSPITAL_STATUS, PREGNANCY, FACILITY_DEATH, EMBALMER_LIC_NO, 
																		DEATH_TYPE, TIME_DEATH, BIRTH_CERT, CERTIFIER, CERT_NUMBER, LOCAL_FILE_NO, VDI, 
																		CITE_ID, FILE_ID, AMENDMENT_CODE, AMENDMENT_YEAR, _ON_LEXIS, _FS_PROFILE, 
																		US_ARMED_FORCES, PLACE_OF_DEATH, STATE_DEATH_FLAG, -PROCESS_DATE, LOCAL); 
  dCombinedDedup := DEDUP(dCombinedSort, SOURCE_STATE, DECEDENT_NAME, DECEDENT_RACE, DECEDENT_ORIGIN, DECEDENT_SEX, 
																		DECEDENT_AGE, EDUCATION, OCCUPATION, WHERE_WORKED, CAUSE, SSN, DOB, DOD, 
																		BIRTHPLACE, MARITAL_STATUS, FATHER, MOTHER, YEAR, COUNTY_RESIDENCE, COUNTY_DEATH, 
																		ADDRESS, AUTOPSY, AUTOPSY_FINDINGS, PRIMARY_CAUSE_OF_DEATH, 
																		UNDERLYING_CAUSE_OF_DEATH, MED_EXAM, EST_LIC_NO, DISPOSITION, DISPOSITION_DATE, 
																		WORK_INJURY, INJURY_DATE, INJURY_TYPE, INJURY_LOCATION, SURG_PERFORMED, 
																		SURGERY_DATE, HOSPITAL_STATUS, PREGNANCY, FACILITY_DEATH, EMBALMER_LIC_NO, 
																		DEATH_TYPE, TIME_DEATH, BIRTH_CERT, CERTIFIER, CERT_NUMBER, LOCAL_FILE_NO, VDI,
																		CITE_ID, FILE_ID, AMENDMENT_CODE, AMENDMENT_YEAR, _ON_LEXIS,_FS_PROFILE, 
																		US_ARMED_FORCES, PLACE_OF_DEATH, STATE_DEATH_FLAG, LOCAL):persist('death_states_deduped');

	PromoteSupers.MAC_SF_BuildProcess(dCombinedDedup,Death_Master.Files.vStatesFileName,statesResult,3,,TRUE);

	RETURN //deployScrubs;
		IF	(FileServices.FileExists(Death_Master.Files.vStatesFileName+'_'+WORKUNIT), // Check if we ran this already.
			OUTPUT(Death_Master.Files.vStatesFileName+' built in previous run.'),
			SEQUENTIAL (
				spray_states(VersionDate,TRUE),	// Promote the State Records from the previous week to the history file.
				spray_states(VersionDate), 			// Spray this week's files for processing.
				deployScrubs,
				statesResult
			)
		);

END;
