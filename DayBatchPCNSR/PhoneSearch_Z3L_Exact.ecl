import DayBatchPCNSR,Address,DayBatchUtils;

export PhoneSearch_Z3L_Exact(GROUPED DATASET(DayBatchPCNSR.Layout_PCNSR_Linked) pcnsrInput) := FUNCTION
	
	PCNSRData := DayBatchPCNSR.Key_PCNSR_LZ3;

	DayBatchPCNSR.Layout_PCNSR_Linked formatOutput(pcnsrInput l,PCNSRData r,STRING m) := TRANSFORM
		MAC_Link_PCNSR_To_Input(l,r,m)
	END;
	
	usePCNSRInput := pcnsrInput;
	
	matchZ3L := JOIN(usePCNSRInput,
									PCNSRData,
									LEFT.outdata.phone_number='' AND
									LEFT.indata.z5<>'' AND LEFT.indata.prim_name<>'' AND LEFT.indata.name_last<>'' AND
									KEYED(LEFT.indata.name_last = RIGHT.lname) AND
									KEYED(LEFT.indata.z5 = RIGHT.zip) AND
									KEYED(LEFT.indata.prim_name = RIGHT.prim_name),
									formatOutput(LEFT,RIGHT,'3Z'),LEFT OUTER,ATMOST(7500));
	
	RETURN matchZ3L;

END;