EXPORT fn_rollupclients(DATASET($.Layouts2.rClientEx) clients_in) := 
				DEDUP(SORT(DISTRIBUTE(clients_in, HASH32(ClientId)),
						ClientId,CaseId,ProgramState,ProgramCode,GroupId,Eligibility,	
										NAC_V2.fn_lfnversion(filename), seqnum, local),
						ClientId,CaseId,ProgramState,ProgramCode,GroupId,Eligibility, 
							left.StartDate <= right.EndDate, left.EndDate >= right.StartDate,
						 right, local);
