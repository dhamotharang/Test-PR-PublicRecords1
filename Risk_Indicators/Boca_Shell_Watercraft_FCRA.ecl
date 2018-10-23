import _Control, watercraft, fcra, riskwise, ut;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Watercraft_FCRA(GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell_ids) ids_only, boolean isPreScreen, integer bsVersion) := FUNCTION


restrictedStates := fcra.compliance.watercrafts.restricted_states;	// need consumer permission
string8 watercraft_build_date := Risk_Indicators.get_Build_date('watercraft_build_version');
myGetDate := watercraft_build_date;
checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;


riskwise.layouts.Layout_Watercraft_Plus watercraft_correct(ids_only le, FCRA.Key_Override_Watercraft.sid ri) := transform
	self.watercraft_key := ri.watercraft_key;
	self.state_origin := ri.state_origin;
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
water_correct_roxie := join(ids_only, FCRA.Key_Override_Watercraft.sid,
											keyed(right.flag_file_id in left.water_correct_ffid) and
											((isPreScreen and right.state_origin not in restrictedStates) or ~isPreScreen),	// filter by state if prescreen
											watercraft_correct(left, right),left outer, atmost(right.flag_file_id in left.water_correct_ffid, 100));	
											
water_correct_thor := join(ids_only, pull(FCRA.Key_Override_Watercraft.sid),
											right.flag_file_id in left.water_correct_ffid and
											((isPreScreen and right.state_origin not in restrictedStates) or ~isPreScreen),	// filter by state if prescreen
											watercraft_correct(left, right),left outer, LOCAL, ALL);		
											
#IF(onThor)
	water_correct := water_correct_thor;
#ELSE
	water_correct := water_correct_roxie;
#END

key_did := watercraft.key_watercraft_did (true); //fcra-version 
riskwise.layouts.Layout_Watercraft_Plus watercraft_FCRA(water_correct le, key_did ri) := transform
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
watercraft_recs_roxie := join(water_correct, key_did, 
												left.did!=0 and left.watercraft_key<>right.watercraft_key and 
												left.state_origin<>right.state_origin and left.sequence_key<>right.sequence_key and
												keyed(right.l_did = left.did) and
												((isPreScreen and right.state_origin not in restrictedStates) or ~isPreScreen),	// filter by state if prescreen
												watercraft_FCRA(left,right), left outer, atmost(right.l_did=left.did, riskwise.max_atmost));

watercraft_recs_thor_did := join(distribute(water_correct(did!=0), hash64(did)), 
												distribute(pull(key_did), hash64(l_did)), 
												left.watercraft_key<>right.watercraft_key and 
												left.state_origin<>right.state_origin and left.sequence_key<>right.sequence_key and
												(right.l_did = left.did) and
												((isPreScreen and right.state_origin not in restrictedStates) or ~isPreScreen),	// filter by state if prescreen
												watercraft_FCRA(left,right), left outer, atmost(right.l_did=left.did, riskwise.max_atmost), LOCAL);

watercraft_recs_thor := group(sort(watercraft_recs_thor_did + water_correct(did=0), seq), seq);

#IF(onThor)
	watercraft_recs := watercraft_recs_thor;
#ELSE
	watercraft_recs := watercraft_recs_roxie;
#END

combined := ungroup(water_correct + watercraft_Recs);

combo_deduped := dedup(sort (combined, seq, did, watercraft_key[1..10], -sequence_key), seq, did, watercraft_key[1..10]);
combo_sorted := sort (combined, seq, watercraft_key, -sequence_key);
combo_recs := if(bsversion < 50, combo_sorted, combo_deduped);

combo := group(combo_recs, seq);

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
rolled_watercraft := rollup(combo, true, roll_watercraft(left,right));	

return rolled_watercraft;

end;