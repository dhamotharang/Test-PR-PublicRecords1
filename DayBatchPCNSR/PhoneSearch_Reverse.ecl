import $, doxie, Suppress;

export PhoneSearch_Reverse(GROUPED DATASET($.Layout_PCNSR_Linked) pcnsrInput,
                           doxie.IDataAccess mod_access) := FUNCTION

	K := $.Key_PCNSR_Phone;
	
	$.Layout_PCNSR_Linked formatOutput(pcnsrInput l,K r,STRING m) := TRANSFORM
		MAC_Link_PCNSR_To_Input(l,r,m)
	END;
	
	match_Phone := JOIN(pcnsrInput,
											K,
											LENGTH(LEFT.indata.phoneno) = 10 AND
											KEYED(LEFT.indata.phoneno[1..3] = RIGHT.area_code) AND
											KEYED(LEFT.indata.phoneno[4..10] = RIGHT.phone_number),
											formatOutput(LEFT,RIGHT,'P'),LEFT OUTER, ATMOST(7500)
											);
   
  match_flagged := Suppress.MAC_FlagSuppressedSource(match_Phone, mod_access, outdata.did, outdata.global_sid);  
  
  match_suppressed := PROJECT(match_flagged, TRANSFORM($.Layout_PCNSR_Linked, 
                                             SELF.outdata := IF(~LEFT.is_suppressed, lEFT.outdata), 
                                             SELF := LEFT));
	ungrp := UNGROUP(match_suppressed);
	srted := GROUP(SORT(ungrp,indata.acctno,-outdata.refresh_date),indata.acctno);
	RETURN srted;
END;