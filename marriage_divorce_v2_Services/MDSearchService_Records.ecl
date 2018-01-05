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
ds_flags := FCRA.GetFlagFile (ds_best);

//FCRA FFD
boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);

dsDIDs := dataset([{FFD.Constants.SingleSearchAcctno,ldid}], FFD.Layouts.DidBatch);

pc_recs := if(isFCRA, FFD.FetchPersonContext(dsDIDs, Gateway.Configuration.Get(), FFD.Constants.DataGroupSet.Marriage_Divorce));  

slim_pc_recs := FFD.SlimPersonContext(pc_recs);

// 4) Send the slim PersonContext  	
// retrieve results
rpen := marriage_divorce_v2_Services.MDRaw.wide_view.by_id(ids, NSS_val, isFCRA, ds_flags, slim_pc_recs, in_params.FFDOptionsMask);

statement_output := if(IsFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(PC_Recs), 
														FFD.Constants.BlankConsumerStatements);

 //statements_out :=dataset([],iesp.share_fcra.t_ConsumerStatement);
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

// output(rpen,named('rpen'));
// output(final_d,named('final_d'));

FFD.MAC.PrepareResultRecord(final_d, results_combined, statement_output, FFD.Constants.BlankConsumerAlerts, Marriage_Divorce_v2_Services.Layouts.result.wide);

return results_combined;

end;
