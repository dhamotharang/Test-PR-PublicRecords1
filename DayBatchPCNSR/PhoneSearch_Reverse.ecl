import DayBatchPCNSR;

export PhoneSearch_Reverse(GROUPED DATASET(DayBatchPCNSR.Layout_PCNSR_Linked) pcnsrInput) := FUNCTION

	K := DayBatchPCNSR.Key_PCNSR_Phone;
	
	DayBatchPCNSR.Layout_PCNSR_Linked formatOutput(pcnsrInput l,K r,STRING m) := TRANSFORM
		MAC_Link_PCNSR_To_Input(l,r,m)
	END;
	
	match_Phone := JOIN(pcnsrInput,
											K,
											LENGTH(LEFT.indata.phoneno) = 10 AND
											KEYED(LEFT.indata.phoneno[1..3] = RIGHT.area_code) AND
											KEYED(LEFT.indata.phoneno[4..10] = RIGHT.phone_number),
											formatOutput(LEFT,RIGHT,'P'),LEFT OUTER, ATMOST(7500)
											);
	ungrp := UNGROUP(match_Phone);
	srted := GROUP(SORT(ungrp,indata.acctno,-outdata.refresh_date),indata.acctno);
	RETURN srted;
END;