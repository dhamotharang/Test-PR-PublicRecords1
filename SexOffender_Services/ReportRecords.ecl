IMPORT doxie, FCRA, FFD, iesp, Gateway, STD;

EXPORT ReportRecords := MODULE
  SHARED shared_val(SexOffender_Services.IParam.report in_mod,
             BOOLEAN isFCRA = FALSE) := FUNCTION
    
    // corrections on FCRA side require using overrides flag file. If isFCRA, then we have a DID in incoming in_params
    did_best := DATASET([TRANSFORM (doxie.layout_best, SELF.did := (UNSIGNED6) in_mod.did, SELF:=[])]);
    
    //FCRA FFD

    BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_mod.FFDOptionsMask);

    dsDIDs := DATASET([{FFD.Constants.SingleSearchAcctno, (UNSIGNED)in_mod.DID}],
                       FFD.Layouts.DidBatch);
    pc_recs := IF(isFCRA, 
      FFD.FetchPersonContext(dsDIDs, 
                             Gateway.Configuration.Get(), 
                             FFD.Constants.DataGroupSet.SexOffender, 
                             in_mod.FFDOptionsMask)
      );
   
    slim_pc_recs := FFD.SlimPersonContext(pc_recs);
                                       
    ds_flags := IF (IsFCRA, FFD.GetFlagFile(did_best, pc_recs), FCRA.compliance.blank_flagfile);
    
    //By Primary Key
    prim_key_recs := SexOffender_Services.Raw.REPORT_VIEW.by_primary_key(
                              DATASET ([{STD.Str.ToUpperCase(in_mod.Primary_Key)}],
                                       SexOffender_Services.layouts.search),
                               in_mod);
    
    //By DID
    did_recs := SexOffender_Services.Raw.REPORT_VIEW.by_did(DATASET ([{(UNSIGNED6)in_mod.did}], doxie.layout_references),
                                                            in_mod,
                                                            isFCRA,
                                                            ds_flags,
                                                            slim_pc_recs);
                              
    recs1 := MAP (
      in_mod.Primary_Key != '' => prim_key_recs,
      (UNSIGNED) in_mod.did != 0 => did_recs
    );
                
    recs_pre := IF(isFCRA, did_recs, recs1);
    
    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_mod.FCRAPurpose, in_mod.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA AND alert_indicators.suppress_records;
    recs := IF(suppress_results_due_alerts, DATASET([], iesp.sexualoffender_fcra.t_FcraSexOffReportRecord), recs_pre);

    consumer_statements := IF(isFCRA AND showConsumerStatements,FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
    consumer_alerts := IF(isFCRA, 
      FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_mod.FFDOptionsMask), 
      FFD.Constants.BlankConsumerAlerts);
         
    FFD.MAC.PrepareResultRecord(recs, final_results, consumer_statements, consumer_alerts, iesp.sexualoffender_fcra.t_FcraSexOffReportRecord);
    
   RETURN final_results;
  END;
  
  EXPORT val(SexOffender_Services.IParam.report in_mod) := PROJECT(shared_val(in_mod, FALSE).Records, iesp.sexualoffender.t_SexOffReportRecord);
  EXPORT fcra_val(SexOffender_Services.IParam.report in_mod) := shared_val(in_mod, TRUE);
  
END;
