
import Autokey_batch, AutokeyB2_batch;

export Get_BDIDs_Batch(GROUPED DATASET(Autokey_batch.Layouts.rec_Cleaned_Input_Record) ds_in, 
												STRING t, 
												SET OF STRING1 skip_set = [],
												BOOLEAN isBareAddr = FALSE, 
												BOOLEAN workHard = FALSE,
												BOOLEAN nofail = TRUE,
												BOOLEAN isTestHarness = FALSE) := 
	FUNCTION
	
		//***** BOOLEANS TO DIRECT THE ACTION
		BOOLEAN skip_all  := 'B' in skip_set;
		BOOLEAN skip_fein := 'F' in skip_set;
		BOOLEAN skip_phn  := 'Q' in skip_set;
		BOOLEAN skip_zip  := 'Z' in skip_set;
		BOOLEAN skip_addr := isBareAddr;	
		
		// 0. Transform to rec_BDID_InBatch.
		ds_BDID_InBatch := PROJECT(ds_in, AutokeyB2_batch.Transforms.xfm_convert_for_getting_BDIDs(LEFT));
				
		// 1.  Obtain the set of zipcodes that are valid for the city name, state, single zipcode and zip radius.
		ds_input_with_ZipSet := PROJECT(ds_BDID_InBatch, AutokeyB2_batch.Transforms.xfm_add_zip_set(LEFT));
		
		// 2.  Parse the input company name into indic and sec values.
		ds_input := PROJECT(ds_input_with_ZipSet, AutokeyB2_batch.Transforms.xfm_parse_companyname(LEFT));
		
		// 3. Run autokey fetches.
		ds_results := 
			IF( NOT skip_all,                                    AutokeyB2_batch.Fetch_Name_Batch( ds_input, t, workHard, nofail, isTestHarness ) ) +
			IF( NOT skip_all,                                    AutokeyB2_batch.Fetch_NameWords_Batch( ds_input, t, workHard, nofail, isTestHarness ) ) +
			IF( NOT skip_all AND NOT skip_addr,                  AutokeyB2_batch.Fetch_Address_Batch( ds_input, t, workHard, nofail, isTestHarness ) ) +
			IF( NOT skip_all AND NOT skip_addr,                  AutokeyB2_batch.Fetch_StName_Batch( ds_input, t, workHard, nofail, isTestHarness ) ) +
			IF( NOT skip_all AND NOT skip_addr,                  AutokeyB2_batch.Fetch_StCityFLName_Batch( ds_input, t, workHard, nofail, isTestHarness ) ) + 
			IF( NOT skip_all AND NOT skip_addr AND NOT skip_zip, AutokeyB2_batch.Fetch_Zip_Batch( ds_input, t, workHard, nofail, isTestHarness ) ) +
			IF( NOT skip_all AND NOT skip_fein,                  AutokeyB2_batch.Fetch_FEIN_Batch( ds_input, t, workHard, nofail, isTestHarness ) ) +
			IF( NOT skip_all AND NOT skip_phn,                   AutokeyB2_batch.Fetch_Phone_Batch( ds_input, t, workHard, nofail, isTestHarness ) )
		;

		// 4. Sort and return.
		ds_sorted_results  := SORT(UNGROUP(ds_results), acctno, search_status, matchcode, bdid);

		RETURN ds_sorted_results;

	END;
