import gong, doxie, ut, DayBatchEDA, lib_datalib;

LBO := DayBatchEDA.Layout_Batch_Out;

export Fetch_Batch_Gong_Full(dataset(DayBatchEDA.Layout_Batch_In) EDAInput) := FUNCTION

keyLimit := 10000;

isaMatch(le, ri) :=
MACRO
	datalib.StringSimilar100(le,ri)=0
ENDMACRO;

isnotaMatch(le, ri) :=
MACRO
	datalib.StringSimilar100(le,ri)>0
ENDMACRO;
	
	//--------------------------------------------------------------
	// Get the initial records from the indexes based on input parameters
	//--------------------------------------------------------------
	
	Layout_Request_Code := RECORD
		INTEGER2 MatchLevel;
		BOOLEAN  AFlag;
		BOOLEAN  BFlag;
		BOOLEAN  CFlag;
		BOOLEAN  DFlag;
		BOOLEAN  EFlag;
		BOOLEAN  FFlag;
		BOOLEAN  GFlag;
		BOOLEAN  HFlag;
		BOOLEAN  IFlag;
		BOOLEAN  JFlag;
		BOOLEAN  KFlag;
		BOOLEAN  LFlag;
		BOOLEAN  MFlag;
		BOOLEAN  NFlag;
		BOOLEAN  OFlag;
		BOOLEAN  RFlag;		
	END;
	
	BOOLEAN match_codes(INTEGER2 i, STRING1 c) := 
			CASE(i, 1 => c IN ['R'],
							3 => c IN ['A','B','C','X'],
							4 => c IN ['A','B','C','J'], 
							5 => c IN ['C','J'],
							9 => c IN ['A','B','C','D','E','G'],
							14 => c IN ['G','H','M','N'],
							15 => c IN ['A','B','D','E'],
							16 => c IN ['A','B','D','E','X'],
							17 =>	c IN ['A','B','D','E','G','H','M','N'],	 
							50 => c IN ['A','B','C','D','E','J'],
							55 =>	c IN ['A','B','C','D','E','F','G','H','J','M','N'],	 
							60 => c IN ['A','B','C','D','E','F','J'],	 
							61 => c IN ['A','B','C','D','E'],	 
							62 => c IN ['A','B','C','D','E','F'],	 
							63 =>	c IN ['A','B','C','D','E','F','G'],	 
							70 =>	c IN ['A','B','C','D','E','J','X'],	 
							76 => c IN ['A','B','C','D','E','F','G','H','J','K','L','M','N'],	 
						  77 =>	c IN ['A','B','C','D','E','F','J','X'],	
							78 => c IN ['A','B','C','D','E','F','G','H','I','J','M','N'],	 
							79 => c IN ['A','B','C','D','E','F','G','H','J','M','N','X'],	 
							80 =>	c IN ['A','B','C','D','E','G','H','J','M','N','X'],	 
							81 =>	c IN ['A','B','C','D','E','F','G','H','I','J','K','L','M','N'],	 
							82 => c IN ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O'], 	 
							83 => c IN ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P'],	 
							90 =>	c IN ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','X'],	 	 
							91 =>	c IN ['A','B','C','D','E','F','G','H','I','J','M','N','O'],
							92 => c IN ['A','B','C','D','E','F','G','H','I','J','M','N','O'],
							93 =>	c IN ['A','B','C','D','E','F','G','H','I','J','M','N','O'],	 
							94 => c IN ['A','B','C','D','E','G','H','J','M','N'],	 
							95 => c IN ['A','B','C','D','E','F','G','H','I','J','M','N','X'],false);

													 
	
	LBO.Layout_Final_Output finalResultProject(LBO.Layout_Out_Record l) := TRANSFORM
		SELF.seq_num := (STRING2)l.seq_num;
		SELF.acctno   := l.acctno;
	  SELF.MatchCode := l.MatchCode;
		SELF.max_results := (STRING2)l.max_results;
		SELF := l;
	END;
	
	LBO.Layout_Out_Record doCzsslfFullProject (DayBatchEDA.Layout_Batch_In l, DayBatchEDA.key_gong_batch_czsslf r) := TRANSFORM
	  SELF.seq_num   := 0;
	  SELF.acctno   := l.acctno;
		SELF.MatchCode := DayBatchEDA.MAC_Gong_MatchCode(l,r);
		SELF.max_results := l.max_results;
		self.sequence_number := (string10)r.sequence_number;
		SELF := r;
	END;
	
	LBO.Layout_Out_Record doLProject (DayBatchEDA.Layout_Batch_In l,DayBatchEDA.key_gong_batch_czsslf r) := TRANSFORM
	  SELF.seq_num   := 0;
	  SELF.acctno   := l.acctno;
		SELF.MatchCode := 'L';
		SELF.max_results := l.max_results;
		self.sequence_number := (string10)r.sequence_number;
		SELF := r;
	END;
	
	LBO.Layout_Out_Record doLczfFullProject (DayBatchEDA.Layout_Batch_In l,DayBatchEDA.key_gong_batch_lczf r) := TRANSFORM
	  SELF.seq_num   := 0;
	  SELF.acctno   := l.acctno;
		SELF.MatchCode := DayBatchEDA.MAC_GHI_MatchCode(l,r);
		SELF.max_results := l.max_results;
		self.sequence_number := (string10)r.sequence_number;
		SELF := r;
	END;
	
	LBO.Layout_Out_Record doMatchCodeProject (DayBatchEDA.Layout_Batch_In l, DayBatchEDA.key_gong_batch_lczf r, string1 mc) := TRANSFORM
	  SELF.seq_num   := 0;
	  SELF.acctno   := l.acctno;
		SELF.MatchCode := mc;
		SELF.max_results := l.max_results;
		self.sequence_number := (string10)r.sequence_number;
		SELF := r;
	END;

		
	LBO.Layout_Out_Record doPhoneProject (DayBatchEDA.Layout_Batch_In l, DayBatchEDA.Key_gong_phone r) := TRANSFORM
	  SELF.seq_num   := 0;
	  SELF.acctno   := l.acctno;
		SELF.MatchCode := 'R';
		SELF.max_results := l.max_results;
		self.sequence_number := (string10)r.sequence_number;
		SELF := r;
	END;
	

	LBO.Layout_Out_Record doFinalProject (LBO.Layout_Out_Record l, INTEGER c) := TRANSFORM
	  SELF.seq_num   := c;
		SELF := l;
	END;

testInclude := MACRO
	(LEFT.includeBus OR ~RIGHT.listing_type_bus='B') AND
	(LEFT.includeRes OR ~RIGHT.listing_type_res='R') AND
	(LEFT.includeGov OR ~RIGHT.listing_type_gov='G')
ENDMACRO;

	
	gong_czsslf_out_recs := JOIN(EDAInput,DayBatchEDA.key_gong_batch_czsslf,
																					left.p_city_name <> '' and
																					left.z5        <> '' and
																					left.prim_name   <> '' and
																					keyed(left.p_city_name = right.p_city_name) and
																					keyed(left.z5 = right.z5) and
																				  keyed(left.prim_name =  right.prim_name) and
																					WILD(right.prim_range) and
																					WILD(right.name_last) and
																				  WILD(right.name_first) AND testInclude() AND
																					match_codes(LEFT.match_level,DayBatchEDA.MAC_Gong_MatchCode(LEFT,RIGHT))
																					, doCzsslfFullProject(LEFT,RIGHT),KEEP(1000),LIMIT(keyLimit,SKIP));
	

	
	gong_l_out_recs := JOIN(EDAInput,DayBatchEDA.key_gong_batch_czsslf,
																		 left.p_city_name <> '' and
																		 left.z5 <> '' and 
																		 keyed(left.p_city_name = right.p_city_name) and
																		 keyed(left.z5 = right.z5) and
																		 WILD(right.prim_name) and
																		 WILD(right.prim_range) and
																		 isnotaMatch(left.name_last,right.name_last) and
																		 WILD(right.name_last) and testInclude() AND
																		 match_codes(LEFT.match_level,'L')
																		 ,doLProject(LEFT,RIGHT),KEEP(10),LIMIT(keyLimit,SKIP));
	
	
	
	gong_ghi_out_recs := JOIN(EDAInput,DayBatchEDA.key_gong_batch_lczf,
																			 left.p_city_name <> '' and
																			 left.z5 <> '' and
																			 left.name_last  <> '' and
																			 keyed(left.name_last =  right.name_last) and
																			 keyed(left.p_city_name = right.p_city_name) and
																			 keyed(left.z5 = right.z5) and
																			 WILD(right.name_first) and testInclude() AND
																			 match_codes(LEFT.match_level,DayBatchEDA.MAC_GHI_MatchCode(LEFT,RIGHT))
															         ,doLczfFullProject(LEFT,RIGHT),KEEP(1000),LIMIT(keyLimit,SKIP));
	
	
	
		
	gong_m_out_recs := JOIN(EDAInput,DayBatchEDA.key_gong_batch_lczf,
																 left.name_last  <> '' and
																 left.name_first <> '' and 
																 isnotaMatch(left.p_city_name,right.p_city_name) and
																 isnotaMatch(left.z5,right.z5) and
																 keyed(left.name_last =  right.name_last) and
																 WILD(right.p_city_name) AND
																 WILD(right.z5) and
																 isaMatch(left.name_first,right.name_first) and testInclude() AND
																 match_codes(LEFT.match_level,'M')																 
																 ,doMatchCodeProject(LEFT,RIGHT, 'M'),KEEP(10),LIMIT(keyLimit,SKIP));
	
	
	
	gong_n_out_recs := JOIN(EDAInput,DayBatchEDA.key_gong_batch_lczf,
																 left.name_last  <> '' and
																 left.name_first_init  <> '' and 
																isnotaMatch(left.p_city_name,right.p_city_name) and
																isnotaMatch(left.z5,right.z5) and
																 keyed(left.name_last =  right.name_last) and
																 WILD(right.p_city_name) AND
																 WILD(right.z5) AND
																 isaMatch(left.name_first[1],right.name_first[1]) and testInclude() AND
																 match_codes(LEFT.match_level,'N')																 
																 ,doMatchCodeProject(LEFT,RIGHT,'N'),KEEP(10),LIMIT(keyLimit,SKIP));
	
	
	
	
	gong_o_out_recs := JOIN(EDAInput,DayBatchEDA.key_gong_batch_lczf,
																 left.name_last  <> '' and
																 isnotaMatch(left.p_city_name,right.p_city_name) and
																 isnotaMatch(left.z5,right.z5) and
																 keyed(left.name_last =  right.name_last) and
																 WILD(right.p_city_name) and
																 WILD(right.z5) and
																 WILD(right.name_first) and testInclude() AND
																 match_codes(LEFT.match_level,'O')																 
																 ,doMatchCodeProject(LEFT,RIGHT,'O'),KEEP(10),LIMIT(keyLimit,SKIP));
	
	
	
	
	
	Phone_key_out_recs := JOIN(EDAInput,DayBatchEDA.Key_gong_phone,
																		left.phoneno <> '' and
																		keyed(left.phone7 = right.ph7)  and
																		(left.area_code = '' or left.area_code = right.ph3) and testInclude() AND
																		match_codes(LEFT.match_level,'R')																		
																		,doPhoneProject(LEFT,RIGHT),KEEP(100),LIMIT(keyLimit,SKIP));
	
	
	Sort_Gong_Records := gong_czsslf_out_recs + 
												    gong_l_out_recs      +
	                          gong_ghi_out_recs    +
												    gong_m_out_recs      +
												    gong_n_out_recs      +
												    gong_o_out_recs      +										
				  							    Phone_key_out_recs;
	
  Sort_All_Records :=  GROUP(SORT(Sort_Gong_Records, acctno, phone10, prim_range, prim_name, p_city_name, st, z5, MatchCode, listed_name, 
											 predir, suffix, postdir, unit_desig, sec_range, 
											 name_prefix, name_first, name_middle, name_last, name_suffix,
											 v_predir, v_prim_name, v_suffix, v_postdir, v_city_name,
											 bell_id, filedate, dual_name_flag, sequence_number,
											 group_id, group_seq, omit_address, omit_phone, omit_locality,
											 listing_type_bus, listing_type_res, listing_type_gov, 
											 publish_code, style_code, indent_code, book_neighborhood_code,
											 prior_area_code, cart, cr_sort_sz, lot, lot_order, dpbc,
											 chk_digit, rec_type, county_code, geo_lat, geo_long, msa, 
											 geo_blk, geo_match, err_stat, designation, caption_text, see_also_text),acctno);
	
	
	dedupAllRecords := DEDUP(Sort_All_Records, phone10, prim_range, prim_name, st, z5);

	
	SortResult := SORT(dedupAllRecords, MatchCode, listed_name);
	
	
	FinalResult := PROJECT(SortResult, doFinalProject(LEFT,COUNTER));
	
	TopnResult := FinalResult(seq_num <= max_results);
	
	
	//return TopnResult;
	
	
 TopnResultFinal := PROJECT(TopnResult,finalResultProject(LEFT));
 
 return TopnResultFinal;
	
	
END;
