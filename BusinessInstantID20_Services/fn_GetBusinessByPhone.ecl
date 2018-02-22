IMPORT BIPV2, Business_Risk_BIP, ut;

EXPORT fn_GetBusinessByPhone( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo) ds_input,
                             DATASET(BIPV2.IDlayouts.l_xlink_ids2) ds_BIPIDs,
                             BusinessInstantID20_Services.iOptions Options,
														 BIPV2.mod_sources.iParams linkingOptions) := 
		FUNCTION

			// NOTE: In Scoring we identify each record using "seq". In the world of BIP it's "uniqueid".
			
			// 1.a. Because BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs( ) sequences the input
			// records using an integer counter, we need to resequence the filtered records 
			// from ds_input so that we can match up the results from that function correctly.
			layout_input_temp := RECORD
				UNSIGNED4 orig_seq;
				BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo;
			END;
			
			ds_input_filt := ds_input(Phone10 != '');
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
			
			// 2. Call fn_IndexedSearchForXLinkIDs( ) to get matching BIPIDs for each input phone.
			BIPV2.IDFunctions.rec_SearchInput xfm_ToSearchInput(layout_input_temp le) := 
				TRANSFORM
					SELF.acctno  := (STRING)le.seq;
					SELF.phone10 := le.phone10;
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
			ds_BestBusinessInfo_pre := 
				BusinessInstantID20_Services.fn_GetBestBusinessInfo(ds_BIPIDs_other_businesses, Options, linkingOptions);
			
			// 6. ...and join back to ds_BIPIDs_w_seq_other_businesses to obtain the original seq #.
			layout_BestInfoLayout_with_LinkIDs := RECORD
				BusinessInstantID20_Services.layouts.BestInfoLayout;
				UNSIGNED6 ultid;
				UNSIGNED6 orgid;
				UNSIGNED6 seleid;
				UNSIGNED6 proxid;
				UNSIGNED6 powid;	
			END;
			
			ds_BestBusinessInfo :=
				JOIN(
					ds_BIPIDs_w_seq_other_businesses, ds_BestBusinessInfo_pre,
					LEFT.uniqueid = RIGHT.seq,
					TRANSFORM( layout_BestInfoLayout_with_LinkIDs,
						SELF.seq := LEFT.seq,  // reassign the original seq #
						SELF := RIGHT,
						SELF := LEFT,
						SELF := []				
					),
					INNER
				);			

			// 7. Join back to ds_input to filter by its history date.
			ds_BestBusinessInfo_filt := 
				JOIN(
					ds_input, ds_BestBusinessInfo,
					LEFT.seq = RIGHT.seq AND
					(
						(
							LENGTH((STRING)LEFT.historydate) = 6 AND 
							(UNSIGNED3)(((STRING)RIGHT.dt_first_seen)[1..6]) < LEFT.historydate
						) OR
						(
							LENGTH((STRING)LEFT.historydate) >= 8 AND 
							(UNSIGNED4)(RIGHT.dt_first_seen) < (UNSIGNED4)(((STRING)LEFT.historydate)[1..8])
						)
					),
					TRANSFORM(RIGHT),
					INNER
				);

			ds_BestBusinessInfo_srtd   := SORT( ds_BestBusinessInfo_filt, seq, best_bus_phone, -dt_first_seen );
			ds_BestBusinessInfo_ddpd   := DEDUP( ds_BestBusinessInfo_srtd, seq, best_bus_phone );
			ds_BestBusinessInfo_resrtd := SORT( ds_BestBusinessInfo_ddpd, seq, -dt_first_seen );
			ds_BestBusinessInfo_grpd   := GROUP( ds_BestBusinessInfo_resrtd, seq );
			
			// 7. Use COMBINE( ) function to transform from normalized records to denormalized, 
			// repeating fields in a single record.
			layout_seq := {UNSIGNED4 seq};

			ds_seq := PROJECT(ds_BestBusinessInfo_ddpd, layout_seq);
			ds_seq_grpd := GROUP(DEDUP(SORT(ds_seq, seq), seq), seq);

			BusinessInstantID20_Services.Layouts.BusinessByPhoneLayout xfm_ToCombineBusinessByPhone( layout_seq le, DATASET(layout_BestInfoLayout_with_LinkIDs) allRows ) := 
				TRANSFORM
					SELF.seq := le.seq;
					SELF.bus_phone_match_company_1    := allRows[1].best_bus_name;
					SELF.bus_phone_match_prim_range_1 := allRows[1].best_bus_prim_range;
					SELF.bus_phone_match_predir_1     := allRows[1].best_bus_predir;
					SELF.bus_phone_match_prim_name_1  := allRows[1].best_bus_prim_name;
					SELF.bus_phone_match_suffix_1     := allRows[1].best_bus_addr_suffix;
					SELF.bus_phone_match_postdir_1    := allRows[1].best_bus_postdir;
					SELF.bus_phone_match_unit_desig_1 := allRows[1].best_bus_unit_desig;
					SELF.bus_phone_match_sec_range_1  := allRows[1].best_bus_sec_range;
					SELF.bus_phone_match_addr_1       := allRows[1].best_bus_addr;
					SELF.bus_phone_match_city_1       := allRows[1].best_bus_city;
					SELF.bus_phone_match_state_1      := allRows[1].best_bus_state;
					SELF.bus_phone_match_zip_1        := allRows[1].best_bus_zip;
					SELF.bus_phone_match_zip4_1       := allRows[1].best_bus_zip4;
					SELF.bus_phone_match_ultid_1      := allRows[1].ultid;
					SELF.bus_phone_match_orgid_1      := allRows[1].orgid;
					SELF.bus_phone_match_seleid_1     := allRows[1].seleid;
					SELF.bus_phone_match_proxid_1     := allRows[1].proxid;
					SELF.bus_phone_match_powid_1      := allRows[1].powid;
					
					SELF.bus_phone_match_company_2    := allRows[2].best_bus_name;
					SELF.bus_phone_match_prim_range_2 := allRows[2].best_bus_prim_range;
					SELF.bus_phone_match_predir_2     := allRows[2].best_bus_predir;
					SELF.bus_phone_match_prim_name_2  := allRows[2].best_bus_prim_name;
					SELF.bus_phone_match_suffix_2     := allRows[2].best_bus_addr_suffix;
					SELF.bus_phone_match_postdir_2    := allRows[2].best_bus_postdir;
					SELF.bus_phone_match_unit_desig_2 := allRows[2].best_bus_unit_desig;
					SELF.bus_phone_match_sec_range_2  := allRows[2].best_bus_sec_range;
					SELF.bus_phone_match_addr_2       := allRows[2].best_bus_addr;
					SELF.bus_phone_match_city_2       := allRows[2].best_bus_city;
					SELF.bus_phone_match_state_2      := allRows[2].best_bus_state;
					SELF.bus_phone_match_zip_2        := allRows[2].best_bus_zip;
					SELF.bus_phone_match_zip4_2       := allRows[2].best_bus_zip4;
					SELF.bus_phone_match_ultid_2      := allRows[2].ultid;
					SELF.bus_phone_match_orgid_2      := allRows[2].orgid;
					SELF.bus_phone_match_seleid_2     := allRows[2].seleid;
					SELF.bus_phone_match_proxid_2     := allRows[2].proxid;
					SELF.bus_phone_match_powid_2      := allRows[2].powid;
					
					SELF.bus_phone_match_company_3    := allRows[3].best_bus_name;
					SELF.bus_phone_match_prim_range_3 := allRows[3].best_bus_prim_range;
					SELF.bus_phone_match_predir_3     := allRows[3].best_bus_predir;
					SELF.bus_phone_match_prim_name_3  := allRows[3].best_bus_prim_name;
					SELF.bus_phone_match_suffix_3     := allRows[3].best_bus_addr_suffix;
					SELF.bus_phone_match_postdir_3    := allRows[3].best_bus_postdir;
					SELF.bus_phone_match_unit_desig_3 := allRows[3].best_bus_unit_desig;
					SELF.bus_phone_match_sec_range_3  := allRows[3].best_bus_sec_range;
					SELF.bus_phone_match_addr_3       := allRows[3].best_bus_addr;
					SELF.bus_phone_match_city_3       := allRows[3].best_bus_city;
					SELF.bus_phone_match_state_3      := allRows[3].best_bus_state;
					SELF.bus_phone_match_zip_3        := allRows[3].best_bus_zip;
					SELF.bus_phone_match_zip4_3       := allRows[3].best_bus_zip4;
					SELF.bus_phone_match_ultid_3      := allRows[3].ultid;
					SELF.bus_phone_match_orgid_3      := allRows[3].orgid;
					SELF.bus_phone_match_seleid_3     := allRows[3].seleid;
					SELF.bus_phone_match_proxid_3     := allRows[3].proxid;
					SELF.bus_phone_match_powid_3      := allRows[3].powid;
					
					SELF := [];
				END;

			ds_businesses_by_phone_combined := 
				COMBINE( 
					ds_seq_grpd, ds_BestBusinessInfo_grpd, 
					GROUP, 
					xfm_ToCombineBusinessByPhone(LEFT,ROWS(RIGHT)) 
				);

			// DEBUGs:
			// OUTPUT( ds_input, NAMED('input_to_fn_GetBusinessByPhone') );
			// OUTPUT( ds_input_filt_reseq, NAMED('input_filt_reseq') );
			// OUTPUT( ds_BIPIDs_filt_reseq, NAMED('BIPIDs_filt_reseq') );
			// OUTPUT( ds_InputSearch, NAMED('InputSearch') );
			// OUTPUT( ds_results_w_acct, NAMED('results_w_acct') );
			// OUTPUT( ds_results_w_acct_other_businesses, NAMED('results_w_acct_other') );
			// OUTPUT( ds_BIPIDs_w_seq_other_businesses, NAMED('BIPIDs_w_seq_other') );
			// OUTPUT( ds_BIPIDs_other_businesses, NAMED('BIPIDs_other') );
			// OUTPUT( ds_BestBusinessInfo_pre, NAMED('BestBusInfo_for_Phone_pre') );
			// OUTPUT( ds_BestBusinessInfo, NAMED('BestBusInfo_for_Phone') );
			// OUTPUT( ds_BestBusinessInfo_filt, NAMED('BestBusInfo_for_Phone_filt') );
			// OUTPUT( ds_BestBusinessInfo_srtd, NAMED('BestBusInfo_for_Phone_srtd') );
			// OUTPUT( ds_BestBusinessInfo_ddpd, NAMED('BestBusInfo_for_Phone_ddpd') );
			// OUTPUT( ds_BestBusinessInfo_resrtd, NAMED('BestBusInfo_for_Phone_resrtd') );
			
			RETURN ds_businesses_by_phone_combined;
		END;
