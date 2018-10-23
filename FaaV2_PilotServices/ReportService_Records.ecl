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
    
  
  ds_best := project(ids,transform(doxie.layout_best,self:=left,self:=[]));
  
  //FCRA FFD
  gateways := Gateway.Configuration.Get();
  boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_mod.FFDOptionsMask);
                                       
  // Get the DID 
  dsDIDs := dataset([{FFD.Constants.SingleSearchAcctno,in_mod.did}],
                        FFD.Layouts.DidBatch);
  
  // Call the person context
  pc_recs := if(isFCRA, FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Pilot, in_mod.FFDOptionsMask));
  
  // Slim down the PersonContext
  slim_pc_recs := FFD.SlimPersonContext(pc_recs);
  
  //Get FCRA files
  ds_flags := if(isFCRA, FFD.GetFlagFile (ds_best, pc_recs));
  
  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_mod.FCRAPurpose, in_mod.FFDOptionsMask)[1];
  suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;
  
  // Send the slim PersonContext
  pilot_final_recs_sorted := faav2_pilotservices.raw.getReportByID(ids, 
                                                                  in_mod.applicationtype, 
                                                                  isFCRA, 
                                                                  ds_flags, 
                                                                  slim_pc_recs, 
                                                                  in_mod.FFDOptionsMask);
    
  statement_output := if(isFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
  consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_mod.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
  has_consumer_data := ~suppress_results_due_alerts and exists(pilot_final_recs_sorted);
  consumer_statements := statement_output(has_consumer_data  OR StatementType IN FFD.Constants.RecordType.StatementConsumerLevel);
  input_consumer := FFD.MAC.PrepareConsumerRecord(in_mod.did, true);
    
  iesp.faaPilot_fcra.t_FcraPilotReportResponse  xform_final_response() := transform                                                                                                            
                              self._Header   := iesp.ECL2ESP.GetHeaderRow(),
                              self.FAAPilot  := if(~suppress_results_due_alerts,pilot_final_recs_sorted[1]),
                              self.FAAPilots := if(~suppress_results_due_alerts,pilot_final_recs_sorted[1].certificates),
                              self.ConsumerStatements := consumer_statements,
                              self.ConsumerAlerts := consumer_alerts,
                              self.Consumer := input_consumer
  end;
    
  temp_results_structure:=dataset([xform_final_response()]);
 
  return temp_results_structure;
    
  end;
  
  export val(params in_mod) := project(shared_val(in_mod, FALSE), iesp.faapilot.t_PilotReportResponse);                             
  export fcra_val(params in_mod) := shared_val(in_mod, TRUE);
    
end;
