// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Returns GSA Excluded Parties / Verifications Search records.*/

IMPORT BatchServices, Autokey_batch;

EXPORT BatchService(useCannedRecs = 'false') :=
	MACRO
		//set parameters
		shared INTEGER max_results_per_acct    		:= GSA_Services.Constants.MAX_RESULTS_DEFAULT : STORED('Max_Results_Per_Acct');
		INTEGER penalt_val					    		:= 0 : STORED('PenaltyThreshold');
		#stored('PenaltThreshold',penalt_val);

		//input processing
		ds_xml_in      := DATASET([], Autokey_batch.Layouts.rec_inBatchMaster) : STORED('batch_in', FEW);
		ds_xml_cleaned := PROJECT(ds_xml_in, BatchServices.transforms.xfm_capitalize_input(LEFT));
		shared ds_batch_in    := IF( NOT useCannedRecs,ds_xml_cleaned,BatchServices._Sample_inBatchMaster('') );

		ds_in := project(project(ds_batch_in,transform(Autokey_batch.Layouts.rec_inBatchMaster,self.seq:=counter,self:=left)),GSA_Services.Layouts.gsa_rec_inBatchMaster);

		//search and return flat record set
		outrecs := GSA_Services.BatchService_Records(ds_in).ds_outRecs;

		//apply batch output transform
		ds_outrecs_1 := project(outrecs, gsa_services.Transforms.xfm_GSA_make_flat(left));

		//apply max_results_per_acct filter.
		ds_outrecs := TOPN(GROUP(ds_outrecs_1,acctno), max_results_per_acct, acctno);

		//Append input to results
		ds_output := join(ds_outrecs, ds_batch_in,
														left.acctno = right.acctno,
														transform(gsa_services.Layouts.batchInputAndResults,self:=right,self:=left));

		//display named output Results.
		ut.mac_TrimFields(ds_output, 'ds_output', result);
		OUTPUT(result, NAMED('Results'));

	ENDMACRO;
