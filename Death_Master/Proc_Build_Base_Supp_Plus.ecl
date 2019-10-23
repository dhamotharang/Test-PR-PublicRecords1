IMPORT Death_Master, Header, ut, PromoteSupers;

EXPORT Proc_Build_Base_Supp_Plus(STRING	VersionDate) := FUNCTION

	suppSuperFileName			:=	'~thor_data400::base::death_master_supplemental';
	plusSuperFileName			:=	'~thor_data400::base::death_master_plus';
	suppSuperFileName_SSA	:=	'~thor_data400::base::death_master_supplemental_ssa';
	plusSuperFileName_SSA	:=	'~thor_data400::base::death_master_plus_ssa';
	 
															
	process_SSA				:=	Death_Master.fSSA_Prep;
	process_States		:=	Death_Master.fStates_Prep;

  // Process the States data into the Plus format and manually suppress any bad records
	suppressSSNs			:=	OUTPUT(Death_Master.Files.SSA_File_Restricted(ssn IN Death_Master.Files.BadSSNSet),NAMED('Suppressed_by_SSN'));
	suppressStateDIDs	:=	OUTPUT(Death_Master.Files.States_File(state_death_id IN Death_Master.Files.BadStateDIDSet),NAMED('Suppressed_by_StateDID'));
  dSSARecords				:=	Death_Master.Files.SSA_File_Restricted(ssn NOT IN Death_Master.Files.BadSSNSet);
	dStateRecords			:=	Death_Master.Files.States_File(state_death_id NOT IN Death_Master.Files.BadStateDIDSet);
	dStatePlusRecords	:=	Death_Master.fn_supplemental_to_plus_layout(dStateRecords);
	
	// Process the SSA data into the Plus format
	Header.layout_death_master_plus tSSAtoPlus(dSSARecords pInput) := 
	TRANSFORM 	
		SELF.state_death_flag	:=	'N';
		SELF									:=	pInput;
		SELF									:=	[];
	END;
	dSSAPlusRecords	:=	PROJECT(dSSARecords,tSSAtoPlus(LEFT));
	
	// apply SSN fix prior to Rollup
	dDeathSSNFix	:=	header.fn_compare_ssa_and_direct_ssns(dStatePlusRecords+dSSAPlusRecords);
	
	// Rollup Plus file. If update record comes in state_death_id will not be changed.
  dPlusDist_SSA  := DISTRIBUTE(dDeathSSNFix,HASH(ssn,lname,fname)); 
	dPlusSort_SSA  := SORT(dPlusDist_SSA,ssn,lname,fname,mname[1],dod8,dob8,zip_lastres,state_death_flag,-filedate,LOCAL); 
	
	RECORDOF(dPlusSort_SSA) tRollupRecords(dPlusSort_SSA L, dPlusSort_SSA R) := 
	TRANSFORM 	
		SELF.state					:=	IF(L.state <>'', L.state, R.state); 
		SELF.fipsCounty			:=	IF(L.fipsCounty <>'', L.fipsCounty, R.fipsCounty); 
		SELF 								:=	L; 
	END; 
	
	dPlusOut_SSA  := ROLLUP(dPlusSort_SSA,	
														LEFT.ssn							=	RIGHT.ssn 				AND 
														LEFT.lname						=	RIGHT.lname				AND 
														LEFT.fname						=	RIGHT.fname				AND 
														LEFT.mname[1]					=	RIGHT.mname[1]		AND 
														LEFT.dod8							=	RIGHT.dod8				AND 
														LEFT.dob8							=	RIGHT.dob8				AND 														
														LEFT.zip_lastres			=	RIGHT.zip_lastres	AND 
														LEFT.state_death_flag	=	RIGHT.state_death_flag,
													tRollupRecords(LEFT, RIGHT), LOCAL):persist('death_states_rollup_ssa');
													
	dPlusOut	:=	dPlusOut_SSA(state_death_flag='Y' OR 
														(state_death_flag='N' AND ~Death_Master.isDateSSARestricted(dod8[5..8]+dod8[1..4])));

	// Keep Plus state_death_id's in Supp	
	dSuppOut_SSA := JOIN(	DISTRIBUTE(dStateRecords(state_death_id<>''),HASH(state_death_id)),
												DISTRIBUTE(dPlusOut(state_death_id<>''),HASH(state_death_id)), 
												TRIM(LEFT.state_death_id,LEFT,RIGHT)	=	TRIM(RIGHT.state_death_id,LEFT,RIGHT), 
												TRANSFORM({dStateRecords}, SELF	:= LEFT), 
												LOCAL);
									
	PromoteSupers.MAC_SF_BuildProcess(dPlusOut_SSA,plusSuperFileName_SSA,plusResult_SSA,3,,TRUE);
	PromoteSupers.MAC_SF_BuildProcess(dPlusOut,plusSuperFileName,plusResult,3,,TRUE);
	PromoteSupers.MAC_SF_BuildProcess(dSuppOut_SSA,suppSuperFileName_SSA,suppResult_SSA,3,,TRUE);
	PromoteSupers.MAC_SF_BuildProcess(dSuppOut_SSA,suppSuperFileName,suppResult,3,,TRUE);

	RETURN SEQUENTIAL (
		process_SSA(VersionDate),
		process_States(VersionDate),
		suppressSSNs,
		suppressStateDIDs,
		plusResult_SSA,
		plusResult,
		suppResult_SSA,
		suppResult
	);

END;