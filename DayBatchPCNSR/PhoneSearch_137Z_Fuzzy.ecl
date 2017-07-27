import DayBatchPCNSR,Address,DayBatchUtils,ut;

export PhoneSearch_137Z_Fuzzy(GROUPED DATASET(DayBatchPCNSR.Layout_PCNSR_Linked) pcnsrInput) := FUNCTION
	
	PCNSRData := DayBatchPCNSR.Key_PCNSR_Z317LF;
	
	DayBatchPCNSR.Layout_PCNSR_Linked formatOutput(pcnsrInput l,PCNSRData r,STRING m) := TRANSFORM
		MAC_Link_PCNSR_To_Input(l,r,m)
	END;
	
	match137Z := JOIN(pcnsrInput,
										PCNSRData,
										LEFT.outdata.phone_number = '' AND
										LEFT.indata.z5<>'' AND LEFT.indata.prim_name<>'' AND LEFT.indata.prim_range<>'' AND
										KEYED(LEFT.indata.z5 = RIGHT.zip) AND
										WILD(RIGHT.prim_name) AND
										ut.StringSimilar(LEFT.indata.prim_name,RIGHT.prim_name) <= 3 AND
										KEYED(LEFT.indata.prim_range = RIGHT.prim_range) AND
										KEYED(LEFT.indata.sec_range = RIGHT.sec_range),
										formatOutput(LEFT,RIGHT,'137Z'),LEFT OUTER);

	RETURN match137Z;


END;