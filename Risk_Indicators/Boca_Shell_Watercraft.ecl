import watercraft, riskwise, ut, risk_indicators;

export Boca_Shell_Watercraft(GROUPED DATASET(risk_indicators.Layout_Boca_Shell_ids) ids_only, integer bsVersion ) := FUNCTION

string8 watercraft_build_date := Risk_Indicators.get_Build_date('watercraft_build_version');
checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;

key_did := watercraft.key_watercraft_did (); //non-fcra version

riskwise.layouts.Layout_Watercraft_Plus watercraft_nonFCRA(ids_only le, key_did ri) := transform
	// to account for people running in history mode with current date, use the minimum of either the history date or the build date, jira MS-48 
	earliest_date := min(watercraft_build_date, risk_indicators.iid_constants.full_history_date(le.historydate));
	myGetDate := if(le.historydate=999999, watercraft_build_date, earliest_date);
                self.watercraft_key := ri.watercraft_key;
                self.sequence_key := ri.sequence_key;
                lenDate := length(trim(ri.sequence_key));
                seqDate := if(lenDate=8,ri.sequence_key, if(lenDate=6, ri.sequence_key+'31', '99999999'));       // put the date in future if there is no date, so that it gets sorted to the end and we keep the oldest record
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
watercraft_recs := join(ids_only, key_did,
									left.did!=0 and keyed(right.l_did = left.did) and
									(unsigned3)(right.sequence_key[1..6]) < left.historydate,
									watercraft_nonFCRA(left,right), left outer, atmost(right.l_did=left.did, riskwise.max_atmost));


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
watercraft_sorted := sort(watercraft_recs, seq, did, watercraft_key, -sequence_key);

watercraft_recs_sorted := if(bsversion < 50, watercraft_sorted, watercraft_deduped);
rolled_watercraft := rollup(watercraft_recs_sorted, left.seq=right.seq and left.did=right.did, roll_watercraft(left,right));     

rollWatercraftFinal := group(sort(rolled_watercraft, seq),seq);


//output(rollWatercraftFinal, named('old'));
//output(watercraft_deduped, named('watercraft_deduped'));
//output(watercraft_recs, named('watercraft_recs'));
// output(watercraftDid_recs, named('watercraftDid_recs'));
// output(rollWatercraftFinal_hull, named('rollWatercraftFinal_hull'));	
// output(watercraftHull_recs, named('watercraftHull_recs'));		

return rollWatercraftFinal;

end;
