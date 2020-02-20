IMPORT  $, Doxie, Suppress;

EXPORT PhoneSearch_Nbr(GROUPED DATASET(DayBatchPCNSR.Layout_PCNSR_Linked) pcnsrInput,
                       UNSIGNED1 max_count,
                       Doxie.IDataAccess mod_access) := FUNCTION
	
	K := DayBatchPCNSR.Key_PCNSR_Nbr;
	
	Layout_rolled_matches := RECORD
		pcnsrInput;
		UNSIGNED1 cnt := 1;
	END;

	Layout_rolled_Matches formatOutput(Layout_rolled_matches l,K r,STRING m) := TRANSFORM
		MAC_Link_PCNSR_To_Input(l,r,m)
		SELF.cnt := l.cnt;
	END;	
	
	Layout_rolled_matches rollMatches(Layout_rolled_matches l,Layout_rolled_matches r) := TRANSFORM
		SELF.indata := l.indata;
		SELF.cnt := l.cnt + 1;
		SELF.outdata := [];
		SELF.matchCode := '';
	END;
	
	in_SecRange_z4 := PROJECT(pcnsrInput,TRANSFORM(Layout_rolled_matches,SELF := LEFT,SELF.cnt := 1));
	
	//Match on sec_range and zip4
	match_SecRange_z4	 := JOIN(in_SecRange_z4,
														 K,
														 LEFT.indata.z5 <>'' AND LEFT.indata.z4 <> '' AND LEFT.indata.sec_range <> '' AND 
														 LEFT.indata.prim_name <> '' AND LEFT.indata.prim_name[1..6] <> 'PO BOX' AND 
														 LEFT.indata.prim_range <> '' AND LEFT.cnt < max_count AND
														 KEYED(LEFT.indata.z5 = RIGHT.zip) AND
														 KEYED(LEFT.indata.z4 = RIGHT.zip4) AND
														 KEYED(LEFT.indata.prim_name = RIGHT.prim_name) AND
														 KEYED(LEFT.indata.prim_range = RIGHT.prim_range) AND
														 LEFT.indata.sec_range <> RIGHT.sec_range,
														 formatOutput(LEFT,RIGHT,'Z'),LEFT OUTER,
														 KEEP(max_count),
														 ATMOST(LEFT.indata.z5 = RIGHT.zip AND 
																		LEFT.indata.z4 = RIGHT.zip4 AND 
																		LEFT.indata.prim_name = RIGHT.prim_name AND
																		LEFT.indata.prim_range = RIGHT.prim_range,7500)
														);
	
	in_SecRange_z3 := ROLLUP(match_SecRange_z4,LEFT.indata.acctno = RIGHT.indata.acctno,rollMatches(LEFT,RIGHT));

	//Match on sec_range and zip4[1..3]
	match_SecRange_z3	 := JOIN(in_SecRange_z3,
														 K,
														 LEFT.indata.z5 <>'' AND LEFT.indata.z4 <> '' AND LEFT.indata.sec_range <> '' AND 
														 LEFT.indata.prim_name <> '' AND LEFT.indata.prim_range <> '' AND
														 LEFT.indata.prim_name[1..6] <> 'PO BOX' AND LEFT.cnt < max_count AND
														 KEYED(LEFT.indata.z5 = RIGHT.zip) AND
														 KEYED(LEFT.indata.z4[1..3] = RIGHT.zip4[1..3]) AND
														 LEFT.indata.z4 <> RIGHT.zip4 AND
														 KEYED(LEFT.indata.prim_name = RIGHT.prim_name) AND
														 KEYED(LEFT.indata.prim_range = RIGHT.prim_range) AND
														 LEFT.indata.sec_range <> RIGHT.sec_range,
														 formatOutput(LEFT,RIGHT,'Z'),LEFT OUTER,
														 KEEP(max_count),
														 ATMOST(LEFT.indata.z5 = RIGHT.zip AND
																		LEFT.indata.z4[1..3] = RIGHT.zip4[1..3] AND
																		LEFT.indata.prim_name = RIGHT.prim_name AND
																		LEFT.indata.prim_range = RIGHT.prim_range, 7500)
														);
	
	in_SecRange_z2 := ROLLUP(match_SecRange_z3,LEFT.indata.acctno = RIGHT.indata.acctno,rollMatches(LEFT,RIGHT));
	
	//Match on sec_range and zip4[1..2]
	match_SecRange_z2	 := JOIN(in_SecRange_z2,
														 K,
														 LEFT.indata.z5 <>'' AND LEFT.indata.z4 <> '' AND LEFT.indata.sec_range <> '' AND 
														 LEFT.indata.prim_name <> '' AND LEFT.indata.prim_range <> '' AND 
														 LEFT.indata.prim_name[1..6] <> 'PO BOX' AND LEFT.cnt < max_count AND
														 KEYED(LEFT.indata.z5 = RIGHT.zip) AND
														 KEYED(LEFT.indata.z4[1..2] = RIGHT.zip4[1..2]) AND
														 LEFT.indata.z4[1..3] <> RIGHT.zip4[1..3] AND
														 KEYED(LEFT.indata.prim_name = RIGHT.prim_name) AND
														 KEYED(LEFT.indata.prim_range = RIGHT.prim_range) AND
														 LEFT.indata.sec_range <> RIGHT.sec_range,
														 formatOutput(LEFT,RIGHT,'Z'),LEFT OUTER,
														 KEEP(max_count),
														 ATMOST(LEFT.indata.z5 = RIGHT.zip AND
																		LEFT.indata.z4[1..2] = RIGHT.zip4[1..2] AND
																		LEFT.indata.prim_name = RIGHT.prim_name AND
																		LEFT.indata.prim_range = RIGHT.prim_range, 7500)
														);

	in_z4 := ROLLUP(match_SecRange_z2,LEFT.indata.acctno = RIGHT.indata.acctno,rollMatches(LEFT,RIGHT));
	
	//Match on zip4
	match_z4	 := JOIN(in_z4,
										 K,
										 LEFT.indata.z5 <>'' AND LEFT.indata.z4 <> '' AND 
										 LEFT.indata.prim_name <> '' AND LEFT.indata.prim_range <> '' AND 
										 LEFT.indata.prim_name[1..6] <> 'PO BOX' AND LEFT.cnt < max_count AND
										 KEYED(LEFT.indata.z5 = RIGHT.zip) AND
										 KEYED(LEFT.indata.z4 = RIGHT.zip4) AND
										 (
											LEFT.indata.prim_name <> RIGHT.prim_name OR
											LEFT.indata.prim_range <> RIGHT.prim_range
										 ),
										 formatOutput(LEFT,RIGHT,'Z'),LEFT OUTER,
										 KEEP(max_count),
										 ATMOST(LEFT.indata.z5 = RIGHT.zip AND
														LEFT.indata.z4 = RIGHT.zip4, 7500)										 
										);

	in_z3 := ROLLUP(match_z4,LEFT.indata.acctno = RIGHT.indata.acctno,rollMatches(LEFT,RIGHT));
	
	//Match on zip4
	match_z3	 := JOIN(in_z3,
										 K,
										 LEFT.indata.z5 <>'' AND LEFT.indata.z4 <> '' AND 
										 LEFT.indata.prim_name <> '' AND LEFT.indata.prim_range <> '' AND 
										 LEFT.indata.prim_name[1..6] <> 'PO BOX' AND LEFT.cnt < max_count AND
										 KEYED(LEFT.indata.z5 = RIGHT.zip) AND
										 LEFT.indata.z4 <> RIGHT.zip4 AND
										 KEYED(LEFT.indata.z4[1..3] = RIGHT.zip4[1..3]),
										 formatOutput(LEFT,RIGHT,'Z'),LEFT OUTER,
										 KEEP(max_count),
										 ATMOST(LEFT.indata.z5 = RIGHT.zip AND
														LEFT.indata.z4[1..3] = RIGHT.zip4[1..3], 7500)
										);

	in_z2 := ROLLUP(match_z3,LEFT.indata.acctno = RIGHT.indata.acctno,rollMatches(LEFT,RIGHT));
	
	//Match on zip4
	match_z2	 := JOIN(in_z2,
										 K,
										 LEFT.indata.z5 <>'' AND LEFT.indata.z4 <> '' AND 
										 LEFT.indata.prim_name <> '' AND LEFT.indata.prim_range <> '' AND 
										 LEFT.indata.prim_name[1..6] <> 'PO BOX' AND LEFT.cnt < max_count AND
										 KEYED(LEFT.indata.z5 = RIGHT.zip) AND
										 LEFT.indata.z4[1..3] <> RIGHT.zip4[1..3] AND
										 KEYED(LEFT.indata.z4[1..2] = RIGHT.zip4[1..2]),
										 formatOutput(LEFT,RIGHT,'Z'),LEFT OUTER,
										 KEEP(max_count),
										 ATMOST(LEFT.indata.z5 = RIGHT.zip AND
														LEFT.indata.z4[1..2] = RIGHT.zip4[1..2], 7500)										 
										);
	
	allMatch := match_SecRange_z4(matchCode <> '') + match_SecRange_z3(matchCode <> '') + 
							match_SecRange_z2(matchCode <> '') + match_z4(matchCode <> '') + 
							match_z3(matchCode <> '') + match_z2(matchCode <> '') + match_z2(cnt = 1);


  allMatch_flagged := Suppress.MAC_FlagSuppressedSource(allMatch, mod_access, outdata.did, outdata.global_sid);  
  
  allMatch_suppressed := PROJECT(allMatch_flagged, TRANSFORM($.Layout_PCNSR_Linked, SELF.outdata := IF(~LEFT.is_suppressed, lEFT.outdata), SELF := LEFT));
  
	ungroupedMatch := UNGROUP(allMatch_suppressed);
	
	grpMatch := GROUP(SORT(ungroupedMatch,indata.acctno),indata.acctno);
	
	out := TOPN(grpMatch,max_count,indata.acctno,
							ABS( (INTEGER)(indata.z4) - (INTEGER)(outdata.zip4) ),
							ABS( (INTEGER)(indata.prim_range) - (INTEGER)(outdata.prim_range) ),
							ABS( (INTEGER)(indata.sec_range) - (INTEGER)(outdata.sec_range) )
							);

	
	RETURN PROJECT(out,TRANSFORM(DayBatchPCNSR.Layout_PCNSR_Linked,SELF := LEFT));

END;