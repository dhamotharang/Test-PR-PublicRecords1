import DayBatchPCNSR,Address,DayBatchUtils;

export PhoneSearch_13Z_Exact(GROUPED DATASET(DayBatchPCNSR.Layout_pcnsr_linked) pcnsrInput) := FUNCTION
	
	PCNSRData := DayBatchPCNSR.Key_PCNSR_Z317LF;

	DayBatchPCNSR.Layout_PCNSR_Linked formatOutput(pcnsrInput l,PCNSRData r,STRING m) := TRANSFORM
		MAC_Link_PCNSR_To_Input(l,r,m)
	END;
	
	match13Z := JOIN(pcnsrInput,
									PCNSRData,
									LEFT.outdata.phone_number='' AND
									LEFT.indata.z5<>'' AND LEFT.indata.prim_name<>'' AND LEFT.indata.prim_range<>'' AND
									KEYED(LEFT.indata.z5 = RIGHT.zip) AND
									KEYED(LEFT.indata.prim_range = RIGHT.prim_range) AND
									KEYED(LEFT.indata.prim_name = RIGHT.prim_name),
									formatOutput(LEFT,RIGHT,'13Z'),LEFT OUTER,ATMOST(7500));

	RETURN match13Z;

END;