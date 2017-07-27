import DayBatchPCNSR;

export dedup_Phone(GROUPED DATASET(DayBatchPCNSR.Layout_PCNSR_Linked) l,STRING20 search) := FUNCTION
	ungrp := UNGROUP(l);
	srted := GROUP(SORT(ungrp,indata.acctno,outdata.phone_number,
											DayBatchPCNSR.getPriority(matchCode,search),
											-outdata.household_arrival_date,
											-outdata.refresh_date),
								 indata.acctno);
	
	deduped := DEDUP(srted,outdata.phone_number);
	
	ungrpDedup := UNGROUP(deduped);
	
	RETURN GROUP(SORT(ungrpDedup,
										indata.acctno,
										DayBatchPCNSR.getPriority(matchCode,search),
										-outdata.household_arrival_date,
								 		-outdata.refresh_date),
							 indata.acctno);
END;