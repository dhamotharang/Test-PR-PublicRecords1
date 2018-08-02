import _Control, watercraft, riskwise, ut, fcra;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Watercraft_Hist_FCRA(GROUPED DATASET(Layout_Boca_Shell_ids) ids_only, boolean isPreScreen, integer bsVersion) := FUNCTION

restrictedStates := fcra.compliance.watercrafts.restricted_states;	// need consumer permission
string8 watercraft_build_date := Risk_Indicators.get_Build_date('watercraft_build_version');

checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;

key_did := watercraft.key_watercraft_did (true); //fcra-version
riskwise.layouts.Layout_Watercraft_Plus watercraft_FCRA(ids_only le, key_did ri) := transform
	myGetDate := iid_constants.myGetDate(le.historydate);
	self.watercraft_key := ri.watercraft_key;
	self.sequence_key := ri.sequence_key;
	lenDate := length(trim(ri.sequence_key));
	seqDate := if(lenDate=8,ri.sequence_key, if(lenDate=6, ri.sequence_key+'31', ''));
	self.watercraft_count := if(trim(ri.watercraft_key)!='', 1, 0);// not really current here, just total
	self.watercraft_count30 := if(trim(ri.watercraft_key)!='' and trim(seqDate)!='' and checkDays(myGetDate,seqDate,30), 1, 0);
	self.watercraft_count90 := if(trim(ri.watercraft_key)!='' and trim(seqDate)!='' and checkDays(myGetDate,seqDate,90), 1, 0);
	self.watercraft_count180 := if(trim(ri.watercraft_key)!='' and trim(seqDate)!='' and checkDays(myGetDate,seqDate,180), 1, 0);
	self.watercraft_count12 := if(trim(ri.watercraft_key)!='' and trim(seqDate)!='' and checkDays(myGetDate,seqDate,ut.DaysInNYears(1)), 1, 0);
	self.watercraft_count24 := if(trim(ri.watercraft_key)!='' and trim(seqDate)!='' and checkDays(myGetDate,seqDate,ut.DaysInNYears(2)), 1, 0);
	self.watercraft_count36 := if(trim(ri.watercraft_key)!='' and trim(seqDate)!='' and checkDays(myGetDate,seqDate,ut.DaysInNYears(3)), 1, 0);
	self.watercraft_count60 := if(trim(ri.watercraft_key)!='' and trim(seqDate)!='' and checkDays(myGetDate,seqDate,ut.DaysInNYears(5)), 1, 0);
	self.watercraft_build_date := watercraft_build_date;
	self := le;
	self := [];
end;
watercraft_recs_roxie := join(ids_only, key_did, 
												 left.did!=0 and keyed(right.l_did = left.did) and 
												 (unsigned3)(right.sequence_key[1..6]) < left.historydate AND	// was told sequence key is best to use
												 ((isPreScreen and right.state_origin not in restrictedStates) or ~isPreScreen),	// filter by state if prescreen
												 watercraft_FCRA(left,right), left outer, atmost(right.l_did=left.did, riskwise.max_atmost));

watercraft_recs_thor_did := join(distribute(ids_only(did!=0), hash64(did)), 
												 distribute(pull(key_did), hash64(l_did)), 
												 right.l_did = left.did and 
												 (unsigned3)(right.sequence_key[1..6]) < left.historydate AND	// was told sequence key is best to use
												 ((isPreScreen and right.state_origin not in restrictedStates) or ~isPreScreen),	// filter by state if prescreen
												 watercraft_FCRA(left,right), left outer, atmost(right.l_did=left.did, riskwise.max_atmost), LOCAL);
watercraft_recs_thor := GROUP(SORT(distribute(watercraft_recs_thor_did + project(ids_only(did=0), transform(riskwise.layouts.Layout_Watercraft_Plus,
												self.watercraft_build_date := watercraft_build_date, self := LEFT, self := [])), hash64(seq)), seq, LOCAL), seq, LOCAL);

#IF(onThor)
	watercraft_recs := watercraft_recs_thor;
#ELSE
	watercraft_recs := watercraft_recs_roxie;
#END

riskwise.layouts.Layout_Watercraft_Plus roll_watercraft(riskwise.layouts.Layout_Watercraft_Plus le, riskwise.layouts.Layout_Watercraft_Plus ri) := transform
	self.watercraft_count := le.watercraft_count+IF(le.watercraft_key=ri.watercraft_key,0,ri.watercraft_count);  // don't increment if the key is a duplicate
	self.watercraft_count30 := le.watercraft_count30+IF(le.watercraft_key=ri.watercraft_key,0,ri.watercraft_count30);
	self.watercraft_count90 := le.watercraft_count90+IF(le.watercraft_key=ri.watercraft_key,0,ri.watercraft_count90);
	self.watercraft_count180 := le.watercraft_count180+IF(le.watercraft_key=ri.watercraft_key,0,ri.watercraft_count180);
	self.watercraft_count12 := le.watercraft_count12+IF(le.watercraft_key=ri.watercraft_key,0,ri.watercraft_count12);
	self.watercraft_count24 := le.watercraft_count24+IF(le.watercraft_key=ri.watercraft_key,0,ri.watercraft_count24);
	self.watercraft_count36 := le.watercraft_count36+IF(le.watercraft_key=ri.watercraft_key,0,ri.watercraft_count36);
	self.watercraft_count60 := le.watercraft_count60+IF(le.watercraft_key=ri.watercraft_key,0,ri.watercraft_count60);
	self := ri;
end;

watercraft_deduped := dedup(sort(watercraft_recs, seq, did, watercraft_key[1..10], -sequence_key), seq, did, watercraft_key[1..10]);
watercraft_sorted := sort(watercraft_recs, watercraft_key,-sequence_key);
watercraft_records := if(bsversion < 50, watercraft_sorted, watercraft_deduped);

rolled_watercraft := rollup(watercraft_records, true, roll_watercraft(left,right));	

return rolled_watercraft;

end;