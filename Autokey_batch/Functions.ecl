
IMPORT Autokey_batch, business_header, Doxie, NID;

EXPORT Functions := MODULE
			
	EXPORT pfe(STRING20 l, STRING20 r) := NID.mod_PFirstTools.SubLinPFR(l,r);
			
	// The following function converts a dataset of canned sample data from its inherent record layout
	// (Autokey_batch.Layouts.rec_Batch_Input_Record) to doxie.layout_inBatchMaster. This is required
	// if we want to pass the canned samples to AutokeyB2_batch.Get_IDs_Batch().
	EXPORT fn_Convert_Samples_to_inBatchMaster(DATASET(Autokey_batch.Layouts.rec_Batch_Input_Record) ds_canned_records,
	                                           BOOLEAN isTestHarness = FALSE, 
																						 BOOLEAN useCannedTestData = FALSE) :=
		FUNCTION
			ds_canned_prepped_for_clean := PROJECT(ds_canned_records, Autokey_Batch.Transforms.xfm_preclean_batch(LEFT));
			ds_canned_clean             := PROJECT(ds_canned_prepped_for_clean, Autokey_Batch.Transforms.xfm_clean_batch(LEFT));
			ds_canned_inBatchMaster     := PROJECT(ds_canned_clean, Autokey_Batch.Transforms.xfm_to_inBatchMaster(LEFT));
			
			// ***** Debugs and diagnostics. *****
			IF( isTestHarness AND useCannedTestData, OUTPUT(ds_canned_records,           NAMED('ds_canned_records')) );
			IF( isTestHarness AND useCannedTestData, OUTPUT(ds_canned_prepped_for_clean, NAMED('ds_canned_prepped_for_clean')) );
			IF( isTestHarness AND useCannedTestData, OUTPUT(ds_canned_clean,             NAMED('ds_canned_clean')) );
			IF( isTestHarness AND useCannedTestData, OUTPUT(ds_canned_inBatchMaster,     NAMED('ds_canned_inBatchMaster')) );
			
			RETURN ds_canned_inBatchMaster;
		END;
	
	
	// The following function loads into a dataset all the pertinent values found
	// in doxie.mac_header_field_declare. The field 'acctno' is used primarily for
	// batch operations; but we'll simply populate it with a semi-meaningful value.		
	// For single, online transactions being converted to a single-record dataset
	// to process through batchified autokey fetches.
	EXPORT fn_LoadDoxieMacHeaderValues() := 
		FUNCTION
				
			business_header.doxie_MAC_Field_Declare()
			
			rec_acctno :=
				RECORD
					STRING30 acctno := '';
				END;
				
			Autokey_batch.Layouts.rec_DID_InBatch xfm_Load_Values(rec_acctno le) :=
				TRANSFORM
			
					SELF.acctno              := le.acctno;
					
					// --- SYSTEM BOOLEANS ---

					SELF.addr_error_value    := addr_error_value;
					SELF.addr_loose          := addr_loose;  
					SELF.nicknames           := nicknames;  
					SELF.phonetics           := phonetics;  
					SELF.fuzzy_ssn           := fuzzy_ssn;

					// --- SYSTEM VALUES ---

					SELF.did_value           := did_value; 
					SELF.lookup_value        := lookup_value; 
					SELF.lookup_value2       := lookup_value2; 

					// --- NAME INFORMATION ---

					SELF.fname_value         := fname_value;
					SELF.lname_value         := lname_value;
					SELF.mname_value         := mname_value;
					SELF.other_lname_value1  := other_lname_value1;
					
					SELF.comp_name_value     := comp_name_value;

					// --- INFORMATION ---

					SELF.rel_fname_value1    := rel_fname_value1;
					SELF.rel_fname_value2    := rel_fname_value2;

					// --- ADDRESS INFORMATION ---

					SELF.prange_value        := prange_value;
					SELF.predir_value        := predir_value;
					SELF.pname_value         := pname_value;
					SELF.addr_suffix_value   := addr_suffix_value;
					SELF.postdir_value       := postdir_value;					
					SELF.sec_range_value     := sec_range_value;
							
					SELF.city_value          := city_value;
					SELF.other_city_value    := other_city_value;
					SELF.city_codes_set      := city_codes_set;
					
					SELF.state_value         := state_value;
					SELF.prev_state_val1     := prev_state_val1;
					SELF.prev_state_val2     := prev_state_val2;
					
					SELF.zip_val             := zip_val;
					SELF.zipradius_value     := zipradius_value;
					SELF.zip_value           := zip_value;			

					// --- PHONE INFORMATION ---

					SELF.phone_value         := phone_value;

					// --- DOB INFORMATION ---

					SELF.find_day            :=  find_day;
					SELF.find_month          :=  find_month; 
					SELF.find_year_high      :=  find_year_high;
					SELF.find_year_low       :=  find_year_low;

					// --- SSN INFORMATION ---

					SELF.ssn_value           := ssn_value;
							 
				END;
			
			ds_acctno := DATASET( [{'single-transaction'}], {rec_acctno} );
							 
			ds := PROJECT( ds_acctno, xfm_Load_Values(LEFT) );

			RETURN ds;
			
		END;	
	
	
	// ***** For test harness only. The reason for this function at all is to assist a test harness--it 
	// will display the left and right datasets combined. That is, the original input records along with 
	// their corresponding DIDs, match codes, and search statuses. Should be useful for debugging.
	EXPORT Display_Matched_Input_And_Output( 
					GROUPED DATASET(Autokey_batch.Layouts.rec_DID_InBatch) ds_in, 
					DATASET(Autokey_batch.Layouts.rec_DID_OutBatch) ds_results) := 
		FUNCTION		
		
				rec_combined := 
					RECORD
						Autokey_batch.Layouts.rec_DID_InBatch  OR
						Autokey_batch.Layouts.rec_DID_OutBatch AND NOT [acctno];
					END;
				
				rec_combined xfm_combine_datasets(ds_in l, ds_results r) := TRANSFORM
					SELF := l;
					SELF := r;
				END;
				
				ds_out := JOIN(ds_in, 
											 ds_results, 
											 LEFT.acctno = RIGHT.acctno, 
											 xfm_combine_datasets(LEFT, RIGHT), 
											 LIMIT(2500), 
											 LEFT OUTER);	
				RETURN ds_out;
			
		END;	
	
END;