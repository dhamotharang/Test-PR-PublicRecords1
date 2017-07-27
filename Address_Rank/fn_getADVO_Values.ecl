IMPORT Advo;

EXPORT  fn_getADVO_Values(DATASET(Address_Rank.Layouts.Bestrec) recs) := FUNCTION
	advo := advo.Key_Addr1;
	
	Address_Rank.Layouts.Bestrec addAdvo(recs l, advo r) := TRANSFORM			
		SELF.college_addr 	:= r.college_indicator;
		SELF.business_addr 	:= IF(r.residential_or_business_ind = 'B','Y','N');
		SELF := l;
		SELF := [];
	END;
	with_ADVO := JOIN(recs, advo,
										KEYED(LEFT.z5	 					= RIGHT.zip) 				AND
										KEYED(LEFT.prim_range 	= RIGHT.prim_range) AND
										KEYED(LEFT.prim_name 		= RIGHT.prim_name) 	AND
										KEYED(LEFT.suffix 			= RIGHT.addr_suffix)AND
										KEYED(LEFT.predir 			= RIGHT.predir) 		AND
										KEYED(LEFT.postdir 			= RIGHT.postdir) 		AND
										KEYED(LEFT.sec_range 		= RIGHT.sec_range),
										addADVO(LEFT, RIGHT),LEFT OUTER, LIMIT(0), KEEP(1));

	RETURN with_ADVO;
END;