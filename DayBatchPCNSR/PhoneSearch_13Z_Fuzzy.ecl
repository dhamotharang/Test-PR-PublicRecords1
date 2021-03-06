import DayBatchPCNSR,Address,DayBatchUtils,ut;

export PhoneSearch_13Z_Fuzzy(GROUPED DATASET(DayBatchPCNSR.Layout_PCNSR_Linked) pcnsrInput) := FUNCTION
	
	PCNSRData := DayBatchPCNSR.Key_PCNSR_Z317LF;

	DayBatchPCNSR.Layout_PCNSR_Linked formatOutput(pcnsrInput l,PCNSRData r,STRING m) := TRANSFORM
		MAC_Link_PCNSR_To_Input(l,r,m)
	END;
	
	match13Z := JOIN(pcnsrInput,
									PCNSRData,
									LEFT.outdata.phone_number = '' AND
									LEFT.indata.z5 <> '' AND LEFT.indata.prim_name <> '' AND LEFT.indata.prim_range <> '' AND
									KEYED(LEFT.indata.z5 = RIGHT.zip) AND
									WILD(RIGHT.prim_name) AND
									KEYED(LEFT.indata.prim_range = RIGHT.prim_range) AND
									ut.StringSimilar(LEFT.indata.prim_name,RIGHT.prim_name) <= 3,
									formatOutput(LEFT,RIGHT,'13Z'), LEFT OUTER );
	
	RETURN match13Z;

END;