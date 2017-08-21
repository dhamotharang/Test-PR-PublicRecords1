IMPORT Death_Master, HEADER, ADDRESS, UT;
EXPORT proc_build_state_data(STRING	VersionDate, BOOLEAN spray=FALSE, BOOLEAN promote=FALSE) := FUNCTION

	// Spray State data
	sprayStates			:= IF(spray,Death_Master.proc_spray_states(VersionDate));
	
	// Process State Data
	processRecords	:= Death_Master.Persist_States_Joined(VersionDate);

	// Promote State data
	promoteStates		:= IF(promote,Death_Master.proc_spray_states(VersionDate,promote));
		
	// Plus File
	RETURN SEQUENTIAL (
		sprayStates,
		processRecords,
		promoteStates
	);
END;
