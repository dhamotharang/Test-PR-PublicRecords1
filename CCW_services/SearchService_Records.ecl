import AutoStandardI, CCW_services, ut, doxie, iesp, Suppress, FCRA, FFD, Gateway;

export SearchService_Records := module
	export params := interface(
		CCW_services.SearchService_IDs.params,
		AutoStandardI.LIBIN.PenaltyI_Indv.base,
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
		AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
		AutoStandardI.InterfaceTranslator.industry_class_value.params,
		FCRA.iRules
		)
	end;

	// penalize, suppress/mask sensitive data 
	export getFormatedRecords (DATASET(CCW_services.layouts.rawrec) recs, 
                              params in_mod,
                              boolean skip_penalizing = false) :=function
																			 
    // pull out dids which are in the file																
		Suppress.MAC_Suppress(recs,recs_did_pulled,in_mod.applicationtype,Suppress.Constants.LinkTypes.DID,did_out);
    // pull out ssn's which are in pull ssn file																
		Suppress.MAC_Suppress(recs_did_pulled,recs_ssn_pulled,in_mod.applicationtype,Suppress.Constants.LinkTypes.SSN,best_ssn);
	 
		// Calculate the penalty on the records
		recs_plus_pen := project (recs_ssn_pulled,transform(CCW_services.Layouts.rawrec,
			tempindvmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
				export allow_wildcard := false;
				export city_field := left.city_name; //trim(ms(left.p_city_name, left.v_city_name, in_mod.city),left,right);
				export did_field := left.did_out;
				export fname_field := left.fname;
				export lname_field := left.lname;
				export mname_field := left.mname;
				export phone_field := '';
				export pname_field := left.prim_name;
				export postdir_field := left.postdir;
				export prange_field := left.prim_range;
				export predir_field := left.predir;
				export ssn_field := left.best_ssn;  
				export state_field := left.st;
				export suffix_field := left.suffix;
				export sec_range_field := left.sec_range;
				export zip_field := left.zip;
				export city2_field := '';
				export county_field := left.county;
				export dob_field := left.dob;
				export dod_field := '';
			end;
			
			// The business info will only ever use the business address.
			tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
							
			// if its deepdive records or isFCRA is true don't apply the penalty...			 
			self.penalt := if (left.isDeepDive or skip_penalizing, 0, tempPenaltIndv), // no business penalty
			              //tempPenaltBiz),
			self := left));

    // mask SSN			
		string6 ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(in_mod,
                             AutoStandardI.InterfaceTranslator.ssn_mask_val.params)); 
    Suppress.MAC_Mask(recs_plus_pen, recs_plus_pen_out, best_ssn, blank, true, false);			
    
		// Format for output				
		recs_fmt := CCW_services.Functions.fnCCWSearchval(recs_plus_pen_out);
				
    mod_penalty := project (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
    unsigned2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
		recs_pen := recs_fmt (_penalty <= pthreshold_translated);

		// sort by lname, fname etc..if search is not by aircraft Number.
		// otherwise sort returned is chronological in nature.
		recs_sort := sort(recs_pen,if(AlsoFound,1,0), _penalty,
												Name.Last, Name.First, Name.Middle, ssn,-Permit.RegistrationDate.year, -Permit.RegistrationDate.month, -Permit.RegistrationDate.day,
												record);
		
    tempresults_slim := project(recs_sort, iesp.concealedweapon_fcra.t_FcraWeaponRecord); 
		return tempresults_slim;
	end;
	
  // search entry point
	export search(params in_mod, boolean isFCRA = false) := function
		
		boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_mod.FFDOptionsMask);
																			 
		// get RIDs from input criteria.
		ids := CCW_services.SearchService_IDs.val(in_mod, isFCRA);
   
	 //Get FCRA files
		ds_best := project(ids,transform(doxie.layout_best,self:=left,self:=[]));
		
		//FCRA FFD 
		// we are using the subject DID rather than the Best DID 
		ds_dids := dataset([{FFD.Constants.SingleSearchAcctno,(unsigned)in_mod.DID}],FFD.Layouts.DidBatch);
		
		pc_recs := if(isFCRA, FFD.FetchPersonContext(ds_dids, Gateway.Configuration.Get(), FFD.Constants.DataGroupSet.CCW, in_mod.FFDOptionsMask));
		
		ds_flags := if(isFCRA, FFD.GetFlagFile (ds_best, pc_recs));
    
		slim_pc_recs := FFD.SlimPersonContext(pc_recs);
		alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_mod.FCRAPurpose, in_mod.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;
		
		// Send the DID and show disputed inside 
		boolean isCNSMR := in_mod.IndustryClass = ut.IndustryClass.Knowx_IC; // D2C - consumer restriction
		recs := CCW_Services.Raw.byRids(ids, isFCRA, ds_flags, slim_pc_recs, in_mod.FFDOptionsMask, isCNSMR);
		final_recs := if(~suppress_results_due_alerts, getFormatedRecords (recs, in_mod, skip_penalizing := isFCRA), //don't penalize on FCRA side
                     dataset([],iesp.concealedweapon_fcra.t_FcraWeaponRecord));
                     
		// 5) Make the statements
		// Here we are interested only in the record statements or consumer level statements. 
  consumer_statements := if(isFCRA and showConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);

  // process alerts coming from PersonContext
		consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_mod.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
		
		FFD.MAC.PrepareResultRecord(final_recs, rec_out, consumer_statements, consumer_alerts, iesp.concealedweapon_fcra.t_FcraWeaponRecord);
		 
		RETURN rec_out;
	end;

  // report entry: if subject is (or subjects are) already found
  export report (dataset (doxie.layout_references) dids,
                 params in_mod, 
                 boolean isFCRA = false,
                 dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile
								 ) := function
    // get internal IDs
    ids := CCW_Services.raw.byDIDs (project (dids, CCW_services.Layouts.search_did), isFCRA);
   
    // get raw records; overrides are applied inside 
		boolean isCNSMR := in_mod.IndustryClass = ut.IndustryClass.Knowx_IC; // D2C - consumer restriction
    recs := CCW_Services.raw.byRids (ids, isFCRA, flagfile, , , isCNSMR);
    final_recs := getFormatedRecords (recs, in_mod, skip_penalizing := true);
		
		return final_recs;
  end;

end;
