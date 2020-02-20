import $, Address, DayBatchUtils, Doxie, Suppress;

export PhoneSearch_Z3L_Exact(GROUPED DATASET($.Layout_PCNSR_Linked) pcnsrInput,
                             Doxie.IDataAccess mod_access) := FUNCTION
	
	PCNSRData := $.Key_PCNSR_LZ3;

	$.Layout_PCNSR_Linked formatOutput(pcnsrInput l,PCNSRData r,STRING m) := TRANSFORM
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
	
	matchZ3L_flagged := Suppress.MAC_FlagSuppressedSource(matchZ3L, mod_access, outdata.did, outdata.global_sid);  
  
  matchZ3L_suppressed := PROJECT(matchZ3L_flagged, TRANSFORM($.Layout_PCNSR_Linked, SELF.outdata := IF(~LEFT.is_suppressed, lEFT.outdata), SELF := LEFT));
  
	RETURN matchZ3L_suppressed;

END;