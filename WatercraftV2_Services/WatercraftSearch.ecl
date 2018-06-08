IMPORT doxie, FCRA, suppress, FFD, iesp, Gateway;

EXPORT WatercraftSearch(WatercraftV2_services.Interfaces.Search_Params in_params, 
												boolean isFCRA = false) := FUNCTION

	ids := 		dedup(sort(Watercraftv2_services.WatercraftSearchService_ids(in_params, isFCRA),
											 watercraft_key,state_origin,sequence_key,if(isDeepDive,1,0)),
									watercraft_key,state_origin,sequence_key);
	
	// corrections on FCRA side require using overrides flag file. If isFCRA, then we have a DID in incoming in_params
	did_rec 	:= if(isFCRA, project(dataset([{in_params.did}], doxie.layout_references), doxie.layout_best));
	
	//FCRA FFD 
	boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);
	gateways := Gateway.Configuration.Get();
																			 
	dsDIDs := dataset([{FFD.Constants.SingleSearchAcctno,in_params.did}],FFD.Layouts.DidBatch);

	pc_recs := if(isFCRA, FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Watercraft, in_params.FFDOptionsMask));  
	
	slim_pc_recs := FFD.SlimPersonContext(pc_recs);
	
	ds_flags 	:= if(isFCRA, FFD.GetFlagFile(did_rec, pc_recs), FCRA.compliance.blank_flagfile);

	watercraft_r := watercraftV2_services.get_watercraft(ids, in_params.ssn_mask, isFCRA, ds_flags, 
																												in_params.include_non_regulated_sources,
																												slim_pc_recs, in_params.FFDOptionsMask).search();
																												
  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_params.FCRAPurpose, in_params.FFDOptionsMask)[1];
  suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;

	consumer_statements := if(IsFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements); 
  consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_params.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
									
	//Handle non-subject found records
	WatercraftV2_Services.Layouts.search_out xformNonSubject(WatercraftV2_Services.Layouts.search_out L) := transform
		owners_supp 			:= project(L.owners((integer)did = (integer)in_params.did or (bdid <> '' or company_name <> '')), 
																	transform(WatercraftV2_Services.Layouts.owner_search_rec,
																						self.orig_name := '',
																						self := left));
		owners_restricted := owners_supp + project(L.owners(~((integer)did = (integer)in_params.did or (bdid <> '' or company_name <> ''))), 
																							 transform(WatercraftV2_Services.Layouts.owner_search_rec,
																												 self.lname := FCRA.Constants.FCRA_Restricted, self := []));
		self.owners := map(in_params.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription => owners_restricted, 
											 in_params.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnBlank => owners_supp,
											 L.owners);
		self := L;
	end;
	
	filter := project(watercraft_r, xformNonSubject(left));
	rsrt := if(in_params.non_subject_suppression <> Suppress.Constants.NonSubjectSuppression.doNothing, filter, watercraft_r);

	sort_rec := record
		WatercraftV2_Services.Layouts.search_out;
		boolean sort_sequence;
	end;

	// the new input options MinVesselLength and MaxVesselLength will work as input option for new sorting functionality. When none of them is provided service returns the results in same order as before.
	final_presort := PROJECT(filter, 
										TRANSFORM(sort_rec, 
											self 							:= left,
											self.sort_sequence:= MAP(	in_params.min_vesl_len <> 0 and in_params.max_vesl_len <> 0 and left.watercraft_length BETWEEN in_params.min_vesl_len AND in_params.max_vesl_len => TRUE,
																								in_params.min_vesl_len <> 0 and in_params.max_vesl_len = 0 and left.watercraft_length >= in_params.min_vesl_len => TRUE,
																								in_params.min_vesl_len = 0 and in_params.max_vesl_len <> 0 and left.watercraft_length <= in_params.max_vesl_len => TRUE,
																								FALSE)));
	//Final Result
	final_rsrt := sort(final_presort(isDeepDive or penalt <= in_params.pt),-sort_sequence, penalt, -registration_date, -date_last_seen, -watercraft_key, -sequence_key, RECORD);	

 recs := if(suppress_results_due_alerts, dataset([], sort_rec), final_rsrt);

	FFD.MAC.PrepareResultRecord(recs, final_rec, consumer_statements, consumer_alerts, sort_rec);
														 
	RETURN final_rec;

END;