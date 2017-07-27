import DayBatchPCNSR;

export srtBy_acct_priority_refDate(GROUPED DATASET(DayBatchPCNSR.Layout_PCNSR_Linked) l,STRING20 search) := FUNCTION
	ungrp := UNGROUP(l);
	srted := GROUP(SORT(ungrp,indata.acctno,DayBatchPCNSR.getPriority(matchCode,search),-outdata.household_arrival_date,-outdata.refresh_date),indata.acctno);
	RETURN srted;
END;