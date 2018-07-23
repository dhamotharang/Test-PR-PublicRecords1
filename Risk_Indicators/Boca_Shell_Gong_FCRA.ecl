import _Control, riskwise, ut, gong, FCRA;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Gong_FCRA(GROUPED DATASET(risk_indicators.layout_bocashell_neutral) ids_wide) := FUNCTION

Layout_Gong := RECORD
	unsigned4 seq;
	risk_indicators.Layouts.Layout_Gong_DID gong_did;
	string10 gongPhone;	// internal
	string50 gongAddr;	// internal
	string20 gongFirst;	// internal
	string20 gongLast;	// internal
	
	string10 invalid_phone_from_did := '';	// internal
	unsigned2 invalid_phones_per_adl := 0; 
	unsigned2 invalid_phones_per_adl_created_6months := 0; 
	string8 invalid_gong_dt_first_seen;	// internal
	string8 invalid_gong_dt_last_seen;		// internal
	unsigned6 did;	// internal
	unsigned3 historydate;	// internal
	qstring120 phones_on_file := '';  // internal
	qstring120 phones_on_file_created12months := '';  // internal
END;


// check corrections
Layout_Gong gong_corr(ids_wide le, FCRA.Key_Override_Gong_FFID ri) := TRANSFORM
	myGetDate := iid_constants.myGetDate(le.historyDate);
	self.gong_did.gong_ADL_dt_first_seen_full := ri.dt_first_seen;
	self.gong_did.gong_ADL_dt_last_seen_full := if(ri.dt_last_seen>myGetDate, myGetDate, ri.dt_last_seen);	//set date last seen to history date if in future
	self.gong_did.gong_did_phone_ct := if(ri.phone10<>'', 1, 0);
	self.gong_did.gong_did_addr_ct := if(trim(ri.prim_range)+trim(ri.prim_name)<>'', 1, 0);
	self.gong_did.gong_did_first_ct := if(ri.name_first<>'', 1, 0);
	self.gong_did.gong_did_last_ct := if(ri.name_last<>'', 1, 0);
	self.gongPhone := ri.phone10;	// for counting phones per did
	self.gongAddr := trim(ri.prim_range)+trim(ri.prim_name);	// for counting addrs per did
	self.gongFirst := trim(ri.name_first);	// for counting first per did
	self.gongLast := trim(ri.name_last);	// for counting last per did
	
	self.did := le.did;
	self.phones_on_file := if(trim(ri.phone10)='', '', ri.phone10 + ',');	
	self.phones_on_file_created12months := if(trim(ri.phone10)<>'' and 
		risk_indicators.iid_constants.checkdays(iid_constants.myGetDate(le.historydate),
														ri.dt_first_seen,
														iid_constants.oneyear, 
														le.historydate), ri.phone10 + ',', '');	

		// set these 3 later	in their own join after we've rolled up unique phones
	self.invalid_phone_from_did := '';
	self.invalid_gong_dt_first_seen := ri.dt_first_seen;
	self.invalid_gong_dt_last_seen := ri.dt_last_seen;	
	
	self := le;
end;
gong_correct_roxie := join(ids_wide, FCRA.Key_Override_Gong_FFID,
												keyed(right.flag_file_id in left.gong_correct_ffid),
												gong_corr(left, right), atmost(right.flag_file_id in left.gong_correct_ffid, 100));

gong_correct_thor := join(ids_wide, pull(FCRA.Key_Override_Gong_FFID),
												right.flag_file_id in left.gong_correct_ffid,
												gong_corr(left, right), LOCAL, ALL);

#IF(onThor)
	gong_correct := gong_correct_thor;
#ELSE
	gong_correct := gong_correct_roxie;
#END

Layout_Gong addPhone(ids_wide le, gong.Key_FCRA_History_did ri) := transform	
	myGetDate := risk_indicators.iid_constants.myGetDate(le.historyDate);
	self.gong_did.gong_ADL_dt_first_seen_full := ri.dt_first_seen;
	self.gong_did.gong_ADL_dt_last_seen_full := if(ri.dt_last_seen>myGetDate, myGetDate, ri.dt_last_seen);	//set date last seen to history date if in future
	self.gong_did.gong_did_phone_ct := if(ri.phone10<>'', 1, 0);
	self.gong_did.gong_did_addr_ct := if(trim(ri.prim_range)+trim(ri.prim_name)<>'', 1, 0);
	self.gong_did.gong_did_first_ct := if(ri.name_first<>'', 1, 0);
	self.gong_did.gong_did_last_ct := if(ri.name_last<>'', 1, 0);
	self.gongPhone := ri.phone10;	// for counting phones per did
	self.gongAddr := trim(ri.prim_range)+trim(ri.prim_name);	// for counting addrs per did
	self.gongFirst := trim(ri.name_first);	// for counting first per did
	self.gongLast := trim(ri.name_last);	// for counting last per did
	

	self.did := le.did;
	self.phones_on_file := if(trim(ri.phone10)='', '', ri.phone10 + ',');		
	self.phones_on_file_created12months := if(trim(ri.phone10)<>'' and 
		risk_indicators.iid_constants.checkdays(iid_constants.myGetDate(le.historydate),
														ri.dt_first_seen,
														iid_constants.oneyear, 
														le.historydate), ri.phone10 + ',', '');			
														
		// set these 3 later	in their own join after we've rolled up unique phones
	self.invalid_phone_from_did := '';
	self.invalid_gong_dt_first_seen := ri.dt_first_seen;
	self.invalid_gong_dt_last_seen := ri.dt_last_seen;
	
	self := le;
END;
gong_by_did_roxie := join(ids_wide, gong.Key_FCRA_History_did, 
													left.did != 0 and keyed(left.did=right.l_did) and		
													// check date
													((unsigned)RIGHT.dt_first_seen <= (unsigned)risk_indicators.iid_constants.myGetDate(left.historyDate)) and
													trim((string12)right.did+(string10)right.phone10+(string8)right.dt_first_seen) not in	left.gong_correct_record_id // old way - prior to 11/13/2012
													and trim((string)right.persistent_record_id) not in left.gong_correct_record_id, // new way - using persistent_record_id
													addPhone(LEFT,RIGHT), left outer, atmost(left.did=right.l_did, Riskwise.max_atmost), keep(100));
									
gong_by_did_thor := join(distribute(ids_wide, hash64(did)), 
												 distribute(pull(gong.Key_FCRA_History_did), hash64(l_did)), 
													left.did != 0 and left.did=right.l_did and		
													// check date
													((unsigned)RIGHT.dt_first_seen <= (unsigned)risk_indicators.iid_constants.myGetDate(left.historyDate)) and
													trim((string12)right.did+(string10)right.phone10+(string8)right.dt_first_seen) not in	left.gong_correct_record_id // old way - prior to 11/13/2012
													and trim((string)right.persistent_record_id) not in left.gong_correct_record_id, // new way - using persistent_record_id
													addPhone(LEFT,RIGHT), left outer, atmost(left.did=right.l_did, Riskwise.max_atmost), keep(100), LOCAL);

#IF(onThor)
	gong_by_did := gong_by_did_thor;
#ELSE
	gong_by_did := ungroup(gong_by_did_roxie);
#END

combined1 := gong_correct + gong_by_did;

// make this check to telcordia it's own join instead of nested inside the previous transform
layout_gong getCombined(combined1 le, risk_indicators.Key_Telcordia_tds ri) := TRANSFORM
	goodphone := ri.npa<>'';
	// if the phone is valid according to telcordia, set the invalid_* fields blank
	self.invalid_phone_from_did := if(goodPhone, '', le.gongphone);  
	self.invalid_gong_dt_first_seen := if(goodPhone, '', le.invalid_gong_dt_first_seen);
	self.invalid_gong_dt_last_seen := if(goodPhone, '', le.invalid_gong_dt_last_seen);
	self := le;
END;

combined_roxie := join(combined1, risk_indicators.Key_Telcordia_tds, 
	left.gongPhone<>'' and 
	keyed(left.gongPhone[1..3]=right.npa) and 
	keyed(left.gongPhone[4..6]=right.nxx), 
	getCombined(LEFT, RIGHT),	
	left outer, keep(1))	;	
	
combined_thor := 	join(distribute(combined1, hash64(gongPhone[1..6])), 
	distribute(pull(risk_indicators.Key_Telcordia_tds), hash64(npa+nxx)), 
	left.gongPhone<>'' and 
	(left.gongPhone[1..3]=right.npa) and 
	(left.gongPhone[4..6]=right.nxx), 
	getCombined(LEFT, RIGHT),	
	left outer, keep(1), LOCAL)	;	
	
#IF(onThor)
	combined := combined_thor;
#ELSE
	combined := combined_roxie;
#END

combo_roxie := group( sort ( combined, seq), seq);									
combo_thor := group( sort ( distribute(combined, hash64(seq)), seq, LOCAL), seq, LOCAL);									

#IF(onThor)
	combo := combo_thor;
#ELSE
	combo := combo_roxie;
#END

// bocashell 3 gong field rollups
Layout_Gong getDates(Layout_Gong le, Layout_Gong ri) := transform
	self.gong_did.gong_ADL_dt_first_seen_full := (string)ut.Min2((unsigned)le.gong_did.gong_ADL_dt_first_seen_full, (unsigned)ri.gong_did.gong_ADL_dt_first_seen_full);
	self.gong_did.gong_ADL_dt_last_seen_full := (string)MAX ((unsigned)le.gong_did.gong_ADL_dt_last_seen_full, (unsigned)ri.gong_did.gong_ADL_dt_last_seen_full);
	self.gong_did.gong_did_phone_ct := le.gong_did.gong_did_phone_ct + if(le.gongPhone=ri.gongPhone, 0, ri.gong_did.gong_did_phone_ct);
	self.phones_on_file := if(le.gongPhone=ri.gongPhone, le.phones_on_file, trim(le.phones_on_file) + ri.phones_on_file + ',');
	self.phones_on_file_created12months := if(le.gongPhone=ri.gongPhone, 
																						le.phones_on_file_created12months, 
																				trim(le.phones_on_file_created12months) + if(trim(ri.phones_on_file)='', '', ri.phones_on_file + ',') );
	
	self := ri;
end;

getgongdates := rollup(sort(combo, seq, -gongPhone, -gong_did.gong_did_phone_ct, record), true, getDates(left,right));

Layout_Gong getAddrs(Layout_Gong le, Layout_Gong ri) := transform
	self.gong_did.gong_did_addr_ct := le.gong_did.gong_did_addr_ct + if(le.gongAddr=ri.gongAddr, 0, ri.gong_did.gong_did_addr_ct);
	self := ri;
end;
getGongAddr := rollup(sort(combo, seq, -gongAddr, -gong_did.gong_did_addr_ct), true, getAddrs(left,right));

Layout_Gong getFirsts(Layout_Gong le, Layout_Gong ri) := transform
	self.gong_did.gong_did_first_ct := le.gong_did.gong_did_first_ct + if(le.gongFirst=ri.gongFirst, 0, ri.gong_did.gong_did_first_ct);
	self := ri;
end;
getGongFirst := rollup(sort(combo, seq,-gongFirst,-gong_did.gong_did_first_ct), true, getFirsts(left,right));

Layout_Gong getLasts(Layout_Gong le, Layout_Gong ri) := transform
	self.gong_did.gong_did_last_ct := le.gong_did.gong_did_last_ct + if(le.gongLast=ri.gongLast, 0, ri.gong_did.gong_did_last_ct);
	self := ri;
end;
getGongLast := rollup(sort(combo, seq,-gongLast,-gong_did.gong_did_last_ct), true, getLasts(left,right));

Layout_Gong joinDateAddr(Layout_Gong le, Layout_Gong ri) := transform
	self.gong_did.gong_ADL_dt_first_seen_full := le.gong_did.gong_ADL_dt_first_seen_full; 
	self.gong_did.gong_ADL_dt_last_seen_full := le.gong_did.gong_ADL_dt_last_seen_full;
	self.gong_did.gong_did_phone_ct := le.gong_did.gong_did_phone_ct;
	self.gong_did.gong_did_addr_ct := ri.gong_did.gong_did_addr_ct;
	self := le;
END;
datephoneaddr_roxie := join(getgongdates, getgongaddr, left.seq=right.seq, joinDateAddr(LEFT,RIGHT), left outer, lookup);
datephoneaddr_thor := group(join(getgongdates, getgongaddr, left.seq=right.seq, joinDateAddr(LEFT,RIGHT), left outer), seq);

#IF(onThor)
	datephoneaddr := datephoneaddr_thor;
#ELSE
	datephoneaddr := datephoneaddr_roxie;
#END

Layout_Gong joinDateAddrFirst(Layout_Gong le, Layout_Gong ri) := transform
	self.gong_did.gong_did_first_ct := ri.gong_did.gong_did_first_ct;
	self := le;
END;
datephoneaddrfirst_roxie := join(datephoneaddr, getGongFirst, left.seq=right.seq, joinDateAddrFirst(LEFT,RIGHT), left outer, lookup);
datephoneaddrfirst_thor := group(join(datephoneaddr, getGongFirst, left.seq=right.seq, joinDateAddrFirst(LEFT,RIGHT), left outer), seq);

#IF(onThor)
	datephoneaddrfirst := datephoneaddrfirst_thor;
#ELSE
	datephoneaddrfirst := datephoneaddrfirst_roxie;
#END

Layout_Gong joinDateAddrFirstLast(Layout_Gong le, Layout_Gong ri) := transform
	self.gong_did.gong_did_last_ct := ri.gong_did.gong_did_last_ct;
	self := le;
END;
datephoneaddrfirstlast_roxie := join(datephoneaddrfirst, getGongLast, left.seq=right.seq, joinDateAddrFirstLast(LEFT,RIGHT), left outer, lookup);
datephoneaddrfirstlast_thor := group(join(datephoneaddrfirst, getGongLast, left.seq=right.seq, joinDateAddrFirstLast(LEFT,RIGHT), left outer), seq);

#IF(onThor)
	datephoneaddrfirstlast := datephoneaddrfirstlast_thor;
#ELSE
	datephoneaddrfirstlast := datephoneaddrfirstlast_roxie;
#END

// now calculate the invalid counts
phone_slim := RECORD
	combo.seq;
	combo.did;
	phone := combo.invalid_phone_from_did;
	combo.historydate;
	dt_first_seen := MIN(GROUP,IF((unsigned)combo.invalid_gong_dt_first_seen=0,999999,(unsigned)combo.invalid_gong_dt_first_seen));
	dt_last_seen := MAX(GROUP,(unsigned)combo.invalid_gong_dt_last_seen);
END;
d_phone := TABLE(combo((integer)invalid_phone_from_did<>0), phone_slim, seq, did, invalid_phone_from_did, historydate);


invalid_phone_stats := record
	did := d_phone.did;
	seq := d_phone.seq;
	invalid_phone_ct := count(group);
	invalid_phone_ct_c6 := count(group, ut.DaysApart(risk_indicators.iid_constants.myGetDate(d_phone.historyDate), ((string)d_phone.dt_first_seen)[1..6]+'31') < 183);
end;
invalid_phone_counts := table(d_phone, invalid_phone_stats, seq, did);


Layout_Gong addInvalidGong (datephoneaddrfirstlast le, invalid_phone_counts ri) := TRANSFORM
	self.invalid_phones_per_adl := ri.invalid_phone_ct;
	self.invalid_phones_per_adl_created_6months := ri.invalid_phone_ct_c6;
	
	SELF := le;
END;
invalidGong_roxie := JOIN (datephoneaddrfirstlast, invalid_phone_counts,
                       LEFT.seq = RIGHT.seq,
											 addInvalidGong(LEFT,RIGHT),
											 LEFT OUTER, lookup);
invalidGong_thor := group(JOIN (datephoneaddrfirstlast, invalid_phone_counts,
                       LEFT.seq = RIGHT.seq,
											 addInvalidGong(LEFT,RIGHT),
											 LEFT OUTER), seq);

#IF(onThor)
	invalidGong := invalidGong_thor;
#ELSE
	invalidGong := invalidGong_roxie;
#END

return invalidGong;
END;