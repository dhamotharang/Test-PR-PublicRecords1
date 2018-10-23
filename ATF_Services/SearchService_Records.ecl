import AutoStandardI, atf_Services, doxie, iesp, ut, doxie_raw, suppress, Gateway,
			 FCRA, FFD, CriminalRecords_Services;

export SearchService_Records := module

  shared raw_records (dataset(ATF_Services.Layouts.ATFNumberPlus) ids,
                      ATF_Services.IParam.search_params in_mod,
                      boolean isFCRA,
                      dataset (fcra.Layout_override_flag) flagfile,
                      boolean isReportStyle,
											dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim
											) := function

		raw_recs := ATF_Services.Raw.byATF_IDS(ids, isFCRA, flagfile,
																					 slim_pc_recs,
																					 in_mod.FFDOptionsMask);

    // ENTRP filtering is specific for comp report only
    recs_active := raw_recs(lic_exp_date[1..6]>ut.IndustryClass.sys_date[1..6]);
    recs_inactive := raw_recs(lic_exp_date[1..6]<=ut.IndustryClass.sys_date[1..6]);
    Doxie_Raw.MAC_ENTRP_CLEAN (recs_inactive,lic_exp_date,recs_entrp);
		
    recs_curr := TOPN(recs_active+recs_entrp,1,-lic_exp_date,record);
    report_recs := IF(ut.IndustryClass.is_entrp,IF(ut.IndustryClass.entMonthVal=1,recs_curr,recs_active+recs_entrp),raw_recs);

		// Calculate the penalty on the records (search only)
		recs_plus_pen := project(raw_recs,transform(atf_Services.Layouts.rawrec,	  
			self.penalt := if (left.isDeepDive, 0, ATF_Services.Functions.CalculatePenalty(in_mod, left)),
			self := left));
		
    // filter by penalty and suppress	
		mod_penalty := project (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
		unsigned2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
		// don't use pentalized records for FCRA or "report view".
    recs_filt := if (isReportStyle or isFCRA, 
                     project (report_recs, atf_services.layouts.rawrec),
                     recs_plus_pen (penalt <= pthreshold_translated));

    // suppress; by DID only
    Suppress.MAC_Suppress(recs_filt,recs_supp,in_mod.applicationtype,Suppress.Constants.LinkTypes.DID,did_out);

    // add crim indicators
    recsIn := PROJECT(recs_supp,TRANSFORM({atf_Services.Layouts.rawrecCrimInd,STRING12 UniqueId},SELF.UniqueId:=LEFT.did_out,SELF:=LEFT));
    CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
    recs_crimInd := PROJECT(IF(in_mod.IncludeCriminalIndicators,recsOut,recsIn),atf_Services.Layouts.rawrecCrimInd);
		
		// Final formatting, sorting, masking
		recs_fmt := atf_Services.Functions.fnatfSearchval(recs_crimInd, in_mod);
		recs_sort := sort(recs_fmt,if(AlsoFound,1,0),_penalty,-LicenseExpireDate,TradeName,RawLicenseName, record);
		suppress.MAC_Mask (recs_sort, results_masked, SSN, null, true, false, , , , in_mod.ssnmask);
		
		return results_masked;
	end;


	export search (ATF_Services.IParam.search_params in_mod,
						     boolean isFCRA = false) := function

		// Get the IDs, pull the payload records and add atf_id.
		ids := ATF_services.SearchService_IDs.val(in_mod, isFCRA);
																 		
		ds_best := project(ids,transform(doxie.layout_best,self:=left,self:=[]));
		
		//FCRA FFD 
		ds_dids := dataset([{FFD.Constants.SingleSearchAcctno,
												 (unsigned)in_mod.DID}],FFD.Layouts.DidBatch);
    
		pc_recs := if(isFCRA,FFD.FetchPersonContext(ds_dids, Gateway.Configuration.Get(), FFD.Constants.DataGroupSet.ATF, in_mod.FFDOptionsMask));
		
		slim_pc_recs := FFD.SlimPersonContext(pc_recs);

		ds_flags := if(isFCRA, FFD.GetFlagFile(ds_best, pc_recs), FCRA.compliance.blank_flagfile);
    
    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_mod.FCRAPurpose, in_mod.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;

		final_records := if(~suppress_results_due_alerts, raw_records(ids, in_mod, isFCRA, ds_flags, FALSE, slim_pc_recs),
                      dataset([], iesp.firearm_fcra.t_FcraFirearmRecord));

		/* Here we are interested only in the ATF record statements or consumer level statements.
			 It was decided to put al the statements that come up for a person irrespective of if 
				we are showing that record or not. */
		boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_mod.FFDOptionsMask);
    
    consumer_statements := if(isFCRA and showConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
    consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_mod.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
		FFD.MAC.PrepareResultRecord(final_records, rec_out, consumer_statements, consumer_alerts, iesp.firearm_fcra.t_FcraFirearmRecord);
    
		return rec_out;
	end;


  // report view uses only DIDs to fetch IDs (vs. full scale search in the search view)
  export report (ATF_Services.IParam.search_params in_mod,
                 boolean isFCRA = false,
                 dataset (fcra.Layout_override_flag) ds_flags = fcra.compliance.blank_flagfile,
								 dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = dataset([],FFD.Layouts.PersonContextBatchSlim)
								 ) := function

    dids := dataset([{(unsigned)in_mod.DID, false}],ATF_Services.Layouts.search_did);
    ids := atf_services.Raw.byDIDs(dids, isFCRA);

    return raw_records (ids, in_mod, isFCRA, ds_flags, TRUE, slim_pc_recs(datagroup in FFD.Constants.DataGroupSet.ATF));
  end;
		
end;