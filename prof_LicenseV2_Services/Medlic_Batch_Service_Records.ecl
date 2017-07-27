IMPORT AMS_Services, Autokey_batch, BatchServices, doxie, prof_LicenseV2_Services;

/* Moved almost all of the coding from prof_LicenseV2_Services.Medlic_Batch_Service  
   to this new function so this new function could be used by both the existing Medlic_Batch_Service
	 and the new (as of 06/01/2010) Medlic_PL_Combined_Batch_Service.
*/

EXPORT Medlic_Batch_Service_Records( UNSIGNED1 pt = 10, BOOLEAN useCannedRecs = FALSE, BOOLEAN running_Combined = FALSE) := 
  FUNCTION

  ipl := TRUE :STORED('IncludeProviders');

	batch_view := prof_LicenseV2_Services.Prof_Lic_Raw.Batch_View;
	pl_rec := Batch_View.pl_rec;
	id_rec := prof_LicenseV2_Services.Prof_Lic_Raw.Batch_View.id_rec;
	id_plus_Rec := prof_LicenseV2_Services.Prof_Lic_Raw.Batch_View.id_Plus_rec;
  
  
  //**** SAMPLE TEST FILE TRANSFORM
	sample_ML_recs := IF( running_Combined,
                        BatchServices._Sample_inBatchMaster( 'MedlicPL' ),
	                      BatchServices._Sample_inBatchMaster( 'Medlic' ) );
												
	test_ML_recs := PROJECT( sample_ML_recs, 
		                       TRANSFORM( pl_rec,
		                                  SELF := LEFT ) );


 
 //**** INPUT TRANSFORM
	// Store standard "batch_in" input dataset into a dataset in the 
	// MLPL "combined" service layout. 
	combo_rec       := prof_LicenseV2_Services.Layout_MLPL_Combined_Input;
  ds_batch_in_raw := DATASET( [], combo_rec ) : STORED( 'batch_in', FEW );

  // *** Pre-processing filtering.
	// If not running the MLPL combined batch service, include all input records., 
	// If running the MLPL combined batch service, only include input records 
	// that either have a non blank taxid or non blank license_number in the search 
	// criteria or that have a blank NPI; because the NPI field is a PL batch service
	// only search field and if we use input records intended for PL searching 
	// in this batch service we will still use any other input search criteria
	// that was entered and we might get false hits for the combined service.
  ds_batch_in_0 := ds_batch_in_raw( NOT running_combined OR
	                                  ( taxid<>'' OR license_number<>'' OR npi<>'' ) );
	
	ds_batch_in_1 := PROJECT( ds_batch_in_0, pl_rec );
	
	ds_batch_in := IF( NOT useCannedRecs, 
							       Batch_View.format_input(ds_batch_in_1),		 
							       Batch_View.format_input(test_ml_recs) );	
	
	//Project ds_batch_in into new format
	Recs := prof_LicenseV2_Services.Medlic_transform.processBatch(ds_batch_in,pt);
	return Recs;

END;