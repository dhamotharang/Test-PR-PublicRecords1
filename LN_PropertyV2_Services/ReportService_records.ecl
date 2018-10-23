// get the fids
import doxie, suppress, FCRA, FFD, Gateway, iesp, LN_PropertyV2_Services;

export ReportService_records (boolean isFCRA = false,
                              integer nonSS = suppress.Constants.NonSubjectSuppression.doNothing,
                              FCRA.iRules in_params = module(FCRA.iRules) end ) := function

    boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);
    gateways := Gateway.Configuration.Get();

    // FFD 
    // 1) we are using the subject DID rather than the Best DID 
    ds_dids := dataset([{FFD.Constants.SingleSearchAcctno,(unsigned)input.did}],FFD.Layouts.DidBatch);
      
    //  Call the person context    
    pc_recs := if(isFCRA, FFD.FetchPersonContext(ds_dids, gateways, FFD.Constants.DataGroupSet.Property, in_params.FFDOptionsMask));

    //  Slim down the PersonContext         
    slim_pc_recs := FFD.SlimPersonContext(pc_recs);                            
                                  
    ds_best := project(ds_dids, transform(doxie.layout_best, self.did := left.did, self:=[]));
    ds_flags := if(isFCRA, FFD.GetFlagFile(ds_best, pc_recs));

    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_params.FCRAPurpose, in_params.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;

    fids := LN_PropertyV2_Services.ReportService_ids(input.did, input.bdid, input.parcelID, 
                                                     input.faresId,,,isFCRA);

    // generate the report
    results_pre := LN_PropertyV2_Services.resultFmt.widest_view.get_by_fid(fids,,,nonSS,isFCRA,slim_pc_recs,in_params.FFDOptionsMask, ds_flags);

    results := if(suppress_results_due_alerts, dataset([],LN_PropertyV2_Services.layouts.combined.widest), results_pre);

    //  Make the statements
    // Here we are interested only in the record statements or consumer level statements. 
    consumer_statements := if(isFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
        
    consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_params.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);

    FFD.MAC.PrepareResultRecord(results, results_combined, consumer_statements, consumer_alerts, 
                                LN_PropertyV2_Services.layouts.combined.widest);
         
    return results_combined;
end;
