import $,Address,DayBatchUtils,Doxie,NID,Suppress,Ut;

export PhoneSearch_Z3L_Fuzzy(GROUPED DATASET($.Layout_PCNSR_Linked) pcnsrInput,
                              Doxie.IDataAccess mod_access) := FUNCTION
	
	PCNSRData := $.Key_PCNSR_LZ3;
	
	$.Layout_PCNSR_Linked formatOutput(pcnsrInput l,PCNSRData r,STRING m) := TRANSFORM
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

	matchZ3L_flagged := Suppress.MAC_FlagSuppressedSource(matchZ3L, mod_access, outdata.did, outdata.global_sid);  
  
  matchZ3L_suppressed := PROJECT(matchZ3L_flagged, TRANSFORM($.Layout_PCNSR_Linked, SELF.outdata := IF(~LEFT.is_suppressed, lEFT.outdata), SELF := LEFT));
  
	RETURN matchZ3L_suppressed;


END;