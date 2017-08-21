IMPORT Death_Master, HEADER, ADDRESS, UT;
EXPORT proc_spray_states(STRING	VersionDate, BOOLEAN promote=FALSE) := FUNCTION
	spray_CA						:= Death_Master.Spray_CaliforniaStateDeathData;
	// spray_CA_1999				:= Death_Master.Spray_CaliforniaStateDeathData_1999;
	spray_GA						:= Death_Master.Spray_GeorgiaStateDeathData;
	spray_MI 						:= Death_Master.Spray_MichiganStateDeathData;
	spray_MT						:= Death_Master.Spray_MontanaStateDeathData;
	spray_NV						:= Death_Master.Spray_NevadaStateDeathData;
	// spray_NV_1980_2012	:= Death_Master.Spray_NevadaStateDeathData_1980_2012;
	spray_OH						:= Death_Master.Spray_OhioStateDeathData;

	RETURN PARALLEL(
		spray_CA(VersionDate, promote),
		// spray_CA_1999(VersionDate, promote),
		spray_GA(VersionDate, promote),
		spray_MI(VersionDate, promote),
		spray_MT(VersionDate, promote),
		spray_NV(VersionDate, promote),
		// spray_NV_1980_2012(VersionDate, promote),
		spray_OH(VersionDate, promote)
	);
END;
