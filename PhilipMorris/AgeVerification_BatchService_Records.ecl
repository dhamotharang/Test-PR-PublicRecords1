TF := PhilipMorris.Transforms;

EXPORT AgeVerification_BatchService_Records() := FUNCTION

	inputData := DATASET([], PhilipMorris.Layouts_Batch.InRecord) : stored('batch_in', few);
	UNSIGNED1 DPPA_Purpose := 0 :STORED('DPPAPurpose');
	UNSIGNED1 GLB_Purpose  := 0 :STORED('GLBPurpose');
	BOOLEAN skipRestrictionsCall       := FALSE : STORED('SkipRestrictionsCall');
	BOOLEAN allowProbationSources      := FALSE : STORED('AllowProbationSources');
	BOOLEAN runFailureReport           := TRUE : STORED('RunFailureReport');
	
	ds_batch_in := inputData;
	// ds_batch_in := PhilipMorris._Sample_records;
	
	ds_batch_in_std := PROJECT(ds_batch_in, TF.xfm_standardize_input_for_batch(LEFT));
	ds_batch_out := PhilipMorris.fn_PmAgeVerify(ds_batch_in_std, true, DPPA_Purpose, GLB_Purpose, skipRestrictionsCall, allowProbationSources, runFailureReport);
			
	RETURN PROJECT(ds_batch_out, TF.xfm_flatten_output_for_batch(LEFT));
	
END;												