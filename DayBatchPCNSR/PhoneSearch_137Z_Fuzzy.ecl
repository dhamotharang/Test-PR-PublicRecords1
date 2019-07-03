import $,Address,DayBatchUtils,Doxie,Suppress,ut;

export PhoneSearch_137Z_Fuzzy(GROUPED DATASET($.Layout_PCNSR_Linked) pcnsrInput,
                              Doxie.IDataAccess mod_access) := FUNCTION
	
	PCNSRData := $.Key_PCNSR_Z317LF;
	
	$.Layout_PCNSR_Linked formatOutput(pcnsrInput l,PCNSRData r,STRING m) := TRANSFORM
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

	match137Z_flagged := Suppress.MAC_FlagSuppressedSource(match137Z, mod_access, outdata.did, outdata.global_sid);  
  
  match137Z_suppressed := PROJECT(match137Z_flagged, TRANSFORM($.Layout_PCNSR_Linked, SELF.outdata := IF(~LEFT.is_suppressed, lEFT.outdata), SELF := LEFT));
  
	RETURN match137Z_suppressed;


END;