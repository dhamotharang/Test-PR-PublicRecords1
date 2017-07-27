
IMPORT Autokey_batch;

EXPORT Get_DIDs_Batch(GROUPED DATASET(Autokey_batch.Layouts.rec_Cleaned_Input_Record) ds_in, 
											STRING t, 
											SET OF STRING1 skip_set = [],
											BOOLEAN isBareAddr = FALSE, 
											BOOLEAN workHard = FALSE,
											BOOLEAN nofail = TRUE,
											BOOLEAN useAllLookups = FALSE,
											BOOLEAN isTestHarness = FALSE) := 
	FUNCTION

		//***** BOOLEANS TO DIRECT THE ACTION
		BOOLEAN skip_all := 'C' IN skip_set;
		BOOLEAN skip_ssn := 'S' IN skip_set;
		BOOLEAN skip_phn := 'P' IN skip_set;
		BOOLEAN skip_zip := 'Z' IN skip_set;
		BOOLEAN  add_zpl := '-' IN skip_set;

		// 0. Transform to rec_DID_InBatch.
		ds_DID_InBatch := PROJECT(ds_in, Autokey_batch.Transforms.xfm_convert_for_getting_DIDs(LEFT));
		
		// 1.  Obtain the set of zipcodes that are valid for the city name, state, single zipcode and zip radius.
		ds_input := PROJECT(ds_DID_InBatch, Autokey_batch.Transforms.xfm_add_zip_set(LEFT));
				
		// 2. Run autokey fetches.
		ds_results := 
			IF( NOT skip_all,                  Autokey_batch.Fetch_Address_Batch( ds_input, t, workHard, nofail, isTestHarness ) ) +
			IF( NOT skip_all,                  Autokey_batch.Fetch_Name_Batch( ds_input, t, workHard, nofail, isTestHarness ) ) +
			IF( NOT skip_all AND NOT skip_phn, Autokey_batch.Fetch_Phone_Batch( ds_input, t, workHard, nofail, useAllLookups, isTestHarness ) ) +							
			IF( NOT skip_all AND NOT skip_ssn, Autokey_batch.Fetch_SSN_Batch( ds_input, t, workHard, nofail, useAllLookups, isTestHarness ) ) +
			IF( NOT skip_all,                  Autokey_batch.Fetch_StCityFLName_Batch( ds_input, t, workHard, nofail, isTestHarness ) ) +
			IF( NOT skip_all,                  Autokey_batch.Fetch_StFLName_Batch( ds_input, t, workHard, nofail, isTestHarness ) ) +
			IF( NOT skip_all AND NOT skip_zip, Autokey_batch.Fetch_Zip_Batch( ds_input, t, workHard, nofail, isTestHarness ) ) +
			IF( NOT skip_all AND add_zpl,      Autokey_batch.Fetch_ZipPRLName_Batch( ds_input, t, workHard, nofail, isTestHarness ) )
		;		
								
		// 3. Sort and return.
		ds_sorted_results  := SORT(UNGROUP(ds_results), acctno, search_status, matchcode, did); 			

		RETURN ds_sorted_results;

	END;
