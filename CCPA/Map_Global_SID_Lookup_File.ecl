	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Create Consolidated Global_SID Lookup table, Using Orbit table////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	OrbitGlobalSid 			:= CCPA.File_Global_SID.orbitTable;		//Updated Orbit table
	DataGlobalSid				:= CCPA.File_Global_SID.lookupTable;	//Existing Consolidated Global_SID Lookup table
	
	dOrbitGlobalSid			:= DEDUP(SORT(DISTRIBUTE(OrbitGlobalSid, HASH32(dataset_id)), dataset_id, LOCAL), dataset_id, LOCAL);
	dDataGlobalSid			:= SORT(DISTRIBUTE(DataGlobalSid, HASH32(dataset_id)), dataset_id, LOCAL);
	
	Layout_Global_SID.lookupTableLayout addTr(dDataGlobalSid L, dOrbitGlobalSid R):= TRANSFORM
		SELF.global_sid		:= R.glb_srcid;
		SELF 							:= L;
	END;
	
	dDataOrbitJoinSid 	:= JOIN(dDataGlobalSid, dOrbitGlobalSid, 
															LEFT.dataset_id = RIGHT.dataset_id,
															addTr(LEFT, RIGHT), LEFT OUTER); 

	ddDataOrbitJoinSid	:= DEDUP(SORT(DISTRIBUTE(dDataOrbitJoinSid, HASH32(dataset_id)), RECORD, LOCAL), RECORD, LOCAL); //Updated Consolidated Global_SID Lookup table

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Run Checks////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	tGlobalSID 					:= TABLE(ddDataOrbitJoinSid, {roxie_packages, global_sid, cnt:= COUNT(GROUP)}, roxie_packages, global_sid);
	
	//Check for Multiple Global_SIDs
	CheckDatasetDups		:= tGlobalSID(cnt > 1 AND global_sid != '');
	aCheckDatasetDups 	:= IF(EXISTS(CheckDatasetDups), 
														PARALLEL(	OUTPUT('***WARNING: DUPLICATE Global_SIDs for Dataset***', NAMED('WarningDups')), 
																			OUTPUT(CheckDatasetDups, ALL, NAMED('WarningDups_Sample'))));
  
	//Check for Blank Global_SIDs
	CheckGlobalSID			:= tGlobalSID(global_sid = '');
	aCheckGlobalSID 		:= IF(EXISTS(CheckGlobalSID), 
														PARALLEL(	OUTPUT('***WARNING: Global_SIDs is BLANK for Dataset***', NAMED('WarningBlanks')), 
																			OUTPUT(CheckGlobalSID, ALL, NAMED('WarningBlanks_Sample')))); 

	ORDERED(aCheckDatasetDups, aCheckGlobalSID);	
	
EXPORT Map_Global_SID_Lookup_File := ddDataOrbitJoinSid;