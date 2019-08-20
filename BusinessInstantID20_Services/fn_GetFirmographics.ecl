IMPORT BIPV2, Business_Risk_BIP, Corp2, MDR;

	// The following function calculates corporate filings or Firmographics data.
	EXPORT fn_GetFirmographics( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean) ds_CleanedInput,
	                            DATASET(BIPV2.IDlayouts.l_xlink_ids2) ds_BIPIDs,
	                            Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
	                            SET OF STRING2 AllowedSourcesSet) := 
		FUNCTION


			STRING clean_field(STRING field) := FUNCTION
				cleanamp := stringlib.StringFindReplace(field, '&amp;', '&');
				cleanapos := stringlib.StringFindReplace(cleanamp, '&apos;', '\'');
				cleanquot := stringlib.StringFindReplace(cleanapos, '&quot;', '"');
				cleangt := stringlib.StringFindReplace(cleanquot, '&gt;', '>');
				cleanlt := stringlib.StringFindReplace(cleangt, '&lt;', '<');
				cleannl := stringlib.StringFindReplace(cleanlt, '\n', ' ');
				RETURN cleannl;
			END;
			
			ds_CorpFilings_raw := Corp2.Key_LinkIDs.Corp.kfetch2(ds_BIPIDs,
																							 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							 0, // ScoreThreshold --> 0 = Give me everything
																							 Business_Risk_BIP.Constants.Limit_Default,
																							 Options.KeepLargeBusinesses
															         );

			// Add back our Seq numbers.
			ds_CorpFilings_seq := 
				JOIN(
					ds_CleanedInput, ds_CorpFilings_raw, 
					LEFT.Seq = RIGHT.UniqueID,
					TRANSFORM( {RECORDOF(RIGHT), UNSIGNED4 Seq, UNSIGNED6 HistoryDate}, 
						SELF.Seq := LEFT.Seq, 
						SELF.HistoryDate := LEFT.HistoryDate,
						SELF := RIGHT), 
					FEW);				

			// Figure out if the kFetch was successful
			kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(ds_CorpFilings_seq);

			// Filter out records after our history date.
			ds_CorpFilings_filt := Business_Risk_BIP.Common.FilterRecords(ds_CorpFilings_seq, dt_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_ID_Corporations, AllowedSourcesSet);

			// Sort to the top the most recent, Current, Legal record for each corp_key. Among these, 
			// we want the record to contain the oldest incorp date. 
			ds_CorpFilings_srtd :=
				SORT( 
					ds_CorpFilings_filt,
					seq,
                    -corp_key,
                    record_type, // 'C' = Current; 'H' = Historical, so Current will be sorted to the top.
					-(corp_ln_name_type_desc = 'LEGAL'), 
					MIN(corp_inc_date, corp_forgn_date),
					-corp_process_date,
                    -dt_last_seen
				);

			ds_CorpFilingsRecs := 
				PROJECT( 
					ds_CorpFilings_srtd, 
					TRANSFORM( BusinessInstantID20_Services.layouts.FirmographicLayout,
						SELF.Seq                := LEFT.seq,
						SELF.sos_filing_name    := clean_field( LEFT.corp_legal_name ),
						SELF.bus_description    := clean_field( IF( LEFT.corp_orig_bus_type_desc != '', TRIM(LEFT.corp_orig_bus_type_desc), TRIM(LEFT.corp_entity_desc) ) ),
						SELF := []									
					));

			ds_CorpFilingsRecs_rolled :=
				ROLLUP(
					ds_CorpFilingsRecs,
					LEFT.seq = RIGHT.seq,
					TRANSFORM( BusinessInstantID20_Services.layouts.FirmographicLayout,
						SELF.Seq                := LEFT.seq,
						SELF.sos_filing_name    := LEFT.sos_filing_name,
						SELF.bus_description    := LEFT.bus_description,
						SELF := []
					)
				);
	
			// DEBUGs...:				
			// OUTPUT( ds_CorpFilings_seq, NAMED('CorpFilings_seq') );
			// OUTPUT( ds_CorpFilings_filt, NAMED('CorpFilings_filt') );
			// OUTPUT( ds_CorpFilings_srtd, NAMED('CorpFilings_srtd') );
			// OUTPUT( ds_CorpFilingsRecs, NAMED('ds_CorpFilingsRecs') );
			
			RETURN ds_CorpFilingsRecs_rolled;
		END;