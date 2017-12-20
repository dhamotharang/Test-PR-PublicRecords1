IMPORT Text_Search, Codes, Header, MDR, FBNV2;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT FBNFragments(Types.StateList st_list=ALL) := MODULE
	SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_FBN_Bus	:= Persist_Stem + 'FBN_Bus';
	SHARED Persist_FBN_Cont	:= Persist_Stem + 'FBN_Cont';

	SHARED FBN_Base := FBNV2.File_FBN_Business_Base_AID(tmsid <> '',tmsid not in FBNV2.Suppress_TMSID());
	SHARED FBN_Cont := FBNV2.File_FBN_Contact_Base(tmsid <> '');
	
	SHARED UNSIGNED8 Key2Doc(STRING key) := (HASH64(key)) << 8;
	SHARED Key1 := RECORD
		FBNV2.Layout_Common.Business_AID.Tmsid;
		UNSIGNED6 sid;
		INTEGER2	cnt := 1;
	END;
	Key1 xbase(FBN_Base l) := TRANSFORM
		SELF.tmsid := l.tmsid;
		SELF.sid := Key2Doc(l.tmsID);
	END;
	Key1 xcont(FBN_Cont l) := TRANSFORM
		SELF.tmsid := l.tmsid;
		SELF.sid := Key2Doc(l.tmsid);
	END;
	Key1 roll1(Key1 l, Key1 r) := TRANSFORM
		SELF.tmsid := '';
		SELF.sid := l.sid;
		SELF.cnt := l.cnt + r.cnt;
	END;
	Key1 enumKey(Key1 lr, Key1 rr) := TRANSFORM
		SELF.cnt := lr.cnt + 1;
		SELF := rr;
	END;	
	g0a := PROJECT(FBN_Base, xbase(LEFT));
	g0b := PROJECT(FBN_Cont, xcont(LEFT));
	g1  := DISTRIBUTE(g0a+g0b, HASH64(sid));
	g2  := SORT(g1, sid, tmsid, LOCAL);
	g3  := DEDUP(g2, sid, tmsid, LOCAL);
	g4  := ROLLUP(g3, roll1(LEFT, RIGHT), sid, LOCAL);
	g5 := ASSERT(g4, cnt<250, 'Too many collisions found in FBN', FAIL);
	g6 := DISTRIBUTED(g5(cnt>1));		// Select collisions
	g7 := JOIN(g3, g6, LEFT.sid=RIGHT.sid, TRANSFORM(key1, SELF:=LEFT), LOCAL, LOOKUP);
	g8 := DISTRIBUTED(UNGROUP(ITERATE(GROUP(g7,sid,LOCAL), enumKey(LEFT, RIGHT))));
	SHARED DocUpdateList := g8 : INDEPENDENT;

	// FBN Business
	Layout_FBN_Bus xd(FBNV2.Layout_Common.Business_AID l) := TRANSFORM
		SELF.source := MDR.sourceTools.fFBNV2(l.tmsid);
		SELF.sid := (UNSIGNED6)(HASH64(TRIM(l.tmsid)) << 8);
		SELF := l;
	END;
	f1 := PROJECT(FBN_Base(bus_state IN st_list OR mail_state IN st_list), xd(LEFT));
	Layout_FBN_Bus updateKey(Layout_FBN_Bus l, Key1 r) := TRANSFORM
		SELF.sid := l.sid + r.cnt;		// zero if no collision
		SELF := l;
	END;
	f2 := JOIN(f1, DocUpdateList, 
						 LEFT.sid=RIGHT.sid AND LEFT.tmsid=RIGHT.tmsid,
						 updateKey(LEFT,RIGHT), LEFT OUTER, LOOKUP);
	Layout_FBN_Bus en(Layout_FBN_Bus l, Layout_FBN_Bus r) := TRANSFORM
		SELF.rid := IF(l.rid=0, ThorLib.Node() + 1, l.rid+ThorLib.Nodes());
		SELF := r;
	END;
	f3 := ITERATE(f2, en(LEFT, RIGHT), LOCAL);	
	SHARED FBN_Bus_File := f3 : PERSIST(Persist_FBN_Bus);
	SHARED FBN_Bus_mod := FBN_BusBooleanSearch(FBN_Bus_File);
	Layout_AnswerListData xans(Layout_FBN_Bus l) := TRANSFORM
		SELF.source_doc_type := 'FBNV2';
		SELF.src := TRANSFER(l.source, UNSIGNED2);
		SELF.doc := l.sid;
		SELF.record_id := l.TMSID;
		SELF.dt_last_seen := (STRING) l.dt_last_seen;
		SELF.phone := StringLib.StringFilterOut(l.bus_phone_num, ' -');
		SELF.company_name := l.bus_name;
		SELF.address.line1				:= l.bus_address1;
		SELF.address.csz					:= l.bus_address2;
		SELF.address.city_name 		:= l.v_city_name;
		SELF.address := l;
		SELF.name := l;
		SELF := l;
		SELF := [];
	END;
	SHARED FBN_Bus_ans_recs := PROJECT(FBN_Bus_File, xans(LEFT));

	// FBN Contact
	Layout_FBN_Contact xd(FBNV2.Layout_Common.Contact l) := TRANSFORM
		SELF.source := MDR.sourceTools.fFBNV2(l.tmsid);
		SELF.sid := (UNSIGNED6)(HASH64(TRIM(l.tmsid)) << 8);
		SELF := l;
	END;
	f1 := PROJECT(FBN_Cont(contact_state IN st_list OR st IN st_list), xd(LEFT));
	Layout_FBN_Contact updateKey(Layout_FBN_Contact l, Key1 r) := TRANSFORM
		SELF.sid := l.sid + r.cnt;		// zero if no collision
		SELF := l;
	END;
	f2 := JOIN(f1, DocUpdateList, 
						 LEFT.sid=RIGHT.sid AND LEFT.tmsid=RIGHT.tmsid,
						 updateKey(LEFT,RIGHT), LEFT OUTER, LOCAL, LOOKUP);
	Layout_FBN_Contact en(Layout_FBN_Contact l, Layout_FBN_Contact r) := TRANSFORM
		SELF.rid := IF(l.rid=0, ThorLib.Node()+10000000000000, l.rid+ThorLib.Nodes());
		SELF := r;
	END;
	f3 := ITERATE(f2, en(LEFT, RIGHT), LOCAL);	
	SHARED FBN_Contact_File := f3 : PERSIST(Persist_FBN_Cont);
	SHARED FBN_Contact_mod := FBN_ContactBooleanSearch(FBN_Contact_File);
	Layout_AnswerListData xans(Layout_FBN_Contact l) := TRANSFORM
		SELF.source_doc_type := 'FBNV2';
		SELF.src := TRANSFER(l.source, UNSIGNED2);
		SELF.doc := l.sid;
		SELF.record_id := l.tmsid;
		SELF.dt_last_seen := (STRING) l.dt_last_seen;
		SELF.phone := StringLib.StringFilterOut(l.contact_phone, ' -');
		SELF.name.full_name 		:= l.contact_name;
		SELF.address.city_name 	:= l.v_city_name;
		SELF.address.line1			:= l.contact_addr;
		SELF.address.csz				:= l.contact_city + ' ' + l.contact_state + ' ' + l.contact_zip;
		SELF.address := l;
		SELF.name := l;
		SELF := l;
		SELF := [];
	END;
	SHARED FBN_Contact_ans_recs := PROJECT(FBN_Contact_File, xans(LEFT));
	
	// Combine FBN sources
	EXPORT DeletePersist := SEQUENTIAL(
						FileServices.DeleteLogicalFile(Persist_FBN_Bus),
						FileServices.DeleteLogicalFile(Persist_FBN_Cont));
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
							:= FBN_Bus_mod.SegmentDefinitions 
							 + FBN_Contact_mod.SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings
							:= FBN_Bus_mod.Postings_Doc + FBN_Contact_mod.Postings_Doc;
	EXPORT DATASET(Text_FragV1.Layout_AnswerListData) answerRecs
							:= FBN_Bus_ans_recs + FBN_Contact_ans_recs;
END;