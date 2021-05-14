import GlobalWatchLists, iesp, Patriot, ut, OFAC_XG5, Gateway, std, Risk_Indicators, _Control;
onThor := _Control.Environment.OnThor;

export getWatchLists2(GROUPED DATASET(Risk_Indicators.Layout_Output) inl, boolean ofac_only = false, boolean skip_company_search = false,unsigned1 ofac_version=1,
				boolean include_ofac =FALSE, boolean include_additional_watchlists=FALSE,real global_watchlist_threshold=0.00,integer2 dob_radius = -1, 
				dataset(iesp.share.t_StringArrayItem) watchlists_requested=dataset([], iesp.share.t_StringArrayItem), 
				dataset(Gateway.Layouts.Config) gateways = dataset([], Gateway.Layouts.Config)) := FUNCTION

r_threshold_score := map(global_watchlist_threshold = 0.00 and ofac_version < 4 => OFAC_XG5.Constants.DEF_THRESHOLD_REAL, 
												global_watchlist_threshold = 0.00 and ofac_version  >= 4 => OFAC_XG5.Constants.DEF_THRESHOLD_KeyBank_REAL, 
												global_watchlist_threshold < Patriot.Constants.MIN_THRESHOLD => Patriot.Constants.MIN_THRESHOLD,
												global_watchlist_threshold > Patriot.Constants.MAX_THRESHOLD => Patriot.Constants.MAX_THRESHOLD,
												global_watchlist_threshold);

// put in layout to process
patriot.Layout_batch_in form(inl le, INTEGER i) :=
TRANSFORM
	SELF.seq := le.seq;
	isPerson := i=1;
	isCo := i=2 AND le.employer_name<>'';
	
	SELF.name_first := IF(isPerson,le.fname,'');
	SELF.name_middle := IF(isPerson,le.mname,'');
	SELF.name_last := IF(isPerson,le.lname,'');
	SELF.name_unparsed := IF(isCo,le.employer_name,'');
	SELF.country := IF(isPerson,STD.Str.ToUpperCase(le.in_country),'');
	SELF.search_type := IF(isPerson,'I','B');
  
	yob := if(le.dob='' and le.age<>'', 
             if((unsigned)le.age = 0, 
                    '',
                    (string)((unsigned)((STRING)Std.Date.Today())[1..4] - (unsigned)le.age) + '0000'
             ), 
             ''
        );
        
	SELF.dob := IF(isPerson and le.dob<>'', le.dob, yob);
	SELF.acctNo := '';
END;
inForm_single := PROJECT(inl, form(LEFT,1));
inForm_norm := NORMALIZE(inl, 2, form(LEFT, COUNTER));
inForm := IF(skip_company_search, inForm_single, inForm_norm)(name_last<>'' OR name_unparsed<>'' OR country<>'');


//************************************************** ofac_version = 1,2,3 **************************************************
// process
patOut := Patriot.Search_Base_Function(inForm, ofac_only, r_threshold_score, true, ofac_version,include_ofac,include_additional_watchlists,watchlists_requested);

dob_check_rec :=record
patOut;
unsigned2 age;
END;

dob_check_rec norm(patOut le, patriot.Layout_Base_Results.layout_keys ri) :=
TRANSFORM
	SELF.pty_key := ri.pty_key;
	SELF.pty_keys := ri;	
	Self.keys := [];
	SELF := le;
	self := [];
END;

// only want to check dob for individuals
normed := NORMALIZE(patOut(Search_type='I'),LEFT.pty_keys,norm(LEFT,RIGHT));


dob_check_rec get_dob(dob_check_rec le, inl ri) :=transform
	SELF.dob := ri.dob;
	SELF.age := (unsigned2) ri.age;
	SELF := le;
END;

// Keep(1) and left outer should be unnecessary because inl should have exactly one record per seq number

normed_wdob :=join(normed,inl,left.seq = right.seq,get_dob(left,right),keep(1) ,left outer);

dob_check_rec dobrange(normed_wdob l, globalwatchlists.Key_GlobalWatchLists_Key r):=transform

	return_match := patriot.find_dob_match(l.dob,l.age,r.dob_1,r.dob_2,r.dob_3,r.dob_4,r.dob_5,r.dob_6,r.dob_7,r.dob_8,
																r.dob_9,r.dob_10,dob_radius);
	self.pty_key := if( return_match,  l.pty_key,skip);															
	self := l;
END;
	

dobs_in_range := join(normed_wdob,globalwatchlists.Key_GlobalWatchLists_Key,keyed(left.pty_key=right.pty_key),
											dobrange(left,right),keep(100));
											
											
duped_dobs_in_range :=dedup(sort(dobs_in_range,seq,pty_key),seq,pty_key);											

dob_check_rec roller2(dob_check_rec le,
																					 dob_check_rec  ri) :=
TRANSFORM
	SELF.pty_keys := choosen(le.pty_keys + ri.pty_keys,500);
	SELF := le;
END;

// Put duped_dobs_in_range in same layout as pat_out where one record exists for each seq number (aka input rec)
// and the pty_keys child contains all the pty_keys for that input rec
rolled_dobs_in_range := rollup(sort(duped_dobs_in_range,seq),left.seq=right.seq,roller2(left,right));

pre_pat_out_indobrange :=project(rolled_dobs_in_range,transform(Patriot.Layout_Base_Results .parent,self:=left));
pat_out_indobrange :=group(sort(pre_pat_out_indobrange + patOut(Search_type = 'B'),seq),seq);

// if dob_radius is default take attribute returned from search_base_function 
Pat_Use := if(dob_radius <> -1, pat_out_indobrange,PatOut);

// Sort by best match
Patriot.Layout_Base_Results .parent sorter(Patriot.Layout_Base_Results.parent le) :=
TRANSFORM
	SELF.pty_keys := SORT(le.pty_keys,-score,pty_key);
	SELF := le;
END;

patPref := PROJECT(pat_Use, sorter(LEFT));

Patriot.Layout_Base_Results.parent roller(Patriot.Layout_Base_Results.parent  le, 
																					Patriot.Layout_Base_Results.parent  ri) :=
TRANSFORM
	SELF.pty_keys := le.pty_keys & ri.pty_keys;
	SELF := le;
END;
// prefer people match over employer match
patRolled := ROLLUP(SORT(patPref,-search_type),true,roller(LEFT,RIGHT));

Risk_Indicators.layout_output rejoin(inl le, patOut ri) := transform

	// search type in pty_keys child allows people match preference over employer
	top_matches := choosen(sort(ri.pty_keys,-(unsigned)(pty_key[1..4]='OFAC'),-search_type,-score, pty_key), 7);

	pat_recs_all := join(top_matches, GlobalWatchLists.Key_GlobalWatchLists_Key, 
										left.pty_key<>'' and
										keyed(right.pty_key=left.pty_key),
										transform(recordof(GlobalWatchLists.Key_GlobalWatchLists_Key), 
											name_matches := right.first_name=left.first_name AND ut.NBEQ(right.last_name,left.last_name);
											cmpy_matches := ut.NBEQ(right.cname,left.cname);
											country_matches := STD.Str.ToUpperCase(right.name_type)='COUNTRY' AND ut.NBEQ(right.address_country, left.country);
											something_matched := name_matches or cmpy_matches or country_matches;
											self.first_name := if(something_matched, right.first_name, skip);
											self := right), atmost(5000), keep(1));
											
	watchlists_temp := project(pat_recs_all, 	
											transform(risk_indicators.layouts.layout_watchlists, 
																self.watchlist_table := left.source;
																self.watchlist_program := GlobalWatchLists.program_lookup(left.sanctions_program_1);
																SELF.watchlist_record_number := left.pty_key;
																SELF.watchlist_contry := left.address_country;
																SELF.watchlist_entity_name := left.orig_pty_name;
																SELF.watchlist_fname := left.fname;
																SELF.watchlist_lname := left.lname;
																nocleanaddr := left.prim_range = '' and left.prim_name = '' and left.zip = '';
																SELF.watchlist_address := if(nocleanaddr,
																															trim(left.address_line_1) + ' ' + trim(left.address_line_2) + ' ' + trim(left.address_line_3),
																															Risk_Indicators.MOD_AddressClean.street_address('',left.prim_range, left.predir, left.prim_name,
																																																							left.suffix, left.postdir, left.unit_desig, left.sec_range));
																// parsed watchlist address
																SELF.WatchlistPrimRange := if(nocleanaddr, '', left.prim_range);	
																SELF.WatchlistPreDir := if(nocleanaddr, '', left.predir);
																SELF.WatchlistPrimName := if(nocleanaddr, '', left.prim_name);
																SELF.WatchlistAddrSuffix := if(nocleanaddr, '', left.suffix);
																SELF.WatchlistPostDir := if(nocleanaddr, '', left.postdir);
																SELF.WatchlistUnitDesignation := if(nocleanaddr, '', left.unit_desig);
																SELF.WatchlistSecRange := if(nocleanaddr, '', left.sec_range);
																SELF.watchlist_city := if(nocleanaddr,left.address_city,left.v_city_name);
																SELF.watchlist_state := if(nocleanaddr,left.address_state_province , left.st);
																SELF.watchlist_zip := if(nocleanaddr,left.address_postal_code , left.zip);
																));
	self.watchlists := watchlists_temp;	
	
	// keep these fields here for all of our legacy products still using them
	SELF.watchlist_table := watchlists_temp[1].watchlist_table;
	SELF.watchlist_program := watchlists_temp[1].watchlist_program;
	SELF.watchlist_record_number := watchlists_temp[1].watchlist_record_number;
	SELF.watchlist_contry := watchlists_temp[1].watchlist_contry;
	SELF.watchlist_fname := watchlists_temp[1].watchlist_fname;
	SELF.watchlist_lname := watchlists_temp[1].watchlist_lname;
	SELF.watchlist_address := watchlists_temp[1].watchlist_address;
	SELF.WatchlistPrimRange := watchlists_temp[1].WatchlistPrimRange;	
	SELF.WatchlistPreDir := watchlists_temp[1].WatchlistPreDir;
	SELF.WatchlistPrimName := watchlists_temp[1].WatchlistPrimName;
	SELF.WatchlistAddrSuffix := watchlists_temp[1].WatchlistAddrSuffix;
	SELF.WatchlistPostDir := watchlists_temp[1].WatchlistPostDir;
	SELF.WatchlistUnitDesignation := watchlists_temp[1].WatchlistUnitDesignation;
	SELF.WatchlistSecRange := watchlists_temp[1].WatchlistSecRange;
	SELF.watchlist_city := watchlists_temp[1].watchlist_city;
	SELF.watchlist_state := watchlists_temp[1].watchlist_state;
	SELF.watchlist_zip := watchlists_temp[1].watchlist_zip;
	SELF.watchlist_entity_name := watchlists_temp[1].watchlist_entity_name;
	self := le;
end;

pj3_roxie := join(inl, patRolled, left.seq = right.seq,
                  rejoin(LEFT,RIGHT), lookup, left outer);

pj3_thor := join(DISTRIBUTE(inl, HASH64(seq)), 
                 DISTRIBUTE(patRolled, HASH64(seq)), 
                 left.seq = right.seq,
                 rejoin(LEFT,RIGHT), left outer, LOCAL);
                 
#IF(onThor)
  pj3 := GROUP(SORT(pj3_thor, seq), seq);
#ELSE
  pj3 := pj3_roxie;
#END
      
//*************OFAC VERSION 4 = XG5 BRIDGER SEARCH LOGIC *****************************

OFAC_XG5.Layout.InputLayout XG5prep(inForm le) := TRANSFORM										
	SELF.seq := le.seq;
	self.acctno := le.acctno;
	self.firstName := trim(le.name_first);
	self.middleName := trim(le.name_middle);
	self.lastName := trim(le.name_last);
	SELF.FullName := IF( le.name_first != '' OR le.name_last != '', '', TRIM(le.name_unparsed,LEFT,RIGHT) );
		dobTemp := if(le.dob = '', '', le.dob[5..6] + '/' + le.dob[7..8] + '/' + le.dob[1..4]);
	SELF.DOB := dobTemp;
	SELF.country := le.country;
	SELF.searchType := if(trim(le.name_first + le.name_middle + le.name_last + le.name_unparsed, ALL) = '', 'E', le.search_type);  // E search type means there is no value in the search string do not call gateway
	SELF := [];
	
END;
 
 DDInform := dedup(sort(inForm, seq, name_first, name_middle, name_last, name_unparsed), seq,  name_first, name_middle, name_last, name_unparsed); 
 prep_XG5 := project(ungroup(DDInform), XG5prep(left)); 
 
 boolean validSearch := count(prep_XG5(searchType <> 'E')) > 0 ;
 
 gateways_XG5 := if(validSearch, gateways, dataset([], Gateway.Layouts.Config));

 XG5_ptys := OFAC_XG5.OFACXG5call(prep_XG5(searchType <> 'E'), 
																	ofac_only ,
																	(r_threshold_score * 100) , 
																	include_ofac,
																	include_Additional_watchlists,
																	dob_radius ,
																	watchlists_requested,
																	gateways_XG5);
																	 
 XG5Parsed := OFAC_XG5.OFACXG5_Watchlist2_Response(XG5_ptys);
 
 XG5Formatted	:= OFAC_XG5.FormatXG5_Watchlist2(XG5Parsed);
 
 BlankXG5 := Project(prep_XG5(searchType = 'E'), transform(Risk_Indicators.layout_output,
												self := left;
												self.watchlists := [];	
												// keep these fields here for all of our legacy products still using them
												SELF.watchlist_table := '';
												SELF.watchlist_program := '';
												SELF.watchlist_record_number := '';
												SELF.watchlist_contry := '';
												SELF.watchlist_fname := '';
												SELF.watchlist_lname := '';
												SELF.watchlist_address := '';
												SELF.WatchlistPrimRange := '';
												SELF.WatchlistPreDir := '';
												SELF.WatchlistPrimName := '';
												SELF.WatchlistAddrSuffix := '';
												SELF.WatchlistPostDir := '';
												SELF.WatchlistUnitDesignation := '';
												SELF.WatchlistSecRange := '';
												SELF.watchlist_city := '';
												SELF.watchlist_state := '';
												SELF.watchlist_zip := '';
												SELF.watchlist_entity_name := '';
	
												self := [];));
 
 AddXG5back := join(inl, (XG5Formatted + BlankXG5), left.seq = right.seq,
										transform(Risk_Indicators.layout_output, 	
	// keep these fields here for all of our legacy products still using them
										SELF.watchlist_table := STD.Str.ToUpperCase(right.watchlist_table);
										SELF.watchlist_program :=  STD.Str.ToUpperCase(right.watchlist_program);
										SELF.watchlist_record_number :=  STD.Str.ToUpperCase(right.watchlist_record_number);
										SELF.watchlist_contry :=  STD.Str.ToUpperCase(right.watchlist_contry);
										SELF.watchlist_fname :=  STD.Uni.ToUpperCase(right.watchlist_fname);
										SELF.watchlist_lname :=  STD.Uni.ToUpperCase(right.watchlist_lname);
										SELF.watchlist_address :=  STD.Str.ToUpperCase(right.watchlist_address);
										SELF.WatchlistPrimRange :=  STD.Str.ToUpperCase(right.WatchlistPrimRange);	
										SELF.WatchlistPreDir :=  STD.Str.ToUpperCase(right.WatchlistPreDir);
										SELF.WatchlistPrimName :=  STD.Str.ToUpperCase(right.WatchlistPrimName);
										SELF.WatchlistAddrSuffix :=  STD.Str.ToUpperCase(right.WatchlistAddrSuffix);
										SELF.WatchlistPostDir :=  STD.Str.ToUpperCase(right.WatchlistPostDir);
										SELF.WatchlistUnitDesignation :=  STD.Str.ToUpperCase(right.WatchlistUnitDesignation);
										SELF.WatchlistSecRange :=  STD.Str.ToUpperCase(right.WatchlistSecRange);
										SELF.watchlist_city :=  STD.Str.ToUpperCase(right.watchlist_city);
										SELF.watchlist_state :=  STD.Str.ToUpperCase(right.watchlist_state);
										SELF.watchlist_zip :=  STD.Str.ToUpperCase(right.watchlist_zip);
										SELF.watchlist_entity_name :=  STD.Uni.ToUpperCase(right.watchlist_entity_name);
										self.watchlists := right.watchlists;
	
 
										self := left), left outer);

 // *****************XG5 END
 
WLResults := if(ofac_version = 4, group(AddXG5back,seq), pj3);		

RETURN WLResults;

//************************************************** ofac_version = 4 **********REMOVED GLOBALWATCHLIST V4 CODE SEE HISTORY FOR IT ******************

END;