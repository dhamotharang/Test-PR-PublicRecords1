import doxie, FCRA, Suppress, FFD, iesp, Gateway;

export WatercraftReport(WatercraftV2_services.Interfaces.report_Params in_params,  
												boolean isFCRA = false) := FUNCTION
	
	ids := 	Watercraftv2_services.WatercraftReportService_ids(in_params, isFCRA);
	
	// corrections on FCRA side require using overrides flag file. If isFCRA, then we have a DID in incoming in_params
	did_rec := if(isFCRA, project(dataset([{in_params.did}], doxie.layout_references), transform(doxie.layout_best, self:=left,self:=[])));
	//FFD 
	boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);
	gateways := Gateway.Configuration.Get();
																			 
	dsDIDs := dataset([{FFD.Constants.SingleSearchAcctno,in_params.did}],
												FFD.Layouts.DidBatch);
												
	pc_recs := if(isFCRA, FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Watercraft, in_params.FFDOptionsMask));  

	slim_pc_recs := FFD.SlimPersonContext(pc_recs);

	ds_flags := if (IsFCRA, FFD.GetFlagFile(did_rec, pc_recs), FCRA.compliance.blank_flagfile);

	prepr := WatercraftV2_services.WatercraftV2_raw.report_view.by_Watercraftkey(ids, in_params.ssn_mask,true, isFCRA, ds_flags, 
																																								in_params.include_non_regulated_sources,slim_pc_recs,
																																								in_params.FFDOptionsMask);

  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_params.FCRAPurpose, in_params.FFDOptionsMask)[1];
  suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;
		
	consumer_statements := if(IsFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements); 
  consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_params.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);

	//use sort from prepr to determine the desired record to output
	summarized_prepr := dedup(prepr, watercraft_key);
	
	final_prepr := if(in_params.summarize, summarized_prepr, prepr);
	
	//Handle non-subject found records
	WatercraftV2_Services.Layouts.report_out xformNonSubject(watercraftV2_Services.layouts.report_out L) := transform
		owners_supp := project(L.owners((integer)did = (integer)in_params.did or (bdid <> '' or company_name <> '')),
													 transform(WatercraftV2_Services.Layouts.owner_report_rec,
																		 self.orig_name := '',
																		 self := left));
		owners_restricted := owners_supp + project(L.owners(~((integer)did = (integer)in_params.did or (bdid <> '' or company_name <> ''))), 
																							 transform(WatercraftV2_Services.Layouts.owner_report_rec,
																												 self.lname := FCRA.Constants.FCRA_Restricted, self := []));
		self.owners := map(in_params.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription => owners_restricted, 
											 in_params.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnBlank => owners_supp,
											 L.owners);
		self := L;
	end;
	
	filter := project(final_prepr, xformNonSubject(left));
	
	rsrt := if(in_params.non_subject_suppression <> Suppress.Constants.NonSubjectSuppression.doNothing, filter, final_prepr);
	
	r :=rsrt(state_origin= in_params.st or in_params.st='');
	
	final_rsrt := sort(r, -registration_date, -date_last_seen, -watercraft_key, -sequence_key);	
							 
 recs := if(suppress_results_due_alerts, dataset([], WatercraftV2_Services.Layouts.report_out), final_rsrt);

	FFD.MAC.PrepareResultRecord(recs, final_rec, consumer_statements, consumer_alerts, WatercraftV2_Services.Layouts.report_out);
														 
	RETURN final_rec;

END;