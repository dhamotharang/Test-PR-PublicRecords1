/**
  This is intended for use for processing new case records in a logical file or superfile
	Use most recent Case data
**/
EXPORT fn_rollupCases (DATASET(nac_v2.Layouts2.rCaseEx) cases_in) := 

		DEDUP(SORT(DISTRIBUTE(cases_in, HASH32(CaseId)),
							CaseId,ProgramState,ProgramCode,GroupId,-$.fn_lfnversion(filename), local),
							CaseId,ProgramState,ProgramCode,GroupId, local);