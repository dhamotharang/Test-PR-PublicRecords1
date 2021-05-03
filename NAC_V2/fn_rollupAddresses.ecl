EXPORT fn_rollupAddresses(DATASET($.Layouts2.rAddressEx) addr_in) := 

			DEDUP(SORT(DISTRIBUTE(addr_in, HASH32(CaseId)),
						CaseId,ClientId,ProgramState,ProgramCode,GroupId, AddressType,
										$.fn_lfnversion(filename), seqnum, local),
						CaseId,ClientId,ProgramState,ProgramCode,GroupId, AddressType,
						 right, local);