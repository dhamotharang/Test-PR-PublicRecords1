import riskwise, ut, dx_Gong, risk_indicators, doxie, Suppress, _Control;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Gong(GROUPED DATASET(risk_indicators.layout_bocashell_neutral) ids_wide, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

Layout_Gong := RECORD
	unsigned4 seq;
	Risk_Indicators.Layouts.Layout_Gong_DID gong_did;
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

Layout_Gong_CCPA := RECORD
    unsigned4 global_sid; // CCPA changes
		boolean skip_opt_out := false;
    Layout_Gong;
END;

key_history_did := dx_Gong.key_history_did();
Layout_Gong_CCPA addPhone(ids_wide le, key_history_did ri) := transform
	myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
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

	// invalid stuff
	self.did := le.did;
	self.global_sid := ri.global_sid;
	self.phones_on_file := if(trim(ri.phone10)='', '', ri.phone10 + ',');
	self.phones_on_file_created12months := if(trim(ri.phone10)<>'' and
		risk_indicators.iid_constants.checkdays(risk_indicators.iid_constants.myGetDate(le.historydate),
														ri.dt_first_seen,
														risk_indicators.iid_constants.oneyear,
														le.historydate), ri.phone10 + ',', '');

	// set these 3 later	in their own join after we've rolled up unique phones
	self.invalid_phone_from_did := '';
	self.invalid_gong_dt_first_seen := ri.dt_first_seen;
	self.invalid_gong_dt_last_seen := ri.dt_last_seen;

	self := le;
END;

gong_by_did_unsuppressed_roxie := join(ids_wide, key_history_did, keyed(left.did=right.l_did) and
                                       // check date
                                       ((unsigned)RIGHT.dt_first_seen <= (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate)),
                                       addPhone(LEFT,RIGHT), left outer, atmost(left.did=right.l_did, Riskwise.max_atmost), keep(100));
                    
gong_by_did_unsuppressed_thor := join(DISTRIBUTE(ids_wide, HASH64(did)), 
                                      DISTRIBUTE(PULL(key_history_did), HASH64(l_did)),
                                      left.did != 0 and
                                      left.did=right.l_did and
                                      // check date
                                      ((unsigned)RIGHT.dt_first_seen <= (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate)),
                                      addPhone(LEFT,RIGHT), left outer, atmost(left.did=right.l_did, Riskwise.max_atmost), keep(100), LOCAL);
                    
#IF(onThor)
	gong_by_did_unsuppressed_correct := gong_by_did_unsuppressed_thor;
#ELSE
	gong_by_did_unsuppressed_correct := gong_by_did_unsuppressed_roxie;
#END

// OUTPUT(gong_by_did_unsuppressed_correct, NAMED('gong_by_did_unsuppressed_correct'));

gong_by_did_flagged := Suppress.CheckSuppression(gong_by_did_unsuppressed_correct, mod_access);

gong_by_did1 := PROJECT(gong_by_did_flagged, TRANSFORM(Layout_Gong,
	self.gong_did.gong_ADL_dt_first_seen_full := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.gong_did.gong_ADL_dt_first_seen_full );
	self.gong_did.gong_ADL_dt_last_seen_full := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.gong_did.gong_ADL_dt_last_seen_full );
	self.gong_did.gong_did_phone_ct := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.gong_did.gong_did_phone_ct );
	self.gong_did.gong_did_addr_ct := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.gong_did.gong_did_addr_ct );
	self.gong_did.gong_did_first_ct := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.gong_did.gong_did_first_ct );
	self.gong_did.gong_did_last_ct := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.gong_did.gong_did_last_ct );
	self.gongPhone := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.gongPhone);
	self.gongAddr := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.gongAddr);
	self.gongFirst := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.gongFirst);
	self.gongLast := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.gongLast);
	self.phones_on_file := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.phones_on_file);
	self.phones_on_file_created12months := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.phones_on_file_created12months);
	self.invalid_gong_dt_first_seen := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.invalid_gong_dt_first_seen);
	self.invalid_gong_dt_last_seen := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.invalid_gong_dt_last_seen);
    SELF := LEFT;
));

/*
// make this check to telcordia it's own join instead of nested inside the previous transform
gong_by_did := join(gong_by_did1, risk_indicators.Key_Telcordia_tpm_Slim,
	left.gongPhone<>'' and
	keyed(left.gongPhone[1..3]=right.npa) and
	keyed(left.gongPhone[4..6]=right.nxx) and
	KEYED(right.tb IN [left.gongPhone[7]]),
transform(layout_gong,
	goodphone := right.npa<>'';
	// if the phone is valid according to telcordia, set the invalid_* fields blank
	self.invalid_phone_from_did := if(goodPhone, '', left.gongphone);
	self.invalid_gong_dt_first_seen := if(goodPhone, '', left.invalid_gong_dt_first_seen);
	self.invalid_gong_dt_last_seen := if(goodPhone, '', left.invalid_gong_dt_last_seen);
	self := left;
	),
	left outer, keep(1))	;
*/

layout_gong gong_by_id_transform(gong_by_did1 le, risk_indicators.Key_Telcordia_tpm_Slim ri) := TRANSFORM
  goodphone := ri.npa<>'';
	// if the phone is valid according to telcordia, set the invalid_* fields blank
	self.invalid_phone_from_did := if(goodPhone, '', le.gongphone);
	self.invalid_gong_dt_first_seen := if(goodPhone, '', le.invalid_gong_dt_first_seen);
	self.invalid_gong_dt_last_seen := if(goodPhone, '', le.invalid_gong_dt_last_seen);
	self := le;
END;

gong_by_did_roxie := join(gong_by_did1, risk_indicators.Key_Telcordia_tpm_Slim,
                          left.gongPhone<>'' and
                          keyed(left.gongPhone[1..3]=right.npa) and
                          keyed(left.gongPhone[4..6]=right.nxx) and
                          KEYED(right.tb IN [left.gongPhone[7]]),
                          gong_by_id_transform(LEFT, RIGHT),
                          left outer, keep(1));
                          
gong_by_did_thor := join(DISTRIBUTE(gong_by_did1, HASH64(gongPhone)),
                         DISTRIBUTE(PULL(risk_indicators.Key_Telcordia_tpm_Slim), HASH64(npa + nxx + tb)),
                         left.gongPhone<>'' and
                         left.gongPhone[1..3]=right.npa and
                         left.gongPhone[4..6]=right.nxx and
                         right.tb IN [left.gongPhone[7]],
                         gong_by_id_transform(LEFT, RIGHT),
                         left outer, keep(1), LOCAL);
                          
#IF(onThor)
	gong_by_did_correct := GROUP(SORT(DISTRIBUTE(gong_by_did_thor, HASH64(seq)), seq, LOCAL), seq, LOCAL);
#ELSE
	gong_by_did_correct := gong_by_did_roxie;
#END

// bocashell 3 gong field rollups
Layout_Gong getDates(Layout_Gong le, Layout_Gong ri) := transform
	self.gong_did.gong_ADL_dt_first_seen_full := (string)ut.Min2((unsigned)le.gong_did.gong_ADL_dt_first_seen_full, (unsigned)ri.gong_did.gong_ADL_dt_first_seen_full);
	self.gong_did.gong_ADL_dt_last_seen_full := (string)max ((unsigned)le.gong_did.gong_ADL_dt_last_seen_full, (unsigned)ri.gong_did.gong_ADL_dt_last_seen_full);
	self.gong_did.gong_did_phone_ct := le.gong_did.gong_did_phone_ct + if(le.gongPhone=ri.gongPhone, 0, ri.gong_did.gong_did_phone_ct);
	self.phones_on_file := if(le.gongPhone=ri.gongPhone, le.phones_on_file, trim(le.phones_on_file) + ri.phones_on_file + ',');
	self.phones_on_file_created12months := if(le.gongPhone=ri.gongPhone,
																						le.phones_on_file_created12months,
																				trim(le.phones_on_file_created12months) + if(trim(ri.phones_on_file)='', '', ri.phones_on_file + ',') );
	self := ri;
end;
getgongdates := rollup(sort(gong_by_did_correct, seq, -gongPhone, -gong_did.gong_did_phone_ct), true, getDates(left,right));

Layout_Gong getAddrs(Layout_Gong le, Layout_Gong ri) := transform
	self.gong_did.gong_did_addr_ct := le.gong_did.gong_did_addr_ct + if(le.gongAddr=ri.gongAddr, 0, ri.gong_did.gong_did_addr_ct);
	self := ri;
end;
getGongAddr := rollup(sort(gong_by_did_correct, seq, -gongAddr, -gong_did.gong_did_addr_ct), true, getAddrs(left,right));

Layout_Gong getFirsts(Layout_Gong le, Layout_Gong ri) := transform
	self.gong_did.gong_did_first_ct := le.gong_did.gong_did_first_ct + if(le.gongFirst=ri.gongFirst, 0, ri.gong_did.gong_did_first_ct);
	self := ri;
end;
getGongFirst := rollup(sort(gong_by_did_correct, seq,-gongFirst,-gong_did.gong_did_first_ct), true, getFirsts(left,right));

Layout_Gong getLasts(Layout_Gong le, Layout_Gong ri) := transform
	self.gong_did.gong_did_last_ct := le.gong_did.gong_did_last_ct + if(le.gongLast=ri.gongLast, 0, ri.gong_did.gong_did_last_ct);
	self := ri;
end;
getGongLast := rollup(sort(gong_by_did_correct, seq,-gongLast,-gong_did.gong_did_last_ct), true, getLasts(left,right));

Layout_Gong joinDateAddr(Layout_Gong le, Layout_Gong ri) := transform
	self.gong_did.gong_ADL_dt_first_seen_full := le.gong_did.gong_ADL_dt_first_seen_full;
	self.gong_did.gong_ADL_dt_last_seen_full := le.gong_did.gong_ADL_dt_last_seen_full;
	self.gong_did.gong_did_phone_ct := le.gong_did.gong_did_phone_ct;
	self.gong_did.gong_did_addr_ct := ri.gong_did.gong_did_addr_ct;
	self := le;
END;
datephoneaddr_roxie := join(getgongdates, getgongaddr, left.seq=right.seq, joinDateAddr(LEFT,RIGHT), left outer, lookup);
datephoneaddr_thor := GROUP(join(getgongdates, getgongaddr, left.seq=right.seq, joinDateAddr(LEFT,RIGHT), left outer), seq);

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
datephoneaddrfirst_thor := GROUP(join(datephoneaddr, getGongFirst, left.seq=right.seq, joinDateAddrFirst(LEFT,RIGHT), left outer), seq);

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
datephoneaddrfirstlast_thor := GROUP(join(datephoneaddrfirst, getGongLast, left.seq=right.seq, joinDateAddrFirstLast(LEFT,RIGHT), left outer), seq);

#IF(onThor)
	datephoneaddrfirstlast := datephoneaddrfirstlast_thor;
#ELSE
	datephoneaddrfirstlast := datephoneaddrfirstlast_roxie;
#END

// now calculate the invalid counts
phone_slim := RECORD
	gong_by_did_correct.did;
	gong_by_did_correct.seq;
	phone := gong_by_did_correct.invalid_phone_from_did;
	gong_by_did_correct.historydate;
	dt_first_seen := MIN(GROUP,IF((unsigned)gong_by_did_correct.invalid_gong_dt_first_seen=0,999999,(unsigned)gong_by_did_correct.invalid_gong_dt_first_seen));
	dt_last_seen := MAX(GROUP,(unsigned)gong_by_did_correct.invalid_gong_dt_last_seen);
END;
d_phone := TABLE(gong_by_did_correct((integer)invalid_phone_from_did<>0), phone_slim, seq, did, invalid_phone_from_did, historydate);


invalid_phone_stats := record
	did := d_phone.did;
	seq := d_phone.seq;
	invalid_phone_ct := count(group);
	invalid_phone_ct_c6 := count(group, ut.DaysApart(risk_indicators.iid_constants.myGetDate(d_phone.historydate), ((STRING)d_phone.dt_first_seen)[1..6]+'31') < 183);
end;
invalid_phone_counts := table(d_phone, invalid_phone_stats, seq, did);


Layout_Gong addInvalidGong (datephoneaddrfirstlast le, invalid_phone_counts ri) := TRANSFORM
	self.invalid_phones_per_adl := ri.invalid_phone_ct;
	self.invalid_phones_per_adl_created_6months := ri.invalid_phone_ct_c6;

	SELF := le;
END;
invalidGong_roxie := JOIN(datephoneaddrfirstlast, invalid_phone_counts,
                           LEFT.seq = RIGHT.seq,
                           addInvalidGong(LEFT,RIGHT),
                           LEFT OUTER, lookup);
                           
invalidGong_thor := GROUP(JOIN(datephoneaddrfirstlast, invalid_phone_counts,
                           LEFT.seq = RIGHT.seq,
                           addInvalidGong(LEFT,RIGHT),
                           LEFT OUTER), seq);
                           
#IF(onThor)
	invalidGong := invalidGong_thor;
#ELSE
	invalidGong := invalidGong_roxie;
#END

// output(gong_by_did, named('gong_by_did_new'));

// OUTPUT(gong_by_did_flagged, NAMED('gong_by_did_flagged'));
// OUTPUT(gong_by_did_correct, NAMED('gong_by_did_correct'));

// OUTPUT(getgongdates, NAMED('getgongdates'));
// OUTPUT(getGongAddr, NAMED('getGongAddr'));
// OUTPUT(getGongFirst, NAMED('getGongFirst'));
// OUTPUT(getGongLast, NAMED('getGongLast'));
// OUTPUT(datephoneaddr, NAMED('datephoneaddr'));
// OUTPUT(datephoneaddrfirst, NAMED('datephoneaddrfirst'));
// OUTPUT(datephoneaddrfirstlast, NAMED('datephoneaddrfirstlast'));
// OUTPUT(d_phone, NAMED('d_phone'));
// OUTPUT(invalid_phone_counts, NAMED('invalid_phone_counts'));

// OUTPUT(sort(gong_by_did_correct, seq, -gongPhone, -gong_did.gong_did_phone_ct), NAMED('getgongdatesSort'));


return invalidGong;
END;