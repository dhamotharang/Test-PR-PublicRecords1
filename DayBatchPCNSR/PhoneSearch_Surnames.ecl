import $, Doxie, Suppress;
/*
This Attribute gets upto 10 records that have the same last name as the last name in the
input data. I successively searches last name records by removing the last character in the
zip till the 10 records are found.
*/

EXPORT PhoneSearch_Surnames(GROUPED DATASET($.Layout_PCNSR_Linked) pcnsrInput, 
                            UNSIGNED max_Count,
                            Doxie.IDataAccess mod_access) := FUNCTION
	
	K_LZ3 := $.Key_PCNSR_Surnames;
	
	Layout_rolled_matches := RECORD
		pcnsrInput;
		UNSIGNED1 cnt := 1;
	END;

	Layout_rolled_Matches formatOutput(Layout_rolled_matches l,K_LZ3 r,STRING m) := TRANSFORM
		MAC_Link_PCNSR_To_Input(l,r,m)
		SELF.cnt := l.cnt;
	END;	
	
	Layout_rolled_matches rollMatches(Layout_rolled_matches l,Layout_rolled_matches r) := TRANSFORM
		SELF.indata := l.indata;
		SELF.cnt := l.cnt + 1;
		SELF.outdata := [];
		SELF.matchCode := '';
	END;
	
	inMatchZL5 := PROJECT(pcnsrInput,TRANSFORM(Layout_rolled_matches,SELF := LEFT,SELF.cnt := 1));
	//LIMIT(-1) put in all following joins to avoid condition of getting more 10000 records
	//despite ATMOST condition -- Bugzilla # 18478
	//Match on full zip
	matchZL5	 := JOIN(inMatchZL5,
										 K_LZ3,
										 LEFT.indata.z5 <>'' AND LEFT.indata.name_last <> '' AND LEFT.cnt < max_count AND
										 KEYED(LEFT.indata.z5 = RIGHT.zip) AND
										 KEYED(LEFT.indata.name_last = RIGHT.lname) AND
										 (
											 LEFT.indata.prim_name <> RIGHT.prim_name OR
											 LEFT.indata.prim_range <> RIGHT.prim_range OR
											 LEFT.indata.sec_range <> RIGHT.sec_range
										 ),
										 formatOutput(LEFT,RIGHT,'Z'),LEFT OUTER,
										 KEEP(max_count),
										 ATMOST(LEFT.indata.name_last = RIGHT.lname AND LEFT.indata.z5 = RIGHT.zip ,7500)
										 );
	
	inMatchZL4 := ROLLUP(matchZL5,LEFT.indata.acctno = RIGHT.indata.acctno,rollMatches(LEFT,RIGHT));

	//Match on first 4 characters of zip
	matchZL4	 := JOIN(inMatchZL4,
										 K_LZ3,
										 LEFT.indata.z5 <>'' AND LEFT.indata.name_last <> '' AND LEFT.cnt < max_count AND
										 KEYED(LEFT.indata.name_last = RIGHT.lname) AND
										 KEYED(LEFT.indata.z5[1..4] = RIGHT.zip[1..4]) AND
										 LEFT.indata.z5 <> RIGHT.zip,
										 formatOutput(LEFT,RIGHT,'Z'),LEFT OUTER,
										 KEEP(max_count),
										 ATMOST(LEFT.indata.name_last = RIGHT.lname AND LEFT.indata.z5[1..4] = RIGHT.zip[1..4],7500)
										 );

	inMatchZL3 := ROLLUP(matchZL4,LEFT.indata.acctno = RIGHT.indata.acctno,rollMatches(LEFT,RIGHT));

	//Match on first 3 characters of zip
	matchZL3	 := JOIN(inMatchZL3,
										 K_LZ3,
										 LEFT.indata.z5 <>'' AND LEFT.indata.name_last <> '' AND LEFT.cnt < max_count AND
										 KEYED(LEFT.indata.name_last = RIGHT.lname) AND
										 KEYED(LEFT.indata.z5[1..3] = RIGHT.zip[1..3]) AND
										 LEFT.indata.z5[1..4] <> RIGHT.zip[1..4],
										 formatOutput(LEFT,RIGHT,'Z'),LEFT OUTER,
										 KEEP(max_count),
										 ATMOST(LEFT.indata.z5[1..3] = RIGHT.zip[1..3] AND LEFT.indata.name_last = RIGHT.lname ,7500)
										 );
	

	inMatchZL2 := ROLLUP(matchZL3,LEFT.indata.acctno = RIGHT.indata.acctno,rollMatches(LEFT,RIGHT));	
	
	//Match on first 2 characters of zip
	matchZL2	 := JOIN(inMatchZL2,
										 K_LZ3,
										 LEFT.indata.z5 <>'' AND LEFT.indata.name_last <> '' AND LEFT.cnt < max_count AND
										 KEYED(LEFT.indata.name_last = RIGHT.lname) AND
										 KEYED(LEFT.indata.z5[1..2] = RIGHT.zip[1..2]) AND
										 LEFT.indata.z5[1..3] <> RIGHT.zip[1..3],
										 formatOutput(LEFT,RIGHT,'Z'),LEFT OUTER,
										 KEEP(max_count),
										 ATMOST(LEFT.indata.z5[1..2] = RIGHT.zip[1..2] AND LEFT.indata.name_last = RIGHT.lname, 7500)
										 );

	inMatchZL1 := ROLLUP(matchZL2,LEFT.indata.acctno = RIGHT.indata.acctno,rollMatches(LEFT,RIGHT));

	//Match on first 1 characters of zip
	matchZL1	 := JOIN(inMatchZL1,
										 K_LZ3,
										 LEFT.indata.z5 <>'' AND LEFT.indata.name_last <> '' AND LEFT.cnt < max_count AND
										 KEYED(LEFT.indata.name_last = RIGHT.lname) AND
										 KEYED(LEFT.indata.z5[1] = RIGHT.zip[1]) AND
										 LEFT.indata.z5[1..2] <> RIGHT.zip[1..2],										 
										 formatOutput(LEFT,RIGHT,'Z') ,LEFT OUTER,
										 KEEP(max_count),
										 ATMOST(LEFT.indata.z5[1] = RIGHT.zip[1] AND LEFT.indata.name_last = RIGHT.lname, 7500)
										 );


	inMatchZL := ROLLUP(matchZL1,LEFT.indata.acctno = RIGHT.indata.acctno,rollMatches(LEFT,RIGHT));
		
	//Match on last name only
	matchL		 := JOIN(inMatchZL,
										 K_LZ3,
										 LEFT.indata.z5 <>'' AND LEFT.indata.name_last <> '' AND LEFT.cnt < max_count AND
										 KEYED(LEFT.indata.name_last = RIGHT.lname) AND
										 LEFT.indata.z5[1] <> RIGHT.zip[1],
										 formatOutput(LEFT,RIGHT,'Z'),LEFT OUTER,
										 KEEP(max_count),
										 ATMOST(LEFT.indata.name_last = RIGHT.lname, 7500)
										 );
	
	//Consolidate  Matches
	allMatch := matchZL5(matchCode <> '') + matchZL4(matchCode <> '') + 
							matchZL3(matchCode <> '') + matchZL2(matchCode <> '') + 
							matchZL1(matchCode <> '') + matchL(matchCode <> '') + matchL(cnt = 1);

  allMatch_flagged := Suppress.MAC_FlagSuppressedSource(allMatch, mod_access, outdata.did, outdata.global_sid);  
  
  allMatch_suppressed := PROJECT(allMatch_flagged, TRANSFORM($.Layout_PCNSR_Linked, SELF.outdata := IF(~LEFT.is_suppressed, lEFT.outdata), SELF := LEFT));

	ungroupedMatch := UNGROUP(allMatch_suppressed);
	
	grpMatch := GROUP(SORT(ungroupedMatch,indata.acctno),indata.acctno);
	
	out := TOPN(grpMatch,max_count,indata.acctno,ABS( (INTEGER)(indata.z5[1..5]) - (INTEGER)(outdata.zip[1..5]) ));

	
	RETURN PROJECT(out,TRANSFORM($.Layout_PCNSR_Linked,SELF := LEFT));
END;