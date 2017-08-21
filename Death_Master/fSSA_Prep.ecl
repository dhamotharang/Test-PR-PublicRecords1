IMPORT Address, ut, VersionControl, NID, Scrubs, Scrubs_Death_Master_SSA, _Control, tools, STD,data_services,PromoteSupers;
EXPORT fSSA_Prep(STRING	runDate, string emailList='') := FUNCTION

	SpraySSAUpdates	:=	Death_Master.Spray_SSADeathmaster();
	
	dSSAUpdates			:=	Death_Master.File_SSADeathmaster;
	dOldSSARecords	:= 	Death_Master.Files.SSA_File_Restricted;
	dOldSSADeletes	:= 	Death_Master.Files.Deletes;
	SSAFiledate			:=	VersionControl.fGetFilenameVersion('~thor_data400::in::ssa_deathm_raw');
	VersionDate			:=	IF(SSAFiledate=0, runDate, (STRING8)SSAFiledate);

	Death_Master.Layout_States.Death_Master_Base tPrepUpdates(dSSAUpdates pInput)	:= 
	TRANSFORM
		SELF.filedate						:= 	VersionDate;
		SELF.rec_type_orig			:= 	pInput.rec_type;
		SELF.lname							:= 	StringLib.StringToUpperCase(Death_Master.fn_cleanNULL(pInput.lname));
		SELF.name_suffix				:=	StringLib.StringToUpperCase(Death_Master.fn_cleanNULL(pInput.name_suffix));
		SELF.fname							:= 	StringLib.StringToUpperCase(Death_Master.fn_cleanNULL(pInput.fname));
		SELF.mname							:= 	StringLib.StringToUpperCase(Death_Master.fn_cleanNULL(pInput.mname));
		SELF.ssn								:=	Death_Master.fn_clean_death_ssn(pInput.ssn);
		SELF										:=	pInput;
		SELF										:=	[];	
	END;

	// Transform new SSA file into Death Master Base layout.
	dPreppedSSAUpdates	:= PROJECT(dSSAUpdates,tPrepUpdates(LEFT));

	Clean_Name(DATASET(RECORDOF(dPreppedSSAUpdates)) pInput) := FUNCTION

		NID.Mac_CleanParsedNames(pInput, cleaned_names, fname, mname, lname, name_suffix, normalizeDualNames:=true);

		RETURN cleaned_names;

	END;

	Standardize_Name(DATASET(RECORDOF(dPreppedSSAUpdates)) pPreProcessInput) := FUNCTION

		// Cannot call the NID directly here, it gives an error saying "cannot associate a side effect with
		// this type of definition - action must precede an expression."
		cleaned_input := Clean_Name(pPreProcessInput);
		
		RECORDOF(dPreppedSSAUpdates) add_clean_name(cleaned_input L) := TRANSFORM
			SELF.clean_fname       :=	L.cln_fname;
			SELF.clean_mname       :=	L.cln_mname;
			SELF.clean_lname       :=	L.cln_lname;
			SELF.clean_name_suffix :=	L.cln_suffix;
			SELF := L;
		END;
		
		RETURN PROJECT(cleaned_input, add_clean_name(LEFT));

	END;
	
	dCleanedSSAUpdates	:=	Standardize_Name(dPreppedSSAUpdates):persist('~persist::death_master_SSA_cleaned_records');
	
//********************************Apply Scrubs before building the base file***************************
	recordsToScrub				:=	PROJECT(dCleanedSSAUpdates,
															TRANSFORM(Scrubs_Death_Master_SSA.Layout_Death_Master_SSA,
																SELF:=LEFT));											//	Remove Scrub Bits
																
	deployScrubs					:=	Scrubs.ScrubsPlus_PassFile(recordsToScrub,'Death_Master_SSA','Scrubs_Death_Master_SSA','Scrubs_Death_Master_SSA','',runDate,emailList);

//****************************************************************************************************
	
	//dScrubbedSSAUpdates	:=	PROJECT(dSSAScrubbedRecords.BitmapInfile,TRANSFORM(RECORDOF(dOldSSARecords),SELF:=LEFT)):persist('~persist::death_master_ssa_scrubbed_records');
	dSortSSARecords			:=	SORT(DISTRIBUTE(dOldSSARecords + dCleanedSSAUpdates,HASH(ssn)),ssn,-filedate,LOCAL);

	RECORDOF(dSortSSARecords) tRollupRecords(dSortSSARecords L, dSortSSARecords R) := 
	TRANSFORM
		SELF.rec_type					:=	IF(L.rec_type = 'D', 'D', IF(L.rec_type = 'C', 'C', 'A')); 
		SELF.zip_lastres			:=	IF(L.rec_type IN ['D','A'], L.zip_lastres, IF(L.zip_lastres<>'',L.zip_lastres,R.zip_lastres));
		SELF.zip_lastpayment	:=	IF(L.rec_type IN ['D','A'], L.zip_lastpayment, IF(L.zip_lastpayment<>'',L.zip_lastpayment,R.zip_lastpayment));
		SELF.state						:=	IF(L.rec_type IN ['D','A'], L.state, IF(L.state<>'',L.state,R.state));
		SELF.st_country_code	:=	IF(L.rec_type IN ['D','A'], L.st_country_code, IF(L.st_country_code<>'',L.st_country_code,R.st_country_code));
		SELF.fipscounty				:=	IF(L.rec_type IN ['D','A'], L.fipscounty, IF(L.fipscounty<>'',L.fipscounty,R.fipscounty));
		SELF									:=	L; 
	END; 

	// Rollup keeping information from the newest record
	dNewSSARecords  :=	ROLLUP(dSortSSARecords,	
															LEFT.ssn	=	RIGHT.ssn,	
															tRollupRecords(LEFT, RIGHT), LOCAL);

	dNewSSAAddChanges				:=	dNewSSARecords(rec_type <> 'D');	// Add&Change records
	dNewSSADeletes					:=	PROJECT(dNewSSARecords(rec_type = 'D'),Death_Master.Layouts.Deletes);	// Delete Records
	
	PromoteSupers.MAC_SF_BuildProcess(dNewSSAAddChanges,Death_Master.Files.vSSARestrictedFileName,NewSSAAddChanges,3,,TRUE);
	PromoteSupers.MAC_SF_BuildProcess(dOldSSADeletes+dNewSSADeletes,Death_Master.Files.vDeletesFileName,AppendNewSSADeletes,3,,TRUE);
	
	RETURN //deployScrubs;
		IF	(FileServices.FileExists(Death_Master.Files.vSSARestrictedFileName+'_'+WORKUNIT), // Check if we ran this already.
			OUTPUT(Death_Master.Files.vSSARestrictedFileName+' built in previous run.'),
			SEQUENTIAL (
				SpraySSAUpdates,
				
				//Only write Adds and Changes if there is something to write.
				IF(COUNT(dSSAUpdates)>0,
					NewSSAAddChanges		),
				//Only write Deletes if there is something to write.
				IF(COUNT(dNewSSADeletes)>0,
					AppendNewSSADeletes		),
					deployScrubs
			)
		);

END;
