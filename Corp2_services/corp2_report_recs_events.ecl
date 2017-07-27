import corp2;

// The following module provides exportable attributes for Tradenames, Trademarks, and generic corporate 
// Events. 
//
// When Corp2_services.corp2_search_recs calls this module, it passes in a dataset of corp_keys and preliminary 
// datasets tradename_recs and trademark_recs. The main chore here is to take these 'tradename' and 'trademark' 
// datasets and attach to them the matching Events (obtained by corp_key). Additionally, all other Events obtained 
// by corp_key shall be exported in their own result set.

export corp2_report_recs_events(
			dataset(layout_corpkey) in_corpkeys, 
			dataset(assorted_layouts.layout_trades) tradename_recs = dataset([],assorted_layouts.layout_trades), 
			dataset(assorted_layouts.layout_trades) trademark_recs = dataset([],assorted_layouts.layout_trades),
			boolean latest_for_MAs =FALSE) := 
	MODULE
												 
		shared layout_events_out_parent := record
			string30  corp_key; 
			unsigned6 bdid;
			STRING1   record_type; 
			layout_events_out;
			dataset(layout_events_out) events {maxcount(50)};
		end;
		
		shared key := corp2.Key_event_Corpkey;

		// 1. Get all matching Events records obtained using the corp_keys dataset parameter and dedup them.
		shared layout_events_out_parent get_events_recs(recordof(key) ri) := transform
			self.corp_process_date := (unsigned4) ri.corp_process_date;
			self                   := ri;
			self.events            := []; // Don't populate 'events' dataset just yet.
		end;

		shared event_recs := join(in_corpkeys, key, 
															keyed(left.corp_key = right.corp_key), 
															get_events_recs(right),
															keep(10000)); 
															
		shared new_date   := max(event_recs, corp_process_date);
		
		shared pre_dedup_res := dedup(event_recs(NOT latest_for_MAs  or corp_process_date = new_date),
																	event_filing_reference_nbr,
																	event_amendment_nbr,
																	event_filing_date,
																	event_date_type_cd,
																	event_date_type_desc,
																	event_filing_cd,
																	event_filing_desc,
																	event_corp_nbr,
																	event_corp_nbr_cd,
																	event_corp_nbr_desc,
																	event_roll,
																	event_frame,
																	event_start,
																	event_end,
																	event_microfilm_nbr,
																	event_desc,
																	all);
		
		// 2. Populate 'events' child dataset now.
		shared layout_events_out_parent get_events_recs2(pre_dedup_res le) := transform
			self.events := project(le, transform(layout_events_out, self := left));
			self        := le;
		end;		

		shared pre_dedup_res_with_events_populated := project(pre_dedup_res, get_events_recs2(left));
		
		shared dedup_res := sort(pre_dedup_res_with_events_populated, corp_key,-dt_last_seen,-(unsigned1)(record_type = 'C'));
		
		// 3. Join Tradename and Trademark datasets to their matching Events.
		shared assorted_layouts.layout_trades get_trade_events(assorted_layouts.layout_trades le, dedup_res ri) := transform
			self.events                     := ri.events;
			self                            := le;
		END;
		
		EXPORT for_tradenames := join(tradename_recs, dedup_res,
																	left.corp_key = right.corp_key and 
																	( TRIM(left.corp_supp_key) != '' AND 
																	  left.corp_supp_key = right.corp_supp_key ), 
																	get_trade_events(left,right),
																	keep(400), left outer);
		
		EXPORT for_trademarks := join(trademark_recs, dedup_res,
																	left.corp_key = right.corp_key and 
																	( TRIM(left.corp_supp_key) != '' AND 
																	  left.corp_supp_key = right.corp_supp_key ), 
																	get_trade_events(left,right),
																	keep(400), left outer);
	
		shared all_trades := for_trademarks + for_tradenames;
				
		// Resort and group Tradenames and Trademarks and their concomitant Events. Then pagenate
		// them--one 'page' (i.e. dataset record) for every maxcount value.
		SHARED mac_resort_corp_recs(dataset_name) := MACRO
			sort(dedup(sort(dataset_name, 
											record,
											-(unsigned1)(record_type='C'),
											-corp_process_date,
											-dt_last_seen
											),
								record,
								except record_type,
											 corp_process_date,
											 dt_last_seen
								),
					 corp_key,
					 corp_supp_key,
					 -dt_last_seen,
					 corp_legal_name,
					 -corp_process_date,
					 -(unsigned1)(record_type = 'C'),
					 corp_vendor, 
					 corp_vendor_county,
					 corp_vendor_subcode
					 )
		ENDMACRO;
		
		shared tradenames_sorted  := mac_resort_corp_recs(for_tradenames);
		shared tradenames_grouped := GROUP(tradenames_sorted, corp_key);	
		
		shared trademarks_sorted  := mac_resort_corp_recs(for_trademarks);
		shared trademarks_grouped := GROUP(trademarks_sorted, corp_key);
		
		
		// (Pagenate).. add page number, iterating at each maxcount...
		shared layout_trades_with_page_no :=  RECORD
			assorted_layouts.layout_trades;
			INTEGER page_no;
		END;
		
		shared layout_trades_with_page_no xfm_assign_page_no(assorted_layouts.layout_trades l, INTEGER c) := TRANSFORM
			SELF.page_no   := ((c - 1) DIV Corp2.Constants.MAXCOUNT_TRADENAMES) + 1;
			SELF           := l;
		END;		

		shared tradenames_with_page_no := PROJECT(tradenames_grouped, xfm_assign_page_no(LEFT,COUNTER));
		shared trademarks_with_page_no := PROJECT(trademarks_grouped, xfm_assign_page_no(LEFT,COUNTER));	
		
		
		
		// (Pagenate).. regroup by corp_key and page number...
		shared ds_tradenames_regrouped := GROUP(UNGROUP(tradenames_with_page_no), corp_key, page_no); 
		shared ds_trademarks_regrouped := GROUP(UNGROUP(trademarks_with_page_no), corp_key, page_no); 

		// (Pagenate).. and roll up by corp_key and page number...:
		
		// ...tradenames...
		shared layout_tradenames_by_page := record
			string30  corp_key;  
			DATASET(layout_trades_out) tradenames {maxcount(Corp2.Constants.MAXCOUNT_TRADENAMES)};
			INTEGER page_no;
		end;
		
		shared layout_tradenames_by_page xfm_rollup_tradenames(layout_trades_with_page_no l, DATASET(layout_trades_with_page_no) allRows) := TRANSFORM
			SELF.corp_key   := l.corp_key;
			SELF.tradenames := CHOOSEN( PROJECT(allRows, layout_trades_out), Corp2.Constants.MAXCOUNT_TRADENAMES );
			SELF.page_no    := l.page_no;  
			SELF            := l;
			SELF 						:= [];
		END;
		
		shared ds_tradenames_rolled := ROLLUP(ds_tradenames_regrouped, GROUP, xfm_rollup_tradenames(LEFT,ROWS(LEFT)));
		
		// ...and trademarks...
		shared layout_trademarks_by_page := record
			string30  corp_key;  
			DATASET(layout_trades_out) trademarks {maxcount(Corp2.Constants.MAXCOUNT_TRADEMARKS)};
			INTEGER page_no;
		end;		
		
		shared layout_trademarks_by_page xfm_rollup_trademarks(layout_trades_with_page_no l, DATASET(layout_trades_with_page_no) allRows) := TRANSFORM
			SELF.corp_key   := l.corp_key;
			SELF.trademarks := CHOOSEN( PROJECT(allRows, layout_trades_out), Corp2.Constants.MAXCOUNT_TRADEMARKS );
			SELF.page_no    := l.page_no;  
			SELF            := l;
		END;		

		shared ds_trademarks_rolled := ROLLUP(ds_trademarks_regrouped, GROUP, xfm_rollup_trademarks(LEFT,ROWS(LEFT)));
		
		// Trademarks and Tradenames are finished and ready for export. Now obtain generic Events, excluding 
		// 'all_trades' by using a LEFT ONLY join. Then pagenate them--one 'page' (i.e. dataset record) for 
		// every maxcount value.
		//		
		shared events_before_roll := join(pre_dedup_res, all_trades, 
															        left.corp_key = right.corp_key and 
															        left.corp_supp_key = right.corp_supp_key and 
															        left.corp_supp_key <> '', 
															        transform(recordof(pre_dedup_res),self := left), 
															        left only);
															 
		shared events_before_roll_sorted := SORT(events_before_roll, corp_key, 
		                                                             -event_filing_date,
		                                                             event_filing_reference_nbr,
		                                                             event_amendment_nbr,
		                                                             record,
		                                                             if(event_desc[1..6]='<CONT>',1,0), 
		                                                             except event_desc);
																																		
		shared events_before_roll_grouped := GROUP(events_before_roll_sorted, corp_key);
		
		
		// (Pagenate).. add page number, iterating at each maxcount...
		
		shared rec_event_with_page_no := record
			string30  corp_key; 
			layout_events_out;
			INTEGER page_no;
		end;
		
		shared rec_event_with_page_no xfm_assign_page_no_to_event(events_before_roll_grouped l, INTEGER c) := TRANSFORM
			SELF.page_no   := ((c - 1) DIV Corp2.Constants.MAXCOUNT_EVENTS) + 1;
			SELF           := l;
		END;

		shared ds_events_with_page_no := PROJECT(events_before_roll_grouped, xfm_assign_page_no_to_event(LEFT,COUNTER));

		// (Pagenate).. regroup by corp_key and page number...

		shared ds_events_regrouped := GROUP(UNGROUP(ds_events_with_page_no), corp_key, page_no); 

		// (Pagenate).. and roll up by corp_key and page number...:

		shared layout_events_by_page := record
			string30  corp_key;  
			DATASET(layout_events_out) events {maxcount(Corp2.Constants.MAXCOUNT_EVENTS)};
			INTEGER page_no;
		end;
		
		shared layout_events_by_page xfm_rollup_events(rec_event_with_page_no l, DATASET(rec_event_with_page_no) allRows) := TRANSFORM
			SELF.corp_key := l.corp_key;
			SELF.events   := CHOOSEN( PROJECT(allRows, layout_events_out), Corp2.Constants.MAXCOUNT_EVENTS );
			SELF.page_no  := l.page_no;  
			SELF          := l;
		END;

		shared ds_events_rolled := ROLLUP(ds_events_regrouped, GROUP, xfm_rollup_events(LEFT,ROWS(LEFT)));

		// Trademarks, Tradenames, and corporate Events are now all finished. Export.
		export tradenames := ds_tradenames_rolled;
		export trademarks := ds_trademarks_rolled;
		export events     := ds_events_rolled;
		
		
	end;
