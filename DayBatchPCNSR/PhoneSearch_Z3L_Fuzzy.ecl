import DayBatchPCNSR,Address,DayBatchUtils,ut,NID;

export PhoneSearch_Z3L_Fuzzy(GROUPED DATASET(DayBatchPCNSR.Layout_PCNSR_Linked) pcnsrInput) := FUNCTION
	
	PCNSRData := DayBatchPCNSR.Key_PCNSR_LZ3;
	
	DayBatchPCNSR.Layout_PCNSR_Linked formatOutput(pcnsrInput l,PCNSRData r,STRING m) := TRANSFORM
		MAC_Link_PCNSR_To_Input(l,r,m)
	END;
	
	matchZ3L := JOIN(pcnsrInput,
									PCNSRData,
									LEFT.outdata.phone_number = '' AND
									LEFT.indata.z5 <> '' AND LEFT.indata.prim_name <> '' AND 
									LEFT.indata.name_last <> '' AND LEFT.indata.prim_name[1..6] <> 'PO BOX' AND
									KEYED(LEFT.indata.name_last = RIGHT.lname) AND
									KEYED(LEFT.indata.z5 = RIGHT.zip) AND
									ut.StringSimilar(LEFT.indata.prim_name,RIGHT.prim_name) <= 3,
									formatOutput(LEFT,RIGHT,'3Z'), LEFT OUTER,KEEP(50)/*,
									ATMOST(LEFT.indata.name_last = RIGHT.lname AND LEFT.indata.z5 = RIGHT.zip,7500)*/ );

	RETURN matchZ3L;

END;