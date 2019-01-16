EXPORT fetch_ADLBest_recs(ds_batch_in,in_mod) := FUNCTIONMACRO
		IMPORT DidVille,BatchDatasets;
		// Basis: DidVille.Did_Batch_Service_Raw
	
		// 1. Transform to input dataset...
		data_in := PROJECT(ds_batch_in, BatchDatasets.Transforms.xfm_to_BestADL_batchIn(LEFT,COUNTER));
		
		// 2. ...and call function located in DidVille.Did_Batch_Service_Raw to get 
		// ADLBest records and return.
		DidVille.Layout_Did_OutBatch ds_results :=  
				DidVille.did_service_common_function(
					file_in            := data_in,
					appends_value      := 'BEST_ALL,VERIFY_ALL',
					verify_value       := 'BEST_ALL,VERIFY_ALL',
					glb_flag           := TRUE,
					glb_purpose_value  := in_mod.GLBPurpose,
					include_minors     := in_mod.IncludeMinors,
					appType            := in_mod.ApplicationType,
					dppa_purpose_value := in_mod.DPPAPurpose,
					IndustryClass_val  := in_mod.industryclass,
					DRM_val            := in_mod.DataRestrictionMask,
					GetSSNBest         := in_mod.GetSSNBest
        );
		RETURN ds_results;
ENDMACRO;