import DayBatchPCNSR;

export PhoneSearch_Simple( GROUPED DATASET(DayBatchPCNSR.Layout_PCNSR_Linked) indata_grouped) := FUNCTION

	regrp := GROUP(UNGROUP(indata_grouped),indata.acctno);													
	//EXACT MATCHES
	match137Z := DayBatchPCNSR.PhoneSearch_137Z_Exact(regrp);
	
	match13Z := DayBatchPCNSR.PhoneSearch_13Z_Exact(match137Z);
	
	matchZ3L := DayBatchPCNSR.PhoneSearch_Z3L_Exact(match13Z);
	
	RETURN matchZ3L;

END;