
IMPORT dx_header, Govt_Collections_Services, PhilipMorris;

EXPORT fn_getExpandedSSNRecs( dataset(Layouts.batch_working) ds_batch_in,
	                            Govt_Collections_Services.IParams.BatchParams in_mod ) :=
	FUNCTION
		
		// Fulfills _documentation, Req. 4.1.10
		
		// Note concerning PhilipMorris.SSNExpansionService: GIID = "Government-Issued ID", typically 
		// a driver's license.

		CN := PhilipMorris.Constants;
		LT := PhilipMorris.Layouts;
		FN := PhilipMorris.Functions;
		TF := PhilipMorris.Transforms;

		// --------------------[ LOCAL FUNCTIONS ]--------------------

				// ------------[ From PhilipMorris.fn_getSSN4ExpansionCandidates( ) ]------------
			
			fn_getSSN4ExpansionCandidates(DATASET(LT.Clean.FullRecordNorm) SearchData, UNSIGNED2 minAgeValue, UNSIGNED1 DPPA_Purpose, UNSIGNED1 GLB_Purpose) := FUNCTION

				searchpassnumeric := CN.SortSearchPassEnum.SSN4EXPANSION;
				
				searchDataLocal := SearchData(IsSearchableSSN4 AND
																			SearchName.lname != '' and 
																			(SearchName.pfname	!= '' or SearchName.pfname2 != ''));
				
				searchpass_candidates_dids := join(			 
						 searchDataLocal, dx_header.key_SSN4_V2(),
						 keyed(left.ssn4=right.ssn4) and
						 keyed(left.SearchName.PhoneticLname[1..6] = right.dph_lname) and
						 keyed(left.SearchName.lname = right.lname) and
						 keyed(left.SearchName.pfname = right.pfname or left.SearchName.pfname2 = right.pfname),			
						 TRANSFORM (LT.Search.FullRecordNormWithHeaderData, 
												SELF.did := RIGHT.DID;
												SELF := LEFT;
												SELF := []; //blank out all the other header fields.. the only necessary field at the moment is the did									
											),
							LIMIT(CN.MAX_NUM_RECORDS_TO_KEEP_PM, SKIP)
					);						 

				searchpass_candidates_dids_sorted  := sort(searchpass_candidates_dids, InternalSeqNo, SearchAddress.ADDRESSID, did);
				searchpass_candidates_dids_deduped := dedup(searchpass_candidates_dids_sorted, InternalSeqNo, SearchAddress.ADDRESSID, did);
																
				dirty_header_records := 
					join(
						searchpass_candidates_dids_deduped, dx_header.key_header(),
						keyed(LEFT.did = RIGHT.s_did) and
						left.ssn4 = RIGHT.SSN[FN.fn_getLen(RIGHT.SSN)-3..] and
						left.SearchName.lname = right.lname and
						right.valid_ssn <> 'M',														
						//first name validation can be better done by applying logic
						//once the records have been pulled
						TRANSFORM( LT.Search.FullRecordNormWithHeaderData, 
							SELF.DOB := IF (RIGHT.valid_dob <> 'M', RIGHT.DOB, 0),
							//valid_dob being maintained in the geo_blk field for debug info as the geo_blk field is not used
							SELF.geo_blk := RIGHT.valid_dob,
							Self := RIGHT,
							Self := LEFT
						),
						LIMIT(CN.MAX_NUM_RECORDS_PER_DID, SKIP)
					);

					clean_header_records := FN.fn_ApplyRestrictions (DPPA_Purpose, GLB_Purpose, dirty_header_records);

					searchpass_candidates_with_data := 
						project(
							clean_header_records, 
							TF.xfm_process_hdr_records(LEFT, searchpassnumeric, minAgeValue, false, false, false)
						);
																	
					final_output := searchpass_candidates_with_data(IsValidCandidate);		

					RETURN final_output;

			END; // fn_getSSN4ExpansionCandidates

			// ------------[ From PhilipMorris.fn_findSSNByNameAddress( ) ]------------
			
			LT.OutputRecord.CandidateRecord fn_findSSNByNameAddress (
				DATASET(LT.OutputRecord.CandidateRecord) SearchData, 
				UNSIGNED2 AddressIdHit,
				BOOLEAN NoHouseNumber = false, 
				BOOLEAN isDobMatch = false) := FUNCTION
				
				nada := DATASET([], LT.OutputRecord.CandidateRecord);
				
				// Filter data by name and address with or without house number.	
				dataHitsAddress := 
					SearchData( MatchesFirstName and MatchesLastName and 
					            MatchesZipCode and MatchesStreetNameFirst4 and 
					            MatchesHouseNumberFirst3 and MatchesSSN4 and 
					            SearchAddressIDHit = AddressIdHit );
					
				 // Record used to calculate count for ssn.
				rollupRec := RECORD
					dataHitsAddress.InternalSeqNo ;
					dataHitsAddress.SSN ;
					dataHitsAddress.SearchAddressIDHit;
					SSNCount := COUNT(GROUP) ;
				END;
				
				ssnTable := TABLE(dataHitsAddress, rollupRec, InternalSeqNo, SSN, SearchAddressIDHit, FEW);
				
				// For this to work with batch, we need to remove the ssns that have only one hit while
				// differentiating among internalseqno values (the equivalent of 'acctno' in this case).
				// I think the rule "if distinct ssns has more than one ssn number remove the ssns that 
				// have only one hit" assumes that if there's more than one record, and one of the records
				// has only one hit, then one of more of the others will certainly have 2 or more records.
				// The following code doesn't make that assumption.
				ssnTable_regrouped := 
					GROUP( SORT( UNGROUP(ssnTable), internalseqno, -ssncount ), internalseqno );

				rollupRec_with_child_ds := RECORD
					UNSIGNED internalseqno;
					DATASET(rollupRec) recs;
				END;

				rollupRec_with_child_ds xfm(rollupRec le, DATASET(rollupRec) allRows) :=
					TRANSFORM
						SELF.internalseqno := le.internalseqno;
						SELF.recs := 
								MAP( 
									COUNT(allRows) > 1 AND MAX(allRows,ssncount) = 1 => TOPN(allRows,1,internalseqno),
									COUNT(allRows) > 1 AND MAX(allRows,ssncount) > 1 => allRows(ssncount > 1),
									/* default: COUNT(allRows) = 1 ................ */  allRows
								);
					END;

				ssnByAddress1Count1_as_child := 
					ROLLUP( ssnTable_regrouped, GROUP, xfm(LEFT, ROWS(LEFT)) );

				rollupRec xfm_norm(rollupRec le) :=
					TRANSFORM
						SELF.internalseqno      := le.internalseqno;
						SELF.ssn                := le.ssn;
						SELF.searchaddressidhit := le.searchaddressidhit;
						SELF.ssncount           := le.ssncount;
					END;
					
				ssnByAddress1Count1 :=
					NORMALIZE( ssnByAddress1Count1_as_child, LEFT.recs, xfm_norm(RIGHT) );

				ssnByNameAddress_data := 
					JOIN(
						ssnByAddress1Count1, dataHitsAddress, 
						LEFT.internalseqno = RIGHT.internalseqno AND LEFT.SSN = RIGHT.SSN, 		
						TRANSFORM(LT.OutputRecord.CandidateRecord, 
							SELF.InputMatchCode := 
									IF( RIGHT.SearchAddressIdHit = CN.AddressTypeEnum.GIID, 'F', 
											IF( RIGHT.SearchAddressIdHit = CN.AddressTypeEnum.CURRENT, 'S', 
													CN.DISPLAY_INPUTMATCHCODE_ADDRESS_MISS));
							SELF := RIGHT
						),
						LEFT OUTER, KEEP(1)
					);
				
				RETURN ssnByNameAddress_data;
				
			END; // fn_findSSNByNameAddress

		// --------------------[ END LOCAL FUNCTIONS ]--------------------
	
		// 1. Transform batch_in to the layout required for PhillipMorris expand SSN process.
		data_in := PROJECT( ds_batch_in, Transforms.xfm_to_ExpSSN_batchIn(LEFT) );
		
		// ------------[ Adapted from PhilipMorris.fn_PMExpandSSN( ) ]------------

		// 2. Add seqno, clean, and normalize.
		inputDataAndSequence   := PROJECT(data_in, TF.xfm_append_seqno_ssn4(LEFT, COUNTER));
		searchDataInput        := PROJECT(inputDataAndSequence, TF.xfm_set_clean_data_ssn4(LEFT));	
		searchdataInputNorm    := NORMALIZE(searchDataInput,3,TF.xfm_normalize_search_data(LEFT, COUNTER));
		ssnExpansionCandidates := fn_getSSN4ExpansionCandidates(searchdataInputNorm, CN.DEFAULT_UNDERAGE_VALUE, in_mod.dppa, in_mod.glb);
		
		// 3. Search by Current Address with house number and no DOBYear match. *** NOTE: we can do
		// a lot below to remove some unnecessary joins.
		ssnByNameAddress2 := 
			fn_findSSNByNameAddress(ssnExpansionCandidates, CN.AddressTypeEnum.CURRENT, false, false);

		LT.Ssn4TransactionData xfm_add_searchdata(LT.Clean.FullRecord le, LT.OutputRecord.CandidateRecord ri) :=
			TRANSFORM													
				SELF.searchdata := le;
				SELF.OutputData.InternalSeqNo := 
						IF ((ri.InternalSeqNo <> 0 AND ri.DID <> 0), ri.InternalSeqNo, ri.InternalSeqNo);
				SELF.OutputData.DID := 
						IF ((ri.InternalSeqNo <> 0 AND ri.DID <> 0), ri.InternalSeqNo, 0);
				SELF.OutputData.DateProcessed_YYYYMMDD :=
						IF ((ri.InternalSeqNo <> 0 AND ri.DID <> 0), ri.DateProcessed_YYYYMMDD, le.TodayYYYYMMDD);													
				SELF.OutputData.SourceNameSort := 
						IF ((ri.InternalSeqNo <> 0 AND ri.DID <> 0), ri.SourceNameSort, CN.SortSourceEnum.UNK);
				SELF.OutputData.SourceName := 
						IF ((ri.InternalSeqNo <> 0 AND ri.DID <> 0), ri.SourceName, CN.DISPLAY_SOURCENAME_BLANK);
				SELF.OutputData.SourceType := 
						IF ((ri.InternalSeqNo <> 0 AND ri.DID <> 0), ri.SourceType, CN.SOURCETYPE_NAME_UNKNOWN);
				SELF.OutputData.SearchPass := 
						IF ((ri.InternalSeqNo <> 0 AND ri.DID <> 0), ri.SearchPass, CN.SortSearchPassEnum.MISS);
				SELF.OutputData.SearchAddressIDHit := 
						IF ((ri.InternalSeqNo <> 0 AND ri.DID <> 0), ri.SearchAddressIDHit, CN.AddressTypeEnum.UNK);
				SELF.OutputData.InputMatchCode := 
						IF ((ri.InternalSeqNo <> 0 AND ri.DID <> 0), ri.InputMatchCode, CN.DISPLAY_INPUTMATCHCODE_ADDRESS_MISS);
				SELF.OutputData  := ri;
				SELF.FailureCode := CN.NOMATCHFAILURECODE.FAILURECODE_UNK;													
				SELF.InputData   := [];
			END;
					
		tmpOut := 
			JOIN(
				searchDataInput, ssnByNameAddress2,
				LEFT.internalseqno = RIGHT.internalseqno,
				xfm_add_searchdata(LEFT,RIGHT),
				LEFT OUTER
			);
		
		outputDataNonIesp := 
			JOIN(inputDataAndSequence, tmpOut, 
				LEFT.InternalSeqNo = RIGHT.OutputData.InternalSeqNo,
				TRANSFORM(LT.Ssn4TransactionData,
					SELF.InputData.InputEcho.ssnLast4 := LEFT.SSN;
					SELF.InputData  := LEFT;												
					self.SearchData := RIGHT.SearchData;
					self.OutputData := RIGHT.OutputData;
					self.FailureCode := RIGHT.FailureCode
				),
				LEFT OUTER, keep(1)
			);

		// Join back to batch_in and return.
		ds_best_ssn_results :=
			JOIN(
				ds_batch_in, outputDataNonIesp,
				LEFT.acctno = RIGHT.inputdata.acctno,
				TRANSFORM( Layouts.batch_working,
					SELF.expanded_ssn := IF( LENGTH(TRIM(LEFT.ssn)) = 4, RIGHT.outputdata.ssn, '' ),
					SELF := LEFT
				),
				LEFT OUTER,
				KEEP(1)
			);

		// OUTPUT( ssnByNameAddress2, NAMED('ssnByNameAddress2') );
		// OUTPUT( tmpOut, NAMED('tmpOut') );
		// OUTPUT( outputDataNonIesp, NAMED('outputDataNonIesp') );
		// OUTPUT( ds_best_ssn_results, NAMED('ds_best_ssn_results') );
		
		IF( in_mod.ViewDebugs, 
				OUTPUT( outputDataNonIesp, NAMED('ds_expssn_intm_recs') ) );
		
		RETURN ds_best_ssn_results;
		
	END;
	