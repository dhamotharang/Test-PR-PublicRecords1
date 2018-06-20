import doxie, FCRA, FFD, iesp, Gateway;

export ReportRecords := module
  shared shared_val(SexOffender_Services.IParam.report in_mod, 
             boolean isFCRA = false) := function
    
    // corrections on FCRA side require using overrides flag file. If isFCRA, then we have a DID in incoming in_params
    did_best := DATASET([transform (doxie.layout_best, self.did := (unsigned6) in_mod.did, self:=[])]);
    
    //FCRA FFD

    boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_mod.FFDOptionsMask);

    dsDIDs := DATASET([{FFD.Constants.SingleSearchAcctno,(unsigned)in_mod.DID}],
                                                                FFD.Layouts.DidBatch);
    pc_recs := if(isFCRA, FFD.FetchPersonContext(dsDIDs, Gateway.Configuration.Get(), FFD.Constants.DataGroupSet.SexOffender, in_mod.FFDOptionsMask));
   
    slim_pc_recs := FFD.SlimPersonContext(pc_recs);
                                       
    ds_flags := IF (IsFCRA, FFD.GetFlagFile(did_best, pc_recs), FCRA.compliance.blank_flagfile);
    
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
                
    recs_pre := IF(isFCRA, did_recs, recs1); 
    
    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_mod.FCRAPurpose, in_mod.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;
    recs := if(suppress_results_due_alerts, dataset([], iesp.sexualoffender_fcra.t_FcraSexOffReportRecord), recs_pre);

    consumer_statements := if(isFCRA and showConsumerStatements,FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
    consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_mod.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
         
    FFD.MAC.PrepareResultRecord(recs, final_results, consumer_statements, consumer_alerts, iesp.sexualoffender_fcra.t_FcraSexOffReportRecord); 
    
   return final_results;
  end;
  
 export val(SexOffender_Services.IParam.report in_mod) := PROJECT(shared_val(in_mod, FALSE).Records, iesp.sexualoffender.t_SexOffReportRecord);                             
 export fcra_val(SexOffender_Services.IParam.report in_mod) := shared_val(in_mod, TRUE);

  
end;
