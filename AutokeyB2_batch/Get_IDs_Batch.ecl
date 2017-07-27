
IMPORT Autokey_batch;								

/* THIS ATTRIBUTE IS DEPRECATED, HAVING BEEN FOLDED INTO AUTOKEY_BATCH.GET_FIDS. */

/* This function simply accumulates all 'fake' DIDs and BDIDs (Autokeys) that match the 
   input criteria. In the non-batch version of this function (AutokeyB2.get_IDs) part of
	 the code identifies which IDs are 'fake' based on their numeric value. AutokeyB2.get_IDs
	 makes this distinction, because in AutokeyB2 the system not only queries the autokeys, 
	 but also the header file. And the header file will return 'real' DIDs and BDIDs.
	 
	 But, on the batch side we're ignoring the header file (see the Documentation attribute 
	 for an explanation); this means all of the IDs we accumulate here shall be 'fake'.  
*/

EXPORT get_ids_batch(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_in,
										 STRING autokeyname, 
										 SET OF STRING1 skip_set = [],
										 BOOLEAN isBareAddr = FALSE, 
										 BOOLEAN workHard = FALSE,
										 BOOLEAN nofail = FALSE,
										 BOOLEAN useAllLookups = FALSE,
										 BOOLEAN isTestHarness = FALSE) := 
	FUNCTION
		
		PERSON_ADDRESS := AutokeyB2_batch.Constants.ADDRESS_MATCH;
		COMPANY_ADDRESS   := AutokeyB2_batch.Constants.COMP_ADDR_MATCH;
		
		// 1. Transform the dataset in doxie.layout_inBatchMaster to Autokey_batch.Layouts.rec_Cleaned_Input_Record.
		//    Sort and group. NOTE! As of this point in time (Jan 2008), rec_Cleaned_Input_Record doesn't contain 
		//    certain data, like DID, DL or VIN. These can be added to the layout later, if necessary.
		ds_input         := PROJECT(ds_in, Autokey_batch.Transforms.xfm_to_Cleaned_Input_Record(LEFT));
		ds_input_sorted  := SORT(ds_input, AccountNumber);
		ds_input_grouped := GROUP(ds_input_sorted, AccountNumber);		
		
		// 2. Get DIDs.				
		AutokeyB2_batch.Layouts.rec_output_IDs_batch xfm_make_DIDs(Autokey_batch.Layouts.rec_DID_OutBatch l) := 
			TRANSFORM
				SELF.ID     := l.DID;
				SELF.isDID  := TRUE;
				SELF        := l;
			END;
		 
		dids := PROJECT( Autokey_batch.Get_DIDs_batch(ds_input_grouped, 
																									autokeyname, 
																									skip_set, 
																									isBareAddr, 
																									workHard, 
																									nofail, 
																									useAllLookups,
																									isTestHarness), 
											xfm_make_DIDs(LEFT) );

		// 3. Get BDIDs.		
		AutokeyB2_batch.Layouts.rec_output_IDs_batch xfm_make_BDIDs(AutokeyB2_batch.Layouts.rec_output_BDIDs_batch l) := 
			TRANSFORM
				SELF.ID     := l.BDID;
				SELF.isBDID := TRUE;
				SELF        := l;
			END;

		bdids := PROJECT( AutoKeyB2_batch.Get_BDIDs_Batch(ds_input_grouped, 
																											autokeyname, 
																											skip_set, 
																											isBareAddr, 
																											workHard, 
																											nofail, 
																											isTestHarness), 
											xfm_make_BDIDs(LEFT) );
		 
		ids := dids + bdids;
		
		// 4. Remove fake ids from address matches based on whether the input record is a person or a company. That  
		//    is, we don't want to return company address matches if no company name was provided. And on the other 
		//    hand, we don't want to return a person's address if no lastname was provided. However, if neither a 
		//    lastname nor a companyname is present, it indicates an address-only search; we want to run those. 
		//		Constant values:  COMP_ADDRESS == 'Ac', PERSON_ADDRESS == 'A'
		ids_with_unwanted_address_matches_removed	:=
			JOIN(ids, ds_input_sorted,
					 LEFT.acctno = RIGHT.accountnumber AND	
					 (
						( NOT (RIGHT.cname = '' AND LEFT.matchcode = COMPANY_ADDRESS) AND 
						  NOT (RIGHT.lname = '' AND LEFT.matchcode = PERSON_ADDRESS) ) OR 
						(RIGHT.cname = '' AND RIGHT.lname = '') 
					 ),
					 TRANSFORM(AutokeyB2_batch.Layouts.rec_output_IDs_batch, SELF := LEFT;),
					 INNER);				 
			 			
		// 5. Sort...
		ds_sorted_ids := SORT(ids_with_unwanted_address_matches_removed, acctno, ID, matchcode);

		// 6. ... and roll up matchcodes, concatenating the matchCodes on adjacent records.
		AutokeyB2_batch.Layouts.rec_output_IDs_batch xfm_rollup_final_results(ds_sorted_ids l, ds_sorted_ids r) := 
			TRANSFORM
				SELF.matchCode := IF( r.matchCode != '' AND r.matchCode != l.matchcode, 
				                      TRIM((STRING10)(l.matchCode)) + r.matchCode, 
				                      l.matchCode);
				SELF           := l;
			END;

		ds_final_results := ROLLUP(ds_sorted_ids, xfm_rollup_final_results(LEFT, RIGHT), acctno, search_status, ID);	
		
		RETURN ds_final_results;
		
	END;
	