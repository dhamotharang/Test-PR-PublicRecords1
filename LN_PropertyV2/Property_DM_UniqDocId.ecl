IMPORT MDR;
EXPORT Property_DM_UniqDocId(dataset(LN_PropertyV2.Layout_Property_DM_Extract) ds, Types.StateList st_list=ALL) := function
	
	Layout_Property_DM_Extract xd(LN_PropertyV2.Layout_Property_DM_Extract l) := TRANSFORM
		SELF.sid := (UNSIGNED6) (fn_hash_fares(l.ln_fares_id) << 8);		// Initial, will have collisions
		SELF.source := MDR.sourceTools.fProperty(l.ln_fares_id);
		SELF := l;
		SELF := [];
	END;
	f0 := DISTRIBUTE(PROJECT(ds(state IN st_list), xd(LEFT)),HASH(sid));
	Layout_Property_DM_Extract en(Layout_Property_DM_Extract l, Layout_Property_DM_Extract r):= TRANSFORM
		SELF.rid := IF(l.rid=0, ThorLib.Node()+1, l.rid+ThorLib.Nodes());
		SELF := r;
	END;
	f1 := ITERATE(f0, en(LEFT, RIGHT), LOCAL);	
	
	Key1 := 	RECORD 
		LN_PropertyV2.layout_property_common_model_base.ln_fares_id;
		UNSIGNED6  sid;
		INTEGER2	 cnt := 1;
	END;
	
	g1 := PROJECT(f1, Key1);
	g2 := SORT(g1, sid, ln_fares_id, LOCAL);
	g3 := DEDUP(g2, sid, ln_fares_id, LOCAL);
	
	Key1 roll1(Key1 l, Key1 r) := TRANSFORM
		SELF.ln_fares_id := '';
		SELF.sid := l.sid;
		SELF.cnt := l.cnt + r.cnt;
	END;
	//get duplicated counts by sid and ln_fares_id
	g4 := ROLLUP(g3, sid, roll1(LEFT, RIGHT), LOCAL);
	g5 := ASSERT(g4, cnt<250, 'Too many collisions found in Deeds & Mortgage', FAIL);
	g6 := g5(cnt>1);		// Select collisions
	g7 := JOIN(g3, g6, LEFT.sid=RIGHT.sid, TRANSFORM(key1, SELF:=LEFT), LOCAL, LOOKUP);
	
	Key1 enumKey(Key1 lr, Key1 rr) := TRANSFORM
		SELF.cnt := lr.cnt + 1;
		SELF := rr;
	END;	
	g8 := DISTRIBUTED(UNGROUP(ITERATE(GROUP(g7,sid,LOCAL), enumKey(LEFT, RIGHT))));
		
	Layout_Property_DM_Extract updateKey(Layout_Property_DM_Extract l, Key1 r) := TRANSFORM
		SELF.sid := l.sid + r.cnt;		// zero if no collision
		SELF := l;
	END;
	
	f3 := JOIN(f1, g8, LEFT.sid=RIGHT.sid AND LEFT.ln_fares_id=RIGHT.ln_fares_id,
						 updateKey(LEFT,RIGHT), LEFT OUTER, LOCAL, LOOKUP);
	return f3;
END;