import GlobalWatchLists, iesp, Patriot, ut, OFAC_XG5, Gateway, std, Risk_Indicators;

EXPORT OFACWatchlistsFunctions := MODULE

EXPORT PersonBridgerXG5MAS(
                STRING InputFirstName,
                STRING InputMiddleName,
                STRING InputLastName,
                STRING InputDateOfBirth,
				boolean include_ofac =FALSE, 
                boolean include_additional_watchlists=FALSE,
                real global_watchlist_threshold=0.00,
				dataset(iesp.share.t_StringArrayItem) watchlists_requested=dataset([], iesp.share.t_StringArrayItem), 
				dataset(Gateway.Layouts.Config) gateways = dataset([], Gateway.Layouts.Config)) := FUNCTION

inl := DATASET([TRANSFORM(Risk_Indicators.Layout_Output,
SELF.fname := InputFirstName;
SELF.mname := InputMiddleName;
SELF.lname := InputLastName;
SELF.dob := InputDateOfBirth;
SELF := [];)]);

r_threshold_score := map(global_watchlist_threshold = 0.00 => OFAC_XG5.Constants.DEF_THRESHOLD_KeyBank_REAL, 
											 global_watchlist_threshold < Patriot.Constants.MIN_THRESHOLD => Patriot.Constants.MIN_THRESHOLD,
											 global_watchlist_threshold > Patriot.Constants.MAX_THRESHOLD => Patriot.Constants.MAX_THRESHOLD,
											 global_watchlist_threshold);
                        
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
inForm := inForm_norm(name_last<>'');

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
																	FALSE,
																	(r_threshold_score * 100), 
																	include_ofac,
																	include_Additional_watchlists,
																	-1,
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

RETURN GROUP(AddXG5back,seq);

END;

EXPORT OFACWatchlistsWrapper(STRING GatewayURL,
                STRING InputFirstName,
                STRING InputMiddleName,
                STRING InputLastName,
                STRING InputDateOfBirth,
				boolean include_ofac =FALSE, 
                boolean include_additional_watchlists=FALSE,
                real global_watchlist_threshold=0.00,
				STRING WatchlistsRequested = '') := FUNCTION
		 BridgerXG5Gateway := DATASET([TRANSFORM(Gateway.Layouts.Config, 
																 SELF.ServiceName := 'bridgerwlc'; // actual gateway is called "Search" but it's referenced in constants as "bridgerwlc"
																 SELF.URL := GatewayURL; 
																 SELF := [];)]);
         Watchlists_Requested := DATASET([TRANSFORM(iesp.share.t_StringArrayItem, 
																 SELF.value := WatchlistsRequested;)]);
		 GatewayResults := PersonBridgerXG5MAS(InputFirstName, InputMiddleName, InputLastName, InputDateOfBirth, include_ofac, include_additional_watchlists,
                                           global_watchlist_threshold, watchlists_requested, BridgerXG5Gateway);
         WatchlistHit := IF(GatewayResults[1].watchlist_record_number <> '', '1', '0');
		 ResultSet := ['BRIDGERXG5 GATEWAY',(STRING)GatewayResults[1].watchlist_record_number,WatchlistHit];
RETURN ResultSet;
END;

EXPORT GrabOFACURL(DummyVariable = '') := FUNCTIONMACRO
  Result := '' : STORED('OFACURL');
  RETURN Result;
ENDMACRO;

END;