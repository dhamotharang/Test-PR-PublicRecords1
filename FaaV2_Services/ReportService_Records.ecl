
// general flow is this: takes id's (did's bdid's)...maybe aircraft number
// hits payload key...and then formats into layout expected ...sorts it
// after you fetch ID's...
// 
//

import AutoStandardI, FaaV2_Services, doxie, iesp, FCRA, FFD, Gateway;

  export ReportService_Records := module
	  export params := interface(
	 	  FAAV2_Services.ReportService_IDs.params,
		  AutoStandardI.LIBIN.PenaltyI_Indv.base,
		  AutoStandardI.InterfaceTranslator.glb_purpose.params,
		  AutoStandardI.InterfaceTranslator.dppa_purpose.params,
		  FCRA.iRules)
	  end;
	SHARED shared_val(params in_mod, boolean isFCRA=false) := function
		
		// Get the IDs, pull the payload records and add Aircraft_number (n_number to them.
		ids := faav2_services.ReportService_IDs.val(in_mod,isFCRA);
		// deep dive info is in the attribute ids one line above.
		
		// override
		ds_best := project(ids,transform(doxie.layout_best,self:=left,self:=[]));
		
		ds_flags := FCRA.GetFlagFile (ds_best);
		
		//FCRA FFD
		gateways := Gateway.Configuration.Get();
		boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_mod.FFDOptionsMask);
																			 
		dsDIDs := dataset([{FFD.Constants.SingleSearchAcctno,in_mod.did}],
												FFD.Layouts.DidBatch);
		pc_recs := if(isFCRA, FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Aircraft));

		slim_pc_recs := FFD.SlimPersonContext(pc_recs);
	
		recs := FaaV2_Services.Raw.getFullAircraft(project (ids, FaaV2_Services.layouts.search_id),
																								in_mod.applicationType,
																								isFCRA,ds_flags, , 
																								slim_pc_recs, in_mod.FFDOptionsMask);		
		// Format for output
		recs_fmt := FaaV2_Services.Functions.fnfaaReportval(recs);
		
		// Prepare the statements  
		statements_out := if(isFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);

 		// Sort.
		recs_sort := sort(recs_fmt, -dateLastSeen.year, -dateLastSeen.month, -dateLastSeen.day,record);
    tempresults_slim := project(recs_sort, iesp.faaaircraft_Fcra.t_FcraaircraftReportRecord);
		
		FFD.MAC.PrepareResultRecord(tempresults_slim, final_results, statements_out, iesp.faaaircraft_Fcra.t_FcraaircraftReportRecord); 
	
	return final_results;
	end;
		
		export val(params in_mod) := project(shared_val(in_mod, FALSE).records, iesp.faaAircraft.t_AircraftReportRecord);                            
		export fcra_val(params  in_mod) := shared_val(in_mod, TRUE);
end;
