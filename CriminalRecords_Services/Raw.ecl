import STD, doxie, doxie_files, hygenics_crim, ut, FCRA, FFD, D2C;

MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;

export Raw := module
	export getOffenderKeys := module
	
		export byDIDs(dataset(doxie.layout_references) in_dids, 
									boolean IsFCRA=false,
									dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile) := function
			correct_ofk  := SET (flagfile (file_id=FCRA.FILE_ID.OFFENDERS), record_id);
			correct_ffid := SET (flagfile (file_id=FCRA.FILE_ID.OFFENDERS), flag_file_id);
			deduped := dedup(sort(in_dids,did),did);
			offenders_key := doxie_files.Key_Offenders(isFCRA);
			// FCRA: this function returns only IDs, which will be used for fetching raw data.
			ofks := join(deduped, offenders_key,
										keyed(left.did = right.sdid)  AND
                    (~isFCRA or
										(string)Right.offender_key NOT IN correct_ofk),
										transform(CriminalRecords_Services.layouts.l_search,self := right),
										atmost(ut.limits.OFFENDERS_PER_DID));
			
			// overrides (FCRA side only)
			ofks_override := CHOOSEN (fcra.key_override_crim.offenders (keyed (flag_file_id IN correct_ffid)), MAX_OVERRIDE_LIMIT);
			// combine main data and overrides; apply FCRA-filtering
			// available dates are: (process_date, file_date, case_date, record_setup_date)
			ofks_fcra := (ofks + project (ofks_override, CriminalRecords_Services.layouts.l_search));
			return if(isFCRA, ofks_fcra, ofks);
		end;

		export byDocNums(dataset(CriminalRecords_Services.layouts.docnum_rec) in_docnums) := Function
			deduped := dedup(sort(in_docnums,doc_number),doc_number);
			docnum_key := doxie_files.Key_offenders_docnum();
			ofks := join(deduped, docnum_key,
										keyed(left.doc_number=right.docnum),
										transform(CriminalRecords_Services.layouts.l_search,self:=right),
										atmost(ut.limits.OFFENDERS_PER_DID));
			return ofks;
		end;
		
		export byCaseNum(dataset(CriminalRecords_Services.layouts.casenum_rec) in_casenums) := Function
			deduped := dedup(sort(in_casenums, case_number), case_number);
			
			CriminalRecords_Services.layouts.casenum_rec clean_case_num(CriminalRecords_Services.layouts.casenum_rec le) := TRANSFORM
				SELF.case_number := hygenics_crim._functions.clean_case_number(le.case_number);
			END;
			
			deduped_cleaned := PROJECT(deduped, clean_case_num(LEFT));
		
			casenum_key := hygenics_crim.Key_offenders_casenumber();
			ofks := join(deduped_cleaned, casenum_key,
									keyed(left.case_number = right.case_num),
									transform(CriminalRecords_Services.layouts.l_search, self := right),
									atmost(ut.limits.OFFENDERS_PER_DID));
									
			return ofks;
		end;
		
		
		
		
		
		export byoffenderID(dataset(CriminalRecords_Services.layouts.l_search) in_offenderid) := Function
			deduped := dedup(sort(in_offenderid,offender_key),offender_key);
			offenderkey_key := doxie_files.Key_Offenders_OffenderKey();
			ofks_did := join(deduped, offenderkey_key,
												keyed(left.offender_key=right.ofk),
												transform(doxie.layout_references,self.did:=(unsigned) right.did),
												atmost(ut.limits.OFFENDERS_PER_DID));
			ofks:=byDIDs(ofks_did);
			return dedup(sort(ofks+in_offenderid,offender_key),offender_key);
		end;
		
	end; //end of getOffenderKeys module

	export getOffenderRaw(dataset(CriminalRecords_Services.layouts.l_search) ids, 
												boolean IsFCRA = false,												
												dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
												dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
												integer8 inFFDOptionsMask = 0,
												boolean isCNSMR = false) := function
	
		boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
		boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
		
		correct_puid  := SET (flagfile (file_id=FCRA.FILE_ID.OFFENDERS_PLUS), record_id);
		correct_ffid := SET (flagfile (file_id=FCRA.FILE_ID.OFFENDERS_PLUS), flag_file_id);
		offenderkey_key := doxie_files.Key_Offenders_OffenderKey(isFCRA);
		recs1 := join(ids, offenderkey_key,
									keyed(left.offender_key=right.ofk) and
									(~isFCRA or
									(((string)Right.offender_persistent_id NOT IN correct_puid) and (Right.data_type != '4')))
								  and (~isCNSMR or (right.data_type not in D2C.Constants.DOCRestrictedDataTypes AND right.vendor not in D2C.Constants.DOCRestrictedVendors))  ,//Restricting access to arrest logs (data_type = 5) and source vendor = MH (Minnesota) when industry class = CNSMR
									transform(CriminalRecords_Services.layouts.l_raw,
									self:=left, 
									self :=right),
									atmost(ut.limits.OFFENDERS_MAX));

    // overrides (FCRA side only)
		ds_override := CHOOSEN (fcra.key_override_crim.offenders_plus (keyed (flag_file_id IN correct_ffid)), MAX_OVERRIDE_LIMIT);
    // combine main data and overrides; apply FCRA-filtering
    // available dates are: (process_date, file_date, case_date, record_setup_date)
		recs_fcra := (recs1 + project (ds_override, transform(CriminalRecords_Services.layouts.l_raw, self := left, self := []))) (
								FCRA.crim_is_ok ((string) STD.Date.Today(), fcra_date, fcra_conviction_flag, fcra_traffic_flag));
		
		CriminalRecords_Services.layouts.l_raw xformStatements( CriminalRecords_Services.layouts.l_raw l , 
																														FFD.Layouts.PersonContextBatchSlim r ) := transform,
		skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
			self.StatementIDs := r.StatementIds; 
			self.IsDisputed   := r.IsDisputed; 
			self := l;
		end;
			
		recs_ds := join(recs_fcra, slim_pc_recs(DataGroup = FFD.Constants.DATAGROUPS.OFFENDERS_PLUS),
														((unsigned)left.did = (unsigned) right.lexid OR 
															right.Acctno = FFD.Constants.SingleSearchAcctno ) and
														left.offender_persistent_id = (integer) right.RecID1,	
														xformStatements(left,right), 
														left outer, 
														keep(1),limit(0));
		recs := if(isFCRA, recs_ds, recs1);
//output(recs,named('OffendersPlusRaw'),EXTEND);	
		return recs;
	end;
end;