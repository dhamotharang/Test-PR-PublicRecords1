// get the fids
import suppress, FCRA, FFD, Gateway, iesp, LN_PropertyV2_Services;
export ReportService_records (boolean isFCRA = false,
															integer nonSS = suppress.Constants.NonSubjectSuppression.doNothing,
															FCRA.iRules in_params = module(FCRA.iRules) end ) := function

		boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);
		gateways := Gateway.Configuration.Get();

		// FFD 
		// 1) we are using the subject DID rather than the Best DID 
		ds_dids := dataset([{FFD.Constants.SingleSearchAcctno,(unsigned)input.did}],FFD.Layouts.DidBatch);
			
		// 2) Call the person context		
		pc_recs := if(isFCRA, FFD.FetchPersonContext(ds_dids, gateways, FFD.Constants.DataGroupSet.Property));

		// 3) Slim down the PersonContext				 
		slim_pc_recs := FFD.SlimPersonContext(pc_recs);														
																	
		fids := LN_PropertyV2_Services.ReportService_ids(input.did, input.bdid, input.parcelID, 
																										 input.faresId,,,isFCRA);

		// generate the report
		results := LN_PropertyV2_Services.resultFmt.widest_view.get_by_fid(fids,,,nonSS,isFCRA,slim_pc_recs,in_params.FFDOptionsMask);

		// 5) Make the statements
		// Here we are interested only in the record statements or consumer level statements. 
		consumer_statements := if(isFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
				
		FFD.MAC.PrepareResultRecord(results, results_combined, consumer_statements, FFD.Constants.BlankConsumerAlerts, 
																LN_PropertyV2_Services.layouts.combined.widest);
				 
		return results_combined;
end;
