import AutoStandardI, doxie, iesp, fcra, FAAV2_PilotServices, FFD, Gateway;

export ReportService_Records := module
	export params := interface(
		FAAV2_PilotServices.ReportService_IDs.params,
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
		FCRA.iRules)
    export string32 ApplicationType;
	end;
	
	shared shared_val(params in_mod,boolean isFCRA = false) := function		

		// Get the IDs, pull the payload records 
	ids_temp := faav2_pilotServices.ReportService_IDs.val(in_mod,isFCRA);
	ids := if(in_mod.airmen_id = 0, ids_temp, ids_temp(airmen_id = in_mod.airmen_id));
		
	
	  //Get FCRA files
	ds_best := project(ids,transform(doxie.layout_best,self:=left,self:=[]));
	ds_flags := if(isFCRA, FCRA.GetFlagFile (ds_best));
	
	//FCRA FFD
	gateways := Gateway.Configuration.Get();
	boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_mod.FFDOptionsMask);
																			 
	// 1) Get the DID 
	dsDIDs := dataset([{FFD.Constants.SingleSearchAcctno,in_mod.did}],
												FFD.Layouts.DidBatch);
	
	// 2) Call the person context
	pc_recs := if(isFCRA, FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Pilot));
	// 3)Slim down the PersonContext
	slim_pc_recs := FFD.SlimPersonContext(pc_recs);
	
	// 4) Send the slim PersonContext
  pilot_final_recs_sorted := faav2_pilotservices.raw.getReportByID(ids, 
																																	in_mod.applicationtype, 
																																	isFCRA, 
																																	ds_flags, 
																																	slim_pc_recs, 
																																	in_mod.FFDOptionsMask);
		
	// 5) Make the statements
   																		
  statement_output := if(isFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
  	
	iesp.faaPilot_fcra.t_FcraPilotReportResponse  xform_final_response(iesp.faapilot_Fcra.t_FcraPilotReportRecord l) := transform		                                                                                                        
                              self._Header   := iesp.ECL2ESP.GetHeaderRow(),
															self.FAAPilot  := l,
															self.FAAPilots := l.certificates,
															self.ConsumerStatements := statement_output
	end;
		
		// project into final response form here so that certificates is still available
		// to place into final structure.
		
	temp_results_structure := project (choosen (pilot_final_recs_sorted, 1), xform_final_response(left));
	
	return temp_results_structure;
		
	end;
	
		export val(params in_mod) := project(shared_val(in_mod, FALSE), iesp.faapilot.t_PilotReportResponse);                             
		export fcra_val(params in_mod) := shared_val(in_mod, TRUE);
		
end;
