import  doxie, suppress, iesp, SexOffender_Services, fcra, FFD, ut;

export ReportService_Records := module
	
	export applyRulesAndFormatCrimRecs(dataset(layouts.l_raw) recs, 
																		 CriminalRecords_Services.IParam.report in_mod, 
																		 boolean IsFCRA = false,
																		 dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
																		 dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
																		 integer8 inFFDOptionsMask = 0) := function

		Suppress.MAC_Suppress(recs,pull_1,in_mod.ApplicationType,Suppress.Constants.LinkTypes.DID,did);
		Suppress.MAC_Suppress(pull_1,pull_2,in_mod.ApplicationType,Suppress.Constants.LinkTypes.SSN,ssn);
		Suppress.MAC_Suppress(pull_2,pull_3,in_mod.ApplicationType,,,Suppress.Constants.DocTypes.OffenderKey,offender_key);
		
		doxie.MAC_PruneOldSSNs(pull_3, out_f_p1, ssn, did, isFCRA);
		doxie.MAC_PruneOldSSNs(out_f_p1, out_cleaned, ssn_appended, did, isFCRA);

		ssn_mask_value := in_mod.ssnmask;
		
		suppress.MAC_Mask(out_cleaned, out_intm, ssn, blank, true, false);
		suppress.MAC_Mask(out_intm, out_mskd, ssn_appended, blank, true, false);
		
		// Format for output
		added_in_mod := project(in_mod, functions.params);
		recs_fmt := CriminalRecords_Services.Functions.fnCrimReportVal(out_mskd, added_in_mod, IsFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
		
    dids_list := project (recs (did != ''), transform (doxie.layout_references, Self.did := (unsigned6) Left.did));
		user_input:= dataset([{(unsigned6)in_mod.did}],doxie.layout_references)(did > 0);
    dedup_dids:=dedup (dids_list+user_input, did, all);

		in_mod_sex_offenders:=project(in_mod, SexOffender_Services.IParam.report);
		// Note : below line needs to change once SO is also FFD ready
		sex_offender_rpt:=SexOffender_Services.Raw.REPORT_VIEW.by_did(dedup_dids,in_mod_sex_offenders, isFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
		
		iesp.criminal_fcra.t_FcraCriminalReportResponse final_xform() := TRANSFORM
			self._Header		 := iesp.ECL2ESP.GetHeaderRow();
			self.SexualOffenses	 := choosen(if(in_mod.IncludeSexualOffenses,sex_offender_rpt),iesp.Constants.SEXOFF_MAX_COUNT_REPORT_RESPONSE_RECORDS);
			self.CriminalRecords := choosen(recs_fmt,iesp.constants.CRIM.MaxReportRecords);
			self.ConsumerStatements  := dataset([],iesp.share_fcra.t_ConsumerStatement);
		end;
		final_proj:=dataset([final_xform()]);
		
		return final_proj;
		
	end;
		
	export val(CriminalRecords_Services.IParam.report in_params,									
						 boolean isFCRA = FALSE,
						 DATASET (FFD.Layouts.PersonContextBatch) in_pc_recs = DATASET ([],FFD.Layouts.PersonContextBatch)) 
	:= FUNCTION
		
		// corrections on FCRA side require using overrides flag file. If isFCRA, then we have a DID in incoming in_params
		did_best := if(isFCRA, project(dataset([{in_params.did}], doxie.layout_references), transform(doxie.layout_best, self:=left,self:=[])));
		ds_flags := if (isFCRA, FCRA.GetFlagFile(did_best), fcra.compliance.blank_flagfile);
		
		boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);
		boolean skipPersonContextCall := in_params.SkipPersonContextCall or ~isFCRA;
		
		ds_dids := project(did_best, transform(FFD.Layouts.DidBatch, self.acctno := FFD.Constants.SingleSearchAcctno, self := left));

		pc_recs := if(skipPersonContextCall, in_pc_recs(datagroup in FFD.Constants.DataGroupSet.Criminal),
			FFD.FetchPersonContext(ds_dids, in_params.gateways, FFD.Constants.DataGroupSet.Criminal));
		
		slim_pc_recs := FFD.SlimPersonContext(pc_recs);		
								
		is_cnsmr := ut.IndustryClass.is_Knowx;
				
		ids := CriminalRecords_Services.ReportService_ids.val(in_params, isFCRA, ds_flags);		
		recs:= CriminalRecords_Services.Raw.getOffenderRaw(ids, isFCRA, ds_flags, slim_pc_recs, in_params.FFDOptionsMask, is_cnsmr);		

		result:= applyRulesAndFormatCrimRecs(recs, in_params, isFCRA, ds_flags, slim_pc_recs, in_params.FFDOptionsMask);
		
		consumer_statements_all := if(isFCRA and showConsumerStatements, FFD.prepareConsumerStatements(pc_recs), 
                                  FFD.Constants.BlankConsumerStatements);
    has_consumer_data := exists(result[1].SexualOffenses) or exists(result[1].CriminalRecords);  
    
		consumer_statements := consumer_statements_all(has_consumer_data  OR StatementType IN FFD.Constants.RecordType.StatementConsumerLevel);
		
		FFD.MAC.AppendConsumerStatements(result, result_final, consumer_statements, iesp.criminal_fcra.t_FcraCriminalReportResponse);
				
		return result_final;
	END;
	
end;