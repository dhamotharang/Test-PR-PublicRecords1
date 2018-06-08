import doxie, suppress, FFD, iesp, FCRA, Gateway;

export MDSearchService_Records(unsigned6 ldid=0,
															 integer1 NSS_val=Suppress.Constants.NonSubjectSuppression.doNothing, 
															 boolean isFCRA= false, 
															 FCRA.iRules in_params = module(FCRA.iRules) end
															 ) := Function
// determine records to display
s_ids := marriage_divorce_v2_Services.MDSearchService_ids(,ldid,isFCRA);

// narrow to just sequences
ids := dedup( project( s_ids, transform(marriage_divorce_v2_Services.layouts.expanded_id,self.search_did := ldid, self:=left)  ), all);

ds_best := project(ids,transform(doxie.layout_best,self.did := left.search_did,self:=left,self:=[]));

//FCRA FFD
boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);

dsDIDs := dataset([{FFD.Constants.SingleSearchAcctno,ldid}], FFD.Layouts.DidBatch);

pc_recs := if(isFCRA, FFD.FetchPersonContext(dsDIDs, Gateway.Configuration.Get(), FFD.Constants.DataGroupSet.Marriage_Divorce, in_params.FFDOptionsMask));  

slim_pc_recs := FFD.SlimPersonContext(pc_recs);

ds_flags := if(isFCRA, FFD.GetFlagFile (ds_best, pc_recs));

// Send the slim PersonContext  	
// retrieve results
rpen := marriage_divorce_v2_Services.MDRaw.wide_view.by_id(ids, NSS_val, isFCRA, ds_flags, slim_pc_recs, in_params.FFDOptionsMask);

alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_params.FCRAPurpose, in_params.FFDOptionsMask)[1];
suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;

statement_output := if(IsFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(PC_Recs), 
														FFD.Constants.BlankConsumerStatements);

consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_params.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);

// prepend deep dive status, and shift deep dives to the bottom of the results
rdd := join(
	rpen, dedup(sort(s_ids, record_id, if(isDeepDive, 1, 0)), record_id),
	left.record_id = right.record_id,	
	transform(marriage_divorce_v2_Services.layouts.result.wide, self.isDeepDive := right.isDeepDive, self := left),
	left outer
);
rsrt := sort(
	rdd(penalt <= input.pThresh),
	if(isDeepDive, 1, 0), penalt, -marriage_dt, record
);
final_d	:= dedup(rsrt, except record_id);

results := if(suppress_results_due_alerts, dataset([],Marriage_Divorce_v2_Services.Layouts.result.wide), final_d);

// output(rpen,named('rpen'));
// output(final_d,named('final_d'));

FFD.MAC.PrepareResultRecord(results, results_combined, statement_output, consumer_alerts, Marriage_Divorce_v2_Services.Layouts.result.wide);

return results_combined;

end;
