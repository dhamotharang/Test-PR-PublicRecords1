IMPORT AutoStandardI, BIPV2, Business_Credit, Business_Credit_KEL, Business_Risk_BIP, doxie, suppress;

	// The following function reads Business Header Records, which'll be used in at least two other 
	// functions a bit later. Slims 'em down too, for a lighter footprint.
	EXPORT fn_GetHeaderRecords( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean) ds_CleanedInput = DATASET( [], BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean ),
	                            DATASET(BIPV2.IDlayouts.l_xlink_ids2) ds_BIPIDs = DATASET([],BIPV2.IDlayouts.l_xlink_ids2),
	                            BusinessInstantID20_Services.iOptions Options,
	                            BIPV2.mod_sources.iParams linkingOptions,
	                            SET OF STRING2 AllowedSourcesSet ) :=
		FUNCTION

			layout_seq_temp := {UNSIGNED4 seq};
			
			// --------------- LexisNexis Business Header ----------------
			
			ds_BusinessHeaderRaw1 := 
					BIPV2.Key_BH_Linking_Ids.kFetch2(inputs                   := ds_BIPIDs,
																					 Level                    := Business_Risk_BIP.Common.SetLinkSearchLevel(Business_Risk_BIP.Constants.LinkSearch.SeleID),
																					 ScoreThreshold           := 0, // ScoreThreshold --> 0 = Give me everything
																					 in_mod                   := linkingOptions,
																					 JoinLimit                := Business_Risk_BIP.Constants.Limit_BusHeader,
																					 dnbFullRemove            := FALSE,
																					 bypassContactSuppression := TRUE,
																					 JoinType                 := Options.KeepLargeBusinesses );
	
		// clean up the business header before doing anything else
		Business_Risk_BIP.Common.mac_slim_header(ds_BusinessHeaderRaw1, ds_BusinessHeaderRaw);	
		
			// Add back our Seq numbers.
			ds_BusinessHeaderSeq := 
				JOIN(
					ds_CleanedInput, ds_BusinessHeaderRaw, 
					LEFT.Seq = RIGHT.UniqueID,
					TRANSFORM( BusinessInstantID20_Services.layouts.BusinessHeaderSlim, 
						SELF.seq := LEFT.seq,
						SELF.uniqueid := RIGHT.uniqueid, 
						SELF.HistoryDate := LEFT.HistoryDate,
						SELF := RIGHT,
						self := []), 
					FEW);				
					
			// Filter out records after our history date and sources that aren't allowed. NOTE: 
			// this is NOT entirely correct, as there are other rules having to do with Load Date
			// that must be implemented when possible. See e.g. Business_Risk_BIP.getBusinessHeader.
			ds_BusinessHeader := 
					ds_BusinessHeaderSeq(
						(Source = '' OR Source IN AllowedSourcesSet) AND // Only keep allowed Business Shell sources.
						(
							( // If running in realtime mode, still filter out any future dates, but
								// include everything up to today's date (thus the <= comparison).
								HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND 
								(INTEGER)(((STRING)dt_first_seen)[1..6]) <= (INTEGER)(StringLib.getDateYYYYMMDD()[1..6])
							) 
							OR 
							Business_Risk_BIP.Common.fn_filter_on_archive_date( (INTEGER)(((STRING)dt_first_seen)[1..6]), (INTEGER)((STRING)HistoryDate)[1..6], 6 )
						)
					); 	

			ds_LN_Business_Header_recs_seq_only :=
				PROJECT( DEDUP( SORT( ds_BusinessHeader, seq), seq), layout_seq_temp );
			
			// --------------- SBFE Business Header ---------------- 
			fdc_layout := RECORD
				RECORDOF(Business_Credit_KEL.File_SBFE_temp);
			END;

      _mod_access := 
        MODULE(doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule()))
          EXPORT STRING DataRestrictionMask := linkingOptions.DataRestrictionMask;
          EXPORT UNSIGNED1 glb := linkingOptions.GLBPurpose;
          EXPORT UNSIGNED1 dppa := linkingOptions.DPPAPurpose;
          EXPORT BOOLEAN show_minors := linkingOptions.IncludeMinors;
          EXPORT UNSIGNED1 unrestricted := (UNSIGNED1)linkingOptions.AllowAll;
          EXPORT BOOLEAN isPreGLBRestricted() := linkingOptions.restrictPreGLB;
          EXPORT BOOLEAN ln_branded :=  linkingOptions.lnbranded;
        END;
          
			ds_SBFERaw := 
					Business_Credit.Key_LinkIds().kFetch2(inputs             := ds_BIPIDs,
																								mod_access         := _mod_access,
                                                Level              := Business_Risk_BIP.Common.SetLinkSearchLevel(Business_Risk_BIP.Constants.LinkSearch.SeleID),
																								ScoreThreshold     := 0, // ScoreThreshold --> 0 = Give me everything
																								JoinLimit          := Business_Risk_BIP.Constants.Limit_SBFE_LinkIds,
																								JoinType           := Options.KeepLargeBusinesses );				

			// Add back our Seq numbers.
			ds_SBFESeq := 
				JOIN(
					ds_CleanedInput, ds_SBFERaw, 
					LEFT.Seq = RIGHT.UniqueID,
					TRANSFORM( { UNSIGNED4 seq, UNSIGNED4 uniqueid, UNSIGNED4 HistoryDate, RECORDOF(ds_SBFERaw) }, 
						SELF.seq := LEFT.seq,
						SELF.uniqueid := RIGHT.uniqueid, 
						SELF.HistoryDate := LEFT.HistoryDate,
						SELF := RIGHT), 
					FEW);	
					
			// Filter out records after our history date. NOTE: this is NOT entirely correct, as 
			// there are other rules having to do with Load Date that must be implemented when
			// possible. See e.g. Business_Risk_BIP.getSBFE.
			ds_SBFE_filt := 
					ds_SBFESeq(
						( // If running in realtime mode, still filter out any future dates, but
							// include everything up to today's date (thus the <= comparison).
							HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND 
							(INTEGER)(((STRING)dt_first_seen)[1..6]) <= (INTEGER)(StringLib.getDateYYYYMMDD()[1..6])
						) 
						OR 
						Business_Risk_BIP.Common.fn_filter_on_archive_date((INTEGER)dt_first_seen, HistoryDate, LENGTH((STRING)HistoryDate))
					); 
			
			// NOTE: fix commented lines, below.
			RECORDOF(fdc_layout.BusinessInformation) xfm_BusinessInformation_recs(ds_SBFE_filt le, RECORDOF(Business_Credit.Key_BusinessInformation()) ri, INTEGER c) := TRANSFORM
				SELF.seq:=le.seq;
				SELF.seq_num := HASH(c, ri.sbfe_contributor_number, ri.contract_account_number, ri.account_type_reported);
				SELF.acct_no := HASH(ri.sbfe_contributor_number, ri.contract_account_number, ri.account_type_reported);
				SELF.load_date := '';        // IF(ri.original_version < Business_Risk_BIP.Constants.FirstSBFELoadDate, (STRING)ri.dt_first_seen, ri.original_version); 
				SELF.HistoryDate := 0;       // le.HistoryDate;
				SELF.HistoryDateTime := 0;   // le.HistoryDateTime;
				SELF.HistoryDateLength := 0; // le.HistoryDateLength;
				SELF := ri;
				SELF := [];
			END;

			// Hit Key_BusinessInformation to get BII (company name, address, etc., etc.).
			BusinessInformation_recs_org := 
				JOIN(
					ds_SBFE_filt, Business_Credit.Key_BusinessInformation(),
					KEYED(RIGHT.contract_account_number = LEFT.contract_account_number) AND 
					KEYED(RIGHT.sbfe_contributor_number = LEFT.sbfe_contributor_number) AND 
					KEYED(RIGHT.account_type_reported = LEFT.account_type_reported), 
					xfm_BusinessInformation_recs(LEFT,RIGHT,COUNTER), 
					ATMOST(Business_Risk_BIP.Constants.Limit_SBFE)
				);
			BusinessInformation_recs := Suppress.MAC_SuppressSource(BusinessInformation_recs_org, _mod_access, did);
			
      // Join back to BIPIDs to filter out non-matching Businesses.
			BusinessInformation_filt :=
				JOIN(
					BusinessInformation_recs(record_type = 'AB'), ds_BIPIDs,
					LEFT.seq = RIGHT.uniqueid AND
					LEFT.ultid = RIGHT.ultid AND
					LEFT.orgid = RIGHT.orgid AND
					LEFT.seleid = RIGHT.seleid,
					TRANSFORM(LEFT),
					INNER
				);
																													
			// BusinessInformation_recs_with_loaddate := 
				// getLoadDate(BusinessInformation_recs, seq_num, dt_first_seen);		
			
			// BusinessInformation_recs_with_loaddate_filtered := 
				// BusinessInformation_recs_with_loaddate((historydate =(INTEGER)Business_Risk_BIP.Constants.NinesDate AND load_date[1..8] <= StringLib.getDateYYYYMMDD())
																											// OR Business_Risk_BIP.Common.fn_filter_on_archive_date((INTEGER)load_date, HistoryDateTime, HistoryDateLength));
																											
			// Slim to the same layout as for LN Business Header, above.
			ds_SBFEHeader := 
				PROJECT(
					BusinessInformation_filt,
					TRANSFORM( BusinessInstantID20_Services.layouts.BusinessHeaderSlim, 
						SELF.seq         := LEFT.seq,
						SELF.uniqueid    := LEFT.seq, 
						SELF.HistoryDate := LEFT.HistoryDate,
						SELF.rcid        := 0,
						SELF.source      := LEFT.source,

						SELF.company_name  := LEFT.business_name,
						SELF.company_fein  := LEFT.federal_taxid_ssn,
						SELF.company_phone := LEFT.phone_number,

						SELF := LEFT,
						SELF := [] ) );

			ds_SBFE_Header_recs_seq_only :=
				PROJECT( DEDUP( SORT( ds_SBFEHeader, seq), seq), layout_seq_temp );
			
			ds_seq_needing_SBFE_records := 
				JOIN(
					ds_LN_Business_Header_recs_seq_only, ds_SBFE_Header_recs_seq_only,
					LEFT.seq = RIGHT.seq,
					TRANSFORM(RIGHT),
					RIGHT ONLY
				);

			ds_SBFE_records_needed :=
				JOIN(
					ds_seq_needing_SBFE_records, ds_SBFEHeader(Options.useSBFE), 
					LEFT.seq = RIGHT.seq,
					TRANSFORM(RIGHT),
					INNER
				);
			
			ds_header_records := SORT( (ds_BusinessHeader + ds_SBFEHeader), seq );

			// DEBUGs...:
			// OUTPUT( ds_BIPIDs, NAMED('_BIPIDs') );
			// OUTPUT( ds_BusinessHeaderSeq, NAMED('BusinessHeaderSeq') );
			// OUTPUT( ds_SBFERaw, NAMED('_SBFERaw') );
			// OUTPUT( ds_SBFE_filt, NAMED('_SBFE_filt') );
			// OUTPUT( BusinessInformation_recs, NAMED('_BusinessInformation_recs') );
			// OUTPUT( BusinessInformation_filt, NAMED('_BusinessInformation_filt') );
			// OUTPUT( ds_LN_Business_Header_recs_seq_only, NAMED('_LN_Business_Header_recs_seq_only') );
			// OUTPUT( ds_SBFEHeader, NAMED('_SBFEHeader') );
			// OUTPUT( ds_SBFE_Header_recs_seq_only, NAMED('_SBFE_Header_recs_seq_only') );
			// OUTPUT( ds_seq_needing_SBFE_records, NAMED('_seq_needing_SBFE_records') );
			// OUTPUT( ds_SBFE_records_needed, NAMED('_SBFE_records_needed') );
			
			RETURN ds_header_records;
		END;
	