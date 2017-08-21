IMPORT Text_Search, Codes, MDR, Corp2;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT CorpFragments(Types.StateList st_list=ALL) := MODULE
	SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_Corp_Base:= Persist_Stem + 'Corp_Base';
	SHARED Persist_Corp_Cont:= Persist_Stem + 'Corp_Cont';
	
	SHARED Corp_Base := corp2.Files().AID.Corp.built(corp_key <> '');
	SHARED Corp_Cont := corp2.Files().AID.Cont.built(corp_key <> '');

	SHARED UNSIGNED8 Key2Doc(STRING key) := (HASH64(key)) << 8;
	SHARED Key1 := RECORD
		Corp2.Layout_Corporate_Direct_Corp_AID.corp_key;
		UNSIGNED6 sid;
		INTEGER2	cnt := 1;
	END;
	Key1 xbase(Corp_Base l) := TRANSFORM
		SELF.corp_key := l.corp_key;
		SELF.sid := Key2Doc(l.corp_key);
	END;
	Key1 xcont(Corp_Cont l) := TRANSFORM
		SELF.corp_key := l.corp_key;
		SELF.sid := Key2Doc(l.corp_key);
	END;
	Key1 roll1(Key1 l, Key1 r) := TRANSFORM
		SELF.corp_key := '';
		SELF.sid := l.sid;
		SELF.cnt := l.cnt + r.cnt;
	END;
	Key1 enumKey(Key1 lr, Key1 rr) := TRANSFORM
		SELF.cnt := lr.cnt + 1;
		SELF := rr;
	END;	
	g0a := PROJECT(Corp_Base, xbase(LEFT));
	g0b := PROJECT(Corp_Cont, xcont(LEFT));
	g1  := DISTRIBUTE(g0a+g0b, HASH64(sid));
	g2  := SORT(g1, sid, corp_key, LOCAL);
	g3  := DEDUP(g2, sid, corp_key, LOCAL);
	g4  := ROLLUP(g3, roll1(LEFT, RIGHT), sid, LOCAL);
	g5 := ASSERT(g4, cnt<250, 'Too many collisions found in Corp', FAIL);
	g6 := DISTRIBUTED(g5(cnt>1));		// Select collisions
	g7 := JOIN(g3, g6, LEFT.sid=RIGHT.sid, TRANSFORM(key1, SELF:=LEFT), LOCAL, LOOKUP);
	g8 := DISTRIBUTED(UNGROUP(ITERATE(GROUP(g7,sid,LOCAL), enumKey(LEFT, RIGHT))));
	SHARED DocUpdateList := g8 : INDEPENDENT;

	// Corp base
	Layout_Corp_Base xd(Corp2.Layout_Corporate_Direct_Corp_AID l) := TRANSFORM
		SELF.sid := Key2Doc(l.corp_key);
		SELF.source := MDR.sourceTools.fCorpV2(l.corp_key, l.corp_state_origin);
		SELF := l;
	END;
	f1 := PROJECT(Corp_Base(corp_state_origin IN st_list), xd(LEFT));
	Layout_Corp_Base updateKey(Layout_Corp_Base l, Key1 r) := TRANSFORM
		SELF.sid := l.sid + r.cnt;		// zero if no collision
		SELF := l;
	END;
	f2 := JOIN(f1, DocUpdateList, 
						 LEFT.sid=RIGHT.sid AND LEFT.corp_key=RIGHT.corp_key,
						 updateKey(LEFT,RIGHT), LEFT OUTER, LOOKUP);
	Layout_Corp_Base en(Layout_Corp_Base l, Layout_Corp_Base r):= TRANSFORM
		SELF.rid := IF(l.rid=0, ThorLib.Node()+1, l.rid+ThorLib.Nodes());
		SELF := r;
	END;
	f3 := ITERATE(f2, en(LEFT, RIGHT), LOCAL);	
	SHARED Corp_Base_File := f3 : PERSIST(Persist_Corp_Base);
	SHARED Corp_Base_mod := Corp_BaseBooleanSearch(Corp_Base_File);
	Layout_AnswerListData xans(Layout_Corp_Base l) := TRANSFORM
		SELF.source_doc_type := 'CORPV2';
		SELF.src := TRANSFER(l.source, UNSIGNED2);
		SELF.doc := l.sid;
		SELF.record_id := l.corp_key;
		SELF.dt_last_seen := (STRING) l.dt_last_seen;
		SELF.phone := StringLib.StringFilterOut(l.corp_phone_number, ' -');
		SELF.company_name				 := l.corp_legal_name;
		SELF.address.prim_range  := l.corp_addr1_prim_range;
		SELF.address.predir 		 := l.corp_addr1_predir;
		SELF.address.prim_name	 := l.corp_addr1_prim_name;
		SELF.address.postdir		 := l.corp_addr1_postdir;
		SELF.address.addr_suffix := l.corp_addr1_addr_suffix;
		SELF.address.unit_desig	 := l.corp_addr1_unit_desig;
		SELF.address.sec_range	 := l.corp_addr1_sec_range;
		SELF.address.zip5 			 := l.corp_addr1_zip5;
		SELF.address.zip4 			 := l.corp_addr1_zip4;
		SELF.address.city_name 	 := l.corp_addr1_v_city_name;
		SELF.address.st					 := l.corp_addr1_state;
		SELF.address.line1 			 := l.corp_address1_line1;
		SELF.address.csz				 := MAP(
														l.corp_address1_line6<>' ' => l.corp_address1_line6,
														l.corp_address1_line5<>' ' => l.corp_address1_line5,
														l.corp_address1_line4<>' ' => l.corp_address1_line4,
														l.corp_address1_line3<>' ' => l.corp_address1_line3,
														l.corp_address1_line2<>' ' => l.corp_address1_line2,
														l.corp_addr1_p_city_name+' '+l.corp_addr1_state+' '+l.corp_addr1_zip5);
		SELF.name := l;
		SELF := l;
		SELF := [];
	END;
	SHARED Corp_Base_ans := PROJECT(Corp_Base_File, xans(LEFT));

	// corp contacts
	Layout_Corp_Contact xd(Corp2.Layout_Corporate_Direct_Cont_AID l) := TRANSFORM
		SELF.sid := Key2Doc(l.corp_key);
		SELF.source := MDR.sourceTools.fCorpV2(l.corp_key, l.corp_state_origin);
		SELF := l;
	END;
	f1 := PROJECT(Corp_Cont(corp_state_origin IN st_list), xd(LEFT));
	Layout_Corp_Contact updateKey(Layout_Corp_Contact l, Key1 r) := TRANSFORM
		SELF.sid := l.sid + r.cnt;		// zero if no collision
		SELF := l;
	END;
	f2 := JOIN(f1, DocUpdateList, 
						 LEFT.sid=RIGHT.sid AND LEFT.corp_key=RIGHT.corp_key,
						 updateKey(LEFT,RIGHT), LEFT OUTER, LOOKUP);
	Layout_Corp_Contact en(Layout_Corp_Contact l, Layout_Corp_Contact r):= TRANSFORM
		SELF.rid := IF(l.rid=0, ThorLib.Node()+10000000000000, l.rid+ThorLib.Nodes());
		SELF := r;
	END;
	f3 := ITERATE(f2, en(LEFT, RIGHT), LOCAL);	
	SHARED Corp_Contact_File := f3 : PERSIST(Persist_Corp_Cont);
	SHARED Corp_Contact_mod := Corp_ContactBooleanSearch(Corp_Contact_File);
	Layout_AnswerListData xans(Layout_Corp_Contact l) := TRANSFORM
		SELF.source_doc_type := 'CORPV2';
		SELF.src := TRANSFER(l.source, UNSIGNED2);
		SELF.doc := l.sid;
		SELF.record_id := l.corp_key;
		SELF.dt_last_seen := (STRING) l.dt_last_seen;
		SELF.dob := l.cont_dob;
		SELF.ssn := l.cont_ssn;
		SELF.phone := StringLib.StringFilterOut(l.corp_phone_number, ' -');
		SELF.company_name := l.cont_cname;
		SELF.name.fname 				:= l.cont_fname;
		SELF.name.mname 				:= l.cont_mname;
		SELF.name.lname 				:= l.cont_lname;
		SELF.name.name_suffix 	:= l.cont_name_suffix;
		SELF.name.full_name 		:= l.cont_name;
		SELF.address.prim_range  	:= l.cont_prim_range;
		SELF.address.predir			 	:= l.cont_predir;
		SELF.address.prim_name	 	:= l.cont_prim_name;
		SELF.address.addr_suffix 	:= l.cont_addr_suffix;
		SELF.address.postdir		 	:= l.cont_postdir;
		SELF.address.unit_desig	 	:= l.cont_unit_desig;
		SELF.address.sec_range	 	:= l.cont_sec_range;
		SELF.address.city_name   	:= l.cont_v_city_name;
		SELF.address.st					 	:= l.cont_state;
		SELF.address.zip5 			 	:= l.cont_zip5;
		SELF.address.zip4 			 	:= l.cont_zip4;
		SELF.address.line1				:= l.cont_address_line1;
		SELF.address.csz					:= MAP(
														 l.cont_address_line6 <> ' '	=> l.cont_address_line6,
														 l.cont_address_line5 <> ' '	=> l.cont_address_line5,
														 l.cont_address_line4 <> ' '	=> l.cont_address_line4,
														 l.cont_address_line3 <> ' '	=> l.cont_address_line3,
														 l.cont_address_line2 <> ' '	=> l.cont_address_line2,
														 l.cont_p_city_name + ' ' + l.cont_state + ' ' + l.cont_zip5);
		SELF := l;
		SELF := [];
	END;
	SHARED Corp_Contact_ans := PROJECT(Corp_Contact_File, xans(LEFT));
	
	// Combine Corp sources 
	EXPORT DeletePersist 
							:= SEQUENTIAL(FileServices.DeleteLogicalFile(Persist_Corp_Base),
														FileServices.DeleteLogicalFile(Persist_Corp_Cont));
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
							:= Corp_Base_mod.SegmentDefinitions 
							 + Corp_Contact_mod.SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings 	 
							:= Corp_Base_mod.Postings_Doc + Corp_Contact_mod.Postings_Doc;
	EXPORT DATASET(Text_FragV1.Layout_AnswerListData) answerRecs
							:= Corp_Base_ans + Corp_Contact_ans;
END;