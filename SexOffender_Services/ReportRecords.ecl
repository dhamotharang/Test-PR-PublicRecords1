import doxie, FCRA, FFD, iesp, Gateway;

export ReportRecords := module
	shared shared_val(SexOffender_Services.IParam.report in_mod, 
						 boolean isFCRA = false) := function
		
		// corrections on FCRA side require using overrides flag file. If isFCRA, then we have a DID in incoming in_params
		did_best := DATASET([transform (doxie.layout_best, self.did := (unsigned6) in_mod.did, self:=[])]);
		ds_flags := IF (IsFCRA, FCRA.GetFlagFile(did_best), fcra.compliance.blank_flagfile);
		
		//FCRA FFD

		boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_mod.FFDOptionsMask);

		dsDIDs := DATASET([{FFD.Constants.SingleSearchAcctno,(unsigned)in_mod.DID}],
																																FFD.Layouts.DidBatch);
		pc_recs := if(isFCRA, FFD.FetchPersonContext(dsDIDs, Gateway.Configuration.Get(), FFD.Constants.DataGroupSet.SexOffender));
	 
		slim_pc_recs := FFD.SlimPersonContext(pc_recs);
																			 
		
		//By Primary Key
		prim_key_recs := SexOffender_Services.Raw.REPORT_VIEW.by_primary_key(
								              DATASET ([{Stringlib.StringToUpperCase(in_mod.Primary_Key)}], 
								                       SexOffender_Services.layouts.search), 
												 		  in_mod);
		
		//By DID
		did_recs := SexOffender_Services.Raw.REPORT_VIEW.by_did(DATASET ([{(unsigned6)in_mod.did}], doxie.layout_references),
																														in_mod,
																														isFCRA, 
																														ds_flags,
																														slim_pc_recs,
																														in_mod.FFDOptionsMask);
															
    recs1 := MAP (in_mod.Primary_Key != '' => prim_key_recs,
								  (unsigned) in_mod.did != 0 => did_recs
								);
								
		recs := IF(isFCRA, did_recs, recs1); 
		
		statement_output := if(isFCRA and showConsumerStatements,FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
   			
		FFD.MAC.PrepareResultRecord(recs, final_results, statement_output, iesp.sexualoffender_fcra.t_FcraSexOffReportRecord); 
		
	 return final_results;
  end;
	
 export val(SexOffender_Services.IParam.report in_mod) := PROJECT(shared_val(in_mod, FALSE).Records, iesp.sexualoffender.t_SexOffReportRecord);                             
 export fcra_val(SexOffender_Services.IParam.report in_mod) := shared_val(in_mod, TRUE);

	
end;
