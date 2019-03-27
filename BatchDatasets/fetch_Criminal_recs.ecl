
IMPORT BatchShare, CriminalRecords_BatchService, Doxie;

/*
It is the responsibility of the calling attribute to set the following STORED values:

		#STORED('MaxResults',[ numeric value ]);

		The #STORED value above is read from global scope by BatchServices
		.Batch_Service_Records. They cannot be passed as formal parameters.
*/
EXPORT fetch_Criminal_recs( DATASET(doxie.layout_references_acctno) ds_acctno_refs ) :=
	FUNCTION
		batch_params := BatchShare.IParam.getBatchParamsV2();
		
		crim_batch_params := MODULE( PROJECT(batch_params, CriminalRecords_BatchService.IParam.batch_params, OPT) )	
			UNSIGNED2 MaxResults_val := 50 : STORED('MaxResults');
		end;

		ds_batch_in := PROJECT( ds_acctno_refs, Transforms.xfm_to_Criminal_batchIn(LEFT) );
		
		ds_batch_out_all := CriminalRecords_BatchService.BatchRecords(crim_batch_params, ds_batch_in);

		ds_batch_out := ds_batch_out_all.Records;

		RETURN ds_batch_out(did != 0);
	END;
  