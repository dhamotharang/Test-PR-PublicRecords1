IMPORT $, doxie, suppress, iesp, SexOffender_Services, fcra, FFD;

EXPORT ReportService_Records := MODULE
  
  EXPORT applyRulesAndFormatCrimRecs(DATASET(layouts.l_raw) recs,
                                     CriminalRecords_Services.IParam.report in_mod,
                                     BOOLEAN IsFCRA = FALSE,
                                     DATASET (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                                     DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim
                                     ) := FUNCTION
    mod_access := PROJECT(in_mod, doxie.IDataAccess);

    Suppress.MAC_Suppress(recs,pull_1,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did, isFCRA := isFCRA);
    Suppress.MAC_Suppress(pull_1,pull_2,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,ssn, isFCRA := isFCRA);
    Suppress.MAC_Suppress(pull_2,pull_3,mod_access.application_type,,,Suppress.Constants.DocTypes.OffenderKey,offender_key, isFCRA := isFCRA);
    
    doxie.MAC_PruneOldSSNs(pull_3, out_f_p1, ssn, did, isFCRA);
    doxie.MAC_PruneOldSSNs(out_f_p1, out_cleaned, ssn_appended, did, isFCRA);

    suppress.MAC_Mask(out_cleaned, out_intm, ssn, blank, TRUE, FALSE, maskVal := mod_access.ssn_mask);
    suppress.MAC_Mask(out_intm, out_mskd, ssn_appended, blank, TRUE, FALSE, maskVal := mod_access.ssn_mask);
    
    // Format for output
    added_in_mod := PROJECT(in_mod, $.functions.params);
    recs_fmt := CriminalRecords_Services.Functions.fnCrimReportVal(out_mskd, added_in_mod, IsFCRA, flagfile, slim_pc_recs, in_mod.FFDOptionsMask);
    
    dids_list := PROJECT (recs (did != ''), TRANSFORM (doxie.layout_references, SELF.did := (UNSIGNED6) LEFT.did));
    user_input:= DATASET([{(UNSIGNED6)in_mod.did}],doxie.layout_references)(did > 0);
    dedup_dids:=DEDUP (dids_list+user_input, did, ALL);

    in_mod_sex_offenders:=PROJECT(in_mod, SexOffender_Services.IParam.report);
    // Note : below line needs to change once SO is also FFD ready
    sex_offender_rpt:=SexOffender_Services.Raw.REPORT_VIEW.by_did(dedup_dids, in_mod_sex_offenders, isFCRA, flagfile, slim_pc_recs);
    
    iesp.criminal_fcra.t_FcraCriminalReportResponse final_xform() := TRANSFORM
      SELF._Header := iesp.ECL2ESP.GetHeaderRow();
      SELF.SexualOffenses := CHOOSEN(IF(in_mod.IncludeSexualOffenses,sex_offender_rpt),iesp.Constants.SEXOFF_MAX_COUNT_REPORT_RESPONSE_RECORDS);
      SELF.CriminalRecords := CHOOSEN(recs_fmt,iesp.constants.CRIM.MaxReportRecords);
      SELF.ConsumerStatements := FFD.Constants.BlankConsumerStatements;
      SELF.ConsumerAlerts := FFD.Constants.BlankConsumerAlerts;
      SELF := [];
    END;
    final_proj:=DATASET([final_xform()]);
    
    RETURN final_proj;
    
  END;
    
  EXPORT val(CriminalRecords_Services.IParam.report in_params,
             BOOLEAN isFCRA = FALSE,
             DATASET (FFD.Layouts.PersonContextBatch) in_pc_recs = DATASET ([],FFD.Layouts.PersonContextBatch))
  := FUNCTION
    
    // corrections on FCRA side require using overrides flag file. If isFCRA, then we have a DID in incoming in_params
    did_best := IF(isFCRA, PROJECT(DATASET([{in_params.did}], doxie.layout_references), TRANSFORM(doxie.layout_best, SELF:=LEFT,SELF:=[])));
    
    BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);
    BOOLEAN skipPersonContextCall := in_params.SkipPersonContextCall OR ~isFCRA;
    
    ds_dids := PROJECT(did_best, TRANSFORM(FFD.Layouts.DidBatch, SELF.acctno := FFD.Constants.SingleSearchAcctno, SELF := LEFT));

    pc_recs := IF(skipPersonContextCall, in_pc_recs(datagroup IN FFD.Constants.DataGroupSet.Criminal),
      FFD.FetchPersonContext(ds_dids, in_params.gateways, FFD.Constants.DataGroupSet.Criminal, in_params.FFDOptionsMask));
    
    slim_pc_recs := FFD.SlimPersonContext(pc_recs);
                
    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_params.FCRAPurpose, in_params.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA AND alert_indicators.suppress_records;
   
    ds_flags := IF (isFCRA, FFD.GetFlagFile(did_best, pc_recs), FCRA.compliance.blank_flagfile);
  
    is_cnsmr := in_params.isConsumer();
        
    ids := CriminalRecords_Services.ReportService_ids.val(in_params, isFCRA, ds_flags);
    recs:= CriminalRecords_Services.Raw.getOffenderRaw(ids, isFCRA, ds_flags, slim_pc_recs, in_params.FFDOptionsMask, is_cnsmr);

    result := applyRulesAndFormatCrimRecs(recs, in_params, isFCRA, ds_flags, slim_pc_recs);
    
    consumer_statements_all := IF(isFCRA AND showConsumerStatements, FFD.prepareConsumerStatements(pc_recs),
                                  FFD.Constants.BlankConsumerStatements);
                                  
    has_consumer_data := ~suppress_results_due_alerts AND (EXISTS(result[1].SexualOffenses) OR EXISTS(result[1].CriminalRecords));
    
    consumer_alerts := IF(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_params.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
    
    consumer_statements := consumer_statements_all(has_consumer_data OR StatementType IN FFD.Constants.RecordType.StatementConsumerLevel);
    
    input_consumer := FFD.MAC.PrepareConsumerRecord(in_params.did, TRUE);

    FFD.MAC.AppendConsumerAlertsAndStatements(result, result_all, consumer_statements, consumer_alerts, input_consumer, iesp.criminal_fcra.t_FcraCriminalReportResponse);
        
    iesp.criminal_fcra.t_FcraCriminalReportResponse null_xform() := TRANSFORM
      SELF._Header := iesp.ECL2ESP.GetHeaderRow();
      SELF.SexualOffenses := [];
      SELF.CriminalRecords := [];
      SELF.ConsumerStatements := consumer_statements;
      SELF.ConsumerAlerts := consumer_alerts;
      SELF.Consumer := input_consumer;
    END;
    null_result:=DATASET([null_xform()]);
    
    result_final:= IF(suppress_results_due_alerts,null_result,result_all);
    
    RETURN result_final;
  END;
  
END;
