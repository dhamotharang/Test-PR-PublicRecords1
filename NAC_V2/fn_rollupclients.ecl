EXPORT fn_rollupclients(DATASET($.Layouts2.rClientEx) clients_in) := FUNCTION

	clients := DEDUP(SORT(DISTRIBUTE(clients_in, HASH32(ClientId)),
							ClientId,CaseId,ProgramState,ProgramCode,GroupId,EffectiveDate,StartDate,EndDate,
										-NAC_V2.fn_lfnversion(filename), local),
							ClientId,CaseId,ProgramState,ProgramCode,GroupId,EffectiveDate,StartDate,EndDate, local);
	return clients;
END;
