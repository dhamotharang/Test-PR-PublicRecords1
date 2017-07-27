
import codes, corp2, doxie, Suppress, ut;

latest_for_MAs := Corp2_services.IParams.getServiceParams().LatestForMAs;

export corp2_report_recs := module

	// ***************************************************************************************************************
	//
	// Retrieve base and ancillary records for use together in the *** Corp Report Service ***
	//
	// ***************************************************************************************************************
	
	// *corps_raw* is a module rather than a function because it is responsible for exporting
	// both the corp base fields as well as the following datasets, which will be joined to the
	// base fiedls as child datasets for the report service:
	//	- hist       
	//	- tradenames 
	//	- trademarks 
	//	- events     
		

	EXPORT corps_raw(dataset(corp2_services.layout_corpkey) in_corpkeys,
									 BOOLEAN is_batch_service = FALSE,
									 BOOLEAN currentOnly = FALSE) := 
		MODULE
		
			/* This module will offer two branches: one branch will exist to accommodate the Corp2 Report Service,
			   and the other will support the SoS batch service. For the Corp2 Report Service, we'll simply do an 
				 index read against corp2.Key_Corp_corpkey and process the matching results. 
				 
				 For the SoS batch service, however, we need to do everything we can to prevent an out-of-memory
				 exception, because the volume of corps data can be very large, even for a single business (each 
				 record in Key_Corp_corpkey layout is 5838 bytes). So, we'll do the same index read but project 
				 the results into a very slim corp record. Then we'll sort, group, and do a TOPN(5) to get only 
				 those records we need to actually fill out the batch record (see assorted_layouts.corp2_batch
				 _layout). Finally, we'll perform a second index read against corp2.Key_Corp_corpkey and fetch 
				 the jumbo records, joining against the TOPN-ed slim dataset on corp_key, record_type, dt_last_seen, 
				 etc., etc., and process these records in the same fashion as the ones obtained for the Corp2 
				 Report Service.
			*/

			/* ----------- Constants ----------- */
			
			SHARED STRING CURRENT    := 'C';
			SHARED STRING HISTORICAL := 'H';

			
			/* ----------- Layouts ----------- */
			
			SHARED rec_corp_base := RECORD
				STRING30  corp_key;  
				STRING32  corp_orig_sos_charter_nbr;
				STRING32  corp_sos_charter_nbr;
				STRING2	  corp_state_origin;
				STRING25  corp_state_origin_decoded;
			END;
			
			rec_corp_hist := RECORD
				rec_corp_base;
				Corp2_services.layout_corps_out
			END;	

			rec_corp_key_slim := RECORD
				corp2.Key_Corp_corpkey.corp_key;
				corp2.Key_Corp_corpkey.record_type;
				corp2.Key_Corp_corpkey.corp_legal_name;        // A debug field.
				corp2.Key_Corp_corpkey.corp_state_origin;      // A debug field.
				corp2.Key_Corp_corpkey.corp_process_date;
				corp2.Key_Corp_corpkey.dt_last_seen;
				corp2.Key_Corp_corpkey.corp_ln_name_type_desc;
			END;	
		

			/* ----------- Transforms ----------- */

			// The following function derives cleaned, atomic address data based on vendor-supplied address
			// information (lines 1 thru 6).
			//
			// We must presume three things based on observation of the data: (1) that an address (i.e. 
			// street address, city, state, zip) shall be composed of four fields--any of the lines 1-6. 
			// (2) If an address occupies five lines, the first line is the company name. (3) The address 
			// components have been provided in the same order all the time. That is, we should never see 
			// the zip in line 2 and the street address in line 6. So, our strategy shall be to remove all 
			// address lines having no data, count the remainder, and omit the company name if it exists.
			//
			get_clean_addr2(RECORDOF(corp2.Key_Corp_corpkey) corp_rec) :=
				FUNCTION
				
					STRING182 error_address := '';
					
					rec_addr_line := RECORD
						STRING70 addr_line := '';
					END;
					
					rec_addr_line xfm_extract_addr_lines(RECORDOF(corp2.Key_Corp_corpkey) l, INTEGER C) :=
						TRANSFORM
							SELF.addr_line := CHOOSE(C, l.corp_address2_line1, l.corp_address2_line2, l.corp_address2_line3, l.corp_address2_line4, l.corp_address2_line5, l.corp_address2_line6);
						END;
					
					normalized_addr_lines := NORMALIZE(DATASET(corp_rec), 6, xfm_extract_addr_lines(LEFT,COUNTER));
					nonblank_addr_lines   := normalized_addr_lines( TRIM(addr_line) != '' ); 
					
					cleaned_address :=  CASE(COUNT(nonblank_addr_lines), 
					                         5 => doxie.cleanaddress182( nonblank_addr_lines[2].addr_line, TRIM(nonblank_addr_lines[3].addr_line) + ' ' + TRIM(nonblank_addr_lines[4].addr_line) + ' ' + TRIM(nonblank_addr_lines[5].addr_line) ),
																	 4 => doxie.cleanaddress182( nonblank_addr_lines[1].addr_line, TRIM(nonblank_addr_lines[2].addr_line) + ' ' + TRIM(nonblank_addr_lines[3].addr_line) + ' ' + TRIM(nonblank_addr_lines[4].addr_line) ),
																	 error_address);
					
					RETURN cleaned_address;
					
				END;
				
			rec_corp_hist get_corp_recs_full(recordof(corp2.Key_Corp_corpkey) l) := transform	
			
				clean_addr2 := get_clean_addr2( l );

				self.bdid                               := IF (l.bdid = 0, '', INTFORMAT (l.bdid, 12, 1));
				self.corp_state_origin_decoded          := codes.general.state_long(l.corp_state_origin);
				self.record_date                        := codes.corp2.corp_record_date(l.record_type);
				self.corp_public_or_private_ind_decoded := codes.corp2.corp_public_or_private_ind(l.corp_public_or_private_ind);
				self.corp_addr2_prim_range              := clean_addr2[1..10];
				self.corp_addr2_predir                  := clean_addr2[11..12];
				self.corp_addr2_prim_name               := clean_addr2[13..40];
				self.corp_addr2_addr_suffix             := clean_addr2[41..44];
				self.corp_addr2_postdir                 := clean_addr2[45..46];
				self.corp_addr2_unit_desig              := clean_addr2[47..56];
				self.corp_addr2_sec_range               := clean_addr2[57..64];
				self.corp_addr2_p_city_name             := clean_addr2[65..89];
				self.corp_addr2_v_city_name             := clean_addr2[90..114];
				self.corp_addr2_state                   := clean_addr2[115..116];
				self.corp_addr2_zip5                    := clean_addr2[117..121];
				self.corp_addr2_zip4                    := clean_addr2[122..125];
				self                                    := l;
				self                                    := [];
			end;

			/* ----------- Functions ----------- */
					
			get_corp_recs_for_report_service(DATASET(corp2_services.layout_corpkey) corpkeys) := 
				FUNCTION	
			
					pre_corp_recs := JOIN(corpkeys, corp2.Key_Corp_corpkey, 
																keyed(left.corp_key = right.corp_key), 
																get_corp_recs_full(right),
																keep(10000));
					
					corp_recs := pre_corp_recs(NOT latest_for_MAs OR corp_process_date = MAX(pre_corp_recs,corp_process_date));

					RETURN corp_recs;
					
				END;
				
			get_corp_recs_for_batch_service(DATASET(corp2_services.layout_corpkey) corpkeys) := 
				FUNCTION  // See block comment above for explanation.
					
					pre_corp_recs := 
						JOIN( 
							corpkeys, corp2.Key_Corp_corpkey, 
							KEYED(LEFT.corp_key = RIGHT.corp_key) AND 
							(RIGHT.record_type = CURRENT OR NOT currentOnly), 
							TRANSFORM(rec_corp_key_slim, SELF := RIGHT), // very slim
							LIMIT(10000,SKIP),
							KEEP(1000) 
						);
					
					pre_corp_recs_sorted  := 
						SORT(
							pre_corp_recs, 
							corp_key, 
							-(UNSIGNED1)(record_type = CURRENT),
							-(UNSIGNED1)(corp_ln_name_type_desc = 'LEGAL'),
							-corp_process_date,
							-dt_last_seen
						);

					pre_corp_recs_grouped := GROUP(pre_corp_recs_sorted, corp_key);					
					pre_corp_recs_top5    := TOPN(pre_corp_recs_grouped, 5, corp_key);					
					
					// Now get the full records corp records (very fat).
					corp_recs := JOIN(pre_corp_recs_top5, corp2.Key_Corp_corpkey,
					                  KEYED(LEFT.corp_key = RIGHT.corp_key) AND
														KEYED(LEFT.record_type = RIGHT.record_type) AND
														LEFT.dt_last_seen = RIGHT.dt_last_seen AND
														LEFT.corp_process_date = RIGHT.corp_process_date AND
														LEFT.corp_ln_name_type_desc = RIGHT.corp_ln_name_type_desc,
														get_corp_recs_full(RIGHT),
														LIMIT(10000,SKIP),
														KEEP(100));
					
					RETURN UNGROUP(corp_recs);					
				END;
			
			/* ||||||||||||||||||||||               |||||||||||||||||||||| */
			/* |||||||||||||||||||||| Begin process |||||||||||||||||||||| */
			/* VVVVVVVVVVVVVVVVVVVVVV               VVVVVVVVVVVVVVVVVVVVVV */
			                                    
			// 1. Get corporate records. Include the corporate history.
			
			EXPORT corp_recs := IF( is_batch_service, 
			                        get_corp_recs_for_batch_service( UNGROUP(in_corpkeys)(corp_key != '') ),
			                        get_corp_recs_for_report_service( UNGROUP(in_corpkeys)(corp_key != '') )
			                       );
														 
			// 2. Get historical recs, trademarks, tradenames. Note: Tradenames and Trademarks are really 
			// types of corporate historical records.
			
			shared set of string tradenameset := ['TRADE NAME'];
			shared set of string trademarkset := ['TRADE MARK','TRADEMARK','SERVICE MARK'];
			shared set of string tradeset     := tradenameset + trademarkset;
			
			// 2a. Historical records....
			EXPORT trade_recs          := corp_recs(corp_ln_name_type_desc IN tradeset);
			EXPORT hist_recs_no_trades := corp_recs(corp_ln_name_type_desc NOT IN tradeset);
			
			// 2a(1). Every now and again, we get a corporate record that is composed of ONLY a trade name
			// trademark or service mark. We need to preserve these as base corp history records, else these
			// trademarks, service marks and trade names have no base record to join to later, and they get lost.
			// Use a left-only join to find any 'orphaned' trademark-type records and union them to the regular
			// corp_hist records.

			ds_orphaned_tradeset_recs 
			                 := JOIN(trade_recs, hist_recs_no_trades,
			                         LEFT.corp_key = RIGHT.corp_key,
			                         TRANSFORM(LEFT),
			                         LEFT ONLY);
			
			hist_recs := hist_recs_no_trades + ds_orphaned_tradeset_recs;
			
			shared for_hist  := sort(dedup(hist_recs, record, except corp_process_date, all), 
			                         corp_key,
                               -(unsigned1)(record_type='C'), 
                               -(unsigned1)(corp_ln_name_type_desc = 'LEGAL'),
                               -corp_process_date
                               );

			ds_corp_hist_grouped := GROUP(for_hist, corp_key);
			
			// Now pagenate
			
			// (Pagenate).. add page number, iterating at each maxcount...
			
			rec_corp_hist_with_page_no := RECORD
				string30 corp_key;
				Corp2_services.layout_corps_out;
				INTEGER page_no;
			END;			

			rec_corp_hist_with_page_no xfm_assign_page_no_to_corp_hist(ds_corp_hist_grouped l, INTEGER c) := TRANSFORM
				SELF.page_no   := ((c - 1) DIV Corp2.Constants.MAXCOUNT_CORP_HIST) + 1;
				SELF           := l;
			END;

			ds_corp_hist_with_page_no := PROJECT(ds_corp_hist_grouped, xfm_assign_page_no_to_corp_hist(LEFT,COUNTER));

			// (Pagenate).. regroup by corp_key and page number...

			ds_corp_hist_regrouped := GROUP(UNGROUP(ds_corp_hist_with_page_no), corp_key, page_no); 

			// (Pagenate).. and roll up by corp_key and page number...:

			layout_corp_hist_by_page := record
				string30  corp_key;  
				DATASET(Corp2_services.layout_corps_out) corp_hist {maxcount(Corp2.Constants.MAXCOUNT_CORP_HIST)};
				INTEGER page_no;
			end;
			
			layout_corp_hist_by_page xfm_rollup_corp_hist(rec_corp_hist_with_page_no l, DATASET(rec_corp_hist_with_page_no) allRows) := TRANSFORM
				SELF.corp_key := l.corp_key;
				SELF.corp_hist:= CHOOSEN( PROJECT(allRows, Corp2_services.layout_corps_out), Corp2.Constants.MAXCOUNT_CORP_HIST );
				SELF.page_no  := l.page_no;  
				SELF          := l;
			END;

			shared ds_corp_hist_rolled := ROLLUP(ds_corp_hist_regrouped, GROUP, xfm_rollup_corp_hist(LEFT,ROWS(LEFT)));

				
			// 2b. Trademarks and Tradenames....

			Corp2_services.assorted_layouts.layout_trades get_trades(corp_recs le) := transform
				self := le;
				self :=[];
			END;
			
			trademark_recs := PROJECT(corp_recs(corp_ln_name_type_desc IN trademarkset), get_trades(LEFT));
			tradename_recs := PROJECT(corp_recs(corp_ln_name_type_desc IN tradenameset), get_trades(LEFT));
			
			for_trademarks := dedup(sort(trademark_recs,corp_key,corp_legal_name,-dt_last_seen),
			                               corp_key,corp_legal_name);
			for_tradenames := dedup(sort(tradename_recs,corp_key,corp_legal_name,-dt_last_seen),
			                               corp_key,corp_legal_name);

			shared m_corp_events  := corp2_report_recs_events(in_corpkeys, for_tradenames, for_trademarks, latest_for_MAs);
						
			// 3. Sort and dedup corp base records.
															 
			dedup_res := DEDUP(SORT(PROJECT(for_hist, rec_corp_base), RECORD), ALL);														 

			rec_corp_base rollcorps_base(rec_corp_base le, rec_corp_base ri) := transform
				self.corp_state_origin         := if(le.corp_state_origin <> ''        , le.corp_state_origin        , ri.corp_state_origin);
				self.corp_state_origin_decoded := if(le.corp_state_origin_decoded <> '', le.corp_state_origin_decoded, ri.corp_state_origin_decoded);
				self.corp_sos_charter_nbr      := if(le.corp_sos_charter_nbr <>''      , le.corp_sos_charter_nbr     , ri.corp_sos_charter_nbr);
				self                           := le;
			end;
			
			res_return_base := project(rollup(dedup_res, left.corp_key = right.corp_key,
			                                         rollcorps_base(left,right)),
			                                  transform(rec_corp_base, self := left, self := [])
																			  );
			
			// 5. Exportable attributes.
			export base       := res_return_base;			
			export hist       := ds_corp_hist_rolled;
			export tradenames := m_corp_events.tradenames; 
			export trademarks := m_corp_events.trademarks; 
			export events     := m_corp_events.events; 
					
		end; // module corps_raw	

	
	// ***************************************************************************************************************
	//
	// Retrieve contact records for use in the *** Corp Report Service ***
	//
	// ***************************************************************************************************************
	
	export retrieve_cont_recs(dataset(corp2_services.layout_corpkey) in_corpkeys,
														string in_ssn_mask_type,
														BOOLEAN currentOnly = FALSE) := FUNCTION

		layout_contact_out_child := record
			string30 corp_key;
			corp2_services.layout_names;            // cname, name, fname, lname, mname, suffix
			corp2_services.layout_search_addresses; // atomic address data
			corp2_services.layout_contact_out;      // Our goal. Here's the layout for corp2_services.layout_contact_out: 
																							//   string12 did := '';	
																							//   corp2_services.layout_parties;
																							//   dataset(corp2_services.layout_names)     names {maxcount(10)};
																							//   dataset(corp2_services.layout_titles)    title_descriptions {maxcount(10)};
																							//   dataset(corp2_services.layout_addresses) addresses {maxcount(10)};
		end;	

		layout_contact_out_plus_corpkey := record
			string30 corp_key;
			corp2_services.layout_contact_out;      
		end;	

		// Obtain matching records; mask SSNs.
		key := corp2.Key_Cont_corpkey;

		cont_recs_raw_A := join(in_corpkeys, key, 
														keyed(left.corp_key = right.corp_key) and 
														right.corp_supp_key = '',  // WHY corp_supp_key = '' ???
														transform(recordof(key),self := right),
														limit(10000,skip),
														keep(10000));
		cont_recs_raw_C := join(in_corpkeys, key, 
														keyed(left.corp_key = right.corp_key and
																	right.record_type = 'C') and 
														right.corp_supp_key = '',
														transform(recordof(key),self := right),
														limit(10000,skip),
														keep(10000));
		cont_recs_raw := IF(currentOnly, cont_recs_raw_C, cont_recs_raw_A);

		Suppress.MAC_Mask(cont_recs_raw, cont_recs_raw2, cont_ssn, null, true, false, maskVal := in_ssn_mask_type);

		// Assign key fields to their appropriate bucket: names, titles, addresses, other stuff. 
		layout_contact_out_child make_contacts_full(recordof(key) le) := transform
			self.names              := project(le, transform(layout_names,self:=left));
			self.title_descriptions := project(le, transform(layout_titles,self:=left));
			self.addresses          := project(le, transform(layout_addresses,self:=left));
			self.record_date        := codes.corp2.corp_record_date(le.record_type);
			self.did                := IF (le.did = 0, '', INTFORMAT (le.did, 12, 1));
			self                    := le;
		end;

		cont_recs := project(cont_recs_raw2, make_contacts_full(left));
		
		dedup_res := dedup(cont_recs, record, except record_type, all);
		
		layout_contact_out_child rollup_contacts(layout_contact_out_child le, layout_contact_out_child ri) := transform		
		
			pre_sorted_by_date_all      := sort(le + ri, -dt_last_seen, cont_fname, cont_mname, cont_lname);
			pre_sorted_by_date_pop_addr := pre_sorted_by_date_all(cont_prim_name <> '' or cont_prim_range <> '' or cont_p_city_name <> '');
			sorted_by_date              := if( count(pre_sorted_by_date_pop_addr) = 0,
																				 pre_sorted_by_date_all,
																				 pre_sorted_by_date_pop_addr
																				);
			self.corp_key                  := ri.corp_key;
			self.names                     := choosen(dedup(normalize(sorted_by_date,left.names,transform(layout_names,self:=right)),record,all),if(latest_for_MAs,10,1));
			self.addresses                 := choosen(dedup(normalize(sorted_by_date,left.addresses,transform(layout_addresses,self:=right)),record,all),if(latest_for_MAs,10,1));
			self.title_descriptions        := choosen(dedup(normalize(pre_sorted_by_date_all,left.title_descriptions,transform(layout_titles,self:=right))(cont_title_desc <>'' or cont_type_desc <>''),record,all),10);
			self.cont_filing_reference_nbr := if(count(sorted_by_date(cont_filing_reference_nbr <>''))>0,sorted_by_date(cont_filing_reference_nbr <>'')[1].cont_filing_reference_nbr,'');
			self.cont_filing_date          := if(count(sorted_by_date(cont_filing_date <> ''))>0,sorted_by_date(cont_filing_date <> '')[1].cont_filing_date,'');
			self.cont_filing_desc          := if(count(sorted_by_date(cont_filing_desc <> ''))>0, sorted_by_date(cont_filing_desc <> '')[1].cont_filing_desc,'');
			self.cont_fein                 := if(count(sorted_by_date(cont_fein <>''))>0, sorted_by_date(cont_fein <>'')[1].cont_fein,'');
			self.cont_ssn                  := if(count(sorted_by_date(cont_ssn <>''))>0, sorted_by_date(cont_ssn <>'')[1].cont_ssn,'');
			self.cont_dob                  := if(count(sorted_by_date(cont_dob <>''))>0, sorted_by_date(cont_dob <>'')[1].cont_dob,'');
			self.cont_status_desc          := if(count(sorted_by_date(cont_status_desc <>''))>0, sorted_by_date(cont_status_desc<>'')[1].cont_status_desc,'');
			self.cont_effective_date       := if(count(sorted_by_date(cont_effective_date <>''))>0, sorted_by_date(cont_effective_date <>'')[1].cont_effective_date,'');
			self.cont_effective_desc       := if(count(sorted_by_date(cont_effective_desc <>''))>0, sorted_by_date(cont_effective_desc <>'')[1].cont_effective_desc,''); // new
			self.cont_addl_info            := if(count(sorted_by_date(cont_addl_info <>''))>0, sorted_by_date(cont_addl_info <>'')[1].cont_addl_info,'');
			self                           := sorted_by_date[1];
		end;

		rolled_contacts := if(latest_for_MAs = TRUE,
						/* THEN */
						rollup(sort(dedup_res, /* by */
												corp_key,
												-(unsigned1)(did=''),
												did,
												cont_lname,
												cont_fname,
												cont_mname,
												cont_name), /* on */
									(left.corp_key = right.corp_key) and
									(left.did = right.did and left.did <> '') or 
										((left.did = '' and right.did = '') and 
										 ((left.cont_lname = right.cont_lname and 
											 left.cont_fname = right.cont_fname and 
											 left.cont_mname = right.cont_mname	and 
											 left.cont_name_suffix = right.cont_name_suffix and 
											 left.cont_name = right.cont_name and 
											 (left.cont_lname <> '' or 
													left.cont_fname <> '' or 
													left.cont_mname <> '')) or
											 (left.cont_cname <> '' and 
												ut.CompanySimilar(left.cont_cname,right.cont_cname)<3))
										 ), rollup_contacts(left,right)),
						/* ELSE */
						rollup(sort(dedup_res, /* by */
												corp_key,
												-(unsigned1)(did=''),
												did,
												-dt_last_seen,
												cont_lname,
												cont_fname,
												cont_mname,
												cont_predir,
												cont_prim_name,
												cont_addr_suffix,
												cont_postdir,
												cont_unit_desig,
												cont_sec_range,
												cont_p_city_name,
												cont_v_city_name,
												cont_state,
												cont_zip5,
												cont_zip4),/* on */
										(left.corp_key = right.corp_key) and
										(left.did = right.did and 
										 left.did <> '' and 
										 left.dt_last_seen = right.dt_last_seen and 
										 left.cont_lname = right.cont_lname and
										 left.cont_fname = right.cont_fname and
										 ((left.cont_prim_name = right.cont_prim_name and 
											 left.cont_prim_range = right.cont_prim_range and 
											 left.cont_p_city_name = right.cont_p_city_name and
											 left.cont_zip5 = right.cont_zip5 and 
											 left.cont_sec_range = right.cont_sec_range) or 
												 (left.cont_prim_range = '' and 
													left.cont_prim_name = '' and 
													left.cont_p_city_name = '' and 
													left.cont_zip5 = ''))
										) 
										or 
										(left.dt_last_seen = right.dt_last_seen and 
										 left.cont_fname = right.cont_fname and 
										 left.cont_lname = right.cont_lname and 
										 left.cont_mname = right.cont_mname and 
										 ((left.cont_lname <> '' or left.cont_fname <> '' or left.cont_mname <>'') or
												(left.cont_cname <> '' and ut.CompanySimilar(left.cont_cname,right.cont_cname) = 0)) and
										 ((left.cont_predir = right.cont_predir and
											 left.cont_prim_name = right.cont_prim_name and 
											 left.cont_addr_suffix = right.cont_addr_suffix and 
											 left.cont_postdir = right.cont_postdir and 
											 left.cont_sec_range = right.cont_sec_range and 
											 left.cont_p_city_name = right.cont_p_city_name and 
											 left.cont_v_city_name = right.cont_v_city_name and 
											 left.cont_state = right.cont_state and 
											 left.cont_zip5 = right.cont_zip5 and
											 left.cont_zip4 = right.cont_zip4) or 
												 (left.cont_prim_range = '' and 
													left.cont_prim_name = '' and 
													left.cont_p_city_name = '' and 
													left.cont_zip5 = '')) and 
											(left.did = right.did or left.did = '' or right.did = '')
										 ), rollup_contacts(left,right)));
											
		sorted_contacts := SORT(rolled_contacts, corp_key, -(UNSIGNED1)(record_type = 'C'), -dt_last_seen, corp_legal_name, cont_lname, cont_fname, cont_mname);
		
		grouped_contacts := GROUP(PROJECT(sorted_contacts, layout_contact_out_plus_corpkey), corp_key);
		
		// Now pagenate
		
		// (Pagenate).. add page number, iterating at each maxcount...
		
		layout_contact_out_with_page_no := record
			string30 corp_key;
			corp2_services.layout_contact_out;    
			INTEGER page_no;
		end;			

		layout_contact_out_with_page_no xfm_assign_page_no_to_contact(grouped_contacts l, INTEGER c) := TRANSFORM
			SELF.page_no   := ((c - 1) DIV Corp2.Constants.MAXCOUNT_CONTACTS) + 1;
			SELF           := l;
		END;

		ds_contacts_with_page_no := PROJECT(grouped_contacts, xfm_assign_page_no_to_contact(LEFT,COUNTER));

		// (Pagenate).. regroup by corp_key and page number...

		ds_contacts_regrouped := GROUP(UNGROUP(ds_contacts_with_page_no), corp_key, page_no); 

		// (Pagenate).. and roll up by corp_key and page number...:

		layout_contacts_by_page := record
			string30  corp_key;  
			DATASET(corp2_services.layout_contact_out) contact {maxcount(Corp2.Constants.MAXCOUNT_CONTACTS)};
			INTEGER page_no;
		end;
		
		layout_contacts_by_page xfm_rollup_contacts(layout_contact_out_with_page_no l, DATASET(layout_contact_out_with_page_no) allRows) := TRANSFORM
			SELF.corp_key := l.corp_key;
			SELF.contact   := CHOOSEN( PROJECT(allRows, corp2_services.layout_contact_out), Corp2.Constants.MAXCOUNT_CONTACTS );
			SELF.page_no  := l.page_no;  
			SELF          := l;
		END;

		ds_contacts_rolled := ROLLUP(ds_contacts_regrouped, GROUP, xfm_rollup_contacts(LEFT,ROWS(LEFT)));
		
		return ds_contacts_rolled;

		// return ds_contacts_with_page_no;
	
	end; // function retrieve_cont_recs
	

	// ***************************************************************************************************************
	//
	// Retrieve stock records for use in the *** Corp Report Service ***
	//
	// ***************************************************************************************************************
	
	export retrieve_stock_recs(dataset(corp2_services.layout_corpkey) in_corpkeys,
														 BOOLEAN currentOnly = FALSE) := FUNCTION
														 
		layout_stocks_out_with_corpkey := record
			string30 corp_key;
			corp2_services.layout_stocks_out;
		end;
		
		key := corp2.Key_Stock_Corpkey;

		layout_stocks_out_with_corpkey get_stocks_recs(recordof(key) ri) :=transform
			self.corp_process_date := (unsigned4)ri.corp_process_date;
			self                   := ri;
		end;

		pre_stock_recsA := join(in_corpkeys, key, 
														keyed(left.corp_key = right.corp_key), 
														get_stocks_recs(right),
														keep(10000)); 
		pre_stock_recsC := join(in_corpkeys, key, 
														keyed(left.corp_key = right.corp_key and right.record_type = 'C'),
														get_stocks_recs(right),
														keep(10000)); 
		pre_stock_recs := IF(currentOnly, pre_stock_recsC, pre_stock_recsA);

		stock_recs := pre_stock_recs(~latest_for_MAs or corp_process_date = max(pre_stock_recs,corp_process_date));

		ds_stocks_deduped := dedup(stock_recs, record, all);
		
		ds_stocks_sorted := sort(ds_stocks_deduped, /* on */
		                         stock_ticker_symbol,
														 stock_exchange,
														 stock_type,
														 stock_class);
		
		ds_stocks_grouped := GROUP(ds_stocks_sorted, corp_key);
		
		// Now pagenate
		
		// (Pagenate).. add page number, iterating at each maxcount...
		
		layout_stocks_out_with_page_no := record
			string30 corp_key;
			corp2_services.layout_stocks_out;    
			INTEGER page_no;
		end;			

		layout_stocks_out_with_page_no xfm_assign_page_no_to_stock(ds_stocks_grouped l, INTEGER c) := TRANSFORM
			SELF.page_no   := ((c - 1) DIV Corp2.Constants.MAXCOUNT_STOCKS) + 1;
			SELF           := l;
		END;

		ds_stocks_with_page_no := PROJECT(ds_stocks_grouped, xfm_assign_page_no_to_stock(LEFT,COUNTER));

		// (Pagenate).. regroup by corp_key and page number...

		ds_stocks_regrouped := GROUP(UNGROUP(ds_stocks_with_page_no), corp_key, page_no); 

		// (Pagenate).. and roll up by corp_key and page number...:

		layout_stocks_by_page := record
			string30  corp_key;  
			DATASET(corp2_services.layout_stocks_out) stocks {maxcount(Corp2.Constants.MAXCOUNT_STOCKS)};
			INTEGER page_no;
		end;
		
		layout_stocks_by_page xfm_rollup_stocks(layout_stocks_out_with_page_no l, DATASET(layout_stocks_out_with_page_no) allRows) := TRANSFORM
			SELF.corp_key := l.corp_key;
			SELF.stocks   := CHOOSEN( PROJECT(allRows, corp2_services.layout_stocks_out), Corp2.Constants.MAXCOUNT_STOCKS );
			SELF.page_no  := l.page_no;  
			SELF          := l;
		END;

		ds_stocks_rolled := ROLLUP(ds_stocks_regrouped, GROUP, xfm_rollup_stocks(LEFT,ROWS(LEFT)));

		return ds_stocks_rolled;
									 
	end; // function retrieve_stock_recs


	// ***************************************************************************************************************
	//
	// Retrieve annual report ("ar") records for use in the *** Corp Report Service ***
	//
	// ***************************************************************************************************************

	string CutOffDollarSign (string str_value) := function
    dollar_position := stringlib.StringFind (str_value, '$', 1);
		// brute typecast seems to be safe here
    return if (dollar_position > 0, str_value[dollar_position + 1..], str_value); 
  end;
	export retrieve_ar_recs(dataset(corp2_services.layout_corpkey) in_corpkeys,
													BOOLEAN currentOnly = FALSE) := FUNCTION

		layout_ar_out_with_corpkey := record
			string30 corp_key;
			layout_ar_out;
		end;
		
		key := corp2.Key_AR_Corpkey;

		layout_ar_out_with_corpkey get_ar_recs(recordof(key) ri) :=transform
			self.corp_process_date := (unsigned4) ri.corp_process_date;

			// ESP expects integers, so we need to cut off possible '$'
			self.ar_tax_amount_paid := CutOffDollarSign (ri.ar_tax_amount_paid);
			self.ar_illinois_capital := CutOffDollarSign (ri.ar_illinois_capital);
			self                   := ri;
		end;

		pre_ar_recs_A := join(in_corpkeys, key,
													keyed(left.corp_key = right.corp_key),
													get_ar_recs(right),
													keep(10000));
		pre_ar_recs_C := join(in_corpkeys, key,
													keyed(left.corp_key = right.corp_key and right.record_type = 'C'),
													get_ar_recs(right),
													keep(10000));
		pre_ar_recs := IF(currentOnly, pre_ar_recs_C, pre_ar_recs_A);

		ar_recs := pre_ar_recs(~latest_for_MAs or corp_process_date = max(pre_ar_recs, corp_process_date));
		
		ds_ar_deduped := dedup(ar_recs, record, all);
		
		ds_ar_sorted := SORT(ds_ar_deduped, /* by */ 
		                     corp_key, 
												 -ar_filed_dt,
												 -ar_due_dt, 
												 -corp_process_date, 
												 -dt_last_seen, 
												 record);					
		
		ds_ar_grouped := GROUP(ds_ar_sorted, corp_key);
		
		// Now pagenate
		
		// (Pagenate).. add page number, iterating at each maxcount...
		
		layout_ar_out_with_page_no := record
			string30 corp_key;
			corp2_services.layout_ar_out;    
			INTEGER page_no;
		end;			

		layout_ar_out_with_page_no xfm_assign_page_no_to_ar(ds_ar_grouped l, INTEGER c) := TRANSFORM
			SELF.page_no   := ((c - 1) DIV Corp2.Constants.MAXCOUNT_ANNUAL_REPORTS) + 1;
			SELF           := l;
		END;

		ds_ar_with_page_no := PROJECT(ds_ar_grouped, xfm_assign_page_no_to_ar(LEFT,COUNTER));

		// (Pagenate).. regroup by corp_key and page number...

		ds_ar_regrouped := GROUP(UNGROUP(ds_ar_with_page_no), corp_key, page_no); 

		// (Pagenate).. and roll up by corp_key and page number...:

		layout_ar_by_page := record
			string30  corp_key;  
			DATASET(corp2_services.layout_ar_out) ar {maxcount(Corp2.Constants.MAXCOUNT_ANNUAL_REPORTS)};
			INTEGER page_no;
		end;
		
		layout_ar_by_page xfm_rollup_ar(layout_ar_out_with_page_no l, DATASET(layout_ar_out_with_page_no) allRows) := TRANSFORM
			SELF.corp_key := l.corp_key;
			SELF.ar   := CHOOSEN( PROJECT(allRows, corp2_services.layout_ar_out), Corp2.Constants.MAXCOUNT_ANNUAL_REPORTS );
			SELF.page_no  := l.page_no;  
			SELF          := l;
		END;

		ds_ar_rolled := ROLLUP(ds_ar_regrouped, GROUP, xfm_rollup_ar(LEFT,ROWS(LEFT)));

		return ds_ar_rolled;
		
	end; // function retrieve_ar_recs

end;
		