IMPORT GlobalWatchLists, iesp, ut, OFAC_XG5, Gateway, Doxie, Suppress, Patriot;

export Search_Function(GROUPED DATASET(patriot.Layout_batch_in) in_data, 
														boolean ofaconly_value,
														real threshold_value = 0.00,
														unsigned1 ofac_version =1,
														boolean include_ofac = false,
														boolean include_additional_watchlists =false,
														integer2 dob_radius = -1,
														dataset(iesp.share.t_StringArrayItem) watchlists_requested=dataset([], iesp.share.t_StringArrayItem),
														unsigned1 LexIdSourceOptout = 1,
														string TransactionID = '',
														string BatchUID = '',
														unsigned6 GlobalCompanyId = 0) :=
FUNCTION

mod_access := MODULE(Doxie.IDataAccess)
	EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
	EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
	EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
END;

r_threshold_score := map(threshold_value = 0.00 and ofac_version < 4 => OFAC_XG5.Constants.DEF_THRESHOLD_REAL, 
												threshold_value = 0.00 and ofac_version  >= 4 => OFAC_XG5.Constants.DEF_THRESHOLD_KeyBank_REAL, 
												threshold_value < Patriot.Constants.MIN_THRESHOLD => Patriot.Constants.MIN_THRESHOLD,
												threshold_value > Patriot.Constants.MAX_THRESHOLD => Patriot.Constants.MAX_THRESHOLD,
												threshold_value);

// blank out Bridger Gateway url if not version 4	
skipWatchlist := ((ofac_version = 4 and Include_Ofac=FALSE and Include_Additional_Watchlists=FALSE and count(watchlists_requested)=0));
gateways	:= if(ofac_version <> 4 or skipWatchlist, dataset([],Gateway.Layouts.Config), Gateway.Configuration.Get());
											
//************************************************** ofac_version = 1,2,3 **************************************************
base := patriot.Search_Base_Function(in_data,ofaconly_value,r_threshold_score,false,ofac_version,include_ofac,Include_additional_watchlists,watchlists_requested);


OFAC_XG5.Layout.InputLayout XG5prep(in_data le) := TRANSFORM
	SELF.seq := le.seq;
	self.acctno := le.acctno;
	self.firstName := trim(le.name_first);
	self.middleName := trim(le.name_middle);
	self.lastName := trim(le.name_last);
	SELF.FullName := IF( le.name_first != '' OR le.name_last != '', '', TRIM(le.name_unparsed,LEFT,RIGHT) );
	dobTemp := if(le.dob = '', '', le.dob[5..6] + '/' + le.dob[7..8] + '/' + le.dob[1..4]);
	SELF.DOB := dobTemp;
	SELF.country := le.country;
	SELF.searchType := le.search_type;
	SELF := [];
	
END;
 
 prep_XG5 := project(ungroup(in_data), XG5prep(left)); 

 XG5_ptys := OFAC_XG5.OFACXG5call(prep_XG5, 
																	ofaconly_value ,
																	r_threshold_score * 100 , 
																	include_ofac,
																	include_Additional_watchlists,
																	dob_radius,
																	watchlists_requested,
																	gateways);
																	
 // want is to fail immediately as we don't want customers to think there was no hit on OFAC
	if(exists(XG5_ptys(ErrorMessage <> '')), FAIL('Bridger Gateway Error'));
 
	XG5Parsed := OFAC_XG5.OFACXG5_Response(XG5_ptys);
 
	XG5Formatted	:= OFAC_XG5.FormatXG5_Response(XG5Parsed);
 
//end of XG5 logic

// explode
patriot.Layout_Base_Results.parent norm(base le, patriot.Layout_Base_Results.layout_keys ri) :=
TRANSFORM
	SELF.record_type := MAP(ri.cname<>''=>'N',
												  ri.country<>''=>'C','I');
	SELF.pty_key := ri.pty_key;
	SELF.country := ri.country;
	SELF.pty_keys := ri;
	SELF.keys := [];
	SELF := le;
END;
normed := NORMALIZE(base,LEFT.pty_keys,norm(LEFT,RIGHT));



{normed, UNSIGNED4 global_sid, UNSIGNED6 did} dobrange(normed l, globalwatchlists.Key_GlobalWatchLists_Key r):=transform
	self.global_sid := r.global_sid;
	self.did := r.did;
	return_match := find_dob_match(l.dob,,r.dob_1,r.dob_2,r.dob_3,r.dob_4,r.dob_5,r.dob_6,r.dob_7,r.dob_8,
																r.dob_9,r.dob_10,dob_radius);
	self.pty_key := if(return_match, l.pty_key,'');															
	self := l;
END;
	
pre_dobs_in_range_unsuppressed := join(normed(record_type='I'),globalwatchlists.Key_GlobalWatchLists_Key,keyed(left.pty_key=right.pty_key),
											dobrange(left,right), keep(100), atmost(10000));
											
pre_dobs_in_range := Suppress.Suppress_ReturnOldLayout(pre_dobs_in_range_unsuppressed, mod_access, RECORDOF(normed));
						
dobs_in_range := pre_dobs_in_range(pty_key<>'');

duped_dobs_in_range :=dedup(sort(dobs_in_range,acctno, pty_key),acctno, pty_key);	

// rollup by key
patriot.Layout_Base_Results.parent roll(patriot.Layout_Base_Results.parent le, 
																				patriot.Layout_Base_Results.parent ri) :=
TRANSFORM
	SELF.pty_keys := le.pty_keys+ri.pty_keys;
	SELF := le;
END;
rolled := ROLLUP(SORT(normed, pty_key), LEFT.pty_key=RIGHT.pty_key, roll(LEFT,RIGHT));

dob_rolled := group(sort(join(rolled,duped_dobs_in_range,left.acctno=right.acctno and left.pty_key=right.pty_key,
							transform(recordof(rolled),self:=left) ,atmost(1)),acctno),acctno);

rolled_Use := if(dob_radius=-1, rolled,dob_rolled);

r := RECORD
	patriot.Layout_Patriot;
	real matchscore;
END;

r get_pat(layout_base_results.layout_keys le, GlobalWatchLists.Key_GlobalWatchLists_Key ri) := TRANSFORM
	name_matches := le.first_name=ri.first_name AND ut.NBEQ(le.last_name,ri.last_name);
	co_matches := ut.NBEQ(le.cname,ri.cname);
	country_matches := ut.NBEQ(le.country,ri.address_country);
	SELF.matchscore := IF(name_matches OR co_matches OR country_matches, le.score, 0.000);
	SELF := ri;
	SELF := []; // Commenting out Source related fields(global_sid & record_sid)
END;

patriot.layout_search_out.aka aka_tran(r le) := TRANSFORM
	First5 := TRIM(((STRING)le.matchscore)[1..5]);
	isWhole := LENGTH(First5)=1;
	extraZeros := '000'[1..5-LENGTH(First5)];
	SELF.score := First5 + IF(isWhole,'.000',extraZeros);
	SELF := le;
END;

Patriot.layout_search_out.remark remark_tran(r le, INTEGER i) := TRANSFORM
	remark_prelim := CHOOSE(i,le.remarks_1,le.remarks_2,le.remarks_3,le.remarks_4,le.remarks_5,
														le.remarks_6,le.remarks_7,le.remarks_8,le.remarks_9,le.remarks_10,
														le.remarks_11,le.remarks_12,le.remarks_13,le.remarks_14,le.remarks_15,
														le.remarks_16,le.remarks_17,le.remarks_18,le.remarks_19,le.remarks_20,
														le.remarks_21,le.remarks_22,le.remarks_23,le.remarks_24,le.remarks_25,
														le.remarks_26,le.remarks_27,le.remarks_28,le.remarks_29,le.remarks_30);
	SELF.remark_v := IF(remark_prelim='',SKIP,remark_prelim);
END;

patriot.layout_search_out.parent format(base le) := TRANSFORM
	// highest number of AKAs in the key for any given pty_key is 3,840.  the next highest entity has 600 records
	// changing the keep(n) to be 4000 to cover that max number we're at for OFAC10923   
	// also adding atmost(10000) to remove the compiler warning:  Neither LIMIT() nor CHOOSEN() supplied for index read
	pat_recs_unsuppressed := JOIN(le.pty_keys, GlobalWatchLists.Key_GlobalWatchLists_Key, keyed(LEFT.pty_key=RIGHT.pty_key), 
											get_pat(LEFT,RIGHT), KEEP(4000), atmost(10000));
											
	pat_recs := Suppress.MAC_SuppressSource(pat_recs_unsuppressed, mod_access);
	
	// self.seq := le.seq;
	aka_dedup1 := DEDUP(SORT(PROJECT(pat_recs, aka_tran(LEFT)), orig_pty_name, -(real)score), orig_pty_name);
	SELF.akas := CHOOSEN(SORT(aka_dedup1, -(real)score, orig_pty_name),10);
	SELF.addresses := CHOOSEN(DEDUP(PROJECT(pat_recs, Patriot.layout_search_out.address),all),10);
	SELF.remarks := NORMALIZE(choosen(pat_recs,1), 30, remark_tran(LEFT, COUNTER));
	SELF.pty_key := le.pty_keys[1].pty_key;
	SELF.source := pat_recs[1].source;
	SELF.record_type := le.record_type;

	SELF.score := SELF.akas[1].score;
	SELF.orig_pty_name := IF(SELF.record_type<>'C',SELF.akas[1].orig_pty_name,'');
	SELF.blocked_country := IF(SELF.record_type='C',SELF.akas[1].orig_pty_name,'');
END;

filled_out := PROJECT(rolled_use, format(LEFT));

patriot.layout_search_out.parent check_aka(patriot.layout_search_out.parent le) :=
TRANSFORM
	SELF.akas := IF(COUNT(le.akas)>1,le.akas);
	SELF := le;
END;
aka_checked := PROJECT(filled_out, check_aka(LEFT));

SearchOut :=  If(ofac_version = 4, ungroup(XG5Formatted(trim(pty_key, left, right) <> '')), ungroup(aka_checked));


RETURN SearchOut;

END;