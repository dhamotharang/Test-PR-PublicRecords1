
IMPORT Autokey_batch, BatchServices, AutokeyB2, ut, Corp2, Data_Services, BIPV2;

EXPORT SOS_Batch_Service_Records(DATASET(Corp2_services.Layouts.layout_batch_in) ds_batch_in = DATASET([],Corp2_services.Layouts.layout_batch_in),
                                 BOOLEAN RETURN_CURRENT_ONLY = FALSE, 
																 UNSIGNED2 maxRecsPerInput = 0,
																 STRING BIPFetchLevel = BIPV2.IDconstants.Fetch_Level_SELEID) := 
	MODULE

		SHARED BOOLEAN IS_BATCH_SERVICE := TRUE;	

		// 1.  Get corp filing records by Autokey fetch. Payload = outPLfat. 
		SHARED ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
				export skip_set        :=  ['P','Q','S'];
				export useAllLookups   := TRUE;
		END;
		
		ak_batch_in := PROJECT(ds_batch_in,TRANSFORM(Autokey_batch.Layouts.rec_inBatchMaster,SELF := LEFT));
		ak_key    := Data_Services.foreign_prod + 'thor_data400::key::corp2::qa::autokey::';
		ak_out    := Autokey_batch.get_fids(ak_batch_in, ak_key, ak_config_data);
		outpl_rec := dataset([], Corp2_services.assorted_layouts.layout_common);
		typestr   := 'BC';

		AutokeyB2.mac_get_payload(ak_out,ak_key,outpl_rec,outPLfat,person_did,bdid,typestr)
		
		SHARED outPL := outPLfat;
		SHARED NAMEWORDS := 'W';
		
		// get corpkeys from linkids
		ds_linkIds := PROJECT(ds_batch_in(ultid !=0),BIPV2.IDlayouts.l_xlink_ids2);
		ds_from_linkids := PROJECT(Corp2.Key_LinkIDs.corp.kFetch2(ds_linkIds,bipFetchLevel),
															 TRANSFORM(Corp2_services.layouts.layout_linkid_payload,
																					SELF := LEFT,
																					SELF.acctno := ''));
		
		// Add back acctno 
		SHARED ds_corpkey_linkids := JOIN(ds_from_linkids,ds_batch_in,
																LEFT.UltID = RIGHT.UltID AND
																(LEFT.OrgID = RIGHT.OrgID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_OrgID) AND
																(LEFT.SeleID = RIGHT.SeleID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_SELEID) AND
																(LEFT.ProxID = RIGHT.ProxID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_ProxID) AND
																(LEFT.PowID = RIGHT.PowID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_PowID) AND
																(LEFT.EmpID = RIGHT.EmpID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_EmpID) AND
																(LEFT.DotID = RIGHT.ProxID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_DotID),
																TRANSFORM(Corp2_services.layouts.layout_corpkey_with_penalty,
																							SELF.acctno := RIGHT.acctno,
																							self.penalt := 0,
																							SELF := LEFT));
																							
		// 2.  Filter the autokey payload records. In this batch service, a single input record can 
		// generate tens of thousands of matching autokey records by virtue of the NameWords autokey 
		// fetch, and so cause the system to throw an out-of-memory exception. The Namewords fetch 
		// doesn't care about address data, so to keep things under control it's critical to limit 
		// the number of matching records here. 
		// 
		// The join below also acts as a filter, in that it requires a company name or last name; and,
		// in the case where there is a state entered in the input record, a matching state. However, 
		// sometimes the matching Autokey record has a matchcode value containing something besides
		// 'W' (which indicates a NameWords match), like 'T' (which indicates a State value match);
		// but, no state value in the record itself. We want to preserve these. All of this logic 
		// will help to keep the number of records manageable.
		//
		// Notice that there is some leaky logic in the first part of the filter:
		//
		//					RIGHT.business_state = LEFT.st 
		//					OR LENGTH(TRIM(StringLib.StringFilterOut(RIGHT.matchcode, NAMEWORDS))) > 0 
		//					OR LEFT.st = ''
		//
		// ...which allows an input record consisting of someone's last name and first name, with 
		// or without additional information. These records will pass through the filter here, but 
		// be caught a little further south in the penalization step. Which is fine. We are not 
		// experiencing trouble with memory errors due to input records that describe a person.
		
		// 2.a.  Sort the left and right sides of the upcoming joins so that the same results are 
		// returned from the KEEP() every time.
		SHARED ds_batch_in_sorted := SORT( ds_batch_in, acctno );
		SHARED outPL_sorted       := SORT( outPL(corp_key != ''), acctno, RECORD );
		
		SHARED outpl_filtered := 
			JOIN(
				ds_batch_in_sorted, outPL_sorted,
				RIGHT.acctno = LEFT.acctno 
				AND
				(
					(
						RIGHT.business_state = LEFT.st 
						OR LENGTH(TRIM(StringLib.StringFilterOut(RIGHT.matchcode, NAMEWORDS))) > 0 
						OR LEFT.st = ''
					) 
					AND RIGHT.company_name != ''  
				), 
				TRANSFORM(Corp2_services.layouts.layout_AK_payload, SELF := RIGHT),
				INNER,
				KEEP(Corp2.constants.BATCH_JOIN_LIMIT_SMALL)
			);

		// 3.  Penalize the autokey payload records against the input dataset. Filter, sort and dedup  
		// to reduce the number of corp_keys further. 
		
		// ...penalize:
		SHARED Corp2_services.layouts.layout_corpkey_with_penalty xfm_penalize_matching_record(
			Corp2_services.Layouts.layout_batch_in le, Corp2_services.layouts.layout_AK_payload ri ) := 
				TRANSFORM
					SELF.acctno := le.acctno;
					SELF.corp_key := ri.corp_key;
					SELF.penalt := 
						MIN( 
							Corp2_services.functions.fn_penalize_matching_biz(le,ri), 
							Corp2_services.functions.fn_penalize_matching_indv(le,ri) 
						);
				END;
		
		SHARED ds_input_plus_corp_keys_penalized :=
			JOIN(
				ds_batch_in, outpl_filtered,
				LEFT.acctno = RIGHT.acctno,
				xfm_penalize_matching_record(LEFT,RIGHT),
				INNER,
				LIMIT(Corp2.constants.BATCH_JOIN_LIMIT_LARGE,SKIP)
			);
		
		// ...filter:
		SHARED ds_input_plus_corp_keys_filtered := 
			ds_input_plus_corp_keys_penalized( penalt <= ak_config_data.PenaltThreshold);
		
		// Add in corp-keys from linkids and  sort, dedup; project:
		SHARED ds_input_plus_corp_keys_deduped := 
			DEDUP( SORT( ds_input_plus_corp_keys_filtered + ds_corpkey_linkids, acctno, corp_key, penalt ), acctno, corp_key);
			
		SHARED ds_corp_keys := 
			PROJECT( UNGROUP(ds_input_plus_corp_keys_deduped), corp2_services.layout_corpkey );

		// 4.  Now, go get Corp records and flatten them. Suppression is handled in Corp2_services.corp2_report_recs.
		SHARED ds_corp_recs := 
			Corp2_services.get_corp_corpkeys.report(ds_corp_keys, '', FALSE, IS_BATCH_SERVICE, RETURN_CURRENT_ONLY);
			
		SHARED ds_corp_recs_flat := 
			Corp2_services.corp2_raw.batch_view.get_batch_out(ds_corp_recs);

		// 5.  Add acctno and penalty back to the result, implement maxRecs if necessary, and return.
		SHARED out_res := 
			JOIN(
				ds_input_plus_corp_keys_deduped, ds_corp_recs_flat,
				LEFT.corp_key = RIGHT.corp_key,
				TRANSFORM( Corp2_services.layouts.layout_batch_out, 
					SELF := LEFT, 
					SELF := RIGHT, 
					SELF := []
				),
				INNER,
				LIMIT(Corp2.constants.BATCH_JOIN_LIMIT_LARGE,SKIP)
			);
		
		SHARED out_res_f := 
			IF( maxRecsPerInput <> 0, 
					UNGROUP(TOPN(GROUP(SORT(out_res, acctno), acctno), maxRecsPerInput, penalt)),
					SORT(out_res, acctno, penalt)
				 );
		
		// DEBUGs:
		// EXPORT res_outPLfat                       := outPL;
		// EXPORT res_outpl_filtered                 := outpl_filtered;
		// EXPORT res_input_plus_corp_keys_penalized := ds_input_plus_corp_keys_penalized;
		// EXPORT res_input_plus_corp_keys_filtered  := ds_input_plus_corp_keys_filtered;
		// EXPORT res_corp_keys                      := ds_corp_keys;
		
		EXPORT results := out_res_f;
				 
	END;