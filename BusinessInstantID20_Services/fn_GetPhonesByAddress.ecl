IMPORT BIPV2, Business_Risk, Business_Risk_BIP, Risk_Indicators, ut;

EXPORT fn_GetPhonesByAddress( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean) ds_input,
                             DATASET(BIPV2.IDlayouts.l_xlink_ids2) ds_BIPIDs,
                             BusinessInstantID20_Services.iOptions Options,
														 BIPV2.mod_sources.iParams linkingOptions) := 
		FUNCTION
			
			// Note: Contrary to the name of this function, we're actually getting Phones by Business
			// address and close-enough company name.
			
			// NOTE: In Scoring we identify each record using "seq". In the world of BIP it's "uniqueid".
			
			// 1.a. Because BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs( ) sequences the input
			// records using an integer counter, we need to resequence the filtered records 
			// from ds_input so that we can match up the results from that function correctly.
			layout_input_temp := RECORD
				UNSIGNED4 orig_seq;
				BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean;
			END;
			
			ds_input_filt := ds_input(prim_name != '');
			ds_input_srtd := SORT( ds_input_filt, seq );
			
			ds_input_filt_reseq :=
				PROJECT(
					ds_input_srtd,
					TRANSFORM( layout_input_temp,
						SELF.orig_seq := LEFT.seq,
						SELF.seq      := COUNTER, // re-sequence
						SELF := LEFT
					)
				);
			
			// 1.b. Filter, sort, and resequence ds_BIPIDs likewise. We'll use this dataset to  
			// filter results, below.
			ds_BIPIDs_filt :=
				JOIN(
					ds_BIPIDs, ds_input_filt,
					LEFT.uniqueid = RIGHT.seq,
					TRANSFORM(LEFT),
					INNER
				);
			
			ds_BIPIDs_srtd := SORT(ds_BIPIDs_filt, uniqueid);

			ds_BIPIDs_filt_reseq := 
				PROJECT(
					ds_BIPIDs_srtd,
					TRANSFORM( { UNSIGNED4 orig_uniqueid, BIPV2.IDlayouts.l_xlink_ids2 },
						SELF.orig_uniqueid := LEFT.uniqueid,
						SELF.uniqueid      := COUNTER, // re-sequence
						SELF := LEFT
					)
				);
			
			// 2. Call fn_IndexedSearchForXLinkIDs( ) to get matching BIPIDs for each input address.
			BIPV2.IDFunctions.rec_SearchInput xfm_ToSearchInput(layout_input_temp le) := 
				TRANSFORM
					SELF.acctno := (STRING)le.seq;
					SELF.prim_range := le.prim_range;
					SELF.prim_name  := le.prim_name;
					SELF.zip5       := le.zip;
					SELF.sec_range  := le.sec_range;
					SELF.city       := le.city;
					SELF.state      := le.state;
					SELF := [];
				END;

			ds_InputSearch := PROJECT( ds_input_filt_reseq, xfm_ToSearchInput(LEFT) );

			ds_results_w_acct := 
				BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_InputSearch).uid_results_w_acct;

			// 3.a. Filter out of results_w_acct the records from ds_BIPIDs having the sameBIPIDs.
			ds_results_w_acct_other_businesses_pre :=
				JOIN(
					ds_results_w_acct, ds_BIPIDs_filt_reseq,
					LEFT.uniqueid = RIGHT.uniqueid AND
					LEFT.UltID = RIGHT.UltID AND
					LEFT.OrgID = RIGHT.OrgID AND
					LEFT.SeleID = RIGHT.SeleID,
					TRANSFORM(LEFT),
					LEFT ONLY
				);

			// 3.b.  Reassign orig_uniqueid as uniqueid.
			ds_results_w_acct_other_businesses :=
				JOIN(
					ds_results_w_acct_other_businesses_pre, ds_BIPIDs_filt_reseq,
					LEFT.uniqueid = RIGHT.uniqueid,
					TRANSFORM( RECORDOF(ds_results_w_acct),
						SELF.uniqueid := RIGHT.orig_uniqueid,
						SELF := LEFT
					),
					INNER
				);
			
			// 4.a. Assign COUNTER as uniqueid to each record returned from fn_IndexedSearchForXLinkIDs( ) 
			// for the next call to get Best info for that Business. Preserve the original seq #.
			ds_BIPIDs_w_seq_other_businesses := 
				PROJECT(
					ds_results_w_acct_other_businesses,
					TRANSFORM( { UNSIGNED4 seq, BIPV2.IDlayouts.l_xlink_ids2 },
						SELF.seq := LEFT.uniqueid, // preserve the original seq #
						SELF.uniqueid := COUNTER,
						SELF := LEFT
					)	
				);
			
			// 4.b. Slim off the seq # for passing in to fn_GetBestBusinessInfo( ).
			ds_BIPIDs_other_businesses := 
				PROJECT( ds_BIPIDs_w_seq_other_businesses, BIPV2.IDlayouts.l_xlink_ids2 );
			
			// 5. Get Best Business info for other Businesses having the same FEIN...
			//
			// QUESTION: Does it make sense to call Best for other phones?
			//
			ds_BestBusinessInfo_pre := 
				BusinessInstantID20_Services.fn_GetBestBusinessInfo(ds_BIPIDs_other_businesses, Options, linkingOptions);
			
			// 6. ...and join back to ds_BIPIDs_w_seq_other_businesses to obtain the original seq #.
			ds_BestBusinessInfo :=
				JOIN(
					ds_BIPIDs_w_seq_other_businesses, ds_BestBusinessInfo_pre,
					LEFT.uniqueid = RIGHT.seq,
					TRANSFORM( BusinessInstantID20_Services.layouts.BestInfoLayout,
						SELF.seq := LEFT.seq,  // reassign the original seq #
						SELF := RIGHT,
						SELF := []				
					),
					INNER
				);			

			// 7. Join back to ds_input to filter by its company name and history date.
			ds_BestBusinessInfo_filt := 
				JOIN(
					ds_input, ds_BestBusinessInfo,
					LEFT.seq = RIGHT.seq AND
					Risk_Indicators.iid_constants.g(Business_Risk.CNameScore(LEFT.CompanyName, RIGHT.best_bus_name)) AND
					(
						(
							LENGTH((STRING)LEFT.historydate) = 6 AND 
							(UNSIGNED3)(RIGHT.dt_first_seen[1..6]) < LEFT.historydate
						) OR
						(
							LENGTH((STRING)LEFT.historydate) >= 8 AND 
							(UNSIGNED4)(RIGHT.dt_first_seen) < (UNSIGNED4)((STRING)LEFT.historydate[1..8])
						)
					),
					TRANSFORM(RIGHT),
					INNER
				);

			ds_BestBusinessInfo_srtd   := SORT( ds_BestBusinessInfo_filt, seq, best_bus_zip, best_bus_state, best_bus_prim_range, best_bus_prim_name, best_bus_sec_range, best_bus_phone, -dt_first_seen );
			ds_BestBusinessInfo_ddpd   := DEDUP( ds_BestBusinessInfo_srtd, seq, best_bus_zip, best_bus_state, best_bus_prim_range, best_bus_prim_name, best_bus_sec_range, best_bus_phone );
			ds_BestBusinessInfo_resrtd := SORT( ds_BestBusinessInfo_ddpd, seq, -dt_first_seen );
			ds_BestBusinessInfo_grpd   := GROUP( ds_BestBusinessInfo_resrtd, seq );
			
			// 7. Use COMBINE( ) function to transform from normalized records to denormalized, 
			// repeating fields in a single record.
			layout_seq := {UNSIGNED4 seq};

			ds_seq := PROJECT(ds_BestBusinessInfo_ddpd, layout_seq);
			ds_seq_grpd := GROUP(DEDUP(SORT(ds_seq, seq), seq), seq);

			BusinessInstantID20_Services.Layouts.PhonesByAddressLayout xfm_ToCombinePhonesByAddress( layout_seq le, DATASET(BusinessInstantID20_Services.layouts.BestInfoLayout) allRows ) := 
				TRANSFORM
					SELF.seq                    := le.seq;
					SELF.bus_addr_match_phone_1 := allRows[1].best_bus_phone;
					SELF.bus_addr_match_phone_2 := allRows[2].best_bus_phone;
					SELF.bus_addr_match_phone_3 := allRows[3].best_bus_phone;
				END;

			ds_phones_by_address_combined := 
				COMBINE( 
					ds_seq_grpd, ds_BestBusinessInfo_grpd, 
					GROUP, 
					xfm_ToCombinePhonesByAddress(LEFT,ROWS(RIGHT)) 
				);

			// DEBUGs:
			// OUTPUT( ds_input, NAMED('input_to_fn_GetBusinessByAddress') );
			// OUTPUT( ds_input_filt_reseq, NAMED('input_filt_reseq') );
			// OUTPUT( ds_BIPIDs_filt_reseq, NAMED('BIPIDs_filt_reseq') );
			// OUTPUT( ds_InputSearch, NAMED('InputSearch') );
			// OUTPUT( ds_results_w_acct, NAMED('results_w_acct') );
			// OUTPUT( ds_results_w_acct_other_businesses, NAMED('results_w_acct_other') );
			// OUTPUT( ds_BIPIDs_w_seq_other_businesses, NAMED('BIPIDs_w_seq_other') );
			// OUTPUT( ds_BIPIDs_other_businesses, NAMED('BIPIDs_other') );
			// OUTPUT( ds_BestBusinessInfo_pre, NAMED('BestBusInfo_for_addr_pre') );
			// OUTPUT( ds_BestBusinessInfo, NAMED('BestBusInfo_for_addr') );
			// OUTPUT( ds_BestBusinessInfo_filt, NAMED('BestBusInfo_for_addr_filt') );
			// OUTPUT( ds_BestBusinessInfo_srtd, NAMED('BestBusInfo_for_addr_srtd') );
			// OUTPUT( ds_BestBusinessInfo_ddpd, NAMED('BestBusInfo_for_addr_ddpd') );
			// OUTPUT( ds_BestBusinessInfo_resrtd, NAMED('BestBusInfo_for_addr_resrtd') );
			
			RETURN ds_phones_by_address_combined;
		END;
