IMPORT LN_PropertyV2, LN_PropertyV2_Services, Text_Search, Codes, MDR;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT PropertyFragments(Types.StateList st_list=ALL) := MODULE
	SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_Prop_A		:= Persist_Stem + 'PropA';
	SHARED Persist_Prop_DM	:= Persist_Stem + 'PropDM';
	// Source sets
	SHARED Assessor_Set := [MDR.sourceTools.src_LnPropV2_Fares_Asrs,
														 MDR.sourceTools.src_LnPropV2_Lexis_Asrs];
	SHARED Deeds_Set    := [MDR.sourceTools.src_LnPropV2_Fares_Deeds,
													MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs];
	// Parsed, cleaned, enhanced data of interest
	SHARED GetSource := MDR.sourceTools.fProperty;
	SHARED Property_Search := LN_PropertyV2.File_Search_did(ln_fares_id<>' ' 
															AND err_stat[1] = 'S');
	// Parsed and cleaned names from search file for assessor data
	sf := Property_Search(which_orig='1' AND GetSource(ln_fares_id) IN Assessor_Set);
	s0 := PROJECT(sf, Layout_Property_KeyExtract);
	s1 := DISTRIBUTE(s0, HASH64(TRIM(ln_fares_id)));
	s2 := SORT(s1, ln_fares_id, process_date, dt_last_seen, LOCAL);
	assessor := DEDUP(s2, ln_fares_id, RIGHT, LOCAL);
	// Assessor data
	ds :=  LN_PropertyV2.File_Assessment(ln_fares_id <> '');
	Layout_Property_A_Extract xa(LN_PropertyV2.layout_property_common_model_base l) := TRANSFORM
		SELF.sid := (UNSIGNED6) (HASH64(TRIM(l.ln_fares_id)) << 8);		// Initial, will have collisions
		SELF.source := MDR.sourceTools.fProperty(l.ln_fares_id);
		SELF := l;
		SELF := [];
	END;
	f0 := PROJECT(ds(state_code IN st_list), xa(LEFT));
	Layout_Property_A_Extract en(Layout_Property_A_Extract l, Layout_Property_A_Extract r):= TRANSFORM
		SELF.rid := IF(l.rid=0, ThorLib.Node()+1, l.rid+ThorLib.Nodes());
		SELF := r;
	END;
	f1 := ITERATE(f0, en(LEFT, RIGHT), LOCAL);	
	f2 := DISTRIBUTE(f1, HASH64(TRIM(ln_fares_id)));
	Key1 := 	RECORD 
		LN_PropertyV2.layout_property_common_model_base.ln_fares_id;
		UNSIGNED6  sid;
		INTEGER2	 cnt := 1;
	END;
	Key1 roll1(Key1 l, Key1 r) := TRANSFORM
		SELF.ln_fares_id := '';
		SELF.sid := l.sid;
		SELF.cnt := l.cnt + r.cnt;
	END;
	Key1 enumKey(Key1 lr, Key1 rr) := TRANSFORM
		SELF.cnt := lr.cnt + 1;
		SELF := rr;
	END;	
	Layout_Property_A_Extract updateKey(Layout_Property_A_Extract l, Key1 r) := TRANSFORM
		SELF.sid := l.sid + r.cnt;		// zero if no collision
		SELF := l;
	END;
	g1 := PROJECT(f1, Key1);
	g2 := SORT(g1, sid, ln_fares_id, LOCAL);
	g3 := DEDUP(g2, sid, ln_fares_id, LOCAL);
	g4 := ROLLUP(g3, sid, roll1(LEFT, RIGHT), LOCAL);
	g5 := ASSERT(g4, cnt<250, 'Too many collisions found in Assets', FAIL);
	g6 := g5(cnt>1);		// Select collisions
	g7 := JOIN(g3, g6, LEFT.sid=RIGHT.sid, TRANSFORM(key1, SELF:=LEFT), LOCAL, LOOKUP);
	g8 := DISTRIBUTED(UNGROUP(ITERATE(GROUP(g7,sid,LOCAL), enumKey(LEFT, RIGHT))));
	f3 := JOIN(f2, g8, LEFT.sid=RIGHT.sid AND LEFT.ln_fares_id=RIGHT.ln_fares_id,
						 updateKey(LEFT,RIGHT), LEFT OUTER, LOCAL, LOOKUP);
	Layout_Property_A_Extract getParsed(f3 l, assessor r) := TRANSFORM
		SELF.ln_fares_id := l.ln_fares_id;
		SELF := r;
		SELF := l;
	END;
	f4 := JOIN(f3, assessor, LEFT.ln_fares_id=RIGHT.ln_fares_id,
						 getParsed(LEFT,RIGHT), LEFT OUTER, LOCAL);
	SHARED Prop_A_File := f4 : PERSIST(Persist_Prop_A);
	SHARED Prop_A_mod := Property_ABooleanSearch(Prop_A_File);
	SHARED Prop_A_Pst := Prop_A_mod.Postings_Doc;
	Layout_AnswerListData xans(Layout_Property_A_Extract l) := TRANSFORM
		SELF.source_doc_type := 'LNPropV2';
		SELF.src := TRANSFER(l.source, UNSIGNED2);
		SELF.doc := l.sid;
		SELF.record_id := l.ln_fares_id;
		SELF.dt_last_seen := MAP(	l.dt_last_seen <> 0		=> (STRING8) l.dt_last_seen,
															l.process_date <> ' ' => l.process_date,
															l.recording_date<>' ' => l.recording_date,
														  l.sale_date <> ' '		=> l.sale_date,
															'19000101');
		SELF.company_name := l.cname;
		SELF.phone := StringLib.StringFilterOut(l.assessee_phone_number, ' -');
		SELF.name.full_name := MAP(l.nameasis <> ' '			=> l.nameasis,
												 l.assessee_name<>' '					=> l.assessee_name,
												 l.mailing_care_of_name<>' ' 	=> l.mailing_care_of_name,
												 l.second_assessee_name<>' '	=> l.second_assessee_name,
												 l.fname + ' ' + l.mname + ' ' + l.lname);
		SELF.address.line1 := MAP(l.property_full_street_address <> ' '  => l.property_full_street_address,
											l.mailing_full_street_address  <> ' '	 => l.mailing_full_street_address,
											l.prim_range+' '+l.predir+' '+l.prim_name+' '+l.suffix+' '+l.postdir);
		SELF.address.csz := MAP(l.property_city_state_zip<>' '		=> l.property_city_state_zip,
										l.mailing_city_state_zip <>' '		=> l.mailing_city_state_zip,
										l.v_city_name + ' ' + l.st + ' ' + l.zip);
		SELF.address.addr_suffix := l.suffix;
		SELF.address.zip5 := l.zip;
		SELF.address.city_name := l.v_city_name;
		SELF.address := l;
		SELF.name := l;
		SELF := l;
		SELF := [];
	END;
	SHARED Prop_A_ans_recs := PROJECT(Prop_A_File, xans(LEFT));
	
	// Parsed and cleaned names from search file for deed and mortgage data
	sf := Property_Search(which_orig='1' AND GetSource(ln_fares_id) IN Deeds_Set
												AND source_code[1] IN ['B', 'O']);
	s0 := PROJECT(sf, Layout_Property_KeyExtract);
	s1 := DISTRIBUTE(s0, HASH64(TRIM(ln_fares_id)));
	s2 := SORT(s1, ln_fares_id, process_date, dt_last_seen, LOCAL);
	deed := DEDUP(s2, ln_fares_id, RIGHT, LOCAL);
	// Deeds and Mortgages
	ds := LN_Propertyv2.File_Deed(ln_fares_id <> '');
	Layout_Property_DM_Extract xd(LN_PropertyV2.layout_deed_mortgage_common_model_base l) := TRANSFORM
		SELF.sid := (UNSIGNED6) (HASH64(TRIM(l.ln_fares_id)) << 8);		// Initial, will have collisions
		SELF.source := MDR.sourceTools.fProperty(l.ln_fares_id);
		SELF := l;
		SELF := [];
	END;
	f0 := PROJECT(ds(state IN st_list), xd(LEFT));
	Layout_Property_DM_Extract en(Layout_Property_DM_Extract l, Layout_Property_DM_Extract r):= TRANSFORM
		SELF.rid := IF(l.rid=0, ThorLib.Node()+1, l.rid+ThorLib.Nodes());
		SELF := r;
	END;
	f1 := ITERATE(f0, en(LEFT, RIGHT), LOCAL);	
	f2 := DISTRIBUTE(f1, HASH64(TRIM(ln_fares_id)));
	Key1 := 	RECORD 
		LN_PropertyV2.layout_property_common_model_base.ln_fares_id;
		UNSIGNED6  sid;
		INTEGER2	 cnt := 1;
	END;
	Key1 roll1(Key1 l, Key1 r) := TRANSFORM
		SELF.ln_fares_id := '';
		SELF.sid := l.sid;
		SELF.cnt := l.cnt + r.cnt;
	END;
	Key1 enumKey(Key1 lr, Key1 rr) := TRANSFORM
		SELF.cnt := lr.cnt + 1;
		SELF := rr;
	END;	
	Layout_Property_DM_Extract updateKey(Layout_Property_DM_Extract l, Key1 r) := TRANSFORM
		SELF.sid := l.sid + r.cnt;		// zero if no collision
		SELF := l;
	END;
	g1 := PROJECT(f1, Key1);
	g2 := SORT(g1, sid, ln_fares_id, LOCAL);
	g3 := DEDUP(g2, sid, ln_fares_id, LOCAL);
	g4 := ROLLUP(g3, sid, roll1(LEFT, RIGHT));
	g5 := ASSERT(g4, cnt<250, 'Too many collisions found in Deeds', FAIL);
	g6 := DISTRIBUTED(g5(cnt>1));		// Select collisions
	g7 := JOIN(g3, g6, LEFT.sid=RIGHT.sid, TRANSFORM(key1, SELF:=LEFT), LOCAL, LOOKUP);
	g8 := DISTRIBUTED(UNGROUP(ITERATE(GROUP(g7,sid,LOCAL), enumKey(LEFT, RIGHT))));
	f3 := JOIN(f2, g8, LEFT.sid=RIGHT.sid AND LEFT.ln_fares_id=RIGHT.ln_fares_id,
						 updateKey(LEFT,RIGHT), LEFT OUTER, LOCAL, LOOKUP);
	Layout_Property_DM_Extract  getParsed(f3 l, deed r) := TRANSFORM
		SELF.ln_fares_id := l.ln_fares_id;
		SELF := r;
		SELF := l;
	END;
	f4 := JOIN(f3, deed, LEFT.ln_fares_id=RIGHT.ln_fares_id,
						 getParsed(LEFT,RIGHT), LEFT OUTER, LOCAL, LOOKUP);
	SHARED Prop_DM_File := f4 : PERSIST(Persist_Prop_DM);
	SHARED Prop_DM_mod := Property_DMBooleanSearch(Prop_DM_File);
	SHARED Prop_DM_pst := Prop_DM_mod.Postings_Doc;
	Layout_AnswerListData xans(Layout_Property_DM_Extract l) := TRANSFORM
		SELF.source_doc_type := 'LNPropV2';
		SELF.src := TRANSFER(l.source, UNSIGNED2);
		SELF.doc := l.sid;
		SELF.record_id := l.ln_fares_id;
		SELF.dt_last_seen := MAP(l.dt_last_seen <> 0						=> (STRING) l.dt_last_seen,
													l.process_date <> ' '							=> l.process_date,
													l.recording_date <> ' '						=> l.recording_date,
													l.contract_date <> ' '						=> l.contract_date,
													'19000101');
		SELF.phone := StringLib.StringFilterOut(l.phone_number, ' -');
		SELF.company_name := l.cname;
		SELF.name.full_name := MAP(l.name1 <> ' '										=> l.name1,
													l.name2 <> ' '										=> l.name2,
													l.mailing_care_of <> ' '					=> l.mailing_care_of,
													l.seller1 <> ' '									=> l.seller1,
													l.seller2 <> ' '									=> l.seller2,
													l.fname + ' ' + l.mname + ' ' + l.lname);
		SELF.address.addr_suffix := l.suffix;
		SELF.address.zip5 := l.zip;
		SELF.address.city_name := l.v_city_name;
		SELF.address.line1 := MAP(l.property_full_street_address <> ' '  => l.property_full_street_address,
											l.mailing_street  <> ' '							 => l.mailing_street,
											
											l.prim_range+' '+l.predir+' '+l.prim_name+' '+l.suffix+' '+l.postdir);
		SELF.address.csz := MAP(l.property_address_citystatezip<>' '		=> l.property_address_citystatezip,
										l.mailing_csz <>' '								=> l.mailing_csz,
										l.v_city_name + ' ' + l.st + ' ' + l.zip);
		SELF.address := l;
		SELF.name := l;
		SELF := l;
		SELF := [];
	END;
	SHARED Prop_DM_ans_recs := PROJECT(Prop_DM_File, xans(LEFT));
	
	// Combine Property
	EXPORT DeletePersist := SEQUENTIAL(						
						FileServices.DeleteLogicalFile(Persist_Prop_A),
						FileServices.DeleteLogicalFile(Persist_Prop_DM));
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
						:= Prop_A_mod.SegmentDefinitions + Prop_DM_mod.SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings 
						:= Prop_A_Pst + Prop_DM_pst;
	EXPORT DATASET(Text_FragV1.Layout_AnswerListData) answerRecs 
						:= Prop_A_ans_recs + Prop_DM_ans_recs;
END;