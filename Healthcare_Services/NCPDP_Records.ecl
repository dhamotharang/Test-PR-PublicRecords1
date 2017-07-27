import iesp;
export NCPDP_Records() := module

	Export getRecords(dataset(NCPDP_Layouts.autokeyInput) inputData) := function
		//Do Search Keys to get data keys
		outRecs := NCPDP_SearchKeys.getRecords(inputData);
		//Do Penalty logic
		outRecsPenalty := NCPDP_Functions.doPenalty(outRecs, inputData);
		return outRecsPenalty;
	end;
	Export getRecordsBatch(dataset(NCPDP_Layouts.autokeyInput) inputData) := function
		rawRecs := getRecords(inputData);
		return rawRecs;
	end;

end;
